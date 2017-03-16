<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>boss系统-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>控制面板</li>
            </ul>
        </div>

        <div class="box">
            <ul class="guide">
                <@shiro.hasPermission name="sample:list">
                <li>
                    <div class="cnt bg-aqua">
                        <a href="/sample/list"> <span><i class="fa fa-truck"></i></span> 寄样列表  <em id="sampleNum"></em></a>
                    </div>
                </li>
                </@shiro.hasPermission>
                <@shiro.hasPermission name="pick:list">
                <li>
                    <div class="cnt bg-green">
                        <a href="/pick/list"><span><i class="fa fa-shopping-bag"></i></span> 选货单列表 <em id="pickNum"></em></a>
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
            <div class="qrcode"></div>
        </div>
    </div>
    
    <#include "./common/footer.ftl"/>
</div>

<script src="/assets/js/jquery.qrcode.min.js"></script>
<script>
    var _global = {
        fn: {
            init: function () {
                this.newMsg();
                this.createQrcode();
            },
            // 消息提醒
            newMsg: function() {
                var self = this;
                $.post('/msg/count', function (result) {
                    if (result.status == 200) {
                        var pickNum = result.data.pick || '',
                            sampleNum = result.data.sample || '';

                        if (pickNum) {
                            $("#pickNum").html('<i class="fa"></i><sup>' + pickNum + '</sup>');
                        } else {
                            $("#pickNum").empty();
                        }
                        if (sampleNum) {
                            $("#sampleNum").html('<i class="fa"></i><sup>' + sampleNum + '</sup>');
                        } else {
                            $("#sampleNum").empty();
                        }
                    }
                })
                
                // 5分钟请求一次
                setTimeout(function() {
                    self.newMsg();
                }, 3e5);
            },
            // 生成二维码
            createQrcode:function() {
                var canvasSupport = !!document.createElement('canvas').getContext;
                $('.qrcode').qrcode({
                    render: canvasSupport ? 'canvas' : 'table',
                    width: 160,
                    height: 160,
                    text: '${bizUrl!}/wechat/member?memberId=${member_session_boss.id!}'
                })
            }
        }
    }
    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>