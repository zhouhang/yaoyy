package com.ms.boss.controller;

import com.github.pagehelper.PageInfo;
import com.ms.boss.config.LogTypeConstant;
import com.ms.dao.enums.SupplierStatusEnum;
import com.ms.dao.enums.UserSourceEnum;
import com.ms.dao.enums.UserTypeEnum;
import com.ms.dao.model.*;
import com.ms.dao.vo.*;
import com.ms.service.*;
import com.ms.service.enums.ContractEnum;
import com.ms.service.enums.MessageEnum;
import com.ms.service.enums.RedisEnum;
import com.ms.service.enums.WxSupplierSignTemplateEnum;
import com.ms.service.observer.SmsTemplateEvent;
import com.ms.service.observer.WxTemplateEvent;
import com.ms.tools.annotation.SecurityToken;
import com.ms.tools.entity.Result;
import com.sucai.compentent.logs.annotation.BizLog;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureOrder;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;


import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by xiao on 2016/12/2.
 */
@Controller
@RequestMapping("supplier/")
public class SupplierController {


    @Autowired
    private SupplierService supplierService;

    @Autowired
    private AreaService areaService;

    @Autowired
    private CommodityService commodityService;

    @Autowired
    private UserTrackRecordService userTrackRecordService;

    @Autowired
    private UserService userService;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private UserAnnexService userAnnexService;

    @Autowired
    private MessageService messageService;
    @Autowired
    private SupplierCommodityService supplierCommodityService;

    @Autowired
    private SurveyService surveyService;

    @Autowired
    private SupplierChoiceService supplierChoiceService;

    @Autowired
    private SupplierContactService supplierContactService;

    @Autowired
    private SupplierAnnexService supplierAnnexService;

    @Autowired
    private HttpSession httpSession;



    /**
     * 供应商list
     * @param supplierVo
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */

    @RequestMapping(value = "list", method = RequestMethod.GET)
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "供应商列表")
    public String supplierList(SupplierVo supplierVo, Integer pageNum,
                               Integer pageSize, ModelMap model){

        PageInfo<SupplierVo> supplierVoPageInfo = supplierService.findVoByParams(supplierVo,pageNum,pageSize);
        model.put("supplierVoPageInfo",supplierVoPageInfo);


        return "supplier_list";
    }

    /**
     * 删除非签约供应商信息
     * @param supplierId
     * @return
     */
    @RequestMapping(value = "del/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Result del(@PathVariable("id") Integer supplierId){
        supplierService.deleteById(supplierId);
        return Result.success("删除成功");
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    public String createSupplier(ModelMap model){
        //查询全国所有省份，供一级区域菜单使用，故parentid为100000
        Integer parentid = 100000;
        List<Area> provinces = areaService.findByParent(parentid);
        model.put("provinces", provinces);
        return "supplier/supplier_add";
    }




    /**
     * 供应商详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    @SecurityToken(generateToken = true)
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "供应商详情")
    public String supplierDetail(@PathVariable("id") Integer id,ModelMap model){

        SupplierVo supplierVo=supplierService.findVoById(id);


        List<SupplierCommodityVo> commodityVos=supplierCommodityService.findBySupplierId(id);

        model.put("supplierVo",supplierVo);
        model.put("commodityVos",commodityVos);

        //查出该供应商区域数据
        AreaVo areaVo = areaService.findVoById(supplierVo.getArea());
        //省份数据
        Integer parentid = 100000;
        List<Area> provinces = areaService.findByParent(parentid);
        if(areaVo!=null){
            //城市数据
            List<Area> cities = areaService.findByParent(areaVo.getProvinceId());
            //地区数据
            List<Area> areaVos = areaService.findByParent(areaVo.getCityId());
            model.put("cities", cities);
            model.put("areaVos", areaVos);
        }


        model.put("areaVo", areaVo);
        model.put("provinces", provinces);


        //读取跟踪记录数据
        UserTrackRecordVo userTrackRecordVo = new UserTrackRecordVo();
        userTrackRecordVo.setSupplierId(id);
        List<UserTrackRecordVo> userTrackRecordVos = userTrackRecordService.findByParamsNoPage(userTrackRecordVo);
        model.put("userTrackRecordVos", userTrackRecordVos);

        return "supplier/supplier_detail";
    }

    /**
     * 保存供应商
     * @param supplierVo
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @SecurityToken(validateToken=true)
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "保存供应商")
    public Result saveSupplier(SupplierVo supplierVo){
        supplierService.save(supplierVo);
        return Result.success("保存成功");
    }

    /**
     * 根据姓名查询供应商
     * @param name
     * @return
     */
    @RequestMapping(value = "search", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "根据姓名查询供应商")
    public Result search(String name){
        UserVo userVo = new UserVo();
        userVo.setName(name);
        return Result.success("供应商列表").data(userService.findByParamsNoPage(userVo));
        //以前是商品表跟supplier表关联,现在是商品表跟user表关联,故修改如上 add by kevin 20170311
        //return Result.success("供应商列表").data(supplierService.search(name));
    }

    /**
     * 供应商签约入驻
     * @param supplierVo
     * @return
     */
    @RequestMapping(value = "sign", method = RequestMethod.POST)
    @ResponseBody
    @BizLog(type = LogTypeConstant.SUPPLIER, desc = "签约供应商")
    public Result sign(SupplierVo supplierVo, String pwd){

        SupplierVo old=supplierService.findVoById(supplierVo.getId());
        if(old.getStatus()!=SupplierStatusEnum.INVEST.getType()){
            Result result = Result.error().msg("必须实地考察才能签约");

            return result;
        }

        //supplier数据转存到user
        UserVo userVo = new UserVo();
        userVo.setType(UserTypeEnum.supplier.getType());
        userVo.setPhone(supplierVo.getPhone());
        userVo.setPassword(pwd);

        UserDetailVo userDetailVo = new UserDetailVo();
        userDetailVo.setName(supplierVo.getName());
        userDetailVo.setPhone(supplierVo.getPhone());
        userDetailVo.setCategoryIds(supplierVo.getEnterCategory());
        userDetailVo.setCompany(supplierVo.getCompany());
        userDetailVo.setArea(supplierVo.getArea());
        userDetailVo.setEmail(supplierVo.getEmail());
        userDetailVo.setQq(supplierVo.getQq());
        userDetailVo.setRemark(supplierVo.getMark());
        userDetailVo.setContract(ContractEnum.IS_NOT_CONTRACT.getKey());
        userVo = userService.sign(userVo, userDetailVo);



        //supplier的user_track_record添加user_id字段值
        UserTrackRecord userTrackRecord = new UserTrackRecord();
        userTrackRecord.setUserId(userVo.getId());
        userTrackRecord.setSupplierId(supplierVo.getId());
        userTrackRecordService.update(userTrackRecord);

        //删除supplier的值
//        supplierService.deleteById(supplierVo.getId());

        //发短信（短信需要手机号，模板id及params）和微信（微信模板消息需要，模板id，openid及params map）
        if(userVo.getOpenid() != null) {
            WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
            templateMessage.setToUser(userVo.getOpenid());
            templateMessage.setTemplateId(WxSupplierSignTemplateEnum.TEMPLATEID.get());
            templateMessage.setUrl(WxSupplierSignTemplateEnum.URL.get());
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM1_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM1_VALUE.get(), WxSupplierSignTemplateEnum.PARAM1_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM2_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM2_VALUE.get(), WxSupplierSignTemplateEnum.PARAM2_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM3_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM3_VALUE.get(), WxSupplierSignTemplateEnum.PARAM3_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM4_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM4_VALUE.get(), WxSupplierSignTemplateEnum.PARAM4_COLOR.get()));
            templateMessage.getData().add(new WxMpTemplateData(WxSupplierSignTemplateEnum.PARAM5_NAME.get(),
                    WxSupplierSignTemplateEnum.PARAM5_VALUE.get().replace("{1}", supplierVo.getPhone()).replace("{2}", pwd),
                    WxSupplierSignTemplateEnum.PARAM5_COLOR.get()));

            WxTemplateEvent wt = new WxTemplateEvent(templateMessage);
            applicationContext.publishEvent(wt);
        }

        SmsTemplateEvent sms = new SmsTemplateEvent(supplierVo.getPhone(), pwd);
        applicationContext.publishEvent(sms);

        return Result.success("保存成功");
    }

	    /**
     * 签约供应商列表
     * @param user
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "signlist", method = RequestMethod.GET)
    public String signlist(UserVo user, Integer pageNum, Integer pageSize, ModelMap model){
        // 只查询供应商商的用户
        user.setType(UserTypeEnum.supplier.getType());
        PageInfo<UserVo> pageInfo = userService.findVoByParams(user, pageNum, pageSize);
        model.put("pageInfo", pageInfo);
        return "suppliersign_list";
    }

    /**
     * 签约供应商详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "signdetail/{id}", method = RequestMethod.GET)
    public String supplierSignDetail(@PathVariable("id") Integer id,ModelMap model){
        UserVo userVo = userService.findById(id);
        userVo.setSourceName(UserSourceEnum.get(userVo.getSource()));
        model.put("userVo",userVo);

        List<CommodityVo> commodityVos=commodityService.findBySupplier(id);
        model.put("commodityVos", commodityVos);

        //查出该供应商区域数据
        AreaVo areaVo = areaService.findVoById(userVo.getArea());
        //省份数据
        Integer parentid = 100000;
        List<Area> provinces = areaService.findByParent(parentid);
        List<Area> cities = null,
                areaVos = null;
        if(areaVo != null){
            //城市数据
            cities = areaService.findByParent(areaVo.getProvinceId());
            //地区数据
            areaVos = areaService.findByParent(areaVo.getCityId());
        }
        model.put("areaVo", areaVo);
        model.put("provinces", provinces);
        model.put("cities", cities);
        model.put("areaVos", areaVos);

        //获取跟踪记录
        UserTrackRecordVo userTrackRecordVo = new UserTrackRecordVo();
        userTrackRecordVo.setUserId(userVo.getId());
        List<UserTrackRecordVo> userTrackRecordVos = userTrackRecordService.findByParamsNoPage(userTrackRecordVo);
        model.put("userTrackRecordVos", userTrackRecordVos);

        //读取图片信息
        UserAnnexVo userAnnexVo = new UserAnnexVo();
        userAnnexVo.setUserId(id);
        List<UserAnnexVo> userAnnexVos = userAnnexService.findByParamsNoPage(userAnnexVo);
        model.put("userAnnexVos", userAnnexVos);

        return "suppliersign_detail";
    }

    /**
     * 保存签约供应商信息
     * @param userVo
     * @return
     */
    @RequestMapping(value = "signsave", method = RequestMethod.POST)
    @ResponseBody
    public Result saveSupplier(UserVo userVo){
        userService.signSave(userVo);
        return Result.success("保存成功");
    }

    /**
     * 保存供应商信息
     * @param userId
     * @param url
     * @return
     */
    @RequestMapping(value = "annex", method = RequestMethod.GET)
    @ResponseBody
    public Result annex(Integer userId, String url){
        UserAnnexVo userAnnexVo = new UserAnnexVo();
        userAnnexVo.setUserId(userId);
        userAnnexVo.setUrl(url);
        userAnnexVo.setCreateTime(new Date());
        userAnnexService.save(userAnnexVo);
        return Result.success("保存成功");
    }

    /**
     * 删除供应商信息
     * @param annexId
     * @return
     */
    @RequestMapping(value = "annexdel", method = RequestMethod.GET)
    @ResponseBody
    public Result annexdel(Integer annexId){
        userAnnexService.deleteFileById(annexId);
        return Result.success("删除成功");
    }

    /**
     * 供应商商品改价页面
     * @param id
     * @return
     */
    @RequestMapping(value = "{id}/commodity", method = RequestMethod.GET)
    public String commodity(@PathVariable("id") Integer id, ModelMap model){
        UserVo uv = new UserVo();
        uv.setSupplierId(id);
        //判断该供应商有没有绑定用户
        List<UserVo> userVos = userService.findByParamsNoPage(uv);
        model.put("isbinding", userVos.size());
        model.put("supplierId", id);
        if(userVos.size() == 0){
            return "supplier/supplier_commodity";
        }
        uv = userVos.get(0);

        //取出绑定用户的商品
        List<CommodityVo> commodityVos=commodityService.findBySupplier(uv.getId());
        model.put("commodityVos", commodityVos);

        //获取跟踪记录
        //"我的消息"
        MessageVo messageVo = new MessageVo();
        messageVo.setUserId(uv.getId());
        List<Integer> types = new ArrayList<Integer>();
        types.add(MessageEnum.SUPPLIER_SAMPLES.get());
        types.add(MessageEnum.SUPPLIER_COMMODITY.get());
        types.add(MessageEnum.SUPPLIER_ORDER.get());
        messageVo.setTypes(types);
        List<MessageVo> messageVos = messageService.findByParamsNoPage(messageVo);
        model.put("messageVos", messageVos);

        return "supplier/supplier_commodity";
    }
    /**
     * 核实供应商(包括正确和不正确)
     * @param supplierCertifyVo
     * @return
     */

    @RequestMapping(value = "verify", method = RequestMethod.POST)
    @ResponseBody
    public Result verify(@RequestBody SupplierCertifyVo supplierCertifyVo){
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        supplierCertifyVo.setMemberId(mem.getId());
        SupplierVo supplierVo=supplierCertifyVo.getSupplier();
        if(supplierVo.getId()==null){
            if(supplierService.existSupplier(supplierVo.getPhone())){
                Result result = Result.error().msg("存在该手机号对应的供货商");

                return result;
            }

        }

        supplierService.certify(supplierCertifyVo);
        return Result.success("核实成功");
    }

    @RequestMapping(value = "judge/{id}", method = RequestMethod.GET)
    public String judge(@PathVariable("id") Integer id,ModelMap model){
        SupplierVo supplierVo=supplierService.findVoById(id);

        //所有问题
        List<SurveyVo> questions=surveyService.allQuestions();

        List<SupplierChoiceVo> supplierChoices=supplierChoiceService.findBySupplierId(id);

        List<SupplierContactVo> contactVos=supplierContactService.findBySupplierId(id);

        List<SupplierAnnexVo> supplierAnnexVos=supplierAnnexService.findBySupplierId(id);



        model.put("supplierVo",supplierVo);
        model.put("questions",questions);
        model.put("supplierChoices",supplierChoices);
        model.put("contactVos",contactVos);
        model.put("supplierAnnexVos",supplierAnnexVos);

        return "supplier/supplier_judge";
    }

    @RequestMapping(value = "/saveJudge", method = RequestMethod.POST)
    @ResponseBody
    public Result saveJudge(@RequestBody SupplierJudgeVo supplierJudgeVo){
        Member mem= (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
        SupplierVo old=supplierService.findVoById(supplierJudgeVo.getSupplierVo().getId());
        if(old.getStatus()!= SupplierStatusEnum.UNVERIFY.getType()){
            supplierJudgeVo.setMemberId(mem.getId());
            supplierService.judge(supplierJudgeVo);
            return Result.success("评价成功");

        }
        else{
            Result result = Result.error().msg("必须核实才能登记");

            return result;
        }


    }




}
