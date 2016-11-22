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

        $("#fenxiang").click(function(){
            console.log("click fenxiangbtn")
            wx.onMenuShareTimeline({
                title: '啦啦啦', // 分享标题
                link: 'http://baidu.com', // 分享链接
                imgUrl: '', // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                    console.log("xx")
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                    console.log("cc")

                }
            });
        })

    })




</script>
</body>
</html>