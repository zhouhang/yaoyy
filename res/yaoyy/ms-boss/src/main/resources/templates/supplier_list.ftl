<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>未签约供应商列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>供应商管理</li>
                <li>未签约供应商</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/supplier/list">
                        <input type="text" name="name" class="ipt" value="" placeholder="姓名或手机号">
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>

                <div class="action-add">
                    <a href="/supplier/create" class="ubtn ubtn-blue">新建供应商</a>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" class="cbx"></th>
                            <th>姓名</th>
                            <th>手机号</th>
                            <th>经营品种</th>
                            <th>公司</th>
                            <th>地区</th>
                            <th>入驻时间</th>
                            <th width="180" class="tc">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <#list supplierVoPageInfo.list as supplier>
                        <tr>
                            <td><input type="checkbox" class="cbx"></td>
                            <td>${supplier.name!}</td>
                            <td>${supplier.phone!}</td>
                            <td>${supplier.enterCategoryStr!}</td>
                            <td>${supplier.company!}</td>
                            <td>${supplier.areaname!}</td>
                            <td>${(supplier.createTime?datetime)!}</td>
                            <td class="tc" data-id="${supplier.id}">
                                <a href="/supplier/detail/${supplier.id}" class="ubtn ubtn-blue jedit">编辑</a>
                                <a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>
                            </td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            </div>
            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=supplierVoPageInfo url="/supplier/list" params="" />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        deleteUrl: '/supplier/del/',
        init: function() {
            navLight('8-1');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
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