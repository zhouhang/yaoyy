<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>商品列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>商品管理</li>
                <li>商品列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                     <form id="filterForm" method="get" action="/commodity/list">
                        <input name="name" type="text" class="ipt" placeholder="商品名称">
                        <input type="text" name="categoryName" class="ipt" placeholder="品种">
                        <select name="status" class="slt">
                            <option value="">上/下架</option>
                            <option value="1">上架</option>
                            <option value="0">下架</option>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                     </form>
                </div>
                <div class="action-add">
                    <a href="/commodity/add" class="ubtn ubtn-blue">新建商品</a>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th><input type="checkbox" class="cbx"></th>
                        <th>商品名称</th>
                        <th>品种</th>
                        <th width="320">标题</th>
                        <th>规格等级</th>
                        <th>价格</th>
                        <th>排序</th>
                        <th>更新时间</th>
                        <th width="230" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pageInfo.list as commodity>
                    <tr <#if commodity.status==0>class="gray"</#if>>
                        <td><input type="checkbox" class="cbx" value="${commodity.id}"></td>
                        <td>${commodity.name}</td>
                        <td>${commodity.categoryName!}</td>
                        <td>${commodity.title!}</td>
                        <td>${commodity.spec}</td>
                        <td>${commodity.price}/${commodity.unitName}</td>
                        <td>${commodity.sort}</td>
                        <td><#if commodity.updateTime??> ${commodity.updateTime?datetime} <#else>${commodity.createTime?datetime} </#if></td>
                        <td class="tc" data-id="${commodity.id}">
                            <a href="javascript:;" class="ubtn ubtn-red jprice">调价</a>
                            <a href="/commodity/detail/${commodity.id}" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>
                            <#if commodity.status==0>
                                <a href="javascript:;" class="ubtn ubtn-red jputup">上架</a>
                            </#if>
                            <#if commodity.status==1>
                                <a href="javascript:;" class="ubtn ubtn-black jputdown">下架</a>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        <#import "./module/pager.ftl" as pager />
        <@pager.pager info=pageInfo url="commodity/list" params="" />
        </div>
    </div>
    
    <#include "./common/footer.ftl"/>
</div>

<!-- 商品新增&编辑弹出框 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-layer">
        <div class="item"></div>
    </div>
    <button type="submit" class="hide"></button>
</form>

<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        deleteUrl      : '/commodity/detete/',
        upDownUrl      : '/commodity/updown',
        detailUrl      : '/commodity/get',
        updatePriceUrl : '/commodity/updatePrice',
        init: function() {
            navLight('6-2');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $table = $('.table'),
                $myform = $('#myform');

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

            // 删除
            $table.on('click', '.jdel', function () {
                var url = that.deleteUrl + $(this).parent().data('id');

                layer.confirm('确认删除？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            // 上架
            $table.on('click', '.jputup', function() {
                var url = that.upDownUrl,
                    id = $(this).parent().data('id');

                layer.confirm('确认上架？', {icon: 3}, function (index) {
                    response(url, {'id': id, 'status': '1'});
                });
                return false;
            })

            // 下架
            $table.on('click', '.jputdown', function() {
                var url = that.upDownUrl,
                    id = $(this).parent().data('id');

                layer.confirm('确认下架？', {icon: 3}, function (index) {
                    response(url, {'id': id, 'status': '0'});
                });
                return false;
            })

            // 调价
            $table.on('click', '.jprice', function () {
                if (that.enable) {
                    that.enable = false;
                    that.showinfo($(this).parent().data('id'));
                }
                return false; // 阻止链接跳转
            })
	    
            $myform.validator({
                fields: {
                    price: '价格: required; range(1~9999)'
                },
                valid: function (form) {
                    that.enable && response(that.updatePriceUrl, $(form).serializeObject());
                    return false;
                }
            });
        },
        showinfo: function(id) {
            var that = this,
                $myform = $('#myform');

            var showBox = function(data) {
                var html = [];
                html.push('<input id="id" name="id" value="'+data.id+'" style="display:none"/>');
                switch (typeof data.price) {
                    case 'number':
                        html.push('<div class="txt"><i>*</i>价格：</div> \n <div class="cnt"> \n <div class="ipt-wrap"> \n <input type="text" name="price" class="ipt" id="jprice" value=' + data.price + ' placeholder="价格" autocomplete="off"> \n <span class="unit">元</span> \n </div> ');
                        break;
                    case 'object':
                        html.push('<div class="txt"><i>*</i>公斤/价格：</div>');
                        $.each(data.price, function(i, item) {
                            var idx = i + 1;
                            html.push('<div class="cnt"> \n <div class="ipt-wrap"><input type="text" name="minKg' , idx , '" class="ipt ipt-short" value="' , item[0] , '" data-rule="required; range(1~99999)" placeholder="1-99999" autocomplete="off"></div> \n <em>-</em> \n <div class="ipt-wrap"><input type="text" name="maxKg' , idx , '" class="ipt ipt-short" value="' , item[1] , '" data-rule="required; range(1~99999)" placeholder="1-99999" autocomplete="off"></div> \n <em>公斤</em> \n <div class="ipt-wrap ml"> \n <input type="text" name="price' , idx , '" class="ipt ipt-short" value="' , item[2] , '" placeholder="1-9999" data-rule="required; range(1~9999)" autocomplete="off"> \n <span class="unit">元</span> \n </div> \n </div>');
                        });
                        break;
                }

                $myform.find('.item').html(html.join(''));

                layer.closeAll();
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: $myform,
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    title: '快速调价'
                });
            }

            // 加载数据
            var k = $.ajax({
                url: that.detailUrl,
                dataType: 'json',
                method: "POST",
                data: {id: id},
                success: function(result) {
                    showBox(result.data);
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
                title: '快速调价',
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