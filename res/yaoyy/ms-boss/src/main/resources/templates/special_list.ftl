<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>专场列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>专场广告</li>
                <li>专场列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/special/list">
                        <input type="text" class="ipt"  name="title" value="${specialVo.title?default('')}" placeholder="标题">
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>

                <div class="action-add">
                    <a href="special/create" class="ubtn ubtn-blue">新建专场</a>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th width="50"><input type="checkbox" class="cbx"></th>
                        <th>标题</th>
                        <th>链接</th>
                        <th>排序</th>
                        <th width="150">创建时间</th>
                        <th width="150">修改时间</th>
                        <th width="180" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list  specialVoPageInfo.list as special>
                    <tr <#if special.status==0>class="gray"</#if>>
                        <td><input type="checkbox" class="cbx"></td>
                        <td>${special.title}</td>
                        <td>${bizBaseUrl}special/${special.id}</td>
                        <td>${special.sort!}</td>
                        <td>${(special.createTime?datetime)!}</td>
                        <td>${(special.updateTime?datetime)!}</td>
                        <td class="tc" data-id="${special.id?c}">
                            <a href="special/edit/${special.id?c}" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="#" class="ubtn ubtn-gray jdel">删除</a>
                            <#if special.status==0>
                                <a href="javascript:;" class="ubtn ubtn-red jputup">上架</a>
                            <#else>
                                <a href="javascript:;" class="ubtn ubtn-black jputdown">下架</a>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>

        <#import "./module/pager.ftl" as pager />
        <@pager.pager info=specialVoPageInfo url="special/list" params=specialVoParams />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        deleteUrl : '/special/delete/',
        updateUrl : '/special/updateStatus',
        init: function() {
            navLight('1-1');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $table = $('.table');
                
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
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>