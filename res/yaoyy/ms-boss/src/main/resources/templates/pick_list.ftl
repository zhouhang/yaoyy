<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>选货单列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>选货单模块</li>
                <li>选货单列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/pick/list">
                        <input type="text" name="code"class="ipt" placeholder="选货单编号">
                        <input type="text" name="phone" class="ipt" placeholder="客户电话">
                        <select name="status" class="slt">
                            <option value="">选择状态</option>
                            <option value="0">未受理</option>
                            <option value="1">已受理</option>
                            <option value="4">审核不通过</option>
                            <option value="2">交易未达成</option>
                            <option value="3">交易已完成</option>
                            <option value="5">待支付</option>
                            <option value="6">待发货</option>
                            <option value="7">已发货</option>
                            <option value="8">待用户确认</option>
                            <option value="9">已取消</option>
                        </select>
                        <select name="abandon" class="slt">
                            <option value="0">正常</option>
                            <option value="1">废弃</option>
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
                        <th>选货单编号</th>
                        <th>客户姓名</th>
                        <th>客户电话</th>
                        <th>状态</th>
                        <th width="150">下单时间</th>
                        <th width="230" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pickVoPageInfo.list as pick>
                    <tr>
                        <td><input type="checkbox" class="cbx"></td>
                        <td><a href="pick/detail/${pick.id}" class="link">${pick.code}</a></td>
                        <td>${pick.nickname}</td>
                        <td>${pick.phone}</td>
                        <td><em class="status-${pick.status+1}">${pick.statusText}</em></td>
                        <td>${(pick.createTime?datetime)!}</td>
                        <td class="tc" data-id="${pick.id}">
                            <a href="pick/detail/${pick.id}" class="ubtn ubtn-blue jedit">查看</a>
                            <#if pick.abandon==0>
                                <a href="javascript:;" class="ubtn ubtn-gray jputdown">废弃</a>
                            <#else>
                                <a href="javascript:;" class="ubtn ubtn-red jputup">恢复</a>
                            </#if>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
            </div>

            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=pickVoPageInfo url="pick/list" params="" />
        </div>
    </div>
    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        deleteUrl: '/pick/delete/',
        init: function() {
            navLight('5-1');
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

            // 恢复
            $table.on('click', '.jputup', function() {
                var url = that.deleteUrl,
                    id = $(this).parent().data('id');

                layer.confirm('确认恢复？', {icon: 3}, function (index) {
                    response(url, {'id': id, 'abandon': '0'});
                });
                return false;
            })

            // 废弃
            $table.on('click', '.jputdown', function() {
                var url = that.deleteUrl,
                    id = $(this).parent().data('id');

                layer.confirm('确认废弃？', {icon: 3}, function (index) {
                    response(url, {'id': id, 'abandon': '1'});
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