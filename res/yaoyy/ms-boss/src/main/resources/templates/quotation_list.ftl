<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>报价单列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>报价单管理</li>
                <li>报价单列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/quotation/list">
                        <input type="text" name="title" class="ipt" placeholder="标题">
                        <select name="status" id="" class="slt">
                            <option value="">全部</option>
                            <option value="0">草稿</option>
                            <option value="1">发布</option>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>
                <div class="action-add">
                    <a href="/quotation/create" class="ubtn ubtn-blue">新建报价单</a>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th><input type="checkbox" class="cbx"></th>
                        <th>标题</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th width="180" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pageInfo.list as quotation>
                    <tr <#if quotation.status==0>class="gray"</#if>>
                        <td><input type="checkbox" class="cbx"></td>
                        <td>${(quotation.title)!}</td>
                        <#if quotation.status==0>
                            <td>草稿</td>
                        <#else>
                            <td>发布</td>
                        </#if>
                        <td>${(quotation.createTime?datetime)!}</td>
                        <td class="tc" data-id="${quotation.id}">
                            <a href="/quotation/detail/${quotation.id}" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>
                            <#if quotation.status==0>
                                <a href="javascript:;" class="ubtn ubtn-red jpublish">发布</a>
                            <#else>
                                <a href="javascript:;" class="ubtn ubtn-black draft">草稿</a>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>

            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=pageInfo url="/quotation/list" params="" />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        deleteUrl: '/quotation/delete/',
        updateUrl:'/quotation/updateStatus',
        init: function() {
            navLight('11-1');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $table = $('.table');

            that.enable = true; // 防止重复提交
            var response = function(url, data, method) {
                $.ajax({
                    type: method || 'POST',
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
            $table.on('click', '.jdel', function() {
                var url = that.deleteUrl + $(this).parent().data('id');

                layer.confirm('确认删除此报价单？', {icon: 3}, function (index) {
                    response(url, {}, 'GET');
                });
                return false;
            })

            //发布
            $table.on('click', '.jpublish', function() {
                var id = $(this).parent().data('id');

                layer.confirm('确认发布？', {icon: 3}, function (index) {
                    response(that.updateUrl, {'id': id, 'status': '1'});
                });
                return false;
            });

            //草稿
            $table.on('click', '.draft', function() {
                var id = $(this).parent().data('id');

                layer.confirm('确认转为草稿？', {icon: 3}, function (index) {
                    response(that.updateUrl, {'id': id, 'status': '0'});
                });
                return false;
            });
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>