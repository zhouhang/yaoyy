<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>签约供应商列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>供应商管理</li>
                <li>签约供应商</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/supplier/signlist">
                        <input type="text" name="name"class="ipt" placeholder="姓名">
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" class="cbx"></th>
                            <th>供应商编号</th>
                            <th>姓名</th>
                            <th>手机号</th>
                            <th>经营品种</th>
                            <th>地区</th>
                            <th>是否签订合同</th>
                            <th>最后登录时间</th>
                            <th width="90" class="tc">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <#list pageInfo.list as user>
                        <tr>
                            <td><input type="checkbox" class="cbx"></td>
                            <td>${user.id}</td>
                            <td>${user.name!}</td>
                            <td>${user.phone!}</td>
                            <td>${user.enterCategoryText!}</td>
                            <td>${user.position!}</td>
                            <td>${user.isContract!}</td>
                            <td>${(user.updateTime?datetime)!}</td>
                            <td class="tc">
                                <a href="/supplier/signdetail/${user.id}" class="ubtn ubtn-blue jedit">编辑</a>
                            </td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            </div>
            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=pageInfo url="/supplier/signlist" params="" />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('8-2');
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>