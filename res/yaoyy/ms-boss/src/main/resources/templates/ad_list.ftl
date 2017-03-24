<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>广告管理-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>专场广告</li>
                <li>广告列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/ad/list">
                        <select name="typeId" class="slt">
                            <option value="">选择类型</option>
                            <#list types as type>
                                <option value="${type.id}">${type.name}</option>
                            </#list>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>

                <div class="action-add">
                    <button class="ubtn ubtn-blue" id="jaddNew">新建广告</button>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th><input type="checkbox" class="cbx"></th>
                        <th>类型</th>
                        <th>名称</th>
                        <th>链接</th>
                        <th>排序</th>
                        <th width="150">创建时间</th>
                        <th width="180" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pageInfo.list as ad>
                    <tr <#if ad.status==0>class="gray"</#if>>
                        <td><input type="checkbox" class="cbx"></td>
                        <td>${ad.adTypeName!}</td>
                        <td>${ad.name!}</td>
                        <td>${ad.href!}</td>
                        <td>${ad.sort!}</td>
                        <td>${(ad.createTime?datetime)!}</td>
                        <td class="tc" data-id="${ad.id}">
                            <a href="javascript:;" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>
                            <#if ad.status == 0>
                                <a href="javascript:;" class="ubtn ubtn-red jputup">启用</a>
                            <#else>
                                <a href="javascript:;" class="ubtn ubtn-black jputdown">禁用</a>
                            </#if>

                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        <#import "./module/pager.ftl" as pager />
        <@pager.pager info=pageInfo url="ad/list" params="" />
        </div>
    </div>
    
    <#include "./common/footer.ftl"/>
</div>

<!-- 广告新增&编辑弹出框 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-layer">
        <div class="item">
            <div class="txt">类型：</div>
            <div class="cnt">
                <select name="typeId" id="typeId" class="slt">
                <#list types as type>
                    <option value="${type.id}">${type.name}</option>
                </#list>
                </select>
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>名称：</div>
            <div class="cnt">
                <input type="text" name="name" class="ipt" placeholder="名称" autocomplete="off">
                <input type="hidden" name="id">
            </div>
        </div>
        <div class="item">
            <div class="txt">链接：</div>
            <div class="cnt">
                <input type="text" name="href" class="ipt" placeholder="链接" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>排序：</div>
            <div class="cnt">
                <input type="text" name="sort" class="ipt" placeholder="只能输入数字" autocomplete="off" data-msg-integer="只能输入数字">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>图片：</div>
            <div class="cnt">
                <span class="thumb up-img x1" id="imgCrop"></span>
                <input type="hidden" id="pictureUrl" name="pictureUrl" value="">
                <span class="tips">图片尺寸：750 X 350</span>
            </div>
        </div>
    </div>
    <button type="submit" class="hide"></button>
</form>

<script src="assets/js/croppic.min.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        deleteUrl  : '/ad/delete/',
        detailUrl  : '/ad/detail/',
        enableUrl  : '/ad/enable/',
        disableUrl : '/ad/disable/',
        saveUrl    : '/ad/save',
        init: function() {
            navLight('1-2');
            this.bindEvent();
            this.upfileImg();
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
            
            // 表单
            $myform.validator({
                fields: {
                    name: '名称: required',
                    sort: '排序: required; integer',
                    pictureUrl: '图片: required'
                },
                valid: function (form) {
                    that.enable && response(that.saveUrl, $(form).serializeObject());
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

            $table.on('click', '.jputup', function() {
                var url = that.enableUrl + $(this).parent().data('id');

                layer.confirm('确认启用？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            $table.on('click', '.jputdown', function() {
                var url = that.disableUrl + $(this).parent().data('id');

                layer.confirm('确认禁用？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            $table.on('click', '.jedit', function() {
                if (that.enable) {
                    that.enable = false;
                    $myform[0].reset();
                    that.showinfo($(this).parent().data('id'));
                }
                return false; // 阻止链接跳转
            })

            // 新建
            $('#jaddNew').on('click', function() {
                $('#imgCrop').empty();
                $('#pictureUrl').val('');
                $myform[0].reset();
                $myform.find('.slt[name="typeId"]').trigger('change');
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: $myform,
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    title: '新建广告'
                });
            })
        },
        showinfo: function(id) {
            var that = this,
                $myform = $('#myform');

            var showBox = function(data) {
                $myform.find('input[name="id"]').val(data.id);
                $myform.find('.ipt[name="name"]').val(data.name);
                $myform.find('.ipt[name="sort"]').val(data.sort);
                $myform.find('.ipt[name="href"]').val(data.href);
                $myform.find('.slt[name="typeId"]').val(data.typeId).trigger('change');

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
                    title: '编辑广告'
                });
            }

            // 加载数据
            var k = $.ajax({
                url: that.detailUrl + id,
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
                title: '编辑广告',
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

            // 切换上传图片的尺寸
            $('#typeId').on('change', function() {
                var tips = this.value == 1 ? '图片尺寸：750 X 350' : '图片尺寸：750 X 400';
                $('#imgCrop').attr('class', 'thumb up-img x' + this.value).nextAll('.tips').html(tips);
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>