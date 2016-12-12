<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>控制面板-药优优</title>
</head>
<body class='wrapper'>
<#include "./common/header.ftl"/>
<#include "./common/aside.ftl"/>
<div class="content">
    <div class="breadcrumb">
        <ul>
            <li>控制面板</li>
        </ul>
    </div>

    <div class="box">
        <ul class="q-list">
            <@shiro.hasPermission name="sample:list">
            <li>
                <div class="cnt bg-aqua">
                    <a href="/sample/list"> <span><i class="fa fa-truck"></i></span> 寄样列表  <em id="sample"><i class="fa"></i><sup>4</sup></em></a>
                </div>
            </li>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="pick:list">
            <li>
                <div class="cnt bg-green">
                    <a href="/pick/list"><span><i class="fa fa-shopping-bag"></i></span> 选货单列表<em id="pick"><i class="fa"></i><sup>4</sup></em></a>
                </div>
            </li>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="commodity:list">
            <li>
                <div class="cnt bg-yellow">
                    <a href="/commodity/list"><span><i class="fa fa-cart-plus"></i></span> 商品列表</a>
                </div>
            </li>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="special:list">
            <li>
                <div class="cnt bg-red">
                    <a href="special/list"><span><i class="fa fa-star"></i></span> 专场列表</a>
                </div>
            </li>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="ad:list">
            <li>
                <div class="cnt bg-purple">
                    <a href="ad/list"><span><i class="fa fa-audio-description"></i></span> 广告列表</a>
                </div>
            </li>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="cms:list">
            <li>
                <div class="cnt bg-maroon">
                    <a href="cms/list"><span><i class="fa fa-file-text"></i></span> CMS列表</a>
                </div>
            </li>
            </@shiro.hasPermission>
        </ul>
    </div>

    <div class="box">
        <p>扫码绑定微信号</p>
        <div id="canvas" url="http://hztjn.free.natapp.cc/wechat/member?memberId=${member_session_boss.id!}">

        </div>
    </div>
</div>
<#include "./common/footer.ftl"/>
<script src="/assets/js/jquery.qrcode.min.js"></script>
<script>
    var _global = {
        fn: {
            init: function () {
                $.post("/msg/count", function (result) {
                    var pickD = "none", sampleD= "none";
                    if (result.status == 200) {
                        var data = result.data;
                        pickD = data.pick == 0?"none":"inline-block";
                        sampleD = data.sample == 0?"none":"inline-block";
                        $("#pick").find("sup").html(data.pick);
                        $("#sample").find("sup").html(data.sample);
                    }

                    $("#pick").css("display", pickD);
                    $("#sample").css("display", sampleD);
                })
                this.createQrcode();
            },
            // 生成二维码
            createQrcode:function() {
                var canvasSupport = !!document.createElement('canvas').getContext;
                if (canvasSupport) {
                    $("#canvas").qrcode({
                        width: 256,
                        height: 256,
                        text: $("#canvas").attr('url')
                    })
                } else {
                    $('.qrcode').each(function() {
                        var url = $("#canvas").attr('url');
                        $("#canvas").find('.canvas img').attr({
                            'src': 'http://qr.liantu.com/api.php?text=' + url,
                            'width': 124,
                            'height': 124
                        });
                    })
                }
            }
        }
    }
    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>