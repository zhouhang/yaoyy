<!DOCTYPE html>
<html lang="en">
<head>
<#include "../common/meta.ftl"/>
<title>寄卖商品管理-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "../common/header.ftl"/>
    <#include "../common/aside.ftl"/>
        <div class="content">
            <div class="breadcrumb">
                <ul>
                    <li>订单管理</li>
                    <li>寄卖下单</li>
                </ul>
            </div>

            <div class="box">
                <div class="tools">
                    <div class="filter">
                        <form action="">
                            <input type="text" class="ipt" placeholder="供应商">
                            <input type="text" class="ipt" placeholder="手机号">
                            <input type="text" class="ipt" placeholder="商品名称">
                            <button class="ubtn ubtn-blue">搜索</button>
                        </form>
                    </div>

                </div>

                <div class="table">
                    <table>
                        <thead>
                        <tr>
                            <th>商品名称</th>
                            <th>规格等级</th>
                            <th>供应商</th>
                            <th>供应商手机号</th>
                            <th>价格</th>
                            <th>寄卖库存</th>
                            <th width="120" class="tc">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list pageInfo.list as commodity>
                        <tr>
                            <td>${commodity.name!}</td>
                            <td>${commodity.spec!}</td>
                            <td>${commodity.supplierName!}</td>
                            <td>${commodity.supplierTel!}</td>
                            <td>${commodity.price!}元/${commodity.unitName!}</td>
                            <td>${commodity.warehouse!}</td>
                            <td class="tc">
                                <a href="javascript:;" class="ubtn ubtn-blue jcreate" data-spec="${commodity.spec!}"
                                   data-name="${commodity.name!}" data-price="${commodity.price!}" data-unit="${commodity.unitName}" data-id="${commodity.id}">下单</a>
                            </td>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            <#import "../module/pager.ftl" as pager />
            <@pager.pager info=pageInfo url="/supplier/commodity" params="" />
            </div>
        </div>
    <#include "../common/footer.ftl"/>
</div>

<!-- 管理员弹出框表单 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-info fa-form-layer">
        <div class="item">
            <div class="txt">商品名称：</div>
            <div class="val">三棱</div>
            <input type="text" style="display: none" id="commodityId">
        </div>
        <div class="item">
            <div class="txt">规格等级：</div>
            <div class="val">过20号筛，直径2cm以上</div>
        </div>
        <div class="item">
            <div class="txt">当前价格：</div>
            <div class="val">15元/公斤</div>
        </div>
        <div class="row-list">
            <div class="row">
                <div class="item">
                    <div class="txt"><i>*</i>购买数量：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" class="ipt number" data-rule="required; range(1~99999)" name="number1" value="" autocomplete="off">
                            <span class="unit">公斤</span>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>对应批次号：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" class="ipt" data-rule="required" name="id1" value="" autocomplete="off">
                        </div>
                    </div>
                </div>
                <div class="op"><button type="button" class="ubtn ubtn-blue" id="jaddrow">添加</button></div>
            </div>
        </div>
        <div class="row-calc">
            总计：<em>0</em> 元
        </div>

        <div class="button">
            <button type="submit" class="ubtn ubtn-blue">保存</button>
            <button type="button" class="ubtn ubtn-gray">取消</button>
        </div>
    </div>
</form>

<script type="temp" id="temp">
	<div class="row">
		<div class="item">
	        <div class="txt"><i>*</i>购买数量：</div>
        	<div class="cnt">
        		<div class="ipt-wrap">
        			<input type="text" class="ipt number" data-rule="required; range(1~99999)" name="number{{idx}}" value="" autocomplete="off">
        			<span class="unit">公斤</span>
        		</div>
        	</div>
		</div>
		<div class="item">
	        <div class="txt"><i>*</i>对应批次号：</div>
        	<div class="cnt">
        		<div class="ipt-wrap">
        			<input type="text" class="ipt" data-rule="required" name="id{{idx}}" value="" autocomplete="off">
        		</div>
        	</div>
		</div>
		<div class="op"><button type="button" class="ubtn ubtn-red jdel">删除</button></div>
    </div>
</script>
<script src="assets/plugins/layer/layer.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        fn: {
            init: function() {
                this.bindEvent();
            },
            bindEvent: function() {
                var $table = $('.table'),
                        $myform = $('#myform'),
                        $rowList = $('.row-list'),
                        $count = $('.row-calc').find('em'),
                        model = $('#temp').html(),
                        idx = 1,
                        count = 0,
                        price = 0;

                $myform.validator({
                    valid: function (form) {
                        var data = $myform.serializeObject();

                        // 序列化属性值
                        var attr = new Array();
                        $('#myform .row-list').find('div.row').each(function(i) {
                            attr.push({"num":$(this).find('.ipt').eq(0).val(),"no":$(this).find('.ipt').eq(1).val()})
                        })

                        $.ajaxSetup({
                            contentType : 'application/json'
                        });

                        // 获取批次信息 和id 下单
                        $.post("/supplier/order/create?commodityId="+$("#myform #commodityId").val(),JSON.stringify(attr),function (result) {
                            if (result.status == 200) {
                                layer.closeAll();
                                window.location.reload();
                            }
                        }, "json");
                    }
                });

                // 关闭弹层
                $myform.on('click', '.ubtn-gray', function () {
                    layer.closeAll();
                    $rowList.find('.row:gt(0)').remove();
                })


                // 下单
                $table.on('click', '.jcreate', function() {
                    var data = [$(this).data("name"), $(this).data("spec"), $(this).data("price")+'元/'+ $(this).data("unit")];
                    price = $(this).data("price");
                    $myform.find('.val').each(function(i) {
                        $(this).html(data[i])
                    })
                    $myform[0].reset();
                    $("#myform #commodityId").val($(this).data("id"));
                    layer.open({
                        skin: 'layer-form',
                        area: ['600px'],
                        type: 1,
                        content: $myform,
                        title: '锁价下单'
                    });
                    count = 0;
                })

                // calc
                $rowList.on('blur', '.number', function() {
                    if (isNaN(this.value)) {
                        count += 0;
                    } else {
                        count += parseInt(this.value, 10);
                    }
                    $count.html(count * price);
                })

                // 添加行
                $('#jaddrow').on('click', function() {
                    idx++;
                    $rowList.append(model.replace(/{{idx}}/g, idx));
                })
                // 删除行
                $rowList.on('click', '.jdel', function() {
                    $(this).closest('.row').remove();
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