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

            <p><span>订单号：</span><a href="/pick/detail/${pick.id!}"><em class="blue">${pick.code!}</em></a></p>

            <p><span>账单号：</span>${bill.code!}</p>

            <p><span>商品总价：</span><b>&yen;${pick.sum}</b>元</p>

            <p><span>运费：</span><b>&yen;${pick.shippingCosts}</b>元</p>
            <p><span>包装加工费：</span><b>&yen;${pick.bagging?default(0)}</b>元<#if !(pick.bagging?exists) || pick.bagging ==0>（免包装加工费）</#if></p>
            <#--
            <p><span>检测费：</span><b>&yen;${pick.checking?default(0)}</b>元<#if !(pick.checking?exists) || pick.checking ==0>（免检测费）</#if></p>
            -->
            <p><span>税款：</span><b>&yen;${pick.taxation}</b>元</p>

            <p class="f18"><span>总计：</span><b>&yen;${pick.amountsPayable}</b>元</p>
        </div>
        <div class="bd">
            <p class="tit">账单详情</p>
            <p><span>订单总金额：</span><b>&yen;${bill.amountsPayable!}</b>元</p>
            <p><span>已支付：</span><b>&yen;${bill.alreadyPayable}</b>元</p>
            <p><span>欠款：</span><b>&yen;${bill.unpaid}</b>元</p>
            <p><span>账期：</span>${bill.billTime!}天</p>
            <p><span>剩余账期：</span>${bill.timeLeft}</p>
        </div>

        <#if bill.status == 0>
        <div class="button">
            <button type="button"  id="wxpay" class="ubtn ubtn-primary">微信支付</button>
            <button type="button" id="alipay" class="ubtn ubtn-primary">支付宝支付</button>
            <a href="/bill/bankTransfer?billId=${bill.id}" class="ubtn ubtn-primary">银行转账</a>
        </div>
        </#if>
        <div class="ui-extra">
            咨询电话：<a href="tel:${consumerHotline}" target="_blank">${consumerHotline}</a>
        </div>

    </div>

</section><!-- /ui-content -->
<#include "./common/footer.ftl"/>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>

    var _global = {
        v:{

        },
        fn: {
            init: function() {
                this.bindEven();
            },
            bindEven: function () {
                var self = this,
                        wait = false;
                $("#wxpay").click(function(){
                    self.wxpay();
                })
                $("#alipay").click(function(){
                    self.alipay();
                })

            },
            //微信支付
            wxpay:function(){
                $.ajax({
                    url: "/wechat/pay",
                    data: { billId:${bill.id}},
                    type: "POST",
                    success: function(result) {
                        console.log(result);
                        var obj = result.data;
                        WeixinJSBridge.invoke('getBrandWCPayRequest',{
                            "appId" : obj.appId,                  //公众号名称，由商户传入
                            "timeStamp":obj.timeStamp,          //时间戳，自 1970 年以来的秒数
                            "nonceStr" : obj.nonceStr,         //随机串
                            "package" : obj.package,      //<span style="font-family:微软雅黑;">商品包信息</span>
                            "signType" : obj.signType,        //微信签名方式:
                            "paySign" : obj.paySign           //微信签名
                        },function(res){
                            if(res.err_msg == "get_brand_wcpay_request:ok") {
                                window.location.href ="/pick/paySuccess?billId="+${bill.id};
                            }
                        });
                    }
                })
            },
            //支付宝支付
            alipay:function(){
                window.location.href ="alipay/index?billId=${bill.id}&authId=${authId}";
            },
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>