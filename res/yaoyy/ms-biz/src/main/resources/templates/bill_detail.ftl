<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>账单详情-药优优</title>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">账单详情</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">

    <div class="bill">
        <div class="bd">
            <p class="tit">订单详情</p>

            <p><span>订单号：</span><em class="blue">${pick.code!}</em></p>

            <p><span>账单号：</span>${bill.code!}</p>

            <p><span>商品总价：</span><b>&yen;${pick.sum}</b>元</p>

            <p><span>运费：</span><b>&yen;${pick.shippingCosts}</b>元</p>
            <p><span>包装费：</span><b>&yen;${pick.bagging?default(0)}</b>元<#if !(pick.bagging?exists) || pick.bagging ==0>（免包装费）</#if></p>

            <p><span>检测费：</span><b>&yen;${pick.checking?default(0)}</b>元<#if !(pick.checking?exists) || pick.checking ==0>（免检测费）</#if></p>

            <p><span>税款：</span><b>&yen;${pick.taxation}</b>元</p>

            <p class="f18"><span>总计：</span><b>&yen;${pick.amountsPayable}</b>元</p>
        </div>
        <div class="bd">
            <p class="tit">账单详情</p>
            <p><span>订单总金额：</span><b>&yen;${bill.amountsPayable!}</b>元</p>
            <p><span>已支付：</span><b>&yen;${bill.alreadyPayable}</b>元</p>
            <p><span>欠款：</span><b>&yen;${bill.amountsPayable - bill.alreadyPayable}</b>元</p>
            <p><span>账期：</span>${bill.billTime!}天</p>
            <p><span>剩余账期：</span>${bill.timeLeft}</p>
        </div>

        <#if bill.status == 0>
        <div class="button">
            <button type="button" class="ubtn ubtn-primary">微信支付</button>
            <button type="button" class="ubtn ubtn-primary">支付宝支付</button>
            <button type="button" class="ubtn ubtn-primary">银行转账</button>
        </div>
        </#if>
        <div class="ui-extra">
            咨询电话：<a href="tel:${consumerHotline}" target="_blank">${consumerHotline}</a>
        </div>

    </div>

</section><!-- /ui-content -->

</body>
</html>