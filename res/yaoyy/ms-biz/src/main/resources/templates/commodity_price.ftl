<!DOCTYPE html>
<html lang="en">
<head>
    <title>历史价格-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body1 body-bg">
<header class="ui-header">
    <div class="title">历史价格</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->
<section class="ui-content">
    <div class="pinfo">
        <h1 class="title">${commodityVo.title!}</h1>
        <div class="price nobd">
            当前价格：
            <i>&yen;</i>
            <em>${commodityVo.price!}</em>
            <b>元/${commodityVo.unitName!}</b>
        </div>
    </div>
    <div class="ptrend">
        <div class="chart" id="chart1"></div>
        <div class="title">近三个月价格走势<em>（单位：元/${commodityVo.unitName!}）</em></div>
    </div>
    <div class="pinfo">
        <div class="norms">
        <#list commodityVoList as commodity>
            <a href="/commodity/price/${commodity.id?c}" <#if commodity.id==commodityVo.id>class="current"</#if>>${commodity.spec}</a>
        </#list>
        </div>
    </div>

    <div class="button">
        <a href="/commodity/detail/${commodityVo.id?c}" class="ubtn ubtn-primary">返回商品详情页</a>
    </div>
</section><!-- /ui-content -->
<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/echarts.min.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.his();
            },
            his: function() {
                var date = ${date};
                var value = ${value};
                var chart = echarts.init(document.getElementById('chart1'));
                var option = {
                    label: {
                        normal: {
                            show: true
                        }
                    },
                    xAxis: {
                        data: date
                    },
                    yAxis: {
                        splitNumber : 3,
                        splitLine: {
                            show: false
                        }
                    },
                    series: [{
                        type: 'line',
                        data: value
                    }],
                    color: ['#b9a060']
                };
                chart.setOption(option);

                $(window).on('resize', function() {
                    chart.resize();
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