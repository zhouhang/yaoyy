<!DOCTYPE html>
<html lang="en">
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商详情-药优优</title>
</head>
<body>

<div class="wrapper">
    <#include "../common/header.ftl"/>
    <#include "../common/aside.ftl"/>
	<div class="content">
		<div class="breadcrumb">
			<ul>
                <li>供应商管理</li>
                <li>供应商详情</li>
    		</ul>
		</div>

        <div class="fa-tab">
            <a href="#">基本信息</a>
            <a href="#">评价信息</a>
            <!--<a href="#">身份信息</a>-->
            <span class="on">商品调价</span>
        </div>

		<div class="box fa-form">
            <div class="hd">商品调价</div>
            <div class="plist">
            <#if isbinding == 0>
                <span class="c-red">该供应商暂未绑定用户</span>
            </#if>
                <ul>
                    <#if commodityVos?exists>
                        <#list commodityVos as commodityVo>
                    <li>
                        <div class="info">
                            <strong>${commodityVo.name!}</strong>
                            <span>${commodityVo.spec!}</span>
                        </div>
                        <div class="op">
                            <input type="text" value="${commodityVo.price!}" class="ipt unitprice"><em>元/${commodityVo.unitName}</em>
                            <input type="text" value="${commodityVo.unwarehouse?default(0)}" class="ipt inventory"><em>库存</em>
                            <a href="javascript:;" class="ubtn ubtn-blue jsave" data-id="${commodityVo.id}">保存</a>
                        </div>
                    </li>
                        </#list>
                    </#if>
                </ul>
            </div>
        </div>

        <div class="box fa-form">
            <div class="hd">调价记录</div>
            <ol class="trace" id="trace">
                <#if messageVos?exists>
                <#list messageVos as messageVo>
                <li>
                    <span>${messageVo.createTime?datetime}</span>
                    <span>${messageVo.content?default("")}</span>
                </li>
                </#list>
                </#if>
            </ol>
        </div>
	</div>
    <#include "../common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('8-1');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,    
                $plist = $('.plist');

            // 库存输入框
            $plist.on('keyup', '.inventory', function() {
                var val = this.value;
                if (val) {
                    val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : '';
                    this.value = val;
                }
            })
            // 单价输入框
            $plist.on('keyup', '.unitprice', function() {
                var val = this.value;
                if (!/^\d+\.?\d*$/.test(val)) {
                    val = Math.abs(parseFloat(val));
                    this.value = isNaN(val) ? '' : val;
                }
            })

            // 保存价格
            $plist.on('click', '.jsave', function() {
                var $pa = $(this).closest('li'),
                    $number = $pa.find('.inventory'),
                    $price = $pa.find('.unitprice'),
                        $id = $(this).data('id');

                $.ajax({
                    url: 'commodity/save',
                    type: "post",
                    data: JSON.stringify({id: $id, unwarehouse: $number.val(), price: $price.val()}),
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    success: function(data) {
                        $.notify({
                            type: 'success',
                            title: '保存成功'
                        })
                    }
                })
            })
            
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>