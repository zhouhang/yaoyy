<!DOCTYPE html>
<html lang="en">
<head>
<title>用户中心-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body1 body-bg">

<header class="ui-header">
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">

    <div class="uinfo">
        <div class="inner mid">
            <img class="avatar" src="assets/images/avatar.png" alt="">
            <span class="myname">${nickname?default("未登入")}</span>
        </div>
    </div>

    <div class="umenu">
        <ul id="menu">
            <li>
                <a href="/pick/list">
                    <i class="fa fa-cart"></i>
                    <span>订单列表</span>
                </a>
            </li>
            <#--<li>-->
                <#--<a href="/sample/list">-->
                    <#--<i class="fa fa-order"></i>-->
                    <#--<span>寄样单列表</span>-->
                <#--</a>-->
            <#--</li>-->
            <li>
                <a href="/center/updatePassword">
                    <i class="fa fa-lock"></i>
                    <span>修改密码</span>
                </a>
            </li>
            <li>
                <a href="/follow/list">
                    <i class="fa fa-heart"></i>
                    <span>商品关注</span>
                    <#if followCount?exists && followCount != 0>
                    <b>${followCount}</b>
                    </#if>
                </a>
            </li>
            <li>
                <a href="/address/list">
                    <i class="fa fa-region"></i>
                    <span>收货地址</span>
                </a>
            </li>
            <#if billExist?exists>
            <li>
                <a href="/bill">
                    <i class="fa fa-bill"></i>
                    <span>我的账单</span>
                </a>
            </li>
            </#if>
            <li>
                <a href="/pick/purchaser/one">
                    <i class="i i-7"></i>
                    <span>采购下单</span>
                </a>
            </li>
        </ul>
    </div>
</section>

<#include "./common/navigation.ftl">

<#include "./common/footer.ftl"/>

<script>
    var _global = {
        fn: {
            init: function() {
                this.menu();
            },
            menu: function() {
                var $menu = $('#menu'),
                    count = $menu.find('li').length % 3,
                    model = [];

                if (count != 0) {
                    count = 3 - count;
                }
                while (count-- > 0) {
                    model.push('<li></li>');
                }
                $menu.append(model.join(''));
            }
        }
    }
    $(function(){
        _global.fn.init();

    });
</script>

</body>
</html>