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
            <a id="fenxiang" class="current" href="javascript:;"       >
                <i class="fa fa-home"></i>
                <span>分享按钮</span>
            </a>
        </li>
    </ul>


</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>

    $(function(){

        var title = "";
        var desc = "药优优——原药材销售平台 优选好药，底价直采！ 质量保障，价格保障，货源保障！";
        var link = "";
        var imgUrl = "";


        wx.config({
            debug: true,
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
                title: '互联网之子',
                desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
                link: 'http://movie.douban.com/subject/25785114/',
                imgUrl: 'http://demo.open.weixin.qq.com/jssdk/images/p2166127561.jpg',
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
                title: '互联网之子',
                link: 'http://movie.douban.com/subject/25785114/',
                imgUrl: 'http://demo.open.weixin.qq.com/jssdk/images/p2166127561.jpg',
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
                title: '互联网之子',
                desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
                link: 'http://movie.douban.com/subject/25785114/',
                imgUrl: 'http://img3.douban.com/view/movie_poster_cover/spst/public/p2166127561.jpg',
                trigger: function(res) {
                    alert('用户点击分享到QQ');
                },
                complete: function(res) {
                    alert(JSON.stringify(res));
                },
                success: function(res) {
                    alert('已分享');
                },
                cancel: function(res) {
                    alert('已取消');
                },
                fail: function(res) {
                    alert(JSON.stringify(res));
                }
            });

            // 2.4 监听“分享到微博”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareWeibo({
                title: '互联网之子',
                desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
                link: 'http://movie.douban.com/subject/25785114/',
                imgUrl: 'http://img3.douban.com/view/movie_poster_cover/spst/public/p2166127561.jpg',
                trigger: function(res) {
                    alert('用户点击分享到微博');
                },
                complete: function(res) {
                    alert(JSON.stringify(res));
                },
                success: function(res) {
                    alert('已分享');
                },
                cancel: function(res) {
                    alert('已取消');
                },
                fail: function(res) {
                    alert(JSON.stringify(res));
                }
            });

            // 2.5 监听“分享到QZone”按钮点击、自定义分享内容及分享接口
            wx.onMenuShareQZone({
                title: '互联网之子',
                desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
                link: 'http://movie.douban.com/subject/25785114/',
                imgUrl: 'http://img3.douban.com/view/movie_poster_cover/spst/public/p2166127561.jpg',
                trigger: function(res) {
                    alert('用户点击分享到QZone');
                },
                complete: function(res) {
                    alert(JSON.stringify(res));
                },
                success: function(res) {
                    alert('已分享');
                },
                cancel: function(res) {
                    alert('已取消');
                },
                fail: function(res) {
                    alert(JSON.stringify(res));
                }
            });

        })

    })




</script>
</body>
</html>