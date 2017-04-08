<!DOCTYPE html>
<html lang="en">
  <head>
    <title>供应商订单详情-药优优</title>
    <#include "../common/meta.ftl"/>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">

  </head>
<body>
<#include "../common/footer.ftl"/>

<div class="ui-content">
    <div class="detail">
        <div class="item">
            <input  id="orderId" type="hidden" value="${pickVo.id!}" />
            <p><span>状态：</span><em>${pickVo.statusText!}</em></p>
            <p><span>订单号：</span>${pickVo.code!}</p>
            <p><span>下单时间：</span>${pickVo.createTime?date}</p>
        </div>

        <div class="item">
            <label>采购单</label>
            <#list pickVo.pickCommodityVoList as pickCommodityVo >
            <div class="t3 fr">${pickCommodityVo.num?c}${pickCommodityVo.unit} <em>${pickCommodityVo.price}</em>元/${pickCommodityVo.unit}</div>
            <div class="t3 mr">${pickCommodityVo.name}  ${pickCommodityVo.origin}  ${pickCommodityVo.spec}</div>
            </#list>
        </div>

        <div class="item">
            <label>货物要求</label>
            <div>${pickVo.remark!}</div>
        </div>

        <div class="item info">
            <label>送货信息</label>
            <p><span>采购单位：</span>${userDetail.company!}</p>
            <p><span>采购人：</span>${userDetail.name!}</p>
            <p><span>采购人手机：</span>${userDetail.phone!}</p>
            <#if shippingAddressHistory?exists>
                <p><span>收货地址：</span>${shippingAddressHistory.detail!}</p>
                <p><span>收货人：</span>${shippingAddressHistory.consignee!}</p>
                <p><span>收货人手机：</span>${shippingAddressHistory.tel!}</p>
            </#if>

        </div>
        <div class="item">
            <span>送货时间：</span>
            <#if pickVo.status==6>
                <a href="javascript:;" class="op mid c-blue">修改送货时间</a>
            </#if>
            <div class="date mid">
                <input type="text" class="ipt" id="date" readonly="" value="${(pickVo.deliveryDate?string("yyyy-MM-dd HH:mm"))!}" />
            </div>
        </div>
        <div class="summary">
            <div class="li">
                商品总价：<em >¥${pickVo.sum!}</em>元
            </div>
            <#if pickVo.shippingCosts?exists>
            <div class="li">
                运费：<em>¥${pickVo.shippingCosts!}</em>元
            </div>
            </#if>
            <#if pickVo.bagging?exists>
            <div class="li">
                包装加工费：<em>¥${pickVo.bagging!}</em>元
            </div>
            </#if>
            <#if pickVo.taxation?exists>
            <div class="li">
                税费：<em>¥${pickVo.taxation!}</em>元
            </div>
            </#if>
            <#if pickVo.amountsPayable?exists>
            <div class="li">
                总计：<em>¥${pickVo.amountsPayable!}</em>元
            </div>
            </#if>
            <#if pickVo.settleType?exists&&pickVo.settleType==2>
            <div class="li">
                帐期：<em>${pickVo.billTime!}</em>天
            </div>
            </#if>
        </div>
    </div>
        <#if pickVo.status==6>
            <div class="ft">
                <button type="button" id="submit" class="ubtn ubtn-primary">确认发货</button>
            </div>
        </#if>
</div>

<script src="${urls.getForLookupPath('/assets/mobiscroll/js/mobiscroll.zepto.js')}"></script>
<script src="${urls.getForLookupPath('/assets/mobiscroll/js/mobiscroll.core.js')}"></script>
<script src="${urls.getForLookupPath('/assets/mobiscroll/js/mobiscroll.scroller.js')}"></script>
<script src="${urls.getForLookupPath('/assets/mobiscroll/js/mobiscroll.datetime.js')}"></script>
<script src="${urls.getForLookupPath('/assets/mobiscroll/js/mobiscroll.i18n.zh.js')}"></script>
<script>
!(function() {
    var _global = {
        fn: {
            init: function() {
                navLight(2);
                this.pickDate();
                this.submit();
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
                        $.ajax({
                            type: 'POST',
                            url: '/supplier/update/DeliverTime',
                            dataType: 'json',
                            data: {orderId:$("#orderId").val(), date:val},
                            success: function(result){
                                if(result.status=='200'){
                                    popover(result.msg);
                                }
                            },
                            error: function(xhr, type){
                                popover('网络连接超时，请您稍后重试!');
                            }
                        });
                    }
                });
            },
            submit: function() {
                var that = this;
                $('#submit').on('click', function() {
                    var date = $("#date").val();
                    if(date==null||date==""){
                        popover('请先填写送货时间!');
                        return false;
                    }

                    $.ajax({
                        type: 'POST',
                        url: '/supplier/delivery',
                        dataType: 'json',
                        data: {orderId:$("#orderId").val(), date:date},
                        success: function(result){
                            if(result.status=='200'){
                                popover(result.msg);
                                location.reload();
                            }
                        },
                        error: function(xhr, type){
                            popover('网络连接超时，请您稍后重试!');
                        }
                    });
                })
            }
        }
    }

     _global.fn.init();

})(window.Zepto||window.jQuery);


</script>
</body>
</html>