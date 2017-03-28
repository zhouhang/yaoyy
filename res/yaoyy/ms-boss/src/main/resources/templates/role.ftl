<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>角色清单-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>账号权限</li>
                <li>角色列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <@shiro.hasPermission name="role:edit">
                <div class="action-add">
                    <a href="/role/add" class="ubtn ubtn-blue">新建角色</a>
                </div>
                </@shiro.hasPermission>
            </div>

            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <th width="50"><input type="checkbox" class="cbx"></th>
                            <th>编号</th>
                            <th>角色名称</th>
                            <th width="150">角色描述</th>
                            <th width="150">创建时间</th>
                            <th class="tc" width="180">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <#list rolePage.list as role>
                        <tr>
                            <td><input type="checkbox" class="cbx" value="${role.id}"></td>
                            <td>${role.id}</td>
                            <td>${role.name!}</td>
                            <td>${role.description!}</td>
                            <td>${(role.createDate?datetime)!}</td>
                            <td class="tc" data-id="${role.id}">
                                <a href="role/power/${role.id}" class="ubtn ubtn-blue jedit">配置</a>
                                <a href="javascript:;"  class="ubtn ubtn-gray jdel">删除</a>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=rolePage url="role/index" params=roleParams />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        deleteUrl: '/role/delete/',
        init: function() {
            navLight('7-2');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this
                $table = $('.table');

            // 删除
            $table.on('click', '.jdel', function() {
                var url = that.deleteUrl + $(this).parent().data('id');

                layer.confirm('确认删除？', {icon: 3}, function (index) {
                    $.get(url, function (data) {
                        if (data.status == '200') {
                            window.location.reload();
                        }
                    }, 'json');
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