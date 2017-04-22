<!DOCTYPE html>
<html lang="en">
<head>
    <title>药优优</title>
<#include "../common/meta.ftl"/>
</head>
<body class="body1 body-bg">
<header class="ui-header">
    <div class="logo">药优优药材商城</div>
</header><!-- /ui-header -->

<#include "../common/navigation.ftl">

<section class="ui-content">
    <ul>
        <li>
            <a id="fenxiang" class="current" href="javascript:;"       >
                <i class="fa fa-home"></i>
                <span>分享按钮</span>
            </a>
        </li>
    </ul>


</section><!-- /ui-content -->

<#include "../common/footer.ftl"/>

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>

    $(function(){

        var title = "原来亳州的那些大户都来这里采购药材......";
        var desc = "药优优——原药材销售平台 优选好药，底价直采！ 质量保障，价格保障，货源保障！";
        var link = "${signature.url!}";
        var imgUrl = "${baseUrl}/assets/images/logo3.jpg";


        wx.config({
            debug: false,
            appId: '${signature.appid}',
            timestamp: ${signature.timestamp?string('#')},
            nonceStr: '${signature.noncestr}',
            signature: '${signature.signature}',
            jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'onMenuShareQZone'
            ]
        });

        wx.ready(function() {

            // 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareAppMessage({
                title: title,
                desc: desc,
                link: link,
                imgUrl: imgUrl,
                trigger: function(res) {
                    // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回

                },
                success: function(res) {

                },
                cancel: function(res) {

                },
                fail: function(res) {

                }
            });

            // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareTimeline({
                title: title,
                link: link,
                imgUrl: imgUrl,
                trigger: function(res) {
                    // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回

                },
                success: function(res) {

                },
                cancel: function(res) {

                },
                fail: function(res) {

                }
            });


            // 2.3 监听“分享到QQ”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareQQ({
                title: title,
                desc: desc,
                link: link,
                imgUrl: imgUrl,
                trigger: function(res) {
                },
                complete: function(res) {

                },
                success: function(res) {

                },
                cancel: function(res) {

                },
                fail: function(res) {

                }
            });

            // 2.4 监听“分享到微博”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareWeibo({
                title: title,
                desc: desc,
                link: link,
                imgUrl: imgUrl,
                trigger: function(res) {
                },
                complete: function(res) {
                },
                success: function(res) {
                },
                cancel: function(res) {
                },
                fail: function(res) {
                }
            });

            // 2.5 监听“分享到QZone”按钮点击、自定义分享内容及分享接口
            wx.onMenuShareQZone({
                title: title,
                desc: desc,
                link: link,
                imgUrl: imgUrl,
                trigger: function(res) {
                },
                complete: function(res) {
                },
                success: function(res) {
                },
                cancel: function(res) {
                },
                fail: function(res) {
                }
            });

        })

    })

</script>
</body>
</html>