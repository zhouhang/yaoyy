<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>选货单选项-药优优</title>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">采购单选项</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->
<form id="myform">
<section class="ui-content">
    <div class="oinfo">
        <div class="item hd">
            <#list commodities as commodity>
            <em>${commodity.name!}</em>
            <span>${commodity.title!}<b>${commodity.warehouse!}${commodity.unitName!}</b> ${commodity.price?string("0.00")}元/${commodity.unitName!}</span>
            </#list>
        </div>
        <div class="item">
            您是否要开发票<sub>（您购买的商品税点5%）</sub>
            <input id="invoiceTitleCheck" type="checkbox" class="fa-switch switch" />
            <input id="invoiceTitle" name="invoice.name" type="text" class="ipt" placeholder="请输入公司抬头" />
        </div>
        <#--<div class="item">-->
            <#--您是否需要特殊包装-->
            <#--<span class="tips">默认50公斤一包，如需要特殊包装需要另收取费用，客服会主动与你沟通。</span>-->
            <#--<input type="checkbox" class="fa-switch switch" />-->
        <#--</div>-->

        <#--<div class="item">-->
            <#--收货地址-->
            <#--<span class="tips">如果您在我们配送范围之内，我们将免费送货上门。<a href="javascript:;" class="blue freight">免费配送范围</a></span>-->
            <#--<a href="consignee.html" class="ar"><i class="ico ico-front mid"></i></a>-->
        <#--</div>-->

        <div class="item">
            <#if address?exists>
                <div id="address_title">${address.consignee!}  ${address.tel!}</div>
                <span id="address_detail" class="tips">${address.fullAdd!}${address.detail!}</span>
                <input type="hidden" name="addrHistoryId" id="regionID" value="${address.id!}">
            <#else >
               请先添加收货地址
            </#if>
                <a href="/address/select?md5=${md5!}&callback=/pickCommodity/apply?md5=${md5!}" class="ar"><i class="ico ico-front mid"></i></a>
        </div>
        <div class="button">
            <button id="submit" type="button" class="ubtn ubtn-primary">提交</button>
        </div>

    </div>
</section><!-- /ui-content -->
</form>
<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script>
    var _global = {
        fn: {
            init: function() {
            <#if address?exists>
                if (sessionStorage.getItem("pickAddrId${md5!}") == undefined) {
                    var addr = {};
                    addr.id = ${address.id};
                    addr.titleN = "ss";
                    sessionStorage.setItem("pickAddrId${md5!}", JSON.stringify(addr));
                };
            </#if>
                var address = sessionStorage.getItem("pickAddrId${md5!}");
                if (address) {
                    address = JSON.parse(address);
                    // 初始化 地址内容
                    if (address.title) {
                        $("#regionID").val(address.id);
                        $("#address_title").html(address.title);
                        $("#address_detail").html(address.detail);
                    }
                }

                var invoiceTitle = sessionStorage.getItem("pickinvoiceTitle${md5!}");
                if (invoiceTitle) {
                    $("#invoiceTitleCheck").prop("checked",true);
                    $("#invoiceTitle").val(invoiceTitle);
                }

                $(window).bind('beforeunload',function(){
                    sessionStorage.setItem("pickinvoiceTitle${md5!}",$("#invoiceTitle").val());
                });
                this.freight();
                this.submit();
            },
            cleanSessionStorage: function () {
                sessionStorage.removeItem("pickAddrId${md5!}");
                sessionStorage.removeItem("pickinvoiceTitle${md5!}");
            },
            submit: function () {
                $("#submit").click(function () {
                    var data = $("#myform").serializeArray();
                    $.post("/pickCommodity/apply?md5=${md5!}",data,function(result){
                        if (result.status == 200) {
                            _global.fn.cleanSessionStorage();
                            <#list commodities as commodity>
                            deleteCommodity(${commodity.id!})
                            </#list>
                            window.location.href="/pick/detail/"+result.data;
                        }
                    })
                    return false;
                })
            },
            freight: function() {
                var model = [{
                    "name": "三棱",
                    "region": "安徽亳州"
                },{
                    "name": "白芍",
                    "region": "安徽亳州"
                },{
                    "name": "天麻",
                    "region": "湖北金寨"
                }]

                $('.oinfo').on('click', '.freight', function() {
                    var temp = [];
                    temp.push('<ul class="freight-free">');
                    temp.push('<li class="fore"><span>免费配送地区</span>品种</li>');
                    $.each(model, function(key, attr) {
                        temp.push('<li><span>', attr.region, '</span>', attr.name, '</li>');
                    })
                    temp.push('</ul>');
                    layer.open({
                        className: 'layer-custom'
                        ,content: temp.join('')
                        ,btn: ['关闭']
                    })
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