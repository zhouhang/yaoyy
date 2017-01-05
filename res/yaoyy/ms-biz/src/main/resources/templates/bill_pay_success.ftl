<!DOCTYPE html>
<html lang="en">
<head>
    <title>支付结果-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">银行转账</div>
    <div class="abs-l mid">
        <a href="/bill/detail/${billId}" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="ui-notice ui-notice-w">
        <p><strong>感谢您进行了银行转账</strong></p>
        <!-- <p><strong>恭喜您！支付成功</strong></p>  -->
        <p>客服将马上验证你的支付信息 / 联系电话：${consumerHotline}</p>
        <a class="ubtn ubtn-primary" href="/bill/detail/${billId}">返回账单</a>
    </div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
</body>
</html>