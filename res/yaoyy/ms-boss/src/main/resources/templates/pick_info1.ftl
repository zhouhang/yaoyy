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
                        <div class="val status-${pickVo.status+1}">${pickVo.statusText}</div>
                    </div>
                    <div class="item">
                        <div class="txt">下单时间：</div>
                        <div class="val">${(pickVo.createTime?datetime)!}</div>
                    </div>
                    <div class="item">
                        <div class="txt">采购单位：</div>
                        <div class="val">${userDetail.company!}</div>
                    </div>
                    <div class="item">
                        <div class="txt">采购人：</div>
                        <div class="val">${userDetail.name!}</div>
                    </div>
                    <div class="item">
                        <div class="txt">采购人手机号：</div>
                        <div class="val">${userDetail.phone!}</div>
                    </div>
                    <!--
                    <div class="item">
                        <div class="txt">地区：</div>
                        <div class="val">安徽亳州</div>
                    </div>
                    -->
                </div>

                <div class="box fa-form">
                    <div class="hd">商品详情</div>
                    <div class="item">
                        <div class="cnt table">
                            <div class="op">修改</div>
                            <table class="tc">
                                <thead>
                                <tr>
                                    <th>商品名称</th>
                                    <th>产地</th>
                                    <th width="200" class="tl">规格等级</th>
                                    <th width="80">数量</th>
                                    <th>价格</th>
                                    <th>供应商</th>
                                    <th width="80">供应商手机</th>
                                    <th>合计</th>
                                </tr>
                                </thead>
                                <tbody>
                               <#list pickVo.pickCommodityVoList as pickCommodityVo >
                                <tr>
                                    <td><a href="/commodity/detail/${pickCommodityVo.id}">${pickCommodityVo.name}</a></td>
                                    <td>${pickCommodityVo.origin}</td>
                                    <td class="tl"><p>${pickCommodityVo.spec}</p></td>
                                    <td><div class="ipt-wrap"><input type="text" class="ipt number" pc="${pickCommodityVo.id}" disabled  data-price="${pickCommodityVo.price?c}" value="${pickCommodityVo.num?c}"></div></td>
                                    <td>${pickCommodityVo.price}元/${pickCommodityVo.unit}</td>
                                    <td>${supplierDetail.name!}</td>
                                    <td>${supplierDetail.phone!}</td>
                                    <td><span>${pickCommodityVo.total?c}</span>元</td>
                                </tr>
                                </#list>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="8" class="tr"><span>合计：</span><em id="sum1">${pickVo.sum!}</em></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>

                <#if shippingAddressHistory??>
                    <div class="box fa-form fa-form-info">
                        <div class="hd">收货信息</div>
                        <div class="item">
                            <div class="txt">收货地址：</div>
                            <div class="val">${shippingAddressHistory.detail!}</div>
                        </div>
                        <div class="item">
                            <div class="txt">收货人：</div>
                            <div class="val">${shippingAddressHistory.consignee!}</div>
                        </div>
                        <div class="item">
                            <div class="txt">收货人手机号：</div>
                            <div class="val">${shippingAddressHistory.tel!}</div>
                        </div>
                        <div class="item">
                            <div class="txt">约定发货时间：</div>
                            <div class="val">${pickVo.deliveryDate!}</div>
                        </div>

                        <div class="item">
                            <div class="txt">货物要求：</div>
                            <div class="val">${pickVo.remark!}</div>
                        </div>
                    </div>
                </#if>


                <div class="box fa-form">
                    <div class="hd">订单追踪</div>
                    <ol class="trace" id="trace">
                        <li class="fore">状态：<em class="status-${pickVo.status+1}">${pickVo.statusText}</em></li>
                    <#list pickTrackingVos as tracking>
                        <li>
                            <span>${tracking.name?default('')}</span>
                            <span>${tracking.createTime?string("yyyy年MM月dd日 HH:mm")}</span>
                            <span>${tracking.recordTypeText}</span>
                            <span>${tracking.extra?default('')}</span>
                        </li>
                    </#list>
                    </ol>
                    <div class="ft <#if pickVo.status!=0>hide</#if>">
                        <button type="button" class="ubtn ubtn-blue submit1">同意受理</button>
                        <button type="button" class="ubtn ubtn-gray ml submit2">拒绝受理</button>
                    </div>
                    <form action=""  <#if pickVo.status==0||pickVo.status==2||pickVo.status=3||pickVo.status=3||pickVo.status=4> class="hide"</#if> id="traceForm">
                            <div class="ft">
                                <button type="button" class="ubtn ubtn-blue submit4">确认订单</button>
                                <button type="button" class="ubtn ubtn-gray ml submit5">取消订单</button>
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
                            <div class="txt">微信昵称：</div>
                            <div class="cnt">
                                <input type="text" name="nickname" value="${userDetail.nickname!}" class="ipt" placeholder="" autocomplete="off">
                            </div>
                        </div>
                        <div class="item">
                            <div class="txt">姓名：</div>
                            <div class="cnt">
                                <input type="text" name="name" value="${userDetail.name!}" class="ipt" placeholder="" autocomplete="off">
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
                                <input type="hidden"  value="${userDetail.area?default('')}"  name="area" id="area" class="ipt" placeholder="" autocomplete="off">
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
                            <div class="txt">单位：</div>
                            <div class="cnt">
                                <input type="text"  value="${userDetail.company!}" name="company" class="ipt" placeholder="单位" autocomplete="off">
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
</div>

<script type="temp" id="temp">
<div class="fa-form fa-form-info fa-form-layer">
 <form id="orderForm">
<input type="hidden"  class="ipt" value="${pickVo.id}" name="id">
    <div class="item">
        <div class="txt">商品总价：</div>
        <div class="cnt"><input type="text" class="ipt" id="sum2" name="sum" value="0" disabled></div>
    </div>
    <div class="item">
        <div class="txt">运费：</div>
        <div class="cnt"><input type="text" class="ipt price" name="shippingCosts" value="0"> <span class="unit">元</span></div>
    </div>
    <div class="item">
        <div class="txt">包装加工费：</div>
        <div class="cnt"><input type="text" class="ipt price" name="bagging" value="0"> <span class="unit">元</span></div>
    </div>
    <!--
    <div class="item">
        <div class="txt">检测费：</div>
        <div class="cnt"><input type="text" class="ipt price" name="checking" value="0"> <span class="unit">元</span></div>
    </div>
    -->
    <div class="item">
        <div class="txt">税款：</div>
        <div class="cnt"><input type="text" class="ipt price" name="taxation" value="0"> <span class="unit">元</span></div>
    </div>
    <div class="item">
        <div class="txt">总计：</div>
        <div class="cnt"><em class="c-red" id="sum3" name="amountsPayable">800</em></div>
    </div>
    <div class="item">
        <div class="txt">付款方式：</div>
        <div class="cnt cbxs">
            <label><input type="radio" name="settleType" class="cbx" value="0" checked>全款</label>
            <label><input type="radio" name="settleType" class="cbx" value="1">保证金</label>
            <label><input type="radio" name="settleType" class="cbx" value="2">赊账</label>
        </div>
    </div>
    <div class="group">
        <div class="item">
            <div class="txt">保证金金额：</div>
            <div class="cnt"><input type="text" class="ipt ipt-short deposit" name="deposit" id="deposit" value=""> <span class="unit">元</span></div>
        </div>
        <div class="item">
            <div class="txt">账期：</div>
            <div class="cnt"><input type="text" class="ipt ipt-short day" name="billTime" id="billTime"value="60"> <span class="unit">天</span></div>
        </div>
    </div>
    <div class="button">
        <button type="button" class="ubtn ubtn-blue">确认</button>
        <button type="button" class="ubtn ubtn-gray">关闭</button>
    </div>
     </form>
</div>
</script>

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
                trackingCreateUrl:'pick/trackingSave',
                updateCommodityNum:'pick/updateNum',
                createOrder:"pick/createOrder"
            },
            fn: {
                init: function() {
                    navLight('5-1');
                    this.tab();
                    this.modify();
                    this.bindEvent();
                    this.submitEvent();
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
                        $ipts = $('.table').find('.ipt');

                    $('.op').on('click', function() {
                        if (status === 'done') { // 修改
                            status = 'modify';
                            $(this).html('保存');
                            $ipts.prop('disabled', false);


                        } else {
                            status = 'done';
                            $(this).html('修改');
                            $ipts.prop('disabled', true);

                            // 发送数据到后台
                            var pickCommoditys=[];
                            $ipts.each(function(i) {
                                var pickCommodity={};
                                pickCommodity.id=$(this).attr("pc");
                                pickCommodity.num=this.value;
                                var price=$(this).data('price');
                                pickCommodity.total=pickCommodity.num * price;
                                pickCommoditys.push(pickCommodity);
                            })

                            $.ajax({
                                url: _global.v.updateCommodityNum,
                                data: JSON.stringify(pickCommoditys),
                                type: "POST",
                                contentType : 'application/json',
                                success: function(data){
                                    if (data.status == "200") {}
                                }
                            });
                        }
                    })
                },
                bindEvent: function() {
                    var self = this,
                        $ipts = $('.table').find('.ipt'),
                        $body = $('body');

                    this.unitPrice = [];

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
                       $.ajax({
                            url: _global.v.createOrder,
                            data: $("#orderForm").serialize()+"&sum="+sum+"&amountsPayable="+amountsPayable,
                            type: "POST",
                            success: function(data) {
                                window.location.reload();
                            }
                        })
                    })

                    // 关闭弹层
                    $body.on('click', '#calc .ubtn-gray', function() {
                        layer.closeAll();
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
                        sum += parseFloat(this.value==""?0:this.value);
                    })
                    $('#sum3').html(formatPrice(sum));
                    $('#deposit').val(sum*0.2);
                },
                // 提交事件
                submitEvent: function() {
                    var self = this,
                            $trace = $('#trace'),
                            $pa = $trace.parent(),
                            model = $('#temp').html();

                    // 同意受理
                    $pa.on('click', '.submit1', function() {
                        self.submit1();
                        return false;
                    })

                    // 拒绝受理
                    $pa.on('click', '.submit2', function(){
                        self.submit2();
                        return false;
                    })

                    // 交易完成
                    $pa.on('click', '.submit4', function() {
                        self.submit4(model);
                        return false;
                    })
                    // 交易未完成
                    $pa.on('click', '.submit5', function() {
                        self.submit5();
                        return false;
                    })
                },
                // 同意受理
                submit1: function() {

                    layer.confirm('确认受理？', {
                        btn: ['确认','取消'] //按钮
                    }, function(index){
                        layer.close(index);
                        $.ajax({
                            url: _global.v.trackingCreateUrl,
                            data: {pickId: ${pickVo.id},recordType:1},
                            type: "POST",
                            success: function(data) {
                                window.location.reload();

                            }
                        })
                    });

                },
                // 拒绝受理
                submit2: function() {
                    layer.prompt({
                        formType: 2,
                        title: '拒绝原因',
                        btn: ['拒绝', '关闭']
                    }, function(text, index) {
                        $.ajax({
                            url: _global.v.trackingCreateUrl,
                            data: {pickId: ${pickVo.id},recordType:2,extra:"理由："+text},
                            type: "POST",
                            success: function(data) {
                                window.location.reload();
                            }
                        })
                        layer.close(index);
                    });
                },
                // 确认订单
                submit4: function(model) {
                    var self = this;
                    layer.open({
                        id: 'calc',
                        skin: 'layer-form',
                        area: ['600px'],
                        type: 1,
                        content: model,
                        title: '报价清单'
                    });

                    $('#calc').height('auto');
                    this.total();
                },
                // 交易未完成
                submit5: function() {
                    layer.prompt({
                        formType: 2,
                        title: '取消原因',
                        btn: ['确认', '关闭']
                    }, function(text, index) {
                        $.ajax({
                            url: _global.v.trackingCreateUrl,
                            data: {pickId: ${pickVo.id},recordType:4,extra:"原因："+text},
                            type: "POST",
                            success: function(data) {
                                window.location.reload();
                            }
                        })
                        layer.close(index);
                    });
                }
            }
        }

        _global.fn.init();
    })();
</script>
</body>
</html>