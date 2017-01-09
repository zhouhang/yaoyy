<!DOCTYPE html>
<html lang="en">
<head>
    <title>付款-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">支付宝</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="pay">
        <div class="banner">
            <img src="assets/images/alipay.png" alt="" width="160">
        </div>
        <div class="hd">
            <em>需付金额：<strong>&yen;${money!}</strong>元</em>
            <span>请在三天内完成汇款，否则订单会自动被取消。</span>
        </div>
        <div class="button">
            <button type="button" class="ubtn ubtn-primary" id="submit">支付宝支付</button>
        </div>
    </div>
    <form id="alipayment" action='/alipay/pay' method=post target="_blank">
        <input type="hidden"  name="orderId" value="${orderId!}">
        <input type="hidden" name="billId" value="${billId!}">
        <input type="hidden" name="userId" value="${userId!}">
    </form>
</section><!-- /ui-content -->

<div class="dialog-mask" id="jtips">
    <h2 class="hd">点击这里</h2>
    <div class="bd">
        <p>然后点击 <em>在浏览器打开</em></p>
        <p>微信客户端不支持支付宝支付，请用浏览器打开该页面再进行支付</p>
    </div>
    <img src="assets/img/guide.png" width="85" height="115" class="guide">
</div>
<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.submit();
            },
            submit: function() {
                var self = this;
                $('#submit').click(function () {
                    if (_YYY.is_weixn) {
                        $('#jtips').show();
                    } else {
                       $("#alipayment").submit();
                    }
                });


                $('#jtips').on('click', function() {
                    $(this).hide();
                });
            }
        }
    }

    $(function(){
        _global.fn.init();
    });
</script>
</body>
</html>