<!DOCTYPE html>
<html lang="en">
<head>
    <title>药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body body-gray">
<header class="ui-header">
    <div class="logo">药优优药材商城</div>
</header><!-- /ui-header -->

<#include "./common/navigation.ftl">

<section class="ui-content">
    <ul>
        <li>
            <a id="payBtn" class="current" href="javascript:;"       >
                <i class="fa fa-home"></i>
                <span>支付按钮</span>
            </a>
        </li>
    </ul>


</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>

    $(function(){

        $("#payBtn").click(function(){

            $.ajax({
                url: "/wechat/pay",
                data: {},
                type: "POST",
                contentType : 'application/json',
                success: function(result) {
                    //  https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=7_7&index=6
                    var obj = result.data;
                    WeixinJSBridge.invoke('getBrandWCPayRequest',{
                        "appId" : obj.appId,                  //公众号名称，由商户传入
                        "timeStamp":obj.timeStamp,          //时间戳，自 1970 年以来的秒数
                        "nonceStr" : obj.nonceStr,         //随机串
                        "package" : obj.package,      //<span style="font-family:微软雅黑;">商品包信息</span>
                        "signType" : obj.signType,        //微信签名方式:
                        "paySign" : obj.paySign           //微信签名
                    },function(res){
//                        alert("errorcode:"+res.err_code+"desc:"+res.err_desc+"msg:"+res.err_msg);
                        console.log(res)
                    });
                }
            })

        })




    })




</script>
</body>
</html>