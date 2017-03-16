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
            <div class="box fa-form fa-form-info">
                <div class="hd">收货信息</div>
               <#if shippingAddressHistory?exists>
                <div class="item">
                    <div class="txt">收货人：</div>
                    <div class="val">${shippingAddressHistory.consignee!}</div>
                </div>
                <div class="item">
                    <div class="txt">收货人电话：</div>
                    <div class="val">${shippingAddressHistory.tel!}</div>
                </div>
                <div class="item">
                    <div class="txt">收货地址：</div>
                    <div class="val">${shippingAddressHistory.detail!}</div>
                </div>
                   <#if orderInvoiceVo?exists>
                       <div class="item">
                           <div class="txt">发票：</div>
                           <div class="val">${orderInvoiceVo.name!} ${orderInvoiceVo.content!}</div>
                       </div>
                   </#if>
                   <div class="item">
                       <div class="txt">备注：</div>
                       <div class="val">${pickVo.remark!}</div>
                   </div>
               </#if>


            </div>
            <div class="box fa-form">
                <div class="hd">订单追踪</div>
                <ol class="trace" id="trace">
                <#list pickTrackingVos as tracking>
                    <li><span>${tracking.name?default('')}</span>&nbsp;&nbsp;<span>${tracking.createTime?string("yyyy年MM月dd日 HH:mm")}</span>&nbsp;&nbsp;<span>${tracking.recordTypeText}</span>&nbsp;&nbsp;<span>${tracking.extra?default('')}</span></li>
                </#list>
                </ol>
            </div>

            <div class="box fa-form">
                <div class="hd">商品详情</div>
                <div class="attr table">
                    <table>
                        <thead>
                        <tr>
                            <th>商品名称</th>
                            <th>产地</th>
                            <th width="200">规格等级</th>
                            <th>数量</th>
                            <th>单位</th>
                            <th>价格</th>
                            <th>合计</th>
                        </tr>
                        </thead>
                        <tbody>
                       <#list pickVo.pickCommodityVoList as pickCommodityVo >
                        <tr>
                            <td><a href="/commodity/detail/${pickCommodityVo.id}">${pickCommodityVo.name}</a></td>
                            <td>${pickCommodityVo.origin}</td>
                            <td><p>${pickCommodityVo.spec}</p></td>
                            <td>${pickCommodityVo.num}</td>
                            <td>${pickCommodityVo.unit}</td>
                            <td>${pickCommodityVo.price}元/${pickCommodityVo.unit}</td>
                            <td>${pickCommodityVo.total}元</td>
                        </tr>
                       </#list>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="7" class="total"><span>合计：</span><em>${pickVo.sum!}元</em></td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <div class="box fa-form fa-form-info">
                <div class="hd">结算详情</div>
                <div class="item">
                    <div class="txt">商品总价：</div>
                    <div class="val"><em>${pickVo.sum!}元</em></div>
                </div>
                <div class="item">
                    <div class="txt">运费：</div>
                    <div class="val"><em>${pickVo.shippingCosts!}元</em>
                    <#if pickVo.shippingCosts?exists&&pickVo.shippingCosts==0>
                        （免运费）
                    </#if>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">包装加工费：</div>
                    <div class="val"><em>${pickVo.bagging!}元</em>
                        <#if pickVo.bagging?exists&&pickVo.bagging==0>
                            （免包装加工费）
                        </#if>
                    </div>
                </div>
                <#--
                <div class="item">
                    <div class="txt">检测费：</div>
                    <div class="val"><em>${pickVo.checking!}元</em>
                    <#if pickVo.checking?exists&&pickVo.checking==0>
                        （免检测费）
                    </#if>
                    </div>
                </div>
                -->
                <div class="item">
                    <div class="txt">税费：</div>
                    <div class="val"><em>${pickVo.taxation!}元</em></div>
                </div>
                <div class="item f16">
                    <div class="txt">总计：</div>
                    <div class="val"><em>${pickVo.amountsPayable!}元</em></div>
                </div>
                <div class="hr"></div>
                <div class="item f16">
                    <div class="txt">结算类型：</div>
                    <div class="val">${pickVo.settleTypeName!}
                        <#if accountBillVo?exists>
                        <a href="/bill/detail/${accountBillVo.id?c}" class="c-blue">跳转到账单页
                        </#if>
                        </a>
                    </div>
                </div>
                <#if pickVo.settleType?exists&&pickVo.settleType==2>
                <div class="item">
                    <div class="txt">账期：</div>
                    <div class="val">${pickVo.billTime!}天</div>
                </div>
                <#elseif pickVo.settleType?exists&&pickVo.settleType==1>
                    <div class="item">
                        <div class="txt">账期：</div>
                        <div class="val">${pickVo.billTime!}天</div>
                    </div>
                    <div class="item">
                        <div class="txt">保证金金额：</div>
                        <div class="val"><em>${pickVo.deposit!}元</em></div>
                    </div>
                </#if>
                <#if payRecord?exists>
                    <div class="item">
                        <div class="txt">支付方式：</div>
                        <div class="val">${payRecord.payTypeText}</div>
                    </div>
                    <div class="item">
                        <div class="txt">支付时间：</div>
                        <div class="val">${payRecord.paymentTime?string("yyyy年MM月dd日 HH:mm")}</div>
                    </div>
                <#if payRecord.payType!=0>

                <div class="item">
                    <div class="txt">已付款：</div>
                    <div class="val"><em>${payRecord.actualPayment}</em></div>
                </div>
                <div class="item">
                    <div class="txt">欠款：</div>
                    <div class="val"><em>${pickVo.amountsPayable-payRecord.actualPayment}元</em></div>
                </div>

                <#else>

                    <div class="item">
                        <#if payRecord.payDocuments?exists>
                        <#list payRecord.payDocuments as payDocument>
                            <div class="txt">支付凭证：</div>
                            <div class="val thumb"><img width="160" height="80" src="${payDocument.path!}" alt=""></div>
                        </#list>
                        </#if>
                    </div>
                    <#if payRecord.status==0>
                    <div class="ft">
                        <button class="ubtn ubtn-blue" payReocrdId="${payRecord.id}"  id="configPay">确认收款</button>
                    </div>
                    </#if>
                </#if>

                </#if>
                <#if logisticalVo?exists>
                <div class="hr"></div>
                <div class="item f16">
                    <div class="txt">物流详情：</div>
                    <div class="val"></div>
                </div>
                <div class="item">
                    <div class="txt">发货日期：</div>
                    <div class="val">${logisticalVo.shipDate?string("yyyy年MM月dd日")}</div>
                </div>

                <div class="item">
                    <div class="txt">发货信息：</div>
                    <div class="val">${logisticalVo.content}</div>
                </div>
                <div class="item">
                    <div class="txt">发货单据：</div>
                    <div class="val thumb"><img width="160" height="80" src="${logisticalVo.pictureUrl!}" alt=""></div>
                </div>
                </#if>

                <div class="ft">
                    <#if pickVo.status==5&&!payRecord?exists>
                        <a href="pick/detail/${pickVo.id}?edit=update" class="ubtn ubtn-blue">修改订单</a>
                    </#if>

                    <#if pickVo.status==6>
                    <a href="javascript:;" class="ubtn ubtn-blue" id="submit2">确认发货</a>
                    </#if>

                </div>

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
</div>

<script src="assets/js/area.js"></script>
<form id="temp" class="hide">
    <input type="hidden"  class="ipt" value="${pickVo.id}" name="orderId">
    <div class="fa-form fa-form-layer">
        <div class="item">
            <div class="txt"><i>*</i>发货信息：</div>
            <div class="cnt cnt-mul"><textarea name="note" id="content" class="ipt ipt-mul" cols="30" rows="10"></textarea></div>
        </div>

        <div class="item">
            <div class="txt"><i>*</i>发货日期：</div>
            <div class="cnt"><div class="ipt-wrap"><input type="text" name="shipDate" class="ipt" value="" onclick="laydate()"></div></div>
        </div>
        <div class="item">
            <div class="txt">发货单据：</div>
            <div class="cnt cnt-mul">
                <span class="thumb up-img x1" id="imgCrop"></span>
                <input type="hidden" value="" name="pictureUrl" id="pictureUrl">
            </div>
        </div>

        <div class="button">
            <button type="submit" class="ubtn ubtn-blue">确认</button>
            <button type="button" class="ubtn ubtn-gray">关闭</button>
        </div>
    </div>
</form>

<script src="assets/js/croppic.min.js"></script>
<script src="assets/plugins/laydate/laydate.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        v: {
            userUpdateUrl:'sample/userComplete/',
            configPayUrl:'payRecord/config/',
            deliveryUrl:'pick/delivery/'
        },
        fn: {
            init: function() {
                navLight('5-1');
                this.tab();
                this.bindEvent();
                this.goodsImg();
                this.upImg();
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
        bindEvent: function() {
            var self = this;
            $trace = $('#trace'),
                    $pa = $trace.parent(),
                    $temp = $('#temp');

            $('#submit2').on('click', function() {
                layer.open({      
                    skin: 'layer-form',        
                    area: ['600px'],
                    type: 1,
                    content: $temp,
                    title: '物流清单'
                });
            })


            $('#configPay').on('click', function() {
                var self=$(this);
                layer.confirm('确认收款？', {
                    btn: ['确认','取消'] //按钮
                }, function(index){
                    layer.close(index);
                    $.ajax({
                        url: _global.v.configPayUrl,
                        data: {"payRecordId":self.attr("payReocrdId"),"orderId":${pickVo.id}},
                        type: "POST",
                        success: function(data) {
                            if (data.status == "200") {
                                window.location.reload();
                            }
                        }
                    })
                });

            })

            // 关闭弹层
            $temp.on('click', '.ubtn-gray', function () {
                layer.closeAll();
            })

            $temp.validator({
                fields: {
                    note: '发货信息: required',
                    shipDate: '发货日期: required'
                },
                valid: function (form) {
                    if ($(form).isValid()) {
                        $.ajax({
                            url: _global.v.deliveryUrl,
                            data: $("#temp").serialize() + "&content=" + $("#content").val(),
                            type: "POST",
                            success: function (data) {
                                if (data.status == "200") {
                                    window.location.reload();
                                }
                                ;
                            }

                        });
                    }
                }
           });
        },
        goodsImg: function() {
            var self = this,
                    $temp = $('#temp');

            // 删除图片
            $temp.on('click', '.del', function() {
                var $self = $(this);
                layer.confirm('确认删除图片？', {
                    btn: ['确认','取消'] //按钮
                }, function(index){
                    layer.close(index);
                    $('#imgCrop').empty();
                    $('#pictureUrl').val('');
                    self.upImg();
                });
                return false;
            })
        },
        upImg: function() {
            var self = this;
            var options = {
                uploadUrl:'/gen/upload',
                customUploadButtonId: 'imgCrop',
                loaderHtml:'<span class="loader">正在上传图片，请稍后...</span>',
                onAfterImgUpload: function(response){
                    self.cropModal && self.cropModal.destroy();
                    $('#imgCrop').show().html('<img src="' + response.url + '" /><i class="del" title="删除"></i>');
                    $('#pictureUrl').val(response.url).trigger('validate');
                }
            }

            self.cropModal && self.cropModal.destroy();
            self.cropModal = new Croppic('imgCropWrap', options);
        }
        }
    }

    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>