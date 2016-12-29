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
            <#if address?exists>
            <div id="address_title" class="title">${address.consignee}  ${address.tel} <#if address.isDefault?exists && address.isDefault><em>默认</em></#if></div>

            <div id="address_detail" class="address"><#if pickVo.addrHistoryId?exists>${address.area}${address.detail} <#else > ${address.fullAdd}${address.detail}</#if></div>
            <#else >
            <div id="address_title" class="title">请先添加收货地址</div>
            <div id="address_detail" class="address">+</div>
            </#if>
            <#if pickVo.status == 5>
            <a href="/address/select?orderId=${pickVo.id}" class="mid"><i class="fa fa-front"></i></a>
            </#if>
        </div>

        <div class="item">
            <div class="more">
                <div class="txt"><strong>发票：</strong><span id="invoice">不开发票</span></div>
        <#if pickVo.status == 5>
                <a href="/pick/invoice/${pickVo.id}" class="mid"><i class="fa fa-front"></i></a>
        </#if>
            </div>
            <div class="more hr">
                <div class="txt"><strong>备注：</strong><span id="note">无</span></div>
        <#if pickVo.status == 5>
                <a href="/pick/note/${pickVo.id}" class="mid"><i class="fa fa-front"></i></a>
        </#if>
            </div>
        <#if logistical?exists>
            <ul class="freight hr">
                <li><strong>物流详情：</strong></li>
                <li>
                    <span>发货时间：</span>
                    <em>${logistical.shipDate?datetime}</em>
                </li>
                <li>
                    <span>发货信息：</span>
                    <em>${logistical.content}</em>
                </li>
                <li>
                    <span>发货单据：</span>
                    <img src="${logistical.pictureUrl}" alt="">
                </li>
            </ul>
        </#if>
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
            <button type="button" id="bankTransfer" class="ubtn ubtn-primary">银行转账</button>
        </#if>
        <#if [0,1,2,4,5]?seq_contains(pickVo.status)>
            <button type="button" id="cancel" class="ubtn ubtn-primary">取消订单</button>
        </#if>
        <#if pickVo.status == 7>
            <button type="button" id="bankTransfer" class="ubtn ubtn-primary">确认收货</button>
        </#if>
        </div>

        <div class="ui-extra">
            咨询电话：<a href="tel:${consumerHotline}" target="_blank">${consumerHotline}</a>
        </div>
    </div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script>

    var _global = {
        v:{
            saveUrl:"/pick/save"
        },
        fn: {
            init: function() {
                // 初始化,订单处于待支付状态时
                var note = sessionStorage.getItem("pickNote${pickVo.id}");
                if (note) {
                    $("#note").html(note);
                }
                var invoice = sessionStorage.getItem("pickInvoice${id}");
                if (invoice) {
                    $("#invoice").html(JSON.parse(invoice).content);
                }
                // 修改后的地址Id 未修改不做任何处理 地址未修改的话id -1 // 后台不做任何处理
                var address = sessionStorage.getItem("pickAddrId${id}");
                if (address) {
                    address = JSON.parse(address);
                    // 初始化 地址内容
                    $("#address_title").html(address.title);
                    $("#address_detail").html(address.detail);
                }

                this.bindEven();
            },
            bindEven: function () {
                $("#bankTransfer").click(function(){
                    _global.fn.save();
                })

                $("#cancel").click(function () {
                    
                })
            },
            save:function(){
                var  pick = {
                    id:${pickVo.id},
                    addrHistoryId:<#if address?exists>${address.id} <#else > null </#if>
                }
                // 发票
                var invoice = sessionStorage.getItem("pickInvoice${id}");
                if (invoice) {
                    pick.invoice = JSON.parse(invoice);
                }

                // 备注
                pick.note = sessionStorage.getItem("pickNote${pickVo.id}");

                // 地址
                if (sessionStorage.getItem("pickAddrId${id}")) {
                    pick.addrHistoryId = JSON.parse(sessionStorage.getItem("pickAddrId${id}")).id;
                }

                // 判断地址不能为空 防止重复提交功能
                $.ajax({
                    url: _global.v.saveUrl+"?type=1",
                    data: JSON.stringify(pick),
                    type: "POST",
                    contentType : 'application/json',
                    success: function(result) {
                        if(result.status=="200"){
                          sessionStorage.clear();
                          window.location.href = result.data; // 跳转到指定页面
                        }
                    },
                    error: function() {
                        popover('网络错误，请刷新页面重试');
                        setTimeout(function() {
                            window.location.reload();
                        }, 1e3);
                    }
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