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
    private static String url = "http://www.yaobest.com/pick/detail/";

    public static SendMsg build(PickVo vo, MessageEnum type){

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
                        "\n\n请在后台订单列表查看";

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
                        "\n\n您的订单号"+vo.getCode()+"("+StringUtils.join(names, ",")+")的订单已被受理，客服马上会为您核算运费等其他费用。";

                msg.title = "您的订单已被受理";
                msg.url = url+vo.getId();
                break;
            case PICK_CONFIRM:

                msg.content =" 您的订单号“"+vo.getCode()+"("+StringUtils.join(names, ",")+")”已核算完毕" +
                        "\n\n商品总价：" + vo.getSum() + "元"+
                        "\n运费：" + ((vo.getShippingCosts() == 0)?"0元（免运费）":(vo.getShippingCosts()+"元")) +
                        "\n包装费：" + ((vo.getBagging()== 0)?"0元（免包装费）":(vo.getBagging()+"元")) +
                        "\n检测费：" + ((vo.getChecking()==0)?"0元（免检测费）":(vo.getChecking()+"元")) +
                        "\n税费：" + vo.getTaxation() + "元"+
                        "\n总计：" + vo.getAmountsPayable() +"元";

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
                msg.content ="您的订单号“"+vo.getCode()+"("+StringUtils.join(names, ",")+")”的货物已经为您发货，请做好收货准备。";
                msg.title = "药优优平台已为您发货";
                msg.url = url+vo.getId();
                break;
            case PAY_SUCCESS:
                //
                msg.content ="您的订单号“"+vo.getCode()+"("+StringUtils.join(names, ",")+")” 已经付款成功，工作人员正在为您做发货准备。";
                msg.title = "您的订单已付款成功";
                msg.url = url + vo.getId();
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
                msg.title = "有一笔订单进行了银行转账";
                break;
            case PAY_ONLINE:
                msg.content ="客户 "+ vo .getNickname()+" 已支付金额"+vo.getActualPayment()+"元，订单号"+vo.getCode()+"。请在订单详情页面查看并发货";
                msg.title = "有一笔订单进行了支付";
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
        msg.content = vo.getNickname() + " 提交了新寄样申请通知 " +
                "\n\n商品：" + StringUtils.join(names, "\n") +
                "\n姓名：" + vo.getNickname() +
                "\n手机号：" + vo.getPhone() +
                "\n地区：" + vo.getArea() +
                "\n\n请在后台寄样列表查看";
        msg.title = "新寄样申请通知";
        return msg;
    }

    public static String buildSMS(PickVo vo) {
        List<String> names = new ArrayList<>();
        vo.setSum(0F);
        vo.getPickCommodityVoList().forEach(c -> {
            names.add(c.getName());
            vo.setSum(vo.getSum()+c.getTotal());
        });
        String msg;
        msg ="【药优优】您的订单号“"+vo.getCode()+"("+StringUtils.join(names, ",")+")”的订单已核算完毕。" +
                "商品总价：" + vo.getSum() + "元 " +
                "运费：" + ((vo.getShippingCosts() == 0)?"0元（免运费）":(vo.getShippingCosts() + "元 "))+
                "包装费：" + ((vo.getBagging()== 0)?"0元（免包装费）":(vo.getBagging() + "元 "))+
                "检测费：" + ((vo.getChecking()==0)?"0元（免检测费）":(vo.getChecking() + "元 "))+
                "税费：" + vo.getTaxation() + "元 " +
                "总计：" + vo.getAmountsPayable() + "元 ";
        if (Integer.valueOf(0).equals(vo.getSettleType())){
            msg += "为了不耽误您的发货，请尽快在订单详情页进行付款。";
        } else if (Integer.valueOf(1).equals(vo.getSettleType())) {
            msg += "本次需付款 "+vo.getDeposit()+"元，为了不耽误您的发货，请尽快在订单详情页进行付款。";
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
