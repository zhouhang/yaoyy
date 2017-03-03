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
                <div class="filter" id="filterForm">
                     <form>
                        <input name="name" type="text" class="ipt" placeholder="商品名称">
                        <input type="text" name="categoryName" class="ipt" placeholder="品种">
                        <select name="status" class="slt">
                            <option value="">上/下架</option>
                            <option value="1">上架</option>
                            <option value="0">下架</option>
                        </select>
                        <button type="button" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                     </form>
                </div>
                <div class="action-add">
                    <button class="ubtn ubtn-blue" id="jaddNewCat">新建商品</button>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th><input type="checkbox"></th>
                        <th>商品名称</th>
                        <th>品种</th>
                        <th width="320">标题</th>
                        <th>规格等级</th>
                        <th>价格</th>
                        <th>排序</th>
                        <th>更新时间</th>
                        <th width="250" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pageInfo.list as commodity>
                    <tr <#if commodity.status==0>class="gray"</#if>>
                        <td><input type="checkbox" value="${commodity.id}"></td>
                        <td>${commodity.name}<#if commodity.mark == 1 ><em class="c-red">【量大价优】</em></#if></td>
                        <td>${commodity.categoryName!}</td>
                        <td>${commodity.title!}</td>
                        <td>${commodity.spec}</td>
                        <td>${commodity.price}/${commodity.unitName}</td>
                        <td>${commodity.sort}</td>
                        <td><#if commodity.updateTime??> ${commodity.updateTime?datetime} <#else>${commodity.createTime?datetime} </#if></td>
                        <td class="tc">
                            <a href="javascript:;" class="ubtn ubtn-red jprice" data-id="${commodity.id}">调价</a>
                            <a href="/commodity/detail/${commodity.id}" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="${commodity.id}" class="ubtn ubtn-gray jdel">删除</a>
                            <#if commodity.status==0>
                                <a href="javascript:;" class="ubtn ubtn-red jputaway" commodityId="${commodity.id?c}" status="${commodity.status}">上架</a>
                            </#if>
                            <#if commodity.status==1>
                                <a href="javascript:;" class="ubtn ubtn-gray jputaway" commodityId="${commodity.id?c}" status="${commodity.status}">下架</a>
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

<!-- 商品新增&编辑弹出框 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-layer">
        <div class="item"></div>
        <div class="button">
            <button type="submit" class="ubtn ubtn-blue">保存</button>
            <button type="button" class="ubtn ubtn-gray">取消</button>
        </div>
    </div>
</form>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        v: {
            deleteUrl: '/commodity/detete/',
            listUrl: '/commodity/list',
            upDownUrl: '/commodity/updown',
            detailUrl:'/commodity/get',
            updatePriceUrl:'/commodity/updatePrice',
            flag: false
        },
        fn: {
            init: function() {
                this.bindEvent();
                $("#filterForm").initByUrlParams();
            },
            bindEvent: function() {

                $("#jaddNewCat").click(function () {
                    location.href = "/commodity/add"
                })

                var $table = $('.table'),
                        $cbx = $table.find('td input:checkbox'),
                        $checkAll = $table.find('th input:checkbox'),
                        count = $cbx.length,
                        self = this;

                // 删除
                $table.on('click', '.jdel', function () {
                    var url = _global.v.deleteUrl + $(this).attr('href');
                    layer.confirm('确认删除此商品？', {icon: 3, title: '提示'}, function (index) {
                        $.post(url, function (data) {
                            if (data.status == "200") {
                                window.location.reload();
                            }
                        }, "json");
                        layer.close(index);
                    });
                    return false; // 阻止链接跳转
                })


                // 上架&下架
                $table.on('click', '.jputaway', function () {
                    var commodityId = $(this).attr('commodityId');
                    var status = $(this).attr("status");
                    var showMsg = '确认上架此商品？';
                    var setStatus = 1;
                    if (status == 1) {
                        showMsg = '确认下架此商品？';
                        setStatus = 0;
                    }
                    layer.confirm(showMsg, {icon: 3, title: '提示'}, function (index) {
                        $.ajax({
                            url: _global.v.upDownUrl,
                            data: {"id": commodityId, "status": setStatus},
                            type: "POST",
                            success: function (data) {
                                if (data.status == "200") {
                                    window.location.reload();
                                }
                                layer.close(index);
                            }
                        });
                        return false; // 阻止链接跳转
                    })
                })

                // 调价
                $table.on('click', '.jprice', function () {
                    if (_global.v.flag) {
                        return false;
                    }
                    _global.v.flag = true;
                    self.showinfo($(this).data('id'));
                    return false; // 阻止链接跳转
                })

                // 全选
                $checkAll.on('click', function () {
                    var isChecked = this.checked;
                    $cbx.each(function () {
                        this.checked = isChecked;
                    })
                })
                // 单选
                $cbx.on('click', function () {
                    var _count = 0;
                    $cbx.each(function () {
                        _count += this.checked ? 1 : 0;
                    })
                    $checkAll.prop('checked', _count === count);
                })

                // 关闭弹层
                $('#myform').on('click', '.ubtn-gray', function() {
                    layer.closeAll();
                }).validator({
                    fields: {
                        price: '价格: required; range(1~9999)'
                    },
                    valid: function (form) {
                        var data = $(form).serializeObject();
                        $.post(_global.v.updatePriceUrl,data, function(data){
                            if (data.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '成功',
                                    text: '商品调价成功',
                                    callback: function() {
                                        window.location.reload(true);
                                    }
                                });
                                layer.closeAll();
                            }
                        })
                    }
                });
                _global.fn.filter();
            },
            // 筛选
            filter: function() {
                var $ipts = $('.filter .ipt, .filter select');
                var url=_global.v.listUrl+"?";

                $('#search_btn').on('click', function() {
                    var params = [];
                    $ipts.each(function() {
                        var val = $.trim(this.value);
                        val && params.push($(this).attr('name') + '=' + val);
                    })
                    location.href = url + params.join('&');
                })
            },
            showinfo: function(id) {
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

                    $('#myform').find('.item').html(html.join(''));

                    layer.closeAll();
                    layer.open({
                        skin: isMobile ? 'layer-form' : '',
                        area: ['600px'],
                        type: 1,
                        content: $('#myform'),
                        title: '快速调价'
                    });
                }

                // 加载数据
                var k = $.ajax({
                    url: _global.v.detailUrl,
                    dataType: 'json',
                    method: "POST",
                    data: {id: id},
                    success: function(result) {
                        showBox(result.data);
                    },
                    complete: function() {
                        _global.v.flag = false;
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
    }

    $(function() {
        _global.fn.init();
    })
</script>

</body>
</html>