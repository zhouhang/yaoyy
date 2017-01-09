package com.ms.dao.enums;

/**
 * Created by xiao on 2016/10/28.
 */
public enum PickEnum {

    PICK_NOTHANDLE(0,"未受理"),
    PICK_HANDING(1,"已受理"),
    PICK_NOTFINISH(2,"交易未达成"),
    PICK_FINISH(3,"交易已完成"),
    PICK_REFUSE(4,"审核不通过"),
    PICK_PAY(5,"待支付"),
    PICK_DELIVERY(6,"待发货"),
    PICK_DELIVERIED(7,"已发货"),
    PICK_CONFIRM(8,"待用户确认"),
    PICK_CANCLE(9,"已取消");





    private PickEnum (Integer value, String text) {
        this.value = value;
        this.text = text;
    }

    private Integer value;
    private String text;
    public Integer getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    /**
     * 通过ID来查询属性名称
     *
     * @param id
     * @return
     */
    public static String findByValue(Integer id) {
        for (PickEnum  pickEnum: PickEnum.values()) {
            if (pickEnum.getValue().equals(id)) {
                return pickEnum.getText();
            }
        }
        return null;
    }
}
