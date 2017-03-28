<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>用户列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>用户管理</li>
                <li>用户列表列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/user/list">
                        <input name="phone" type="text" class="ipt" placeholder="手机">
                        <input name="name" type="text" class="ipt" placeholder="姓名/单位">
                        <select name="identityType" class="slt">
                            <option value="">身份类型</option>
                            <option value="1">饮片厂</option>
                            <option value="2">药厂</option>
                            <option value="3">药材经营公司</option>
                            <option value="4">个体经营户</option>
                            <option value="5">合作社</option>
                            <option value="6">种植基地</option>
                            <option value="8">个人经营</option>
                            <option value="9">采购经理</option>
                            <option value="10">销售经理</option>
                            <option value="7">其他</option>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th width="50"><input type="checkbox" class="cbx"></th>
                        <th>手机</th>
                        <th>称呼</th>
                        <th>身份类型</th>
                        <th>姓名/单位</th>
                        <th>状态</th>
                        <th width="150">创建时间</th>
                        <th width="180" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pageInfo.list as user>
                    <tr <#if user.status==0>class="gray"</#if>>
                        <td><input type="checkbox" class="cbx"></td>
                        <td>${user.phone}</td>
                        <td>${user.nickname?default("")}</td>
                        <td>${user.identityTypeName?default("")}</td>
                        <td>${user.name?default("")}</td>
                        <td>${user.typeName?default("")}</td>
                        <td>${user.createTime?datetime}</td>
                        <td class="tc" data-id="${user.id}">
                            <a href="javascript:;" class="ubtn ubtn-blue jedit">查看</a>
                            <#if user.status==1>
                                <a href="javascript:;" class="ubtn ubtn-black jdel">禁用</a>
                            <#else>
                                <a href="javascript:;" class="ubtn ubtn-red jenable">启用</a>
                            </#if>

                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        <#import "./module/pager.ftl" as pager />
        <@pager.pager info=pageInfo url="user/list" params="" />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        detailUrl: '/user/detail/',
        disableUrl: '/user/disable/',
        enableUrl: '/user/enable/',
        init: function() {
            navLight('3-1');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $table = $('.table');

            that.enable = true; // 防止重复提交
            var response = function(url, data) {
                $.ajax({
                    type: 'GET',
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

            // 启用
            $table.on('click', '.jenable', function() {
                var url = that.enableUrl + $(this).parent().data('id');

                layer.confirm('确认启用此账户？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            // 禁用
            $table.on('click', '.jdel', function() {
                var url = that.disableUrl + $(this).parent().data('id');

                layer.confirm('确认禁用此账户？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            // 查看详情
            $table.on('click', '.jedit', function() {
                if (that.enable) {
                    that.enable = false;
                    that.showinfo($(this).parent().data('id'));
                }
                return false;
            })
        },
        showinfo: function(id) {
            var that = this;
            
            var showBox = function(data) {
                var html = [];
                html.push('<div class="fa-form fa-form-info fa-form-layer">');
                html.push('<div class="item"> \n <div class="txt">手机：</div> \n <div class="val">', data.phone, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">称呼：</div> \n <div class="val">', data.nickname, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">身份类型：</div> \n <div class="val">', data.identityTypeName, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">姓名/单位：</div> \n <div class="val">', data.name, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">用户备注：</div> \n <div class="val">', data.remark, '</div> \n </div>');
                html.push('<div class="item"> \n <div class="txt">注册时间：</div> \n <div class="val">', data.createTime, '</div> \n </div>');
                html.push('</div>');
                layer.closeAll();
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,                        
                    content: html.join(''),
                    btn: ['关闭'],
                    title: '用户详情'
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
                title: '用户详情',
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