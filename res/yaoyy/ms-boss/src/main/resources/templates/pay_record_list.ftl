<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>交易流水列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>

    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>账单流水管理</li>
                <li>交易流水列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form  id="filterForm" >
                        <input type="text" class="ipt" name="phone" placeholder="用户手机号">
                        <input type="text" class="ipt" name="code" placeholder="单号">
                        <input type="text" class="ipt" id="startDate" name="startDate" placeholder="起始日期">
                        <input type="text" class="ipt" id="endDate" name="endDate" placeholder="结束日期">
                        <button class="ubtn ubtn-blue" type="button" id="search">搜索</button>
                    </form>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th>交易流水号</th>
                        <th>单号</th>
                        <th>单号类型</th>
                        <th>用户姓名</th>
                        <th>支付金额</th>
                        <th>支付渠道</th>
                        <th>状态</th>
                        <th width="100" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list pageInfo.list as payRecordVo >
                    <tr>
                        <td>${payRecordVo.payCode!}</td>
                        <td>${payRecordVo.code!}</td>
                        <td>
                            <#if payRecordVo.codeType==0>
                                订单
                            <#else>
                                账单
                            </#if>

                        </td>
                        <td>${payRecordVo.nickname!}</td>
                        <td>${payRecordVo.actualPayment!}</td>
                        <td>${payRecordVo.payTypeText!}</td>
                        <td>
                            <#if payRecordVo.status==0>
                                付款待确认
                            <#elseif payRecordVo.status==1>
                                支付成功
                            <#elseif payRecordVo.status==2>
                                支付失败
                            </#if>
                        </td>
                        <td class="tc">
                            <a href="/payRecord/detail/${payRecordVo.id}" class="ubtn ubtn-blue">查看</a>
                        </td>
                    </tr>
                    </#list>

                    </tbody>
                </table>
            </div>

            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=pageInfo url="/payRecord/list" params="" />
        </div>
    </div>

    <#include "./common/footer.ftl"/>

<script src="assets/plugins/laydate/laydate.js"></script>
<script>
    var _global = {
        v: {
            listUrl:'/payRecord/list'
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


                // 开始日期
                laydate({
                    elem: '#startDate',
                    format: 'YYYY-MM-DD hh:mm:ss',
                    istime: true,
                    choose: function(date){
                        $('#startDate').trigger('validate');
                    }
                })

                laydate({
                    elem: '#endDate',
                    format: 'YYYY-MM-DD hh:mm:ss',
                    istime: true,
                    choose: function(date){
                        $('#endDate').trigger('validate');
                    }
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