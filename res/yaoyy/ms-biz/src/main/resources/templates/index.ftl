<!DOCTYPE html>
<html lang="en">
<head>
<title>优选好药 底价直采-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body1 body-bg">

<header class="ui-header">
    <h1 class="logo">药优优药材商城</h1>

    <div class="search mid">
        <form id="searchForm">
            <input type="text" name="keyword" id="keyword" value="" class="ipt" />
            <button type="submit" id="search" class="ico ico-search mid submit"></button>
        </form>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="ui-slide" id="slide1">
        <ul>
            <#list banners as banner>
                <li><a href="${banner.href!}"><img src="${banner.pictureUrl!}" alt="${banner.name!}"></a></li>
            </#list>
        </ul>
    </div>

    <div class="ui-floor">
        <ul class="menu">
            <li>
                <a href="/commodity/list"><i class="ico ico-list"></i>品种清单</a>
            </li>
            <li>
                <a href="/pickCommodity/list"><i class="ico ico-shopcart"></i>品采购单</a>
            </li>
            <li>
                <a href="/headline"><i class="ico ico-toutiao"></i>品药商头条</a>
            </li>
        </ul>
    </div>

    <div class="ui-floor">
        <div class="hd">
            <h2 class="ico-notice">药商头条</h2>
            <div class="marquee">
                <ul>
                    <#list headlines as headline>
                        <li>
                            <a href="/headline/${headline.id}"><em>${(headline.tagStr?split(","))[0]}</em>${headline.title!}</a>
                        </li>
                    </#list>
                </ul>
            </div>
        </div>
        <div class="bd">
            <a href="/quotation/index" class="pro">
                <img src="assets/images/ddhq.jpg" alt="地道行情">
                <div class="txt">
                    <em>道地行情</em>
                    <span>每周更新 替你上行</span>
                </div>
            </a>
            <a href="${special.href!}" class="pro">
                <img src="${special.pictureUrl!}" alt="${special.name!}">
                <div class="txt">
                    <em>${special.name!}</em>
                    <span>优选好药 底价直采</span>
                </div>
            </a>
        </div>
    </div>

    <div class="ui-floor">
        <h2 class="ico-arrow-down">特价好货</h2>
        <ul class="list">
            <#list commoditys as commodity>
            <li>
                <a href="/commodity/detail/${commodity.id!}" class="pic">
                    <img src="${commodity.thumbnailUrl}" alt="${commodity.title}">
                </a>
                <a href="/commodity/detail/${commodity.id!}">
                    <em>${commodity.title}</em>
                    <span>${commodity.price?string("0.00")}</span>
                    <b>元/${commodity.unitName}</b>
                </a>
            </li>
            </#list>
            <li class="hide">
                <a href="#" class="pic more"><b>更多特价药材</b></a>
            </li>
        </ul>
        <div class="more">
            <a href="/commodity/list" class="ubtn ubtn-white">更多特价药材<i class="ico ico-more"></i></a>
        </div>
    </div>

</section><!-- /ui-content -->

<#include "./common/navigation.ftl">

<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.slide();
                this.sideQrcode();
                this.marquee();
            },
            slide: function() {
                var $slide = $('#slide1'),
                        $nav,
                        length = $slide.find('li').length;

                if (length < 2) {
                    return;
                }
                var nav = ['<div class="nav">'];
                for (var i = 0 ; i < length; i++) {
                    nav.push( i === 0 ? '<i class="current"></i>' : '<i></i>');
                }
                nav.push('</div>');
                $slide.append(nav.join(''));
                $nav = $slide.find('i');

                $slide.swipeSlide({
                    autoSwipe: true,
                    firstCallback : function(i){
                        $nav.eq(i).addClass('current').siblings().removeClass('current');
                    },
                    callback : function(i){
                        $nav.eq(i).addClass('current').siblings().removeClass('current');
                    }
                });
            },
            sideQrcode: function() {
                var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
                if (!isMobile) {
                    $('body').append('<div class="sideQrcode"><span>微信“扫一扫”立即关注</span><img src="/assets/images/qrcode.png" width="150" height="150"><span>微信号：药优优</span></div>');
                }
            },
            // 公告
            marquee: function() {
            var $marquee = $('.marquee'),
                    $ul = $marquee.find('ul'),
                    length = $ul.find('li').length,
                    ypos = $ul.find('li').height(),
                    idx = 0,
                    speed = 300,
                    delay = 3500;

            if (length == 1) {
                return this;
            }
            $ul.append($ul.html());

            setInterval(function() {
                idx ++;
                $ul.animate({
                    top: -idx * ypos
                }, speed, function() {
                    if (idx === length) {
                        idx = 0;
                        $ul.css({top: 0})
                    }
                });
            }, delay);

        }
        }
    }

    $(function(){
        _global.fn.init();

    });

</script>
<script>
    var weixinShare = {
        appId: '${signature.appid!}',
        title: '优选好药 底价直采《药优优》',
        desc: '药优优——原药材销售平台 优选好药，底价直采！ 质量保障，价格保障，货源保障！',
        link: '${signature.url!}',
        imgUrl: "${baseUrl}/assets/images/logo3.jpg",
        timestamp: ${signature.timestamp?string("#")},
        nonceStr: '${signature.noncestr!}',
        signature: '${signature.signature!}'
    }
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${urls.getForLookupPath('/assets/js/weixin_share.js')}"></script>

</body>
</html>