<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>交易流水详情-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>账单流水管理</li>
                <li>交易流水详情</li>
            </ul>
        </div>

        <div class="box fa-form fa-form-info">
            <div class="hd">交易信息</div>
            <div class="item">
                <div class="txt">支付流水号：</div>
                <div class="val">${payRecordVo.payCode!}</div>
            </div>
            <div class="item">
                <div class="txt">单号：</div>
                <div class="val">
                 <#if payRecordVo.codeType==0>
                        <a class="c-blue" href="/pick/detail/${payRecordVo.orderId}">${payRecordVo.code!}</a>
                        <#else>
                        <a class="c-blue" href="/bill/detail/${payRecordVo.accountBillId}">${payRecordVo.code!}</a>
                        </#if>
                    </div>
            </div>
            <div class="item">
                <div class="txt">单号类型：</div>
                <div class="val">
                <#if payRecordVo.codeType==0>
                    订单
                <#else>
                    账单
                </#if></div>
            </div>
            <div class="item">
                <div class="txt">用户姓名：</div>
                <div class="val">${payRecordVo.nickname!}</div>
            </div>
            <div class="item">
                <div class="txt">用户手机：</div>
                <div class="val">${payRecordVo.phone!}</div>
            </div>
            <div class="item">
                <div class="txt">单位：</div>
                <div class="val">${payRecordVo.name!}</div>
            </div>
            <div class="item">
                <div class="txt">支付金额：</div>
                <div class="val">${payRecordVo.actualPayment!}元</div>
            </div>
            <div class="item">
                <div class="txt">支付渠道：</div>
                <div class="val">${payRecordVo.payTypeText!}</div>
            </div>
        </div>
       <#if payRecordVo.payType==0>
        <div class="box fa-form fa-form-info">

            <div class="hd">付款信息</div>
            <div class="item">
                <div class="txt">收款账户：</div>
                <div class="val">企业银行账户</div>
            </div>
            <div class="item">
                <div class="txt">开户行：</div>
                <div class="val">${payRecordVo.payBank!}</div>
            </div>
            <div class="item">
                <div class="txt">开户人：</div>
                <div class="val">${payRecordVo.payAccount!}</div>
            </div>
            <div class="item">
                <div class="txt">收款账户号：</div>
                <div class="val">${payRecordVo.payBankCard!}</div>
            </div>
            <div class="item">
                <div class="txt">支付凭证：</div>
                <#list payRecordVo.payDocuments as payDocument>
                <div class="val thumb"><img width="160" height="80" src="${payDocument.path}" alt=""></div>
                </#list>
            </div>
            <div class="item">
                <div class="txt">支付时间：</div>
                <div class="val">${payRecordVo.paymentTime?string("yyyy年MM月dd日 HH:mm")}</div>
            </div>
        </div>

        <div class="box fa-form fa-form-info">
            <div class="item">
                <div class="txt">支付结果：</div>
                <div class="val">
                    <#if payRecordVo.status==0>
                    付款待确认
                <#elseif payRecordVo.status==1>
                    支付成功
                <#elseif payRecordVo.status==2>
                    支付失败
                </#if></div>
            </div>
            <div class="item">
                <div class="txt">操作人员：</div>
                <div class="val">${payRecordVo.memberName!}</div>
            </div>
            <div class="item">
                <div class="txt">记录时间：</div>
                <div class="val">
                    <#if payRecordVo.operateTime?exists>
                    ${payRecordVo.operateTime?string("yyyy年MM月dd日 HH:mm")}
                    </#if>
                </div>
            </div>
        </div>
            <#else>
                <div class="box fa-form fa-form-info">

                    <div class="hd">付款信息</div>
                    <div class="item">
                        <div class="txt">收款账户：</div>
                        <div class="val">${payRecordVo.payTypeText!}</div>
                    </div>
                    <div class="item">
                        <div class="txt">微信账户号：</div>
                        <div class="val">${payRecordVo.payAccount!}</div>
                    </div>
                    <div class="item">
                        <div class="txt">支付时间：</div>
                        <div class="val">
                            <#if payRecordVo.paymentTime?exists>
                                 ${payRecordVo.paymentTime?string("yyyy年MM月dd日 HH:mm")}
                            </#if>
                        </div>
                    </div>
                </div>
            </#if>

    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('9-1');
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>