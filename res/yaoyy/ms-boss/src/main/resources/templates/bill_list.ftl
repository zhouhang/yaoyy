<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>账单列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>账单管理</li>
                <li>账单列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/bill/list">
                        <input type="text" name="nickname"class="ipt" placeholder="客户姓名">
                        <input type="text"name="orderCode" class="ipt" placeholder="订单号">
                        <select name="status" class="slt">
                            <option value="">全部</option>
                            <option value="1">已结清</option>
                            <option value="0">未结清</option>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <th>账单号</th>
                            <th>订单号</th>
                            <th>客户姓名</th>
                            <th>单位</th>
                            <th>账单金额</th>
                            <th>剩余账期</th>
                            <th>操作人</th>
                            <th>状态</th>
                            <th>创建时间</th>
                            <th width="90" class="tc">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <#list pageInfo.list as billVo>
                        <tr>
                            <td><a href="/bill/detail/${billVo.id?c}" class="link">${billVo.code}</a></td>
                            <td>${billVo.orderCode}</td>
                            <td>${billVo.nickname}</td>
                            <td>${billVo.name}</td>
                            <td>${billVo.amountsPayable}元</td>
                            <td>${billVo.timeLeft}</td>
                            <td>${billVo.operateName}</td>
                            <td>
                                   <#if billVo.status==0>
                                    <span class="c-red">未结清</span>
                                    <#else>
                                       已结清
                                     </#if>
                            </td>
                            <td>${billVo.createDate?datetime}</td>
                            <td class="tc">
                                <a href="/bill/detail/${billVo.id?c}" class="ubtn ubtn-blue">查看</a>
                            </td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            </div>
            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=pageInfo url="/bill/list" params="" />
        </div>
    </div>
    
    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('9-2');
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>