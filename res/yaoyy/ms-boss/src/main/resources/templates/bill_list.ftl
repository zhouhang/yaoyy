<!DOCTYPE html>
<html lang="en">
<head>
    <title>账单列表-boss</title>
    <#include "./common/meta.ftl"/>
</head>
<body class='wrapper'>
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
                <form action=""  id="filterForm">
                    <input type="text" name="nickname"class="ipt" placeholder="客户姓名">
                    <input type="text"name="orderCode" class="ipt" placeholder="订单号">
                    <select name="status" class="slt">
                        <option value="">全部</option>
                        <option value="1">已结清</option>
                        <option value="0">未结清</option>
                    </select>
                    <button type="button"class="ubtn ubtn-blue"  id="search">搜索</button>
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
                    <th width="100" class="tc">操作</th>
                </tr>
                </thead>
                <tbody>
                <#list pageInfo.list as billVo>
                <tr>
                    <td>${billVo.code}</td>
                    <td>${billVo.orderCode}</td>
                    <td>${billVo.nickname}</td>
                    <td>${billVo.name}</td>
                    <td>${billVo.amountsPayable}元</td>
                    <td>${billVo.timeLeft}天</td>
                    <td>${billVo.operateName}</td>
                    <td>
                           <#if billVo.status==0>
                            未结清
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
</div>

<#include "./common/footer.ftl"/>>

<script>
    var _global = {
        v: {
            listUrl:'/bill/list'
        },
        fn: {
            init: function() {
                this.bindEvent();
                $("#filterForm").initByUrlParams();
            },
            bindEvent: function() {
                $("#search").on('click',function () {
                    var $ipts = $('.filter .ipt, .filter select');
                    var url=_global.v.listUrl+"?";
                    var params = [];
                    $ipts.each(function() {
                        var val = $.trim(this.value);
                        console.log(val);
                        val && params.push($(this).attr('name') + '=' + val);
                    })
                    location.href=url+params.join('&');
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