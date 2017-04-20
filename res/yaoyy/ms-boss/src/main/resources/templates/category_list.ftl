<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>品种列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>商品管理</li>
                <li>品种列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/category/list">
                        <input type="text" name="name" class="ipt" placeholder="品种" id="searchName" />
                        <select class="ipt"  name="status" id="searchStatus" class="slt">
                            <option <#if (categoryVo.status??)> selected</#if>  value="">上/下架</option>
                            <option <#if categoryVo.status?exists && categoryVo.status==1> selected</#if> value="1">上架</option>
                            <option <#if categoryVo.status?exists && categoryVo.status==0> selected</#if>value="0">下架</option>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>

                <div class="action-add">
                    <button class="ubtn ubtn-blue" id="jaddNewCat">新建品种</button>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th width="50"><input type="checkbox" class="cbx"></th>
                        <th>品种</th>
                        <th>标题</th>
                        <th>排序</th>
                        <th>父类</th>
                        <th width="150">创建时间</th>
                        <th width="180" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list categoryPage.list as category>
                    <tr <#if category.status==0>class="gray"</#if>>
                        <td><input type="checkbox" class="cbx"></td>
                        <td>${category.name!}</td>
                        <td>${category.title!}</td>
                        <td>${category.sort!}</td>
                        <td>${category.parentName!}</td>
                        <td>${(category.createTime?datetime)!}  </td>
                        <td class="tc" data-id="${category.id?c}">
                            <a href="javascript:;" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="javascript:;" class="ubtn ubtn-gray jdel" >删除</a>
                            <#if category.status==0>
                                <a href="javascript:;" class="ubtn ubtn-red jputup">上架</a>
                            </#if>
                            <#if category.status==1>
                                <a href="javascript:;" class="ubtn ubtn-black jputdown">下架</a>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>

        <#import "./module/pager.ftl" as pager />
        <@pager.pager info=categoryPage url="category/list" params=categoryParams/>
        </div>
    </div>
    
    <#include "./common/footer.ftl"/>
</div>

<!-- 品种新增&编辑弹出框 -->
<form id="myform" class="hide" method="post">
    <input type="hidden"  class="ipt" value="" name="id" id="cId">
    <div class="fa-form fa-form-layer">
        <div class="item">
            <div class="txt"><i>*</i>父类品种：</div>
            <div class="cnt">
                <select name="pid" id="names" class="slt">
                    <#list names as name>
                    <option value="${name.id?c}">${name.name}</option>
                    </#list>
                </select>
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>品种：</div>
            <div class="cnt">
                <input type="text" name="name" class="ipt" placeholder="品种" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>标题：</div>
            <div class="cnt">
                <input type="text" name="title" class="ipt" placeholder="标题" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>排序：</div>
            <div class="cnt">
                <input type="text" name="sort" class="ipt" placeholder="只能输入数字" autocomplete="off" data-msg-integer="只能输入数字">
            </div>
        </div>
        <div class="item">
            <div class="txt">图片：</div>
            <div class="cnt">
                <span class="thumb up-img x4" id="imgCrop"></span>
                <input type="hidden" value="" name="pictureUrl" id="pictureUrl">
                <span class="tips">图片尺寸：220 X 180</span>
            </div>
        </div>
        <!--<div class="item">  品种新加属性，kevin继续完成开发
            <div class="txt"><i>*</i>等级规格：</div>
            <div class="cnt">
                <input type="text" name="spec" class="ipt" placeholder="等级规格" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>单位：</div>
            <div class="cnt">
                <input type="text" name="unit" class="ipt" placeholder="单位" autocomplete="off">
            </div>
        </div>-->
    </div>
    <button type="submit" class="hide"></button>
</form>

<script src="assets/js/croppic.min.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        deleteUrl : '/category/delete/',
        updateUrl : '/category/update/',
        getUrl    : '/category/get/',
        saveUrl   : '/category/save/',
        init: function() {
            navLight('6-1');
            this.bindEvent();
            this.upfileImg();
        },
        bindEvent: function() {
            var that = this,
                url = '',
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

            // 表单
            $myform.validator({
                fields: {
                    name: '品种: required',
                    title: '标题: required',
                    sort: '排序: required; integer'
//                    pictureUrl: '图片: required'
                },
                valid: function (form) {
                    that.enable && response(url, $(form).serializeObject());
                    return false;
                }
            });

            // 删除
            $table.on('click', '.jdel', function() {
                var url = that.deleteUrl + $(this).parent().data('id');

                layer.confirm('确认删除？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            // 上架
            $table.on('click', '.jputup', function() {
                var url = that.updateUrl,
                    id = $(this).parent().data('id');

                layer.confirm('确认上架？', {icon: 3}, function (index) {
                    response(url, {'id': id, 'status': '1'});
                });
                return false;
            })

            // 下架
            $table.on('click', '.jputdown', function() {
                var url = that.updateUrl,
                    id = $(this).parent().data('id');

                layer.confirm('确认下架？', {icon: 3}, function (index) {
                    response(url, {'id': id, 'status': '0'});
                });
                return false;
            })

            // 编辑
            $table.on('click', '.jedit', function() {
                if (that.enable) {
                    that.enable = false;
                    $myform[0].reset();
                    url = that.updateUrl;
                    that.showinfo($(this).parent().data('id'));
                }
                return false;
            })

            // 新建
            $('#jaddNewCat').on('click', function() {
                $('#imgCrop').empty();
                $('#pictureUrl').val('');
                $("#cId").val('');
                $myform[0].reset();
                url = that.saveUrl;
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: $myform,
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    title: '新建品种'
                });
            })
        },
        showinfo: function(id) {
            var that = this,
                $myform = $('#myform');

            var showBox = function(data) {
                $myform.find('.ipt[name="name"]').val(data.name);
                $myform.find('.ipt[name="title"]').val(data.title);
                $myform.find('.ipt[name="sort"]').val(data.sort);
                $myform.find('.ipt[name="id"]').val(data.id);
                $('#names').val(data.pid);

                // 如果有图片，填充图片
                if (data.pictureUrl) {
                    $('#imgCrop').html('<img src="' + data.pictureUrl + '" /><i class="del" title="删除"></i>');
                } else {
                    $('#imgCrop').empty();
                }
                $('#pictureUrl').val(data.pictureUrl);
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
                    title: '编辑品种'
                });
            }

            // 加载数据
            var k = $.ajax({
                url: that.getUrl + id,
                type: 'POST',
                data: {id: id},
                dataType: 'json',
                success: function(data) {
                    data.status == 200 && showBox(data.data);
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
                title: '编辑品种',
                cancel: function() {
                    k.abort();
                }
            });
        },
        upfileImg: function() {
            $('body').append('<div id="upload" style="position:fixed;bottom:0;left:0;width:0;height:0;visibility:hidden;"></div>');

            new Croppic('upload', {
                uploadUrl: '/gen/upload',
                onBeforeImgUpload: function() {
                    $('#imgCrop').html('<span class="loader">图片上传中...</span>');
                },
                onAfterImgUpload: function(response){
                    $('#imgCrop').html('<img src="' + response.url + '"><i class="del" title="删除">').next(':hidden').val(response.url).trigger('validate');
                },
                onError: function(msg){
                    $('#imgCrop').html('<span class="upimg-msg">' + msg + '</span>');
                }
            });

            // 删除图片
            $('#myform').on('click', '.del', function() {
                var $that = $(this);
                layer.confirm('确认删除图片？', function(index){
                    $that.parent().empty().next(':hidden').val('');
                    layer.close(index);
                });
                return false;
            })

            $('#myform').on('click', '#imgCrop', function() {
                $('#upload').find('.cropControlUpload').trigger('click');
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>