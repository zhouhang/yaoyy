<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>账单详情-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>账单管理</li>
                <li>账单详情</li>
            </ul>
        </div>

        <div class="box fa-form fa-form-info">
            <div class="hd">基本信息</div>
            <div class="item">
                <div class="txt">账单编号：</div>
                <div class="val">${billVo.code!}</div>
            </div>
            <div class="item">
                <div class="txt">订单编号：</div>
                <div class="val"><a href="/pick/detail/${billVo.orderId}" class="link">${billVo.orderCode!}</a></div>
            </div>
            <div class="item">
                <div class="txt">客户姓名：</div>
                <div class="val">${userDetail.name?default(userDetail.nickname)!}</div>
            </div>
            <div class="item">
                <div class="txt">客户电话：</div>
                <div class="val">${userDetail.phone!}</div>
            </div>
            <div class="item">
                <div class="txt">单位：</div>
                <div class="val">${userDetail.company?default(userDetail.name)!}</div>
            </div>
            <div class="item">
                <div class="txt">地区：</div>
                <div class="val">${userDetail.area!}</div>
            </div>
            <div class="item">
                <div class="txt">身份类型：</div>
                <div class="val">${billVo.userTypeName!}</div>
            </div>
        </div>

        <div class="box fa-form">
            <div class="hd">商品信息</div>
            <div class="item">
                <div class="cnt table">
                    <table class="tc">
                        <thead>
                        <tr>
                            <th>商品名称</th>
                            <th>产地</th>
                            <th width="200" class="tl">规格等级</th>
                            <th width="80">数量</th>
                            <th>单位</th>
                            <th>价格</th>
                            <th>合计</th>
                        </tr>
                        </thead>
                        <tbody>
                       <#list billVo.pickVo.pickCommodityVoList as pickCommodityVo >
                       <tr>
                           <td><a href="#">${pickCommodityVo.name}</a></td>
                           <td>${pickCommodityVo.origin}</td>
                           <td class="tl"><p>${pickCommodityVo.spec}</p></td>
                           <td>${pickCommodityVo.num}</td>
                           <td>${pickCommodityVo.unit}</td>
                           <td>${pickCommodityVo.price}元/${pickCommodityVo.unit}</td>
                           <td><span>${pickCommodityVo.total}</span>元</td>
                       </tr>
                       </#list>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="7" class="tr"><span>合计：</span><em class="c-red">${billVo.pickVo.sum!}元</em></td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <div class="box fa-form fa-form-info">
            <div class="hd">账单信息</div>
            <div class="item">
                <div class="txt">申请时间：</div>
                <div class="val">${(billVo.createDate?datetime)!}</div>
            </div>
            <div class="item">
                <div class="txt">操作人：</div>
                <div class="val">${billVo.operateName!}</div>
            </div>
            <div class="item">
                <div class="txt">状态：</div>
                <div class="val">
                <#if billVo.status==0>
                    <span class="c-red">未结清</span>
                <#else>
                    已结清
                </#if>
                </div>
            </div>
            <div class="item">
                <div class="txt">商品总价：</div>
                <div class="val"><em>${billVo.pickVo.sum}元</em></div>
            </div>
            <div class="item">
                <div class="txt">运费：</div>
                <div class="val"><em>${billVo.pickVo.shippingCosts!}元</em></div>
            </div>
            <div class="item">
                <div class="txt">包装加工费：</div>
                <div class="val"><em>${billVo.pickVo.bagging!}元</em></div>
            </div>
            <#--
            <div class="item">
                <div class="txt">检测费：</div>
                <div class="val"><em>${billVo.pickVo.checking!}元</em></div>
            </div>
            -->
            <div class="item">
                <div class="txt">税款：</div>
                <div class="val"><em>${billVo.pickVo.taxation!}元</em></div>
            </div>
            <div class="item f16">
                <div class="txt">总计：</div>
                <div class="val"><em>${billVo.pickVo.amountsPayable!}元</em></div>
            </div>
            <div class="hr"></div>
            <div class="item f16">
                <div class="txt">账单类型：</div>
                <div class="val">${billVo.pickVo.settleTypeName!}</div>
            </div>
            <div class="item">
                <div class="txt">账期：</div>
                <div class="val">${billVo.pickVo.billTime!}天</div>
            </div>
           <#if billVo.pickVo.settleType==1>

               <div class="item">
                   <div class="txt">保证金金额：</div>
                   <div class="val"><em>${billVo.pickVo.deposit!}元</em></div>
               </div>
           </#if>
            <div class="item">
                <div class="txt">已付款：</div>
                <div class="val"><em>${billVo.alreadyPayable!}元</em></div>
            </div>
            <div class="item">
                <div class="txt">欠款：</div>
                <div class="val"><em>${billVo.amountsPayable-billVo.alreadyPayable}元</em></div>
            </div>
            <div class="item f16">
                <div class="txt">剩余帐期：</div>
                <div class="val"><em>${billVo.timeLeft!}</em></div>
            </div>
        </div>

        <#if payRecord?exists>
        <div class="box fa-form fa-form-info">
            <div class="hd">付款信息</div>
            <div class="item">
                <div class="txt">支付方式：</div>
                <div class="val">${payRecord.payTypeText!}</div>
            </div>
            <#if payRecord.payType==0>
            <div class="item">
                <div class="txt">支付凭证：</div>
               <#list payRecord.payDocuments as payDocument>
                <div class="val thumb">
                    <img src="${payDocument.path}" alt="" width="160" height="80">
                </div>
                </#list>
            </div>
            </#if>
            <div class="item">
                <div class="txt">支付时间：</div>
                <div class="val">${payRecord.paymentTime?string("yyyy年MM月dd日 HH:mm")}</div>
            </div>
            <#if payRecord.status==0>
            <div class="ft">
                <button type="button" class="ubtn ubtn-blue" id="configPay" data-payId="${payRecord.id}">确认收款</button>
            </div>
            </#if>
        </div>
        </#if>

    </div>

    <#include "./common/footer.ftl"/>
</div>

<script>
!(function($, window) {
    var _global = {
        configUrl: '/bill/configPay',
        init: function() {
            navLight('9-2');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $configPay = $('#configPay'),
                payId = $configPay.data('payId');

            $configPay.on('click',function () {
                layer.confirm('确认收款？', {
                    btn: ['确认','取消'] //按钮
                }, function(index){
                    layer.close(index);
                    $.ajax({
                        url: that.configUrl,
                        data: {'payRecordId': payId},
                        type: 'POST',
                        success: function(data) {
                            if (data.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '操作成功',
                                    callback: function() {
                                        window.location.reload();
                                    }
                                });
                            }
                        }
                    })
                });
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>