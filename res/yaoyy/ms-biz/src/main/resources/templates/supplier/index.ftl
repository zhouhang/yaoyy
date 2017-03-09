<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商登录-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
<footer class="footer">
<#include "../common/navigation.ftl"/>
<div class="ui-content">
       <div class="umenu2">
            <ul>
                <li>
                    <a href="#">
                        <em>12</em>
                        <span>上架商品</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <em>8</em>
                        <span>订单记录</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <em>300</em>
                        <span>寄卖数量<i>（公斤）</i></span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="floor">
            <div class="hd ico-notice">网站公告</div>
            <div class="bd">
                <ul class="list">
                    <li><time>2017-02-2</time><a href="#">网站更新公告</a></li>
                    <li><time>2017-02-2</time><a href="#">亳州市政府召开药商大会通知</a></li>
                    <li><time>2017-02-2</time><a href="#">中药材交易市场管理规定政府召开药商大...</a></li>
                </ul>
            </div>
            <div class="more">
                <a href="notice.html" class="ico-arrow-r">查看更多</a>
            </div>
        </div>

        <div class="floor">
            <div class="hd ico-news">我的消息</div>
            <div class="bd">
                <ul id="news">
                    <li>
                        <span>客服张倩为你发出了商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须）的样品。</span>
                        <em class="e1">寄样</em>
                        <time data-time="2017-03-06 15:22:11">四小时前</time>
                    </li>
                    <li>
                        <span>管理员程斌上传了商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须）。</span>
                        <em class="e1">下单</em>
                        <time data-time="2017-03-05 22:22:11">2017-02-28</time>
                    </li>
                    <li>
                        <span>您的商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留毛须）被下单100公斤。</span>
                        <em class="e2">商品</em>
                        <time data-time="2017-02-28 15:22:11">2017-02-28</time>
                    </li>
                </ul>
            </div>
            <div class="more">
                <a href="news.html" class="ico-arrow-r">查看更多</a>
            </div>
        </div>
</div>
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.timeago();
            },
            timeago: function() {
                $('#news').find('time').each(function() {
                    var date = $(this).data('time');
                    date && $(this).html(_YYY.timeago.elapsedTime(date));
                })
            }

        }
    }

    $(function(){
        _global.fn.init();

    });

</script>
</body>
</html>