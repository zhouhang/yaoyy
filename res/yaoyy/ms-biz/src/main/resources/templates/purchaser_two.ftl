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
            <input type="hidden" name="id" id="id" value="${vo.id!}">
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
<#include "./common/footer.ftl"/>
<script src="assets/js/mobiscroll.min.js"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                <#if address?exists>
                    if (sessionStorage.getItem("pickAddrId${vo.id}") == undefined) {
                        var addr = {};
                        addr.id = ${address.id};
                        addr.titleN = "ss";
                        sessionStorage.setItem("pickAddrId${vo.id!}", JSON.stringify(addr));
                    };
                </#if>
                var address = sessionStorage.getItem("pickAddrId${vo.id!}");
                if (address) {
                    address = JSON.parse(address);
                    // 初始化 地址内容
                    if (address.title) {
                        $("#regionID").val(address.id);
                        $("#address_title").html(address.title);
                        $("#address_detail").html(address.detail);
                    }
                }

                var remark = sessionStorage.getItem("pickRemark${vo.id!}");
                if (remark) {
                    $("#remark").val(remark);
                }
                var date = sessionStorage.getItem("pickDate${vo.id!}");
                if (date) {
                    $("#date").val(date);
                }
                $(window).bind('beforeunload',function(){
                    sessionStorage.setItem("pickDate${vo.id!}",$("#date").val());
                    sessionStorage.setItem("pickRemark${vo.id!}", $("#remark").val());
                });


                this.pickDate();
                this.submit();
            },
            cleanSessionStorage: function () {
                sessionStorage.removeItem("pickDate${vo.id!}");
                sessionStorage.removeItem("pickRemark${vo.id!}");
                sessionStorage.removeItem("pickAddrId${vo.id!}");
            },
            submit: function () {
                $("#submit").click(function () {
                    var date = $("#myform").serializeArray();
                    $.post("/pick/purchaser/two",date,function(result){
                        if (result.status == 200) {
                            _global.fn.cleanSessionStorage();
                            window.location.href="/pick/detail/${vo.id!}";
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
                    display: 'bottom',
                    animate: 'slideup',
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