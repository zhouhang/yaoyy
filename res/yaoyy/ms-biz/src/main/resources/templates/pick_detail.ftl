<!DOCTYPE html>
<html lang="en">
<head>
    <title>订单详情-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">订单详情</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="sinfo">
        <div class="item">
            <ul class="info">
                <li>订单状态：${pickVo.bizStatusText}</li>
                <li>订单号：${pickVo.code}</li>
                <li>申请时间：${(pickVo.createTime?datetime)!}</li>
                <#if pickVo.status = 5>
                <li><strong>请在3天内完成支付，否则订单会自动被取消。</strong></li>
                </#if>
            </ul>
            <ul class="step">
                <li <#if [0,1,2,4,5]?seq_contains(pickVo.status)>class="active"</#if> >
                    <i></i>
                    <span>提交订单</span>
                </li>
                <li <#if 6= pickVo.status >class="active"</#if>>
                    <i></i>
                    <span>支付完成</span>
                </li>
                <li <#if 7= pickVo.status >class="active"</#if>>
                    <i></i>
                    <span>待收货</span>
                </li>
                <li <#if 3= pickVo.status>class="active"</#if>>
                    <i></i>
                    <span>交易完成</span>
                </li>
            </ul>
            <ul class="time">
                <#list pickTrackingVos as tracking >
                    <#if tracking.recordType!=3>
                    <li>
                        <time>${(tracking.createTime?datetime)!}</time>
                        <span>${tracking.recordTypeText}</span>
                        <span>${tracking.extra?default('')}</span>
                    </li>
                    </#if>
                </#list>
            </ul>
        </div>

        <div class="item">
            <div class="hd">订单：</div>
            <ul class="list">
                <#list pickVo.pickCommodityVoList as pickCommodityVo>
                <li><a href="commodity/detail/${pickCommodityVo.realCommodityId}"><em>${pickCommodityVo.name}</em><span>${pickCommodityVo.origin}  ${pickCommodityVo.spec}  ${pickCommodityVo.price}元/${pickCommodityVo.unit}</span></a><sub><em>${pickCommodityVo.num}</em> ${pickCommodityVo.unit} <b>&yen; <em>${pickCommodityVo.total}</em></b> 元</sub></li>
                </#list>
            </ul>
        <#if pickVo.sum?exists && pickVo.sum != 0>
            <div class="total">
                总计：<b>${pickVo.sum?default(0)}</b>元
            </div>
        </#if>
        </div>
    <#if pickVo.amountsPayable?exists && pickVo.amountsPayable != 0>
        <div class="item more">
            <div class="title">王彬  18801285391 <em>默认</em></div>
            <div class="address">湖北省武汉市洪山区城区珞瑜路光谷银座15楼</div>
        <#if pickVo.status == 5>
            <a href="consignee.html" class="mid"><i class="fa fa-front"></i></a>
        </#if>
        </div>

        <div class="item">
            <div class="more">
                <div class="txt"><strong>发票：</strong>不开发票</div>
        <#if pickVo.status == 5>
                <a href="invoice.html" class="mid"><i class="fa fa-front"></i></a>
        </#if>
            </div>
            <div class="more hr">
                <div class="txt"><strong>备注：</strong><span id="note">无</span></div>
        <#if pickVo.status == 5>
                <a href="/pick/note/${pickVo.id}" class="mid"><i class="fa fa-front"></i></a>
        </#if>
            </div>
        </div>

        <div class="item summary">
            <dl>
                <dt>商品总价：</dt>
                <dd><em>${pickVo.sum?default(0)}</em>元</dd>
            </dl>
            <dl>
                <dt>运费：</dt>
                <dd><em>${pickVo.shippingCosts?default(0)}</em>元</dd>
            </dl>
            <dl>
                <dt>包装费：</dt>
                <dd><em>${pickVo.bagging?default(0)}</em>元（免包装费）</dd>
            </dl>
            <dl>
                <dt>检测费：</dt>
                <dd><em>${pickVo.checking?default(0)}</em>元（免检测费）</dd>
            </dl>
            <dl>
                <dt>税款：</dt>
                <dd><em>${pickVo.taxation?default(0)}</em>元</dd>
            </dl>
            <dl class="f18">
                <dt>总计：</dt>
                <dd><em>${pickVo.amountsPayable?default(0)}</em>元</dd>
            </dl>
        </div>
    </#if>

        <div class="button">
        <#if pickVo.status == 5>
            <button type="button" class="ubtn ubtn-primary">银行转账</button>
        </#if>
            <button type="button" class="ubtn ubtn-primary">取消订单</button>
        </div>

        <div class="ui-extra">
            咨询电话：<a href="tel:${consumerHotline}" target="_blank">${consumerHotline}</a>
        </div>
    </div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                var note = sessionStorage.getItem("pickNote${pickVo.id}");
                if (note) {
                    $("#note").html(note);
                }
            }
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>