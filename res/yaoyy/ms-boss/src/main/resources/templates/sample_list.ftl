<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>寄样列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>寄样服务</li>
                <li>寄样列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/sample/list">
                        <input name="code" type="text" class="ipt" placeholder="寄样编号" value="">
                        <input name="nickname" type="text" class="ipt" placeholder="联系人" value="">
                        <input name="phone" type="text" class="ipt" placeholder="手机号" value="">
                        <select name="status" class="slt">
                            <option value="">选择状态</option>
                            <option value="0">未受理</option>
                            <option value="1">同意寄样</option>
                            <option value="2">拒绝寄样</option>
                            <option value="3">客户来访</option>
                            <option value="4">已寄样</option>
                            <option value="5">寄样完成</option>
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
                            <th>寄样编号</th>
                            <th>联系人</th>
                            <th>手机号</th>
                            <th>地区</th>
                            <th>意向商品</th>
                            <th>状态</th>
                            <th width="150">创建时间</th>
                            <th width="120" class="tc">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <#list sendSampleVoPageInfo.list as sendSample>
                        <tr >
                            <td><a href="/sample/detail/${sendSample.id?c}" class="link">${sendSample.code}</a></td>
                            <td>${sendSample.nickname}</td>
                            <td>${sendSample.phone}</td>
                            <td>${sendSample.position}</td>
                            <td>${sendSample.intentionText}</td>
                            <td><em class="status-${sendSample.status+1}">${sendSample.statusText}</em></td>
                            <td>${(sendSample.createTime?datetime)!}</td>
                            <td class="tc" data-id="${sendSample.id?c}">
                                <a href="/sample/detail/${sendSample.id?c}" class="ubtn ubtn-blue jedit">查看</a>
                                <#if sendSample.abandon==0>
                                    <a href="javascript:;" class="ubtn ubtn-black jputdown">废弃</a>
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
            <@pager.pager info=sendSampleVoPageInfo url="sample/list" params="" />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script src="assets/plugins/validator/jquery.validator.js"></script>
<script>
!(function($, window) {
    var _global = {
        deleteUrl: '/sample/delete/',
        init: function() {
            navLight('4-1');
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