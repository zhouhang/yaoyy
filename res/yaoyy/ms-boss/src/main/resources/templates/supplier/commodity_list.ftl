<!DOCTYPE html>
<html lang="en">
<head>
<#include "../common/meta.ftl"/>
<title>寄卖商品管理-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "../common/header.ftl"/>
    <#include "../common/aside.ftl"/>
        <div class="content">
            <div class="breadcrumb">
                <ul>
                    <li>订单管理</li>
                    <li>寄卖下单</li>
                </ul>
            </div>

            <div class="box">
                <div class="tools">
                    <div class="filter">
                        <form id="filterForm" method="get" action="/supplier/commodity">
                            <input type="text" name="supplierName" class="ipt" placeholder="供应商">
                            <input type="text" name="supplierTel" class="ipt" placeholder="手机号">
                            <input type="text" name="name" class="ipt" placeholder="商品名称">
                            <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                        </form>
                    </div>

                </div>

                <div class="table">
                    <table>
                        <thead>
                        <tr>
                            <th>商品名称</th>
                            <th>规格等级</th>
                            <th>供应商</th>
                            <th>供应商手机号</th>
                            <th>价格</th>
                            <th>寄卖库存</th>
                            <th width="90" class="tc">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list pageInfo.list as commodity>
                        <tr>
                            <td>${commodity.name!}</td>
                            <td>${commodity.spec!}</td>
                            <td>${commodity.supplierName!}</td>
                            <td>${commodity.supplierTel!}</td>
                            <td>${commodity.price!}元/${commodity.unitName!}</td>
                            <td>${commodity.warehouse!}</td>
                            <td class="tc">
                                <a href="javascript:;" class="ubtn ubtn-blue jcreate" data-attr="${commodity.id}||${commodity.name!}||${commodity.spec!}||${commodity.price?c}||${commodity.unitName}">下单</a>
                            </td>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            <#import "../module/pager.ftl" as pager />
            <@pager.pager info=pageInfo url="/supplier/commodity" params="" />
            </div>
        </div>
    <#include "../common/footer.ftl"/>
</div>

<!-- 下单表单 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-info fa-form-layer">
        <div class="item">
            <div class="txt">商品名称：</div>
            <div class="val">三棱</div>
            <input type="hidden" id="commodityId">
        </div>
        <div class="item">
            <div class="txt">规格等级：</div>
            <div class="val">过20号筛，直径2cm以上</div>
        </div>
        <div class="item">
            <div class="txt">当前价格：</div>
            <div class="val">15元/公斤</div>
        </div>
        <div class="row-list">
            <div class="row-li">
                <div class="item">
                    <div class="txt"><i>*</i>购买数量：</div>
                    <div class="cnt">
                        <input type="text" class="ipt number" data-rule="required; range(1~99999)" name="number1" value="" autocomplete="off">
                        <span class="unit">公斤</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>对应批次号：</div>
                    <div class="cnt">
                        <input type="text" class="ipt" data-rule="required" name="id1" value="" autocomplete="off">
                    </div>
                </div>
                <div class="op"><button type="button" class="ubtn ubtn-blue" id="jaddrow">添加</button></div>
            </div>
        </div>
        <div class="row-calc">
            总计：<em>0</em> 元
        </div>
    </div>
    <button type="submit" class="hide"></button>
</form>

<script type="temp" id="temp">
	<div class="row-li">
		<div class="item">
	        <div class="txt"><i>*</i>购买数量：</div>
        	<div class="cnt">
    			<input type="text" class="ipt number" data-rule="required; range(1~99999)" value="" autocomplete="off">
    			<span class="unit">{{unit}}</span>
        	</div>
		</div>
		<div class="item">
	        <div class="txt"><i>*</i>对应批次号：</div>
        	<div class="cnt">
        		<input type="text" class="ipt" data-rule="required" value="" autocomplete="off">
        	</div>
		</div>
		<div class="op"><button type="button" class="ubtn ubtn-red jdel">删除</button></div>
    </div>
</script>

<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        listUrl: '/supplier/stock',
        init: function () {
            navLight('8-4');
            this.bindEvent();
        },
        bindEvent: function() {
            var $table = $('.table'),
                $myform = $('#myform'),
                $rowList = $('.row-list'),
                $count = $('.row-calc').find('em'),
                model = $('#temp').html(),
                attr = [], // id|name|spec|price|unit
                enable = true;

            var response = function(url) {
                var data = [];

                $myform.find('.row').each(function(i) {
                    data.push({
                        'num': $(this).find('.ipt:eq(0)').val(),
                        'no': $(this).find('.ipt:eq(1)').val()
                    })
                })

                $.ajax({
                    type: 'POST',
                    url: url,
                    dataType: 'json',
                    data: {commodityId: attr[0], data: JSON.stringify(data)},
                    contentType: 'application/json',
                    beforeSend: function() {
                        enable = false;
                    },
                    success: function(res) {
                        if (res.status == 200) {
                            window.location.reload();
                        } else {
                            $.notify({
                                type: 'warn',
                                title: '库存不足',
                                delay: 3e3
                            });
                        }
                    },
                    complete: function() {
                        enable = true;
                    }
                })
            }

            $myform.validator({
                valid: function (form) {
                    enable && response('/supplier/order/create');
                }
            });

            // 下单
            $table.on('click', '.jcreate', function() {
                var val = [];
                attr = $(this).data('attr').split('||');
                val = [attr[1], attr[2], attr[3]+'元/'+ attr[4]];
                $myform.find('.val').each(function(i) {
                    $(this).html(val[i]);
                })
                $myform.find('.unit').html(attr[4]);
                $myform[0].reset();
                layer.open({
                    skin: 'layer-form',
                    area: ['600px', '100%'],
                    type: 1,
                    content: $myform,
                    title: '锁价下单',
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    btn2: function() {
                        $rowList.find('.row:gt(0)').remove();
                    }
                });
            })

            // calc
            $rowList.on('blur', '.number', function() {
                var count = 0;
                $rowList.find('.number').each(function() {
                    if (this.value == '' || isNaN(this.value)) {
                        count += 0;
                    } else {
                        count += parseInt(this.value, 10);
                    }
                })
                $count.html(count * attr[3]);
            })

            // 添加行
            $('#jaddrow').on('click', function() {
                $rowList.append(model.replace(/{{unit}}/g, attr[4]));
            })
            // 删除行
            $rowList.on('click', '.jdel', function() {
                $(this).closest('.row-li').remove();
            })

        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>