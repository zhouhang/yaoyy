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
                        <form id="filterForm" action="">
                            <input type="text" name="supplierName" class="ipt" placeholder="供应商">
                            <input type="text" name="supplierTel" class="ipt" placeholder="手机号">
                            <input type="text" name="name" class="ipt" placeholder="商品名称">
                            <button id="search_btn" type="button" class="ubtn ubtn-blue">搜索</button>
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
                            <th width="230" class="tc">操作</th>
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
                                <a href="javascript:;" class="c-blue jadd" data-spec="${commodity.spec!}" data-name="${commodity.name!}" data-id="${commodity.id}">添加寄卖库存</a>
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
            <div class="fa-form fa-form-layer">
                <div class="item">
                    <div class="txt">商品名称：</div>
                    <div id="name" class="val">三棱</div>
                    <input style="display: none" type="text" id="id">
                </div>
                <div class="item">
                    <div class="txt">规格等级：</div>
                    <div id="spec" class="val">过20号筛，直径2cm以上</div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>添加数量：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" id="num" class="ipt" name="number" value="">
                            <span class="unit">公斤</span>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <p>注：添加寄卖库存的商品在寄卖商品列表中显示</p>
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
                fn: {
                    init: function () {
                        this.bindEvent();
                        this.filter();
                    },
                    // 筛选
                    filter: function() {
                        $("#filterForm").initByUrlParams();
                        var $ipts = $('.filter .ipt, .filter select');
                        var url="/supplier/commodity?";

                        $('#search_btn').on('click', function() {
                            var params = [];
                            $ipts.each(function() {
                                var val = $.trim(this.value);
                                val && params.push($(this).attr('name') + '=' + val);
                            })
                            location.href = url + params.join('&');
                        })
                    },
                    bindEvent: function () {
                        var $table = $('.table'),
                                $myform = $('#myform');

                        $myform.validator({
                            fields: {
                                number: '数量: required'
                            },
                            valid: function (form) {
                                $.post("/supplier/stock",{id: $("#myform #id").val(),num:$("#myform #num").val()} ,function (data) {
                                    if (data.status == 200) {
                                        layer.closeAll();
                                        window.location.reload();
                                    }
                                }, "json");
                            }
                        });

                        // 关闭弹层
                        $myform.on('click', '.ubtn-gray', function () {
                            layer.closeAll();
                        })


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
                            $this = $(this);

                            $("#myform #name").html($this.data("name"));
                            $("#myform #spec").html($this.data("spec"));
                            $myform[0].reset();
                            $("#myform #id").val($this.data("id"));
                            layer.open({
                                skin: 'layer-form',
                                area: ['600px'],
                                type: 1,
                                content: $myform,
                                title: '添加寄卖库存'
                            });
                            return false; // 阻止链接跳转
                        })
                    }
                }
            }

            $(function () {
                _global.fn.init();
            })
        </script>
</body>
</html>