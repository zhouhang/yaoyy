<!DOCTYPE html>
<html lang="en">
<head>
    <title>${special.title!}-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body">
<header class="ui-header">
    <div class="title">${special.title!}</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
    <div class="abs-r mid">
        <a href="category/search"><i class="fa fa-search"></i></a>
    </div>
</header><!-- /ui-header -->

<#include "./common/navigation.ftl">

<section class="ui-content">
    <div class="ui-banner">
        <img src="${special.pictuerUrl!}" alt="${special.title!}">
    </div>
    <div class="plist">
        <ul>
            <#list commodities as commodity >
            <li>
                <a href="/commodity/detail/${commodity.id}">
                    <div class="cnt">
                        <div class="title">${commodity.name!}</div>
                        <div class="summary">
                            ${commodity.title!}
                        </div>
                        <div class="price">
                            <i>&yen;</i>
                            <em>${commodity.price!}</em>
                            <b>元/${commodity.unitName!}</b>

                        </div>
                    </div>
                    <div class="pic">
                        <img src="${commodity.thumbnailUrl!}" width="110" height="90" alt="">
                    </div>
                </a>
            </li>
            </#list>
        </ul>
    </div>

</section><!-- /ui-content -->


<#include "./common/footer.ftl"/>
<script>
    var weixinShare = {
        appId: '${signature.appid!}',
        title: '${special.title!}《药优优》',
        desc: '药优优——原药材销售平台 优选好药，底价直采！ 质量保障，价格保障，货源保障！',
        link: '${signature.url!}',
        imgUrl: "${special.pictuerUrl}",
        timestamp: ${signature.timestamp?string("#")},
        nonceStr: '${signature.noncestr!}',
        signature: '${signature.signature!}'
    }
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${urls.getForLookupPath('/assets/js/weixin_share.js')}"></script>

</body>
</html>