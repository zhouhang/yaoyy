<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>报价单列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <<#include "./common/header.ftl"/>
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
                    <form action="" id="filterForm">
                        <input type="text" name="title" class="ipt" placeholder="标题">
                        <select name="status" id="" class="slt">
                            <option value="">全部</option>
                            <option value="0">草稿</option>
                            <option value="1">发布</option>
                        </select>
                        <button type="button" class="ubtn ubtn-blue" id="search">搜索</button>
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
                        <th width="170" class="tc">操作</th>
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
                        <td class="tc">
                            <a href="/quotation/detail/${quotation.id}" class="ubtn ubtn-blue jedit">编辑</a>
                            <a href="javascript:;" qid="${quotation.id}" class="ubtn ubtn-gray jdel">删除</a>
                            <#if quotation.status==0>
                                <a href="javascript:;" data-id="${quotation.id}" class="ubtn ubtn-red jpublish">发布</a>
                            <#else>
                                <a href="javascript:;" data-id="${quotation.id}" class="ubtn ubtn-red draft">草稿</a>
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

<script>
    var _global = {
        v: {
            deleteUrl: '/quotation/delete/',
            listUrl:'/quotation/list',
            updateUrl:'/quotation/updateStatus'
        },
        fn: {
            init: function() {
                this.bindEvent();
                $("#filterForm").initByUrlParams();
            },
            bindEvent: function() {
                var $table = $('.table'),
                        $cbx = $table.find('td input:checkbox'),
                        $checkAll = $table.find('th input:checkbox'),
                        count = $cbx.length;
                var $search=$("#search");

                // 删除
                $table.on('click', '.jdel', function() {
                    var url = _global.v.deleteUrl + $(this).attr('qid');
                    layer.confirm('确认删除此报价单？', {icon: 3, title: '提示'}, function (index) {
                        $.get(url, function (data) {
                            if (data.status == "200") {
                                window.location.reload();
                            }
                        }, "json");
                        layer.close(index);
                    });
                    return false; // 阻止链接跳转
                })
                //发布
                $table.on('click', '.jpublish', function() {
                    var qId = $(this).data('id');
                    layer.confirm('确认发布？', {icon: 3, title: '提示'}, function (index) {
                        $.ajax({
                            url: _global.v. updateUrl,
                            data: {"id": qId, "status": 1},
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
                });
                //草稿
                $table.on('click', '.draft', function() {
                    var qId = $(this).data('id');
                    layer.confirm('确认转为草稿？', {icon: 3, title: '提示'}, function (index) {
                        $.ajax({
                            url: _global.v. updateUrl,
                            data: {"id": qId, "status":0},
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
                });



                $search.on('click',function () {
                    var params = [];
                    $(".filter .ipt, .filter select").each(function() {
                        var val = $.trim(this.value);
                        val && params.push($(this).attr('name') + '=' + val);
                    })
                    location.href=_global.v.listUrl+'?'+params.join('&');
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
            }


        }
    }

    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>