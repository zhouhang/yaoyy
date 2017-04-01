<!DOCTYPE html>
<html lang="en">
<head>
<#include "../common/meta.ftl"/>
    <title>寄卖订单-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "../common/header.ftl"/>
    <#include "../common/aside.ftl"/>
        <div class="content">
            <div class="breadcrumb">
                <ul>
                    <li>订单管理</li>
                    <li>寄卖订单</li>
                </ul>
            </div>

            <div class="box">
                <div class="tools">
                    <div class="filter">
                        <form id="filterForm" method="get" action="/supplier/order">
                            <input type="text" name="supplierName" class="ipt" placeholder="供应商">
                            <input type="text" name="supplierTel" class="ipt" placeholder="手机号">
                            <input type="text" name="commodityName" class="ipt" placeholder="商品名称">
                            <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                        </form>
                    </div>

                </div>

                <div class="table">
                    <table>
                        <thead>
                        <tr>
                            <th>订单号</th>
                            <th>商品名称</th>
                            <th>供应商</th>
                            <th>价格</th>
                            <th>购买数量</th>
                            <th>总价</th>
                            <th>订单状态</th>
                            <th width="60" class="tc">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list pageInfo.list as pick>
                        <tr>
                            <td>${pick.code!}</td>
                            <td>${pick.commodityName!}</td>
                            <td>${pick.supplierName!}</td>
                            <td>${pick.price}元/${pick.unit}</td>
                            <td>${pick.num}${pick.unit}</td>
                            <td>${pick.sum}</td>
                            <td>${pick.statusText}</td>
                            <td class="tc" data-id="${pick.id!}">
                                <a href="javascript:;" class="ubtn ubtn-blue jedit">查看详情</a>
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

<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        init: function () {
            navLight('8-5');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $table = $('.table'),
                $body = $('body');

            that.enable = true; // 防止重复提交
            var response = function(url, data) {
                $.ajax({
                    type: 'POST',
                    url: url,
                    dataType: 'json',
                    data: data || {},
                    beforeSend: function() {
                        that.enable = false;
                    },
                    success: function(data) {
                        data.status == 200 && window.location.reload();
                    },
                    complete: function() {
                        that.enable = true;
                    }
                })
            }

            // 查看详情
            $table.on('click', '.jedit', function() {
                if (that.enable) {
                    that.enable = false;
                    that.showInfo($(this).parent().data('id'));
                }
                return false;
            })

            // 关闭弹层
            $body.on('click', '.fa-form-info .ubtn-gray', function () {
                layer.closeAll();
            })

            // 退货
            $body.on('click', '.fa-form-info .ubtn-red', function () {
                response('/supplier/order/refunds', {pickId: $(this).data('id')});
            })

            // 结算
            $body.on('click', '.fa-form-info .ubtn-blue', function () {
                response('/supplier/order/finish', {pickId: $(this).data('id')});
            })
        },
        showInfo: function(id) {
            var that = this;

            var showBox = function(data) {
                var html = [];
                html.push('<div class="fa-form fa-form-info fa-form-layer">');
                html.push('<div class="item"> \n <div class="txt">订单号：</div> \n <div class="val">', data.code, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">商品名称：</div> \n <div class="val">', data.commodityName, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">规格等级：</div> \n <div class="val">', data.spec, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">供应商：</div> \n <div class="val">', data.supplierName, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">供应商手机号：</div> \n <div class="val">', data.supplierTel, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">价格：</div> \n <div class="val">', data.price, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">购买数量：</div> \n <div class="val">', data.num, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">总价：</div> \n <div class="val">', data.sum, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">订单状态：</div> \n <div class="val">', data.statusText, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">批次号：</div> \n <div class="val">', data.batchInfo, '</div> \n </div>');
                html.push('<div class="note">注：订单状态已完成没有结算订单和退货按钮</div>');
                html.push('<div class="button">');
                if (data.status !== 3) {
                    html.push('<button type="button" class="ubtn ubtn-blue" data-id="'+data.id+'">结算订单</button>');
                    html.push('<button type="button" class="ubtn ubtn-red" data-id="'+data.id+'">退货</button>');
                }
                html.push('<button type="button" class="ubtn ubtn-gray">取消</button>');
                html.push('</div>');
                html.push('</div>');
                layer.closeAll();
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: html.join(''),
                    title: '订单详情'
                });
            }

            // 加载数据
            var k = $.ajax({
                url: '/supplier/order/detail',
                data: {pickId: id},
                dataType: 'json',
                method: 'POST',
                success: function(data) {
                    showBox(data.data);
                },
                complete: function() {
                    that.enable = true;
                }
            })

            // loading
            layer.open({
                area: ['200px'],
                type: 1,
                content: '<div class="layer-loading">加载中...</div>',
                title: '订单详情',
                cancel: function() {
                    k.abort();
                }
            });
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>