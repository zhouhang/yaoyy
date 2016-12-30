package com.ms.dao.enums;

/**
 * Created by xiao on 2016/12/30.
 * 前台跟踪记录描述
 */
public enum BizPickTrackingTypeEnum {
    PICK_APPLY(0,"提交采购单"),
    PICK_AGREE(1,"客服受理了采购单，等待客服为您报价"),
    PICK_REFUSE(2,"不能受理选货单"),
    PICK_RECORD(3,"跟踪记录"),
    PICK_NOT_FINISH(4,"客服取消了该订单"),
    PICK_FINISH(5,"该采购单交易完成"),
    PICK_ORDER(6,"客服已为您报价，请尽快完成支付  若有疑问咨询电话："),
    PICK_RECEIPT(7,"您已确认收货，如货物有质量问题 药优优平台为您提供完善的售后保障 联系电话：0558-5120088"),
    PICK_PAYALL(8,"您的付款确认无误，我们工作人员正在为您做发货准备"),
    PICK_PAYPOSIT(9,"支付了保证金"),
    PICK_ORDER_DELIVERIED(11,"我们已经为您发货，在收货后请点击确认收货按钮确认收货"),
    PICK_CONFIRM(12,"确认了订单"),
    PICK_UPDATE(13,"修改了订单"),
    PICK_SUBMIT_PAY(14,"您已经提交了支付信息，客服审核后会联系您并为您发货"),
    PICK_CANCEL(15,"订单已取消");









    private BizPickTrackingTypeEnum(Integer value, String text) {
        this.value = value;
        this.text = text;
    }

    private Integer value;
    private String text;
    public Integer getValue() {
        return value;
    }
    public void setValue(Integer value) {
        this.value = value;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }

    /**
     * 通过ID来查询属性名称
     *
     * @param id
     * @return
     */
    public static String findByValue(Integer id) {
        for (BizPickTrackingTypeEnum trackingEnum: BizPickTrackingTypeEnum.values()) {
            if (trackingEnum.getValue().equals(id)) {
                return trackingEnum.getText();
            }
        }
        return null;
    }



}
