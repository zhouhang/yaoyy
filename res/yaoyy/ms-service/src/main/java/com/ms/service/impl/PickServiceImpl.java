package com.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ms.dao.*;
import com.ms.dao.enums.*;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.observer.MsgConsumeEvent;
import com.ms.service.observer.MsgProducerEvent;
import com.ms.tools.exception.ControllerException;
import com.ms.tools.exception.ValidationException;
import com.ms.tools.utils.SeqNoUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;

@Service
public class PickServiceImpl  extends AbsCommonService<Pick> implements PickService{

	@Autowired
	private PickDao pickDao;


	@Autowired
	private PickCommodityService pickCommodityService;


	@Autowired
	private UserDao userDao;

	@Autowired
	private UserDetailDao userDetailDao;


	@Autowired
	private PickTrackingDao pickTrackingDao;

	@Autowired
	private CommodityService commodityService;

	private CodeDao codeDao;

	@Autowired
	private  ApplicationContext applicationContext;

	@Autowired
	private MemberService memberService;

	@Autowired
	private PickTrackingService  pickTrackingService;

	@Autowired
	private LogisticalService logisticalService;

	@Autowired
	private ShippingAddressService shippingAddressService;

	@Autowired
	private ShippingAddressHistoryService shippingAddressHistoryService;

	@Autowired
	private OrderInvoiceService orderInvoiceService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private PayRecordService payRecordService;

	@Autowired
	private AccountBillService accountBillService;

	@Autowired
	private CommodityBatchDao commodityBatchDao;




	@Override
	public PageInfo<PickVo> findByParams(PickVo pickVo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
        PageHelper.startPage(pageNum, pageSize);
    	List<PickVo>  list = pickDao.findByParams(pickVo);
		list.forEach(p->{
			p.getSettleTypeName();
			p.getStatusText();
			p.getUserBusinessTypeName();
//			List<PickCommodityVo> pickCommodityVos=pickCommodityService.findByPickId(p.getId());
			float total=0;
			for(PickCommodityVo vo :p.getPickCommodityVoList()){
				total+=vo.getTotal();
			}
			p.setTotal(total);
			// 查询账期剩余时间
			if (SettleTypeEnum.SETTLE_BILL.getType() == p.getSettleType()) {
				AccountBillVo billVo = accountBillService.findVoByOrderId(p.getId());
				p.setBillTimeLeft(billVo.getTimeLeft());
				p.setBillTime(billVo.getBillTime());
			}
		});
        PageInfo page = new PageInfo(list);
        return page;
	}

	@Override
	public PickVo findVoById(Integer id) {
		PickVo pickVo=pickDao.findVoById(id);
		List<PickCommodityVo> pickCommodityVos=pickCommodityService.findByPickId(id);
		float total=0;

		for(PickCommodityVo vo :pickCommodityVos){
			total+=vo.getTotal();
		}
		pickVo.setTotal(total);

		pickVo.setPickCommodityVoList(pickCommodityVos);

		// 发票信息
		pickVo.setInvoice(orderInvoiceService.findByOrderId(pickVo.getId()));
		return pickVo;
	}

	@Override
	@Transactional
	public void save(PickVo pickVo) {
		UserVo userVo=userDao.findByPhone(pickVo.getPhone());

		Integer nowLogin=pickVo.getUserId();//现在登录的userid
		//如果用户注册
		Date now=new Date();

		int useId;
		if (userVo==null){
			User user=new User();
			user.setPhone(pickVo.getPhone());
			user.setType(UserTypeEnum.purchase.getType());
			user.setSource(UserSourceEnum.auto.getType());
			user.setStatus(UserEnum.enable.getType());
			user.setSalt("");
			user.setPassword("");
			//user.setOpenid("");
			user.setUpdateTime(now);
			user.setCreateTime(now);
			userDao.create(user);

			useId=user.getId();
		}
		else{
			useId=userVo.getId();
		}
		UserDetail userDetail=userDetailDao.findByUserId(useId);
		if (userDetail==null){
			userDetail=new UserDetail();
			userDetail.setPhone(pickVo.getPhone());
			userDetail.setNickname(pickVo.getNickname());
			userDetail.setArea(0);
			userDetail.setUserId(useId);
			userDetail.setName("");
			userDetail.setRemark("");
			userDetail.setType(0);
			userDetail.setUpdateTime(now);
			userDetail.setCreateTime(now);
			userDetailDao.create(userDetail);
		}
		else{
			userDetail.setPhone(pickVo.getPhone());
			userDetail.setNickname(pickVo.getNickname());
			userDetail.setUpdateTime(now);
			userDetailDao.update(userDetail);
		}




		Pick pick=new Pick();
		if(nowLogin==null){
			pick.setUserId(useId);
		}
		else{
			pick.setUserId(nowLogin);
		}
		pick.setNickname(pickVo.getNickname());
		pick.setPhone(pickVo.getPhone());
		pick.setStatus(PickEnum.PICK_NOTHANDLE.getValue());
		pick.setUpdateTime(now);
		pick.setCreateTime(now);
		pick.setCode("");
		pick.setAbandon(0);

		/**
		 * 设置code
		 */
		pick.setCode(SeqNoUtil.getOrderCode());
		pickDao.create(pick);

		pickVo.getPickCommodityVoList().forEach(c->{
			c.setPickId(pick.getId());
		});
		pickCommodityService.saveList(pickVo.getPickCommodityVoList());



		PickTracking pickTracking=new PickTracking();
		pickTracking.setName(pickVo.getNickname());
		pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
		if(nowLogin==null){
			pickTracking.setOperator(useId);
		}
		else{
			pickTracking.setOperator(nowLogin);
		}
		pickTracking.setExtra("");
		pickTracking.setCreateTime(now);
		pickTracking.setUpdateTime(now);
		pickTracking.setPickId(pick.getId());
		pickTracking.setRecordType(PickTrackingTypeEnum.PICK_APPLY.getValue());
		pickTrackingDao.create(pickTracking);

		/**
		 * 存消息
		 *
		 */
		String content=pick.getNickname()+"提交选货单";
		MsgProducerEvent msgProducerEvent =new MsgProducerEvent(pick.getUserId(),pick.getId(), MessageEnum.PICK,content, MsgIsMemberEnum.IS_MEMBER.getKey());
		applicationContext.publishEvent(msgProducerEvent);
		// 选货登记通知用户
		MsgProducerEvent msgProducerEventC =new MsgProducerEvent(pick.getUserId(),pick.getId(), MessageEnum.PICK_C,content, MsgIsMemberEnum.IS_MEMBER.getKey());
		applicationContext.publishEvent(msgProducerEventC);

	}

	@Override
	@Transactional
	public void createOrder(PickVo pickVo) {

		PickVo oldPick=pickDao.findVoById(pickVo.getId());
		if(!PickEnum.PICK_PAY.getValue().equals(oldPick.getStatus())){
			//创建一条生成订单跟踪记录
			PickTracking pickTracking=new PickTracking();
			if(pickVo.getMemberId()!=null){
				Member member=memberService.findById(pickVo.getMemberId());
				pickTracking.setName(member.getName());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
				pickTracking.setOperator(member.getId());
			} else{
				PickVo pick=pickDao.findVoById(pickVo.getId());
				pickTracking.setName(pick.getNickname());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
				pickTracking.setOperator(pickVo.getUserId());
			}


			pickTracking.setExtra("");
			pickTracking.setCreateTime(new Date());
			pickTracking.setUpdateTime(new Date());
			pickTracking.setPickId(pickVo.getId());
			pickTracking.setRecordType(PickTrackingTypeEnum.PICK_ORDER.getValue());
			pickTrackingDao.create(pickTracking);

		}
		else{
			//创建一条修改结算详情的记录
			for(PickCommodity pickCommodity:pickVo.getPickCommodityVoList()){
				pickCommodityService.update(pickCommodity);
			}
			PickTracking pickTracking=new PickTracking();
			if(pickVo.getMemberId()!=null){
				Member member=memberService.findById(pickVo.getMemberId());
				pickTracking.setName(member.getName());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
				pickTracking.setOperator(member.getId());
			}
			else{
				PickVo pick=pickDao.findVoById(pickVo.getId());
				pickTracking.setName(pick.getNickname());
				pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
				pickTracking.setOperator(pickVo.getUserId());
			}



			pickTracking.setExtra("");
			pickTracking.setCreateTime(new Date());
			pickTracking.setUpdateTime(new Date());
			pickTracking.setPickId(pickVo.getId());
			pickTracking.setRecordType(PickTrackingTypeEnum.PICK_UPDATE.getValue());
			pickTrackingDao.create(pickTracking);

		}
		//全款或保证金
		if(pickVo.getSettleType()==SettleTypeEnum.SETTLE_ALL.getType()||pickVo.getSettleType()==SettleTypeEnum.SETTLE_DEPOSIT.getType()){
			pickVo.setStatus(PickEnum.PICK_PAY.getValue());
		}
		else{
			pickVo.setStatus(PickEnum.PICK_CONFIRM.getValue());
		}
		//设置有效期
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.DATE, 3);
		pickVo.setExpireDate(calendar.getTime());
		pickDao.update(pickVo);

		// 客服确认订单 通知用户
		Pick pick = pickDao.findById(pickVo.getId());
		MsgProducerEvent mp =new MsgProducerEvent(pick.getUserId(),pick.getId(), MessageEnum.PICK_CONFIRM, null, MsgIsMemberEnum.IS_MEMBER.getKey());
		applicationContext.publishEvent(mp);

	}

	@Override
	@Transactional
	public void changeOrderStatus(Integer id, Integer status) {
		Pick pick=new Pick();
		pick.setId(id);
		pick.setStatus(status);
		pick.setUpdateTime(new Date());
		pickDao.update(pick);

		//增加跟踪记录
		PickVo pickVo=pickDao.findVoById(id);
		PickTracking pickTracking=new PickTracking();
		pickTracking.setName(pickVo.getNickname());
		pickTracking.setOpType(TrackingTypeEnum.TYPE_USER.getValue());
		pickTracking.setOperator(pickVo.getUserId());



		pickTracking.setExtra("");
		pickTracking.setCreateTime(new Date());
		pickTracking.setUpdateTime(new Date());
		pickTracking.setPickId(pickVo.getId());
		if(status==PickEnum.PICK_CANCLE.getValue()){
			pickTracking.setRecordType(PickTrackingTypeEnum.PICK_CANCEL.getValue());
			pickTrackingDao.create(pickTracking);
		}else if(status==PickEnum.PICK_FINISH.getValue()){
			pickTracking.setRecordType(PickTrackingTypeEnum.PICK_RECEIPT.getValue());
			pickTrackingDao.create(pickTracking);
		}


	}
    @Override
	@Transactional
	public void updateCommodityNum(List<PickCommodity> pickCommodities) {
		for(PickCommodity pickCommodity:pickCommodities){
			pickCommodityService.update(pickCommodity);
		}
	}

	@Override
	@Transactional
	public void delivery(LogisticalVo logisticalVo,Member mem) {
		logisticalService.save(logisticalVo);

		Date now=new Date();
		Pick pick =new Pick();
		pick.setId(logisticalVo.getOrderId());
		pick.setStatus(PickEnum.PICK_DELIVERIED.getValue());
		pick.setDeliveryDate(logisticalVo.getShipDate());
		pick.setUpdateTime(now);
		pickDao.update(pick);

		PickTrackingVo pickTrackingVo=new PickTrackingVo();
		pickTrackingVo.setPickId(logisticalVo.getOrderId());
		pickTrackingVo.setOperator(mem.getId());
		pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_ADMIN.getValue());
		pickTrackingVo.setName(mem.getName());
		pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_ORDER_DELIVERIED.getValue());
		if(pickTrackingVo.getExtra()==null){
			pickTrackingVo.setExtra("");
		}
		pickTrackingVo.setCreateTime(now);
		pickTrackingVo.setUpdateTime(now);

		pickTrackingDao.create(pickTrackingVo);

		//通知用户待收货
		pick = findById(pick.getId());
		MsgProducerEvent mp =new MsgProducerEvent(pick.getUserId(),pick.getId(), MessageEnum.PICK_DELIVERY, null, MsgIsMemberEnum.IS_MEMBER.getKey());
		applicationContext.publishEvent(mp);
	}

	@Override
	@Transactional
	public void handlePay(PaymentVo payment) {
		//更新payment
		payment.setCallbackTime(new Date());
		paymentService.update(payment);

		//创建支付记录
		PayRecordVo payRecordVo=new PayRecordVo();
		payRecordVo.setCodeType(payment.getType());
		//订单支付
		if(payment.getType()==0){
			PickVo pickVo=findVoById(payment.getOrderId());
			payRecordVo.setCode(pickVo.getCode());
			payRecordVo.setOrderId(payment.getOrderId());
		}else{
			AccountBillVo accountBillVo=accountBillService.findVoById(payment.getBillId());
			payRecordVo.setCode(accountBillVo.getCode());
			payRecordVo.setAccountBillId(payment.getBillId());
		}
		payRecordVo.setPaymentId(payment.getId());
		payRecordVo.setUserId(payment.getUserId());
		payRecordVo.setActualPayment(payment.getMoney());
		payRecordVo.setPayAccount(payment.getPayAppId());
		payRecordVo.setPaymentTime(payment.getCreateTime());
		payRecordVo.setStatus(payment.getStatus());
		payRecordVo.setPayType(payment.getPayType());
		payRecordVo.setCreateTime(new Date());

		payRecordService.save(payRecordVo);
		//如果支付成功更新订单状态并添加跟踪记录
		if(payment.getStatus()==1){
			//如果存在账期就为这个用户生成账单
			if(payment.getType()==0){//订单支付
				PickVo pick=findVoById(payment.getOrderId());
				if(pick.getSettleType()== SettleTypeEnum.SETTLE_DEPOSIT.getType()){
					AccountBillVo accountBillVo=new AccountBillVo();
					accountBillVo.setMemberId(pick.getMemberId());
					accountBillVo.setOrderId(pick.getId());
					accountBillVo.setUserId(pick.getUserId());
					accountBillVo.setBillTime(pick.getBillTime());
					accountBillVo.setAlreadyPayable(pick.getDeposit());
					accountBillVo.setAmountsPayable(pick.getAmountsPayable());
					accountBillService.saveAccountBill(accountBillVo);
				}
				PickTrackingVo pickTrackingVo=new PickTrackingVo();
				pickTrackingVo.setPickId(payment.getOrderId());

				pickTrackingVo.setOperator(pick.getUserId());
				pickTrackingVo.setName(pick.getNickname());
				pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_USER.getValue());

				if(pick.getSettleType()== SettleTypeEnum.SETTLE_DEPOSIT.getType()){
					pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_SELFPAY_DEPOSTI.getValue());
				}
				else{
					pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_SELFPAY_ALL.getValue());
				}
				pickTrackingService.save(pickTrackingVo);

				// 支付成功 通知客服查看
				MsgProducerEvent mp =new MsgProducerEvent(pick.getUserId(),payRecordVo.getId(), MessageEnum.PAY_ONLINE, null, MsgIsMemberEnum.IS_MEMBER.getKey());
				applicationContext.publishEvent(mp);
				MsgProducerEvent mpC =new MsgProducerEvent(pick.getUserId(),pick.getId(), MessageEnum.PAY_SUCCESS, null, MsgIsMemberEnum.IS_MEMBER.getKey());
				applicationContext.publishEvent(mpC);

			}
			else{
				//账单支付需要更改账单状态
                AccountBillVo accountBillVo=accountBillService.findVoById(payment.getBillId());
				accountBillVo.setAlreadyPayable(accountBillVo.getAlreadyPayable()+payment.getMoney());
				accountBillVo.setStatus(1);
				accountBillService.update(accountBillVo);

				PickVo pick=findVoById(accountBillVo.getOrderId());
				PickTrackingVo pickTrackingVo=new PickTrackingVo();
				pickTrackingVo.setPickId(payment.getOrderId());
				pickTrackingVo.setOperator(pick.getUserId());
				pickTrackingVo.setName(pick.getNickname());
				pickTrackingVo.setOpType(TrackingTypeEnum.TYPE_USER.getValue());

				pickTrackingVo.setRecordType(PickTrackingTypeEnum.PICK_PAY_BILL.getValue());

				pickTrackingService.save(pickTrackingVo);
			}





		}

	}

	@Override
	@Transactional
	public void cancel(Integer id, Integer userId) {
		// 判断订单属于当前用户,再取消
		Pick pick = findById(id);
		if (pick == null || !pick.getUserId().equals(userId)) {
			throw new ControllerException("没有权限取消订单");
			// TODO: 判断当前订单的状态是否 处于可取消状态
		}
		changeOrderStatus(id,PickEnum.PICK_CANCLE.getValue());
		//用户提交之后立即取消时候需要消费掉这条消息，否则消费不了
		MsgConsumeEvent msgConsumeEvent=new MsgConsumeEvent(pick.getId(), MessageEnum.PICK);
		applicationContext.publishEvent(msgConsumeEvent);
	}




	@Override
	@Transactional
	public void receipt(Integer id, Integer userId) {
		// 判断订单属于当前用户,再确认收货
		Pick pick = findById(id);
		if (pick == null || !pick.getUserId().equals(userId)) {
			throw new ControllerException("没有权限取消订单");
			// TODO: 判断当前订单的状态是否 处于可确认收货状态
		}
		changeOrderStatus(id,PickEnum.PICK_FINISH.getValue());
	}

	@Override
	@Transactional
	public void saveOrder(PickVo pickVo) {


		// 保存订单

		// 判断提交的订单是否属于当前用户
		Pick originPick = findById(pickVo.getId());
		if (!(originPick!= null && pickVo.getUserId().equals(originPick.getUserId()))){
			throw new ControllerException("用户无权限访问此页面.");
		}

		// 收货地址保存到历史收货地址表中并把ID 回填到订单表
		if (pickVo.getAddrHistoryId() != null ){
			// 历史地址ID = -1 表示用户修改时未修改地址信息
			if (pickVo.getAddrHistoryId() != -1) {
				ShippingAddressVo sa = shippingAddressService.findVoById(pickVo.getAddrHistoryId());
				ShippingAddressHistory sah = new ShippingAddressHistory();
				BeanUtils.copyProperties(sa, sah);
				sah.setId(null);
				sah.setArea(sa.getFullAdd());
				sah.setAreaId(sa.getAreaId());
				shippingAddressHistoryService.create(sah);
				pickVo.setAddrHistoryId(sah.getId());
			} else {
				pickVo.setAddrHistoryId(null);
			}
		} else {
			throw new ControllerException("地址不能为空.");
		}

		// 保存发票信息 保存前需要先检查下用户发票之前是否存在
		if (pickVo.getInvoice() != null && pickVo.getInvoice().getType()!= null){
			OrderInvoice invoice = orderInvoiceService.findByOrderId(pickVo.getId());
			if (invoice == null) {
				pickVo.getInvoice().setOrderId(pickVo.getId());
				orderInvoiceService.create(pickVo.getInvoice());
			} else {
				// 确认空值的问题
				pickVo.getInvoice().setId(invoice.getId());
				BeanUtils.copyProperties(pickVo.getInvoice(),invoice);
				invoice.setOrderId(pickVo.getId());
				orderInvoiceService.update(invoice);
			}

		}

		update(pickVo);
	}

	@Override
	@Transactional
	public void supplierCreateOrder(List<CommodityBatch> list, Integer commodityId, Integer memId) {

		// 寄卖下单时默认购买用户未 id 为1 的用户
		// 创建订单后直接设置为已发货
		/*
		寄卖下单只有商品总价字段
				* 其它 运费,包装费, 都为0
				* 付款方式为现款
				* 下单成功后默认状态为已发货
				* 退货和结算订单 直接改状态,添加跟踪记录.
				* 寄卖下单时默认购买用户为 id 为1 的用户
				* */



		Pick pick = new Pick();
		//计算商品总价
		pick.setSum(0F);
		PickCommodityVo pickCommodity = new PickCommodityVo();
		// 先查询商品库存 检查商品库存信息 在下单
		CommodityVo commodity = commodityService.findById(commodityId);
		pickCommodity.setNum(0);
		list.forEach(batch -> {
			pick.setSum(pick.getSum() + (batch.getNum() * commodity.getPrice()));
			pickCommodity.setNum(pickCommodity.getNum() + batch.getNum());
		});
		pick.setAmountsPayable(pick.getSum());

		if (pickCommodity.getNum() > commodity.getWarehouse()) {
			throw new ValidationException("寄卖商品库存不足.");
		} else {
			// 更新商品库存
			Commodity updateCommodity = new Commodity();
			updateCommodity.setId(commodityId);
			updateCommodity.setWarehouse(commodity.getWarehouse() - pickCommodity.getNum());
			commodityService.update(updateCommodity);
		}

		// 1. 计算商品总价 2. 设置pick 默认值 保存订单3, 查询商品信息 保存商品信息到历史表 保存商品到订单商品表 保存订单商品批次信息
		UserDetail userDetail = userDetailDao.findByUserId(1);
		pick.setUserId(1); // 默认客户ID 为1
		pick.setCode(SeqNoUtil.getOrderCode());
		pick.setNickname(userDetail.getNickname());
		pick.setPhone(userDetail.getPhone());
		pick.setStatus(PickEnum.PICK_NOTHANDLE.getValue());
		pick.setUpdateTime(new Date());
		pick.setCreateTime(new Date());
		pick.setAbandon(0);
		pick.setDeliveryDate(new Date());
		pick.setSettleType(SettleTypeEnum.SETTLE_ALL.getType());
		pick.setShippingCosts(0F);
		pick.setBagging(0F);
		pick.setChecking(0F);
		pick.setTaxation(0F);
		pick.setMemberId(memId);
		pick.setRemark("寄卖订单");
		pick.setStatus(PickEnum.PICK_DELIVERIED.getValue());
		create(pick);

		pickCommodity.setCommodityId(commodityId);
		pickCommodity.setPickId(pick.getId());

//		update(pick);

		// 保存商品信息到历史记录表 并保存订单商品信息到订单商品表
		List<PickCommodityVo> commoditylist = new ArrayList<>();
		commoditylist.add(pickCommodity);
		pickCommodityService.saveList(commoditylist);

		list.forEach(batch -> {
			batch.setPickCommodityId(pickCommodity.getId());
		});

		// 保存批次信息 同时添加供应商通知消息
		commodityBatchDao.batchInsert(list);

		// 寄卖下单
		String content = "您的商品(" + commodity.getName() + commodity.getSpec()+")以"+pickCommodity.getPrice()+"/"+commodity.getUnit()+"被下单"+pickCommodity.getNum()+commodity.getUnitName();
		MsgProducerEvent mp =new MsgProducerEvent(commodity.getSupplierId(),commodity.getId(), MessageEnum.SUPPLIER_ORDER_CONSIGNMENT, content, MsgIsMemberEnum.IS_NOT_MEMBER.getKey());
		applicationContext.publishEvent(mp);

	}

	@Override
	public PageInfo<SupplierOrderVo> queryForSupplier(SupplierOrderVo vo,Integer pageNum,Integer pageSize) {
		pageNum = pageNum==null?1:pageNum;
		pageSize = pageSize==null?10:pageSize;
		PageHelper.startPage(pageNum, pageSize);
		List<SupplierOrderVo> list = pickDao.queryForSupplier(vo);
		PageInfo page = new PageInfo(list);
		return page;
	}

	@Override
	public SupplierOrderVo queryByIdForSupplier(Integer pickId) {
		SupplierOrderVo vo = new SupplierOrderVo();
		vo.setId(pickId);
		List<SupplierOrderVo> list = pickDao.queryForSupplier(vo);
		if (list != null && list.size()>0) {
			CommodityBatchVo batchVo = new CommodityBatchVo();
			batchVo.setPickCommodityId(list.get(0).getPickCommodityId());
			List<String> batchs = new ArrayList();
			commodityBatchDao.findByParams(batchVo).forEach(batch -> {
				batchs.add(batch.getNo());
			});
			list.get(0).setBatchInfo(StringUtils.join(batchs.toArray(new String[batchs.size()]),","));
			return  list.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public void supplierFinish(Integer pickId) {
		// 添加跟踪记录
		Pick pick = new Pick();
		pick.setId(pickId);
		pick.setStatus(PickEnum.PICK_FINISH.getValue());
		update(pick);
		SupplierOrderVo orderVo = queryByIdForSupplier(pickId);
		// 结算
		String content = "您的商品(" + orderVo.getCommodityName() + orderVo.getSpec()+")以"+orderVo.getPrice()+"/"+orderVo.getUnit()+"价格交易完成"+orderVo.getNum()+orderVo.getUnit()+"我们会在3天内与您结算";
		MsgProducerEvent mp =new MsgProducerEvent(orderVo.getSupplierId(),orderVo.getCommodityId(), MessageEnum.SUPPLIER_ORDER_CONSIGNMENT, content, MsgIsMemberEnum.IS_NOT_MEMBER.getKey());
		applicationContext.publishEvent(mp);
	}

	@Override
	@Transactional
	public void supplierRefunds(Integer pickId) {
		// 添加跟踪记录
		Pick pick = new Pick();
		pick.setId(pickId);
		pick.setStatus(PickEnum.PICK_NOTFINISH.getValue());
		update(pick);

		SupplierOrderVo orderVo = queryByIdForSupplier(pickId);
		// 退货
		String content = "您的商品(" + orderVo.getCommodityName() + orderVo.getSpec()+")"+orderVo.getNum()+orderVo.getUnit()+"被买家退货.";
		MsgProducerEvent mp =new MsgProducerEvent(orderVo.getSupplierId(),orderVo.getCommodityId(), MessageEnum.SUPPLIER_ORDER_CONSIGNMENT, content, MsgIsMemberEnum.IS_NOT_MEMBER.getKey());
		applicationContext.publishEvent(mp);
	}


	@Override
	public ICommonDao<Pick> getDao() {
		return pickDao;
	}

	public List<PickVo> findByParamsNoPage(PickVo pickVo) {
		return pickDao.findByParams(pickVo);
	}



}
