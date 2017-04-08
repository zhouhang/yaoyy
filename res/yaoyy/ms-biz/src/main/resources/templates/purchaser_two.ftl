<!DOCTYPE html>
<html lang="en">
<head>
<title>收货信息-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body-gray">
<section class="ui-content">

    <div class="order">
        <form action="" id="myform">
            <div class="item">
                <label class="label">商品信息</label>
                <#list vo.pickCommodityVoList as commodity >
                <span class="t3 fr">${commodity.num!}公斤 <em class="c-red">${commodity.price?string("0.00")}</em>元/公斤</span>
                <span class="t3 mr">${commodity.name!}&nbsp;${commodity.spec!}&nbsp;${commodity.origin!}</span>
                </#list>
            </div>
            <div class="item note">
                <label class="label">货物要求</label>
                <textarea name="remark" id="remark" class="ipt mul" cols="30" rows="10"></textarea>
                <span class="error"></span>
            </div>
            <div class="item">
                <span class="t1" style="visibility:hidden;">送货时间</span>
                <em class="arrow"></em>
                <input type="text" name="deliveryDate" id="date" style="position:absolute;top:0;left:0;width:100%;height:100%;padding:16px 13px;border:0;background:none;" value="送货时间" />
                <span class="error"></span>
            </div>
            <div class="item">
                <#if address?exists>
                    <strong id="address_title" class="t1">${address.consignee!}  ${address.tel!}</strong>
                    <span id="address_detail" class="t2">${address.fullAdd!}${address.detail!}</span>
                    <input type="hidden" name="addrHistoryId" id="regionID" value="${address.id!}">
                    <span class="error"></span>
                    <a href="/address/select?orderId=${vo.id}&callback=/pick/purchaser/two?pickId=${vo.id}" class="arrow"></a>
                <#else >
                    <span class="t1">收货地址</span>
                    <input type="hidden" name="addrHistoryId" id="regionID" value="">
                    <span class="error"></span>
                    <a href="/address/select?orderId=${vo.id}&callback=/pick/purchaser/two?pickId=${vo.id}" class="arrow"></a>
                </#if>

            </div>
            <div class="ft">
                <button type="button" class="ubtn ubtn-primary" id="submit">提交</button>
            </div>
        </form>
    </div>
</section><!-- /ui-content -->
<link rel="stylesheet" href="assets/mobiscroll/css/mobiscroll.css" />
<#include "./common/footer.ftl"/>
<script src="assets/mobiscroll/js/mobiscroll.zepto.js"></script>
<script src="assets/mobiscroll/js/mobiscroll.core.js"></script>
<script src="assets/mobiscroll/js/mobiscroll.scroller.js"></script>
<script src="assets/mobiscroll/js/mobiscroll.datetime.js"></script>
<script src="assets/mobiscroll/js/mobiscroll.i18n.zh.js"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                <#if address?exists>
                    if (sessionStorage.getItem("pickAddrId${id}") == undefined) {
                        var addr = {};
                        addr.id = ${address.id};
                        addr.titleN = "ss";
                        sessionStorage.setItem("pickAddrId${id}", JSON.stringify(addr));
                    };
                </#if>
                // 修改后的地址Id 未修改不做任何处理 地址未修改的话id -1 // 后台不做任何处理
                var address = sessionStorage.getItem("pickAddrId${id}");
                if (address) {
                    address = JSON.parse(address);
                    // 初始化 地址内容
                    if (address.title) {
                        $("#regionID").id(address.id);
                        $("#address_title").html(address.title);
                        $("#address_detail").html(address.detail);
                    }
                }

                this.pickDate();
                this.submit();
            },
            submit: function () {
                $("#submit").click(function () {
                    var date = $("#myform").serializeArray();
                    $.post("/pick/purchaser/two",date,function(result){
                        if (result.status == 200) {
                            window.location.href="/pick/list;
                        }
                    })
                })
            },
            pickDate: function() {
                var that = this,
                        time = new Date(),
                        year = time.getFullYear(),
                        month = time.getMonth(),
                        date = time.getDate();

                $('#date').scroller({
                    preset: 'datetime',
                    minDate: time,
                    maxDate: new Date(year, month + 3, date),
                    theme: 'android-ics light',
                    mode: 'scroller',
                    lang: 'zh',
                    display: 'bottom',
                    animate: '',
                    rows: 5,
                    minWidth: 60,
                    height: 36,
                    showLabel: false,
                    useShortLabels: true,
                    //点击确定按钮，触发事件
                    onSelect: function(val) {
                        that.date = val;
                    }
                });
            }
        }
    }

    $(function(){
        _global.fn.init();

    });
</script>
</body>
</html>