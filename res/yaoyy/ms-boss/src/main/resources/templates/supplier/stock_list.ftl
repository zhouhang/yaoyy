<!DOCTYPE html>
<html lang="en">
<head>
<#include "../common/meta.ftl"/>
<title>寄卖库存管理-药优优</title>
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
                    <form id="filterForm" method="get" action="/supplier/stock">
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
                        <th width="180" class="tc">操作</th>
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
                            <a href="javascript:;" class="ubtn ubtn-blue jadd" data-attr="${commodity.id}||${commodity.name!}||${commodity.spec!}||${commodity.unitName}">添加寄卖库存</a>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        <#import "../module/pager.ftl" as pager />
        <@pager.pager info=pageInfo url="/supplier/stock" params="" />
        </div>
    </div>
    <#include "../common/footer.ftl"/>
</div>

<!-- 添加库存弹出框表单 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-layer">
        <div class="item">
            <div class="txt">商品名称：</div>
            <div id="form_name" class="val"></div>
        </div>
        <div class="item">
            <div class="txt">规格等级：</div>
            <div id="form_spec" class="val"></div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>添加数量：</div>
            <div class="cnt">
                <div class="ipt-wrap">
                    <input type="text" id="form_num" class="ipt" name="number" value="" autocomplete="off">
                    <span class="unit">公斤</span>
                </div>
            </div>
        </div>
        <div class="item">
            <p>注：添加寄卖库存的商品在寄卖商品列表中显示</p>
        </div>
    </div>
    <button type="submit" class="hide"></button>
</form>

<script src="assets/plugins/layer/layer.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        init: function () {
            navLight('8-3');
            this.bindEvent();
        },
        bindEvent: function () {
            var that = this,
                attr = [], // id|name|spec|unit
                enable = true,
                $table = $('.table'),
                $myform = $('#myform');

            var response = function(url) {
                $.ajax({
                    type: 'POST',
                    url: url,
                    dataType: 'json',
                    data: {id: attr[0], num: $('#form_num').val()},
                    beforeSend: function() {
                        enable = false;
                    },
                    success: function(res) {
                        res.status == 200 && window.location.reload();
                    },
                    complete: function() {
                        enable = true;
                    }
                })
            }
            $myform.validator({
                fields: {
                    number: '数量: required'
                },
                valid: function (form) {
                    enable && response('/supplier/stock');
                }
            });

            // 数量
            $myform.on('keyup', '.ipt', function () {
                var val = this.value;
                if (val) {
                    val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : 0;
                    this.value = val;
                }
            })

            // 添加库存
            $table.on('click', '.jadd', function () {
                attr = $(this).data('attr').split('||');
                $('#form_name').html(attr[1]);
                $('#form_spec').html(attr[2]);
                $('#form_num').val('');
                $myform.find('.unit').html(attr[3]);
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: $myform,
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    title: '添加寄卖库存'
                });
                return false; // 阻止链接跳转
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>