package com.ms.dao.enums;

/**
 * Created by xiao on 2016/10/28.
 */
public enum PickEnum {

    PICK_NOTHANDLE(0,"未受理"),
    PICK_HANDING(1,"已受理"),
    PICK_NOTFINISH(2,"交易未完成"),
    PICK_FINISH(3,"交易已完成"),
    PICK_REFUSE(4,"审核不通过");




    private PickEnum (Integer value, String text) {
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
        for (PickEnum  pickEnum: PickEnum.values()) {
            if (pickEnum.getValue().equals(id)) {
                return pickEnum.getText();
            }
        }
        return null;
    }
}
