<!DOCTYPE html>
<html lang="en">
<head>
    <title>寄样列表-boss-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class='wrapper'>

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
                <form action="" id="searchForm">
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
                    <button type="button" class="ubtn ubtn-blue" id="search">搜索</button>
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
                        <th width="230" class="tc">操作</th>
                    </tr>
                </thead>
                <tbody>
                <#list sendSampleVoPageInfo.list as sendSample>
                    <tr>
                        <td>${sendSample.code}</td>
                        <td>${sendSample.nickname}</td>
                        <td>${sendSample.phone}</td>
                        <td>${sendSample.area}</td>
                        <td>${sendSample.intentionText}</td>
                        <td><em class="status-${sendSample.status+1}">${sendSample.statusText}</em></td>
                        <td>${(sendSample.createTime?datetime)!}</td>
                        <td class="tc">
                            <a href="/sample/detail/${sendSample.id?c}" class="ubtn ubtn-blue jedit">查看</a>
                            <#if sendSample.abandon==0>
                                <a href="javascript:;" class="ubtn ubtn-gray jdel" data-id="${sendSample.id?c}">废弃</a>
                            <#else>
                                <a href="javascript:;" class="ubtn ubtn-red jenable" data-id="${sendSample.id?c}">恢复</a>
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
<script src="assets/plugins/validator/jquery.validator.js"></script>
<script>
    var _global = {
        v: {
            deleteUrl: '/sample/delete/',
        },
        fn: {
            init: function() {
                this.bindEvent();
                $("#searchForm").initByUrlParams();
            },
            bindEvent: function() {
                var $table = $('.table'),
                        $cbx = $table.find('td input:checkbox'),
                        $checkAll = $table.find('th input:checkbox'),
                        count = $cbx.length;
                var $search =$("#search");
                var $pageSize=$("#pageSize");

                // 启用
                $table.on('click', '.jenable', function() {
                    var sendId = $(this).data('id');
                    layer.confirm('确认恢复此寄样单？', {icon: 3, title: '提示'}, function (index) {
                        $.ajax({
                            url: _global.v.deleteUrl,
                            data: {"id": sendId, "abandon": 0},
                            type: "POST",
                            success: function (data) {
                                if (data.status == "200") {
                                    window.location.reload();
                                }
                                layer.close(index);
                            }
                        });
                    });
                    return false; // 阻止链接跳转
                })

                // 删除
                $table.on('click', '.jdel', function() {
                    var sendId = $(this).data('id');
                    layer.confirm('确认废弃此寄样单？', {icon: 3, title: '提示'}, function (index) {
                        $.ajax({
                            url: _global.v.deleteUrl,
                            data: {"id": sendId, "abandon": 1},
                            type: "POST",
                            success: function (data) {
                                if (data.status == "200") {
                                    window.location.reload();
                                }
                                layer.close(index);
                            }
                        });

                    });
                    return false; // 阻止链接跳转
                })

                // 全选
                $checkAll.on('click', function() {
                    var isChecked = this.checked;
                    $cbx.each(function() {
                        this.checked = isChecked;
                    })
                })
                // 单选
                $cbx.on('click', function() {
                    var _count = 0;
                    $cbx.each(function() {
                        _count += this.checked ? 1 : 0;
                    })
                    $checkAll.prop('checked', _count === count);
                })

                $search.on("click",function(){
                    var condition=$("#searchForm").serializeArray();
                    var conditionText="";
                    $.each(condition, function(i, field){
                        if(field.value!=""){
                            if(conditionText!=""){
                                conditionText=conditionText+"&"+field.name+"="+field.value;
                            }else{
                                conditionText=conditionText+field.name+"="+field.value;
                            }
                        }
                    });
                    if (condition!=""){
                       window.location.href="/sample/list?"+conditionText;
                    }

                })

                $pageSize.on("change",function(){
                    var pageSize=$(this).val();
                    var condition=$("#searchForm").serializeArray();
                    var conditionText="";
                    $.each(condition, function(i, field){
                        if(field.value!=""){
                            if(conditionText!=""){
                                conditionText=conditionText+"&"+field.name+"="+field.value;
                            }else{
                                conditionText=conditionText+field.name+"="+field.value;
                            }
                        }
                    });
                    var url="/sample/list?pageSize="+pageSize;
                    if (conditionText!=""){
                        url=url+"&"+conditionText;
                    }
                    window.location.href=url;

                })
            }
        }
    }

    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>