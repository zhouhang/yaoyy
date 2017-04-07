<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>订单详情-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
<#include "./common/navigation.ftl"/>

<div class="ui-content">
    <div class="detail">
        <div class="item">
            <p><span>状态：</span><em>${pickVo.statusText!}</em></p>
            <p><span>订单号：</span>${pickVo.id!}</p>
            <p><span>下单时间：</span>${pickVo.createTime?datetime}</p>
        </div>

        <div class="item">
            <label>采购单</label>
            <div class="t3 fr">${pickVo.total!}公斤 <em>15</em>元/公斤</div>
            <div class="t3 mr">三棱  浙江  统个三棱  浙江  统个三棱  浙江  统个</div>
        </div>
        <div class="item">
            <label>货物要求</label>
            <div>干度90%，含量74%</div>
        </div>
        <div class="item info">
            <label>收货信息</label>
            <p><span>采购单位：</span>安徽省沪谯饮片厂</p>
            <p><span>采购人：</span>王彬</p>
            <p><span>采购人手机：</span>17099928881</p>
            <p><span>收货地址：</span>武汉</p>
            <p><span>收货人：</span>张三</p>
            <p><span>收货人手机：</span>17099928881</p>
        </div>
        <div class="item">
            <span>送货时间：</span>
            <a href="javascript:;" class="op mid c-blue">修改送货时间</a>
            <div class="date mid">
                <input type="text" class="ipt" id="date" readonly="" value="2017-03-22" />
            </div>
        </div>
        <div class="summary">
            <div class="li">
                商品总价：<em id="_min">¥90.00</em>元
            </div>
        </div>
        <div class="ft">
            <button type="button" id="submit" class="ubtn ubtn-primary">确认发货</button>
        </div>
    </div>
</div>

<link rel="stylesheet" href="${urls.getForLookupPath('/assets/mobiscroll/css/mobiscroll.css')}" />
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/mobiscroll.zepto.js')}"></script>
<script src="${urls.getForLookupPath('/assets/js/mobiscroll.core.js')}"></script>
<script src="${urls.getForLookupPath('/assets/js/mobiscroll.scroller.js')}"></script>
<script src="${urls.getForLookupPath('/assets/js/mobiscroll.datetime.js')}"></script>
<script src="${urls.getForLookupPath('/assets/js/mobiscroll.i18n.zh.js')}"></script>
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
                    }
                });
            },
            submit: function() {
                var that = this;
                $('#submit').on('click', function() {
                    // alert(that.date)
                })
            }
        }
    }

     _global.fn.init();

})(window.Zepto||window.jQuery);


</script>
</body>
</html>