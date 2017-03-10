<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>订单详情-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>

<div class="content">
    <div class="breadcrumb">
        <ul>
            <li>订单模块</li>
            <li>订单列表</li>
        </ul>
    </div>

    <div class="fa-tab">
        <span class="on">订单信息</span>
        <span>客户信息</span>
    </div>

    <div class="fa-tab-cont">
        <div class="items">
            <div class="box fa-form fa-form-info">
                <div class="hd">基本信息</div>
                <div class="item">
                    <div class="txt">订单编号：</div>
                    <div class="val">${pickVo.code}</div>
                </div>
                <div class="item">
                    <div class="txt">状态：</div>
                    <div class="val c-red">${pickVo.statusText}</div>
                </div>
                <div class="item">
                    <div class="txt">客户姓名：</div>
                    <div class="val">${pickVo.nickname}</div>
                </div>
                <div class="item">
                    <div class="txt">手机号：</div>
                    <div class="val">${pickVo.phone}</div>
                </div>
                <!--
                <div class="item">
                    <div class="txt">地区：</div>
                    <div class="val">安徽亳州</div>
                </div>
                -->
                <div class="item">
                    <div class="txt">申请时间：</div>
                    <div class="val">${(pickVo.createTime?datetime)!}</div>
                </div>
            </div>

            <div class="box fa-form">
                <div class="hd">商品详情</div>
                <div class="attr table">
                    <div class="op"></div>
                    <table>
                        <thead>
                        <tr>
                            <th>商品名称</th>
                            <th>产地</th>
                            <th width="200">规格等级</th>
                            <th width="80">数量</th>
                            <th>单位</th>
                            <th>价格</th>
                            <th>合计</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list pickVo.pickCommodityVoList as pickCommodityVo >
                            <tr>
                                <td><a href="#">${pickCommodityVo.name}</a></td>
                                <td>${pickCommodityVo.origin}</td>
                                <td><p>${pickCommodityVo.spec}</p></td>
                                <td><input type="text" class="ipt number" pc="${pickCommodityVo.id}"  data-price="${pickCommodityVo.price}" value="${pickCommodityVo.num?c}"></td>
                                <td>${pickCommodityVo.unit}</td>
                                <td>${pickCommodityVo.price}元/${pickCommodityVo.unit}</td>
                                <td><span>${pickCommodityVo.total}</span>元</td>
                            </tr>
                        </#list>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="7" class="total"><span>合计：</span><em id="sum1">${pickVo.sum!}</em></td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <div class="box fa-form" id="calc">
                <form id="orderForm">
                    <input type="hidden"  class="ipt" value="${pickVo.id}" name="id">
                <div class="hd">报价清单</div>
                <div class="item">
                    <div class="txt">商品总价：</div>
                    <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt" id="sum2"  name="sum" value="${pickVo.sum!}" disabled><span class="unit">元</span></div></div>
                </div>
                <div class="item">
                    <div class="txt">运费：</div>
                    <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt price" name="shippingCosts" value="${pickVo.shippingCosts!}"><span class="unit">元</span></div></div>
                </div>
                <div class="item">
                    <div class="txt">包装加工费：</div>
                    <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt price" name="bagging" value="${pickVo.bagging!}"><span class="unit">元</span></div></div>
                </div>
                    <#--
                <div class="item">
                    <div class="txt">检测费：</div>
                    <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt price" name="checking" value="${pickVo.checking!}"><span class="unit">元</span></div></div>
                </div>
                   -->
                <div class="item">
                    <div class="txt">税款：</div>
                    <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt price" name="taxation" value="${pickVo.taxation!}"><span class="unit">元</span></div></div>
                </div>
                <div class="item">
                    <div class="txt">总计：</div>
                    <div class="cnt"><em class="c-red" id="sum3"  name="amountsPayable">800</em></div>
                </div>
                <div class="item">
                    <div class="txt">付款方式：</div>
                    <div class="cnt cbxs2">
                        <label><input type="radio" name="settleType" class="cbx" value="0" <#if pickVo.settleType==0>checked</#if>>全款</label>
                        <label><input type="radio" name="settleType" class="cbx" value="1" <#if pickVo.settleType==1>checked</#if>>保证金</label>
                        <label><input type="radio" name="settleType" class="cbx" value="2" <#if pickVo.settleType==2>checked</#if>>赊账</label>
                    </div>
                </div>
                <div class="group">
                    <div class="item">
                        <div class="txt">保证金金额：</div>
                        <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt ipt-short deposit"name="deposit" id="deposit" value="${pickVo.deposit?c}"<span class="unit">元</span></div></div>
                    </div>
                    <div class="item">
                        <div class="txt">账期：</div>
                        <div class="cnt"><div class="ipt-wrap"><input type="text" class="ipt ipt-short day" name="billTime" id="billTime" value="${pickVo.billTime!}"><span class="unit">天</span></div></div>
                    </div>
                </div>
                <div class="ft">
                    <button type="button" class="ubtn ubtn-blue">提交订单</button>
                </div>
                    </form>
            </div>
        </div>
        <div class="items">
            <div class="box fa-form">
                <div class="hd">客户信息</div>
                <form id="userForm">
                    <input type="hidden"  class="ipt" value="${userDetail.id!}" name="id">
                    <div class="item">
                        <div class="txt">个人称呼：</div>
                        <div class="cnt">
                            <input type="text" name="nickname" value="${userDetail.nickname!}" class="ipt" placeholder="" autocomplete="off">
                        </div>
                    </div>
                    <div class="item">
                        <div class="txt">联系电话：</div>
                        <div class="cnt">
                            <input type="text"value="${userDetail.phone!}" name="phone"  class="ipt" placeholder="" autocomplete="off">
                        </div>
                    </div>
                    <div class="item">
                        <div class="txt">地区：</div>
                        <div class="cnt" id="pickArea">
                            <input type="text" style="display: none"  value="${userDetail.area?default('')}"  name="area" id="area" class="ipt" placeholder="" autocomplete="off">
                        </div>
                    </div>
                    <div class="item">
                        <div class="txt">身份类型：</div>
                        <div class="cnt cbxs">
                            <label><input type="radio" name="type" class="cbx" value="1" <#if userDetail.type?exists && userDetail.type==1> checked</#if> >饮片厂</label>
                            <label><input type="radio" name="type" class="cbx" value="2" <#if userDetail.type?exists && userDetail.type==2> checked</#if>>药厂</label>
                            <label><input type="radio" name="type" class="cbx" value="3" <#if userDetail.type?exists && userDetail.type==3> checked</#if>>药材经营公司</label>
                            <label><input type="radio" name="type" class="cbx" value="4" <#if userDetail.type?exists && userDetail.type==4> checked</#if>>个体经营户</label>
                            <label><input type="radio" name="type" class="cbx" value="5" <#if userDetail.type?exists && userDetail.type==5> checked</#if>>合作社</label>
                            <label><input type="radio" name="type" class="cbx" value="6" <#if userDetail.type?exists && userDetail.type==6> checked</#if>>种植基地</label>
                            <label><input type="radio" name="type" class="cbx" value="7" <#if userDetail.type?exists && userDetail.type==7> checked</#if>>其他</label>
                            <label><input type="radio" name="type" class="cbx" value="8" <#if userDetail.type?exists && userDetail.type==8> checked</#if>>个人经营</label>
                            <label><input type="radio" name="type" class="cbx" value="9" <#if userDetail.type?exists && userDetail.type==9> checked</#if>>采购经理</label>
                            <label><input type="radio" name="type" class="cbx" value="10" <#if userDetail.type?exists && userDetail.type==10> checked</#if>>销售经理</label>
                        </div>
                    </div>
                    <div class="item">
                        <div class="txt">姓名/单位：</div>
                        <div class="cnt">
                            <input type="text"  value="${userDetail.name!}" name="name" class="ipt" placeholder="姓名/单位" autocomplete="off">
                        </div>
                    </div>
                    <div class="item">
                        <div class="txt">用户备注：</div>
                        <div class="cnt">
                            <textarea name="" id="userRemark" class="ipt ipt-mul">${userDetail.remark!}</textarea>
                        </div>
                    </div>
                    <div class="ft">
                        <button type="button" id="saveUser" class="ubtn ubtn-blue">保存客户信息</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<#include "./common/footer.ftl"/>

<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script src="assets/js/area.js"></script>
<script>
    !(function() {
        var formatPrice = function(val) {
            return val.toFixed(2);
        }

        var _global = {
            v: {
                userUpdateUrl:'sample/userComplete/',
                createOrder:"pick/updateOrder"
            },
            fn: {
                init: function() {
                    this.tab();
                    this.modify();
                    this.bindEvent();
                    this.total();
                    $('#pickArea').citys({areaId:'area'});
                },
                tab: function() {
                    var $items = $('.fa-tab-cont').find('.items'),
                            $wrapper = $('.wrapper');

                    $('.fa-tab').on('click', 'span', function() {
                        var k = $(this).index();
                        $(this).addClass('on').siblings().removeClass('on');
                        $items.hide().eq(k).show();
                        $wrapper.css('min-height', 'auto');
                        _fix();
                    })
                },
                // 修改商品数量
                modify: function() {
                    var status = 'done',
                            $ipts = $('.attr').find('.ipt');
                    //$ipts.prop('disabled', false);

                },
                bindEvent: function() {
                    var self = this,
                            $ipts = $('.attr').find('.ipt'),
                            $body = $('body');

                    this.unitPrice = [];
                    var settleType=${pickVo.settleType};
                    if (settleType == 0) {
                        $('#calc').find('.group').hide();
                    } else if (settleType == 1) {
                        $('#calc').find('.group').show().find('.item').show();
                    } else {
                        $('#calc').find('.group').show().find('.item').hide().eq(1).show();
                    }

                    $ipts.each(function(i) {
                        var $sum = $(this).closest('tr').find('span'),
                                myprice = $(this).data('price');

                        // 保存初始值
                        self.unitPrice.push({
                            sum: this.value * myprice
                        })

                        // 小计
                        $sum.html(formatPrice(this.value * myprice));

                        // 修改数量
                        $(this).on('blur', function() {
                            var amount = this.value,
                                    sum = 0;
                            if (amount) {
                                amount = (!isNaN(amount = parseInt(amount, 10)) && amount) > 0 ? amount : 1;
                            } else {
                                amount = 1;
                            }
                            sum = formatPrice(amount * myprice);
                            $sum.html(sum);
                            this.value = amount;
                            self.unitPrice[i].sum = sum;
                            self.total();
                        })
                    })

                    $body.on('focus', '.ipt', function() {
                        $(this).select();
                    })

                    // 各种费用
                    $body.on('keyup', '.price', function() {
                        var val = this.value;
                        if (!/^\d+\.?\d*$/.test(val)) {
                            val = Math.abs(parseFloat(val));
                            this.value = isNaN(val) ? '' : val;
                        }
                    })
                            .on('blur', '.price', function() {
                                if (!this.value) {
                                    this.value = 0;
                                }
                                self.total2();
                            })

                    // 保证金
                    $body.on('keyup', '.deposit', function() {
                        var val = this.value;
                        if (!/^\d+\.?\d*$/.test(val)) {
                            val = Math.abs(parseFloat(val));
                            this.value = isNaN(val) ? '' : val;
                        }
                    })

                    // 账期
                    $body.on('keyup', '.day', function() {
                        var val = this.value;
                        if (val) {
                            val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : 1;
                            this.value = Math.max(val, 1);
                        }
                    })

                    // 付款方式
                    $body.on('click', '.cbx', function() {
                        if (this.value == 0) {
                            $('#calc').find('.group').hide();
                        } else if (this.value == 1) {
                            $('#calc').find('.group').show().find('.item').show();
                        } else {
                            $('#calc').find('.group').show().find('.item').hide().eq(1).show();
                        }
                    })

                    // 确定
                    $body.on('click', '#calc .ubtn-blue', function() {
                        layer.confirm('确认提交订单？', {
                            btn: ['确认','取消'] //按钮
                        }, function(index){
                            layer.close(index);
                            var sum=$("#sum2").val();
                            var amountsPayable=$("#sum3").text();
                            var billTime=$("#billTime").val();
                            var deposit=$("#deposit").val();
                            var settleType=$(".cbx[name='settleType']:checked").val();
                            if(parseInt(billTime)<7){
                                $.notify({
                                    type: 'error',
                                    title: '账期不得少于七天'
                                });
                                return;
                            }
                            if(settleType=='1'&&parseFloat(deposit)<=0){
                                $.notify({
                                    type: 'error',
                                    title: '保证金不能为0'
                                });
                                return;
                            }
                            var pickCommoditys=[];
                            $ipts.each(function(i) {
                                var pickCommodity={};
                                pickCommodity.id=$(this).attr("pc");
                                pickCommodity.num=this.value;
                                var price=$(this).data('price');
                                pickCommodity.total=pickCommodity.num * price;
                                pickCommoditys.push(pickCommodity);
                            })
                            var pick=$("#orderForm").serializeObject();
                            pick.sum=sum;
                            pick.amountsPayable=amountsPayable;
                            pick.pickCommodityVoList=pickCommoditys;
                            $.ajax({
                                url: _global.v.createOrder,
                                data: JSON.stringify(pick),
                                type: "POST",
                                contentType : 'application/json',
                                success: function(data) {
                                    window.location.href = '/pick/detail/'+${pickVo.id};
                                }
                            })
                        });
                    })
                    $("#saveUser").on('click', function() {
                        var url = _global.v.userUpdateUrl;
                        $.ajax({
                            url: url,
                            data: $("#userForm").serialize()+"&remark="+$("#userRemark").val(),
                            type: "POST",
                            success: function(data){
                                if (data.status == "200") {
                                    $.notify({
                                        type: 'success',
                                        title: '保存成功'
                                    });
                                }

                            }
                        });
                    });
                    // 关闭弹层
                    // $body.on('click', '#calc .ubtn-gray', function() {
                    //     layer.closeAll();
                    // })
                },
                // 统计商品价格
                total: function() {
                    var sum = 0;
                    $.each(this.unitPrice, function(i, item) {
                        sum += parseFloat(item.sum);
                    })
                    this.sum = sum;
                    sum = formatPrice(sum);
                    $('#sum1').html(sum);
                    $('#sum2').val(sum);
                    this.total2();
                },
                // 统计各种费用后的价格
                total2: function() {
                    var sum = this.sum;
                    $('#calc').find('.price').each(function() {
                        sum += parseFloat(this.value);
                    })
                    $('#sum3').html(formatPrice(sum));
                }
            }
        }

        _global.fn.init();
    })();
</script>
</body>
</html>