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
                        <form action="">
                            <input type="text" class="ipt" placeholder="供应商">
                            <input type="text" class="ipt" placeholder="手机号">
                            <input type="text" class="ipt" placeholder="商品名称">
                            <button class="ubtn ubtn-blue">搜索</button>
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
                            <th width="120" class="tc">操作</th>
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
                            <td class="tc">
                                <a href="javascript:;" class="ubtn ubtn-blue jedit" data-id="${pick.id!}">查看详情</a>
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
<!-- 管理员弹出框表单 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-info fa-form-layer">
        <div class="item">
            <div class="txt">商品名称：</div>
            <div class="val">三棱</div>
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
            <div class="row">
                <div class="item">
                    <div class="txt"><i>*</i>购买数量：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" class="ipt price" data-rule="required; range(1~99999)" name="number1" value="" autocomplete="off">
                            <span class="unit">公斤</span>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>对应批次号：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" class="ipt" data-rule="required" name="id1" value="" autocomplete="off">
                        </div>
                    </div>
                </div>
                <div class="op"><button type="button" class="ubtn ubtn-blue" id="jaddrow">添加</button></div>
            </div>
        </div>
        <div class="row-calc">
            总计：<em>0</em> 元
        </div>

        <div class="button">
            <button type="submit" class="ubtn ubtn-blue">保存</button>
            <button type="button" class="ubtn ubtn-gray">取消</button>
        </div>
    </div>
</form>
<script src="assets/plugins/layer/layer.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        v: {
            deleteUrl: '',
            flag: false
        },
        fn: {
            init: function() {
                this.bindEvent();
            },
            bindEvent: function() {
                var $table = $('.table'),
                        self = this;

                // 查看详情
                $table.on('click', '.jedit', function() {
                    if (_global.v.flag) {
                        return false;
                    }
                    _global.v.flag = true;
                    self.showUserinfo($(this).data('id'));
                    return false;
                })

                // 关闭弹层
                $('body').on('click', '.fa-form-info .ubtn-gray', function () {
                    layer.closeAll();
                })
            },
            showUserinfo: function(id) {
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

                    // 退货
                    $('.fa-form-info').on('click', '.ubtn-red', function () {
                        $.post("/supplier/order/refunds",{pickId:$(this).data("id")}, function(result){
                            if (result.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '成功',
                                    text: '退货成功',
                                    callback: function() {
                                        window.location.reload(true);
                                    }
                                });
                                layer.closeAll();
                            }
                        })
                    })

                    // 结算
                    $('.fa-form-info').on('click', '.ubtn-blue', function () {
                        $.post("/supplier/order/finish",{pickId:$(this).data("id")}, function(result){
                            if (result.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '成功',
                                    text: '订单已完成',
                                    callback: function() {
                                        window.location.reload(true);
                                    }
                                });
                                layer.closeAll();
                            }
                        })
                    })
                }

                // 加载数据
                var k = $.ajax({
                    url: '/supplier/order/detail',
                    data: {pickId: id},
                    dataType: 'json',
                    method:"POST",
                    success: function(data) {
                        showBox(data.data);
                    },
                    complete: function() {
                        _global.v.flag = false;
                    }
                })

                // loading
                layer.open({
                    area: ['200px'],
                    type: 1,
                    moveType: 1,
                    content: '<div class="layer-loading">加载中...</div>',
                    title: '订单详情',
                    cancel: function() {
                        k.abort();
                    }
                });

            }
        }
    }

    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>