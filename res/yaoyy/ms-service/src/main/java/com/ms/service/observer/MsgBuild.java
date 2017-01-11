package com.ms.service.observer;

import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.PickVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.service.enums.MessageEnum;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Author: koabs
 * 1/10/17.
 */
public class MsgBuild {
    public static SendMsg build(PickVo vo, MessageEnum type){
        String url = "http://www.yaobest.com/pick/detail/";
        SendMsg msg = new SendMsg();
        List<String> names = new ArrayList<>();
        vo.setSum(0F);
        vo.getPickCommodityVoList().forEach(c -> {
            names.add(c.getName());
            vo.setSum(vo.getSum()+c.getTotal());
        });
        switch (type) {
            case PICK :
                msg.content = vo.getNickname() + " 提交了一个新订货登记通知 " +
                        "\n\n商品：" + StringUtils.join(names, ",") +
                        "\n姓名：" + vo.getNickname() +
                        "\n手机号：" + vo.getPhone() +
                        "\n\n请在后台选货单列表查看";

                msg.title = "新订货登记通知";
                break;
            case PICK_C:
                msg.content =" 您提交了一张采购单，客服会在半个小时之内与您联系" +
                        "\n\n采购商品：" + StringUtils.join(names, ",") +
                        "\n姓名：" + vo.getNickname() +
                        "\n手机号：" + vo.getPhone();

                msg.title = "您提交了一张采购单";
                msg.url = url+vo.getId();
                break;
            case PICK_ACCEPT:
                msg.content ="您的订单已被受理" +
                        "\n\n您的订单已被受理，商品总价"+vo.getSum()+"元，客服马上会为您核算运费等其他费用。";

                msg.title = "您的订单已被受理";
                msg.url = url+vo.getId();
                break;
            case PICK_CONFIRM:

                msg.content =" 您的订单已核算完毕" +
                        "\n\n商品总价：" + vo.getSum() +
                        "\n运费：" + ((vo.getShippingCosts() == 0)?"0元（免运费）":vo.getShippingCosts()) +
                        "\n包装费：" + ((vo.getBagging()== 0)?"0元（免包装费）":vo.getBagging()) +
                        "\n检查费：" + ((vo.getChecking()==0)?"0元（免检查费）":vo.getChecking()) +
                        "\n税费：" + vo.getTaxation() +
                        "\n总计：" + vo.getAmountsPayable();

                if (Integer.valueOf(0).equals(vo.getSettleType())){
                    msg.content += "为了不耽误您的发货，请尽快在订单详情页进行付款.";
                } else if (Integer.valueOf(1).equals(vo.getSettleType())) {
                    msg.content += "本次需付款 "+vo.getDeposit()+"元，为了不耽误您的发货，请尽快在订单详情页进行付款.";
                } else if (Integer.valueOf(2).equals(vo.getSettleType())) {
                    msg.content += "请在订单详情页进行确认，我们会在您确认后马上为您发货。";
                }

                msg.title = "您的订单已核算完毕";
                msg.url = url+vo.getId();
                break;
            case PICK_DELIVERY:
                msg.content ="您的订单号“"+vo.getCode()+"”的货物已经为您发货，请做好收货准备。点击查看物流详细信息。";
                msg.title = "《药优优》平台已为您发货";
                msg.url = url+vo.getId();
                break;
            case PICK_FINISH:
                msg.content ="您的订单号“"+vo.getCode() +"”的订单已完成。若有货物问题药优优平台为您提供完善的售后保障，联系电话：0558-5120088  ";
                msg.title = "订单已完成";
                msg.url = url+vo.getId();
                break;
            default:
                msg = null; break;
        }
        return msg;
    }

    public static SendMsg build(PayRecordVo vo, MessageEnum type){
        SendMsg msg = new SendMsg();
        switch (type) {
            case PAY_BANK:
                msg.content ="客户 "+ vo .getNickname()+" 提交了银行转账支付凭证，支付金额"+vo.getActualPayment()+"元，订单号"+vo.getCode()+"。请在订单详情页面查看并确认";
                msg.title = "客户提交了银行转账";
                break;
            case PAY_ONLINE:
                msg.content ="客户 "+ vo .getNickname()+" 已支付金额"+vo.getActualPayment()+"元，订单号"+vo.getCode()+"。请在订单详情页面查看并发货";
                msg.title = "客户进行了在线支付";
                break;
            default:
                msg = null; break;
        }
        return msg;
    }


    public static SendMsg build(SendSampleVo vo) {
        SendMsg msg = new SendMsg();
        List<String> names = new ArrayList<>();
        vo.getCommodityList().forEach(c -> {
            names.add(c.getName() + ' ' + c.getOrigin() + ' ' + c.getSpec());
        });
        msg.content = vo.getNickname() + " 新寄样申请通知 " +
                "\n\n商品：" + StringUtils.join(names, "\n") +
                "\n姓名：" + vo.getNickname() +
                "\n手机号：" + vo.getPhone() +
                "\n地区：" + vo.getArea() +
                "\n\n请在后台寄样列表查看";
        msg.title = "新寄样申请通知";
        return msg;
    }

    public static String buildSMS(PickVo vo) {
        String msg;
        msg =" 您的订单已核算完毕" +
                "商品总价：" + vo.getSum() +
                "运费：" + ((vo.getShippingCosts() == 0)?"0元（免运费）":vo.getShippingCosts()) +
                "包装费：" + ((vo.getBagging()== 0)?"0元（免包装费）":vo.getBagging()) +
                "检查费：" + ((vo.getChecking()==0)?"0元（免检查费）":vo.getChecking()) +
                "税费：" + vo.getTaxation() +
                "总计：" + vo.getAmountsPayable();
        if (Integer.valueOf(0).equals(vo.getSettleType())){
            msg += "为了不耽误您的发货，请尽快在订单详情页进行付款.";
        } else if (Integer.valueOf(1).equals(vo.getSettleType())) {
            msg += "本次需付款 "+vo.getDeposit()+"元，为了不耽误您的发货，请尽快在订单详情页进行付款.";
        } else if (Integer.valueOf(2).equals(vo.getSettleType())) {
            msg += "请在订单详情页进行确认，我们会在您确认后马上为您发货。";
        }
        return  msg;
    }

}

class  SendMsg {
    public SendMsg() {
    }
    public String title;
    public String content;
    public String url;
}
