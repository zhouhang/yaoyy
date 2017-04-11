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
        <a href="/pick/list" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="sinfo">
        <div class="item">
            <ul class="info">
                <li>订单状态：${pickVo.bizStatusText}</li>
                <li>订单号：${pickVo.code}</li>
                <li>申请时间：${(pickVo.createTime?datetime)!}</li>
                <#if pickVo.status = 5&&pickVo.settleType!=2>
                <li><strong>请在3天内完成支付，否则订单会自动被取消。</strong></li>
                </#if>
            </ul>
            <ul class="step">
                <li <#if [0,1,2,4,5,8]?seq_contains(pickVo.status)>class="active"</#if> >
                    <i></i>
                    <span>提交采购单</span>
                </li>
                <li <#if 6= pickVo.status >class="active"</#if>>
                    <i></i>
                    <#if pickVo.settleType?exists>
                        <#if pickVo.settleType!=2>
                            <span>支付完成</span>
                        <#else>
                            <span>确认账单</span>
                        </#if>
                   <#else>
                        <span>支付完成</span>
                    </#if>
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
                        <span> &nbsp; &nbsp; &nbsp;${tracking.bizRecordTypeText}
                            <#if tracking.recordType==6>
                            ${tracking.memberTel!}
                             </#if>
                        </span>
                        <span>${tracking.extra?default('')}</span>
                    </li>
                    </#if>
                </#list>
            </ul>
        </div>

        <div class="item">
            <div class="hd">商品详情：</div>
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
        <div class="item">
            <div class="more">
            <#if address?exists>
            <div id="address_title" class="title">${address.consignee}  ${address.tel} <#if address.isDefault?exists && address.isDefault><em>默认</em></#if></div>

            <div id="address_detail" class="address"><#if pickVo.addrHistoryId?exists>${address.area}${address.detail} <#else > ${address.fullAdd}${address.detail}</#if></div>
            <#else >
            <div id="address_title" class="title">请先添加收货地址</div>
            <div id="address_detail" class="address">+</div>
            </#if>
            <#if pickVo.status == 5 ||pickVo.status== 8>
            <a href="/address/select?orderId=${pickVo.id}"><i class="fa fa-front mid"></i></a>
            </#if>
            </div>
        </div>

        <div class="item">
            <div class="more">
                <div class="txt"><strong>发票：</strong><span id="invoice"><#if orderInvoiceVo?exists>${orderInvoiceVo.content}<#else >不开发票</#if></span></div>
        <#if pickVo.status == 5||pickVo.status== 8>
                <a href="/pick/invoice/${pickVo.id}"><i class="fa fa-front mid"></i></a>
        </#if>
            </div>
            <div class="more hr">
                <div class="txt"><strong>备注：</strong><span id="note"><#if pickVo.remark?exists>${pickVo.remark}<#else >无</#if></span></div>
        <#if pickVo.status == 5 ||pickVo.status== 8>
                <a href="/pick/note/${pickVo.id}"><i class="fa fa-front mid"></i></a>
        </#if>
            </div>
        <#if logistical?exists>
            <ul class="freight hr">
                <li><strong>物流详情：</strong></li>
                <li>
                    <span>发货时间：</span>
                    <em><#if logistical.shipDate?exists>${logistical.shipDate?datetime}</#if></em>
                </li>
                <li>
                    <span>发货信息：</span>
                    <em>${logistical.content!}</em>
                </li>
                <li>
                    <span>发货单据：</span>
                    <img src="${logistical.pictureUrl!}" alt="">
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
                <dt>包装加工费：</dt>
                <dd><em>${pickVo.bagging?default(0)}</em>元<#if !(pickVo.bagging?exists) || pickVo.bagging ==0>（免包装加工费）</#if></dd>
            </dl>
            <#--
            <dl>
                <dt>检测费：</dt>
                <dd><em>${pickVo.checking?default(0)}</em>元<#if !(pickVo.checking?exists) || pickVo.checking ==0>（免检测费）</#if></dd>
            </dl>
            -->
            <dl>
                <dt>税款：</dt>
                <dd><em>${pickVo.taxation?default(0)}</em>元</dd>
            </dl>
            <dl class="f18">
                <dt>总计：</dt>
                <dd><em>${pickVo.amountsPayable?default(0)}</em>元</dd>
            </dl>
            <#if pickVo.settleType?exists && pickVo.settleType==1>
            <dl class="f18">
                <dt>支付保证金：</dt>
                <dd><em>${pickVo.deposit?default(0)}</em>元</dd>
            </dl>
            <dl class="f18">
                <dt>账期：</dt>
                <dd><em>${pickVo.billTime?default(0)}</em>天</dd>
            </dl>
            <dl class="f18">
                <dt>剩余金额：</dt>
                <dd><em>${pickVo.amountsPayable-pickVo.deposit}</em>元</dd>
            </dl>
            <#elseif pickVo.settleType?exists && pickVo.settleType==2>
                <dl class="f18">
                    <dt>账期：</dt>
                    <dd><em>${pickVo.billTime?default(0)}</em>天</dd>
                </dl>
            </#if>
        </div>
    </#if>

        <div class="button">
        <#if pickVo.settleType?exists && pickVo.settleType!=2>
        <#if pickVo.status == 5>
            <button type="button" id="bankTransfer" class="ubtn ubtn-primary">银行转账</button>
            <button type="button" id="wxpay" class="ubtn ubtn-primary">微信支付</button>
            <button type="button" id="alipay" class="ubtn ubtn-primary">支付宝支付</button>
        </#if>
          <#else>
              <#if pickVo.status == 8>
              <button type="button" id="configBill" class="ubtn ubtn-primary">确认账单无误</button>
              </#if>
        </#if>
        <#if [0,1,5,8]?seq_contains(pickVo.status)>
            <button type="button" id="cancel" class="ubtn ubtn-white">取消订单</button>
        </#if>
        <#if pickVo.status == 7>
            <button type="button" id="receipt" class="ubtn ubtn-primary">确认收货</button>
        </#if>
        </div>

        <div class="ui-extra">
            咨询电话：<a href="tel:${consumerHotline}" target="_blank">${consumerHotline}</a>
        </div>
    </div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>

    var _global = {
        v:{
            saveUrl:"/pick/save",
            cancelUrl:"/pick/cancel",
            receiptUrl:"/pick/receipt",
            configUrl:"/pick/configBill"
        },
        fn: {
            init: function() {
            <#if [1,5,8]?seq_contains(pickVo.status)>
                <#if orderInvoiceSession?exists>
                    if (sessionStorage.getItem("pickInvoice${pickVo.id}")== undefined) {
                        sessionStorage.setItem("pickInvoice${pickVo.id}", '${orderInvoiceSession}');
                    }
                </#if>
                <#if remarkSession?exists>
                if (!sessionStorage.getItem("pickNote${pickVo.id}")) {
                    sessionStorage.setItem("pickNote${pickVo.id}", '${remarkSession}');
                }
                </#if>
                <#if address?exists>
                    if (sessionStorage.getItem("pickAddrId${id}") == undefined) {
                        var addr = {};
                        addr.id = ${address.id};
                        addr.titleN = "ss";
                        sessionStorage.setItem("pickAddrId${id}", JSON.stringify(addr));
                    };
                </#if>

                // 初始化,订单处于待支付状态时
                var note = sessionStorage.getItem("pickNote${pickVo.id}");
                if (note) {
                    $("#note").html(note);
                }
                var invoice = sessionStorage.getItem("pickInvoice${id}");
                if (invoice) {
                    invoice = JSON.parse(invoice);
                    var content = "";
                    if (invoice.content == "不开发票") {
                        content = "不开发票";
                    } else {
                        if (invoice.type == 2) {
                            content = invoice.name + " " + invoice.content;
                        } else {
                            content = "个人 " + invoice.content;
                        }
                    }
                    $("#invoice").html(content);
                }
                // 修改后的地址Id 未修改不做任何处理 地址未修改的话id -1 // 后台不做任何处理
                var address = sessionStorage.getItem("pickAddrId${id}");
                if (address) {
                    address = JSON.parse(address);
                    // 初始化 地址内容
                    if (address.title) {
                        $("#address_title").html(address.title);
                        $("#address_detail").html(address.detail);
                    }
                }
            </#if>
                this.bindEven();
            },
            bindEven: function () {
                var self = this,
                    wait = false;
                    
                $("#bankTransfer").click(function(){
                    self.save(1);
                })
                $("#configBill").click(function(){
                    self.save(2);
                })
                $("#wxpay").click(function(){
                    self.wxpay();
                })
                $("#alipay").click(function(){
                    self.alipay();
                })


                //取消订单
                $("#cancel").click(function () {
                    if (wait) {
                        return false;
                    }
                    layer.open({
                        className: 'layer-custom',
                        content: '确定要取消订单吗？',
                        btn: ['确定', '取消'],
                        yes: function(index) {
                            $.ajax({
                                url: _global.v.cancelUrl + "?id=${pickVo.id}",
                                type: "POST",
                                beforeSend: function() {
                                    wait = true;
                                },
                                success: function (result) {
                                    if (result.status == "200") {
                                        window.location.reload();
                                    } else {
                                        wait = false;
                                    }
                                },
                                error: function () {
                                    popover('网络错误，请刷新页面重试');
                                    setTimeout(function () {
                                        window.location.reload();
                                    }, 1e3);
                                }
                            })
                        }
                    });
                });

                $("#receipt").click(function () {
                    // 确认收货
                    $.ajax({
                        url: _global.v.receiptUrl + "?id=${pickVo.id}",
                        type: "POST",
                        success: function (result) {
                            if (result.status == "200") {
                                window.location.reload();
                            }
                        },
                        error: function () {
                            popover('网络错误，请刷新页面重试');
                            setTimeout(function () {
                                window.location.reload();
                            }, 1e3);
                        }
                    })
                });

            },
            save:function(btnType){
                if (!this.checkMsg()) return;
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
                pick.remark = sessionStorage.getItem("pickNote${pickVo.id}");

                // 地址
                if (sessionStorage.getItem("pickAddrId${id}")) {
                    pick.addrHistoryId = JSON.parse(sessionStorage.getItem("pickAddrId${id}")).id;
                }

                // 判断地址不能为空 防止重复提交功能
                var url="";
                if(btnType==1){
                    url=_global.v.saveUrl+"?type=1";
                }
                else{
                    url=_global.v.configUrl;
                }
                $.ajax({
                    url: url,
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
            },
            //微信支付
            wxpay:function(){
                $.ajax({
                    url: "/wechat/pay",
                    data: { orderId:${pickVo.id}},
                    type: "POST",
                    success: function(result) {
                        var obj = result.data;
                        WeixinJSBridge.invoke('getBrandWCPayRequest',{
                            "appId" : obj.appId,                  //公众号名称，由商户传入
                            "timeStamp":obj.timeStamp,          //时间戳，自 1970 年以来的秒数
                            "nonceStr" : obj.nonceStr,         //随机串
                            "package" : obj.package,      //<span style="font-family:微软雅黑;">商品包信息</span>
                            "signType" : obj.signType,        //微信签名方式:
                            "paySign" : obj.paySign           //微信签名
                        },function(res){
                            if(res.err_msg == "get_brand_wcpay_request:ok") {
                                window.location.href ="/pick/paySuccess?orderId="+${pickVo.id};
                            }
                        });
                    }
                })
            },
            //支付宝支付
            alipay:function(){
                window.location.href ="alipay/index?orderId=${pickVo.id}&authId=${authId!}";
            },
            checkMsg: function () {
                // 默认验证通过
                if (sessionStorage.getItem("pickAddrId${id}") == undefined) {
                    popover('请填写收货地址');
                    return false;
                }

                return true;
            }
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>