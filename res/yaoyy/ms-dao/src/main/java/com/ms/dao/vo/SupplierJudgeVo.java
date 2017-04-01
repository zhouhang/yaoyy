package com.ms.dao.vo;

import com.ms.dao.model.Supplier;
import com.ms.dao.model.SupplierAnnex;
import com.ms.dao.model.SupplierChoice;

import java.util.List;

/**
 * Created by xc on 2017/3/23.
 */
public class SupplierJudgeVo {

    private SupplierVo supplierVo;

    private List<SupplierContactVo> contacts;

    private List<SupplierAnnexVo> annexVos;

    private List<SupplierChoiceVo> choiceVos;

    private Integer memberId;


    public SupplierVo getSupplierVo() {
        return supplierVo;
    }

    public void setSupplierVo(SupplierVo supplierVo) {
        this.supplierVo = supplierVo;
    }

    public List<SupplierContactVo> getContacts() {
        return contacts;
    }

    public void setContacts(List<SupplierContactVo> contacts) {
        this.contacts = contacts;
    }

    public List<SupplierAnnexVo> getAnnexVos() {
        return annexVos;
    }

    public void setAnnexVos(List<SupplierAnnexVo> annexVos) {
        this.annexVos = annexVos;
    }

    public List<SupplierChoiceVo> getChoiceVos() {
        return choiceVos;
    }

    public void setChoiceVos(List<SupplierChoiceVo> choiceVos) {
        this.choiceVos = choiceVos;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }
}
