<!DOCTYPE html>
<html lang="en">
<head>
    <title>支付结果-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">支付成功</div>
    <div class="abs-l mid">
       <#if orderId?exists>
        <a href="/pick/detail/${orderId}" class="fa fa-back"></a>
       <#elseif billId?exists>
           <a href="/bill/${billId}" class="fa fa-back"></a>
       </#if>

    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="ui-notice ui-notice-w">
        <p><strong>恭喜您！支付成功</strong></p>
        <#if orderId?exists>
        <p>客服验证后会马上为您发货 / 联系电话：${consumerHotline}</p>
        <a class="ubtn ubtn-primary" href="/pick/detail/${orderId}">返回订单</a>
        <#elseif billId?exists>
            <a class="ubtn ubtn-primary" href="/bill/${billId}">返回账单</a>
        </#if>
    </div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
</body>
</html>