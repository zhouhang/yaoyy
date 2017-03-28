<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>供应商列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>供应商管理</li>
                <li>供应商列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" name="form" method="get" action="/supplier/list">
                        <select class="ipt" name="status">
                            <option value="">信息核实</option>
                            <option value="0">未核实</option>
                            <option value="1">已核实</option>
                            <option value="2">核实不正确</option>
                            <option value="3">已实地考察</option>
                            <option value="4">已签约</option>
                        </select>
                        <select class="ipt" name="source">
                            <option value="">信息来源</option>
                            <option value="1">系统录入</option>
                            <option value="2">沪谯导入</option>
                            <option value="3">天济导入</option>
                            <option value="4">微信登记</option>
                        </select>
                        <input type="text" name="name" class="ipt" value="" placeholder="姓名/手机号">
                        <input type="text" name="enterCategoryStr" class="ipt" value="" placeholder="品种">
                        <input type="hidden" class="ipt" name="pageNum" value="${supplierVoPageInfo.pageNum!}">
                        <input type="hidden" class="ipt" name="pageSize" value="${supplierVoPageInfo.pageSize!}">
                        <button type="button" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>

                <div class="action-add">
                    <a href="/supplier/create" class="ubtn ubtn-blue">新建供应商</a>
                    <a href="/supplier//exportExcel" class="ubtn ubtn-blue">导出供应商</a>

                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <th width="50"><input type="checkbox" class="cbx"></th>
                            <th>供应商编号</th>
                            <th>供应商姓名</th>
                            <th>手机号</th>
                            <th>经营品种</th>
                            <th>信息核实</th>
                            <th>绑定用户</th>
                            <#--<th>报价次数</th>-->
                            <th>信息来源</th>
                            <th>创建时间</th>
                            <th width="180" class="tc">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <#list supplierVoPageInfo.list as supplier>
                        <tr>
                            <td><input type="checkbox" class="cbx"></td>
                            <td>${supplier.id?c}</td>
                            <td>${supplier.name!}</td>
                            <td>${supplier.phone!}</td>
                            <td>${supplier.enterCategoryStr!}</td>
                            <td>
                                <#if supplier.status?? && supplier.status==0>
                                    <span class="status-1">未核实</span>
                                <#elseif supplier.status?? && supplier.status==1>
                                    <span class="status-2">已核实</span>
                                <#elseif supplier.status?? && supplier.status==2>
                                    <span class="status-7">核实不正确</span>
                                <#elseif supplier.status?? && supplier.status==3>
                                    <span class="status-8">实地考察认证</span>
                                <#elseif supplier.status?? && supplier.status==4>
                                    <span class="status-9">已签约</span>
                                <#else>
                                ${supplier.statusText!}
                                </#if>
                            </td>
                            <td>${supplier.binding!}</td>
                            <#--<td>0</td>-->
                            <td>
                            ${supplier.sourceText!}
                            </td>
                            <td>${(supplier.createTime?datetime)!}</td>
                            <td class="tc" data-id="${supplier.id?c}">
                                <a href="/supplier/detail/${supplier.id?c}" class="ubtn ubtn-blue jedit">编辑</a>
                                <#--<a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>-->
                            </td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            </div>
            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=supplierVoPageInfo url="/supplier/list" params="${supplierParams!}" />
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

            $("#search_btn").click(function(){
                var $name = $("input[name=name]");
                var pattern = /^1[34578]\d{9}$/;
                if(pattern.test($name.val())){
                    $name.attr("name", "phone");
                }else{
                    $name.attr("name", "name");
                }
                $("form").submit();
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>