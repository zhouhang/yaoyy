<!DOCTYPE html>
<html lang="en">
<head>
    <title>支付结果-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="body2">
<header class="ui-header">
    <div class="title">银行转账</div>
    <div class="abs-l mid">
        <a href="/pick/detail/${orderId}" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="ui-notice ui-notice-w">
        <p><strong>感谢您进行了银行转账</strong></p>
        <!-- <p><strong>恭喜您！支付成功</strong></p>  -->
        <p>客服验证后会马上为您发货 / 联系电话：${consumerHotline}</p>
        <a class="ubtn ubtn-primary" href="/pick/detail/${orderId}">返回订单</a>
    </div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
</body>
</html>