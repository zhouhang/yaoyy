<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>选货单-药优优</title>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">订单</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <!--  <div class="ui-notice ui-notice-extra">
         订单还没有商品，<br>去商品详情页面可以添加商品到订单！
         <a class="ubtn ubtn-primary" href='/'>返回首页</a>
     </div> -->
    <div class="pick-form">
        <form action="" id="pick_commodity">

        </form>
    </div>
</section><!-- /ui-content -->

<div class="ui-loading"></div>
<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script>

    var _global = {
        v: {
            commoditySearchUrl:"pickCommodity/getDetail",
            saveUrl:"pickCommodity/save"
        },
        fn: {
            init: function() {
                this.initCart();
            },
            initCart: function() {
                var self = this;
                var cartName = _YYY.localstorage.get(_YYY.CARTNAME);
                if(cartName){
                    var arr = eval(cartName),
                            commodityIds = [];
                    $.each(arr, function(i, item) {
                        commodityIds.push(item.commodityId);
                    })
                    if(commodityIds.length != 0){
                        $('.ui-loading').show();
                        $.ajax({
                            url: _global.v.commoditySearchUrl,
                            type: 'POST',
                            data: JSON.stringify(commodityIds),
                            contentType : 'application/json',
                            dataType: 'json',
                            success: function(data) {
                                if (data.data.length !== 0) {
                                    self.empty(false);
                                    self.tohtml(data.data, arr);
                                } else {
                                    // _YYY.localstorage.remove(_YYY.CARTNAME);
                                    self.empty(true);
                                }
                            },
                            complete: function() {
                                $('.ui-loading').hide();
                            }
                        })
                    } else {
                        self.empty(true);
                    }
                } else {
                    self.empty(true);
                }
            },
            empty: function(isEmpty) {
                $('.ui-notice').remove();
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 订单还没有商品，<br>去商品详情页面可以添加商品到订单！ \n <a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
                } else {
                    $('.ui-content').prepend('<div class="ui-notice"> \n 您的订单如下，“选货登记”后我们会在30分钟内与您取得联系如您需要寄养服务可以直接与我们电话沟通，我们为您提供免费的寄养服务。联系电话：0558-5897775 \n </div>');
                }
            },
            tohtml:function (data, arr) {
//                console.log(data)
                var self = this,
                        html = [],
                        $wrap = $("#pick_commodity");

                self.cbx = {}; // 保存各供应商的单选框的选中数量和总数

                $.each(data, function(i, item) {
                    html.push('<div class="group">');

                    html.push('<div class="company">');
                    html.push('<label><input type="checkbox" class="fa-cbx2 cbx" name="1" value="', item.supplierId, '">', item.supplierName, '</label>');
                    html.push('</div>');

                    self.cbx['c' + item.supplierId]  = [0, 0];
                    $.each(item.commodities, function(j, attr) {
                        self.cbx['c' + item.supplierId][1]++;
                        html.push('<div class="floor">');

                        html.push('<div class="mid op">');
                        html.push('<input type="checkbox" name="" data-id="',attr.id,'" value="', item.supplierId , '" class="fa-cbx2 cbx" />');
                        html.push('</div>');

                        html.push('<div class="hd">');
                        html.push('<em>' , attr.name , '</em>');
                        html.push('<span>' , attr.origin , ' ' , attr.spec , '</span>');
                        html.push('</div>');

                        html.push('<div class="price">');
                        html.push('<i>&yen;</i> <b>' , attr.price , '</b> 元/', attr.unitName);
                        html.push('</div>');

                        html.push('<div class="ui-quantity cale">');
                        html.push('<button type="button" class="fa fa-reduce op"></button>');
                        html.push('<input type="tel" class="ipt num-input" value="' , attr.minimumQuantity , '" data-min="' , attr.minimumQuantity , '" cid="' , attr.id , '" autocomplete="off">');
                        html.push('<button type="button" class="fa fa-plus op"></button>');
                        html.push('</div>');

                        html.push('<div class="del" cid="' , attr.id , '" key="', attr.supplierId, '">');
                        html.push('<button type="button" class="fa fa-remove"></button>');
                        html.push('</div>');

                        html.push('</div>');
                    })

                    html.push('</div>');

                })

                html.push('<div class="ft ui-form">');
                html.push('<button type="button" class="ubtn ubtn-primary" id="submit">下单</button>');
                html.push('</div>');
                html.push('</div>');
                $wrap.html(html.join(''));

                // 商品数量
                $.each(arr, function(i, item) {
                    var $ipt = $wrap.find('.ipt[cid="' + item.commodityId + '"]');
                    if ($ipt.length === 1) {
                        $ipt.val(Math.max(item.num, $ipt.data('min') || 1));
                        updateCommodity(item.commodityId, $ipt.val());
                    } else {
                        // deleteCommodity(item.commodityId);
                    }
                })
                this.submit();
                this.bindEvent();
            },
            submit: function() {
                var self = this;
                var isSubmit = false;


                $('#submit').on('click', function() {
                    if (isSubmit ) {
                        return false;
                    }
                    var list = [];
                    isSubmit = true;        // 阻止重复提交
                    $("#pick_commodity").find('.floor .cbx:checked').each(function(){

                        var $ipt = $("input[cid='"+$(this).data('id')+"']");
                        list.push({
                            commodityId: $ipt.attr('cid'),
                            num: $ipt.val()
                        });
                    })
                    $.post("/pickCommodity/save",{commoditys:JSON.stringify(list)},function(result){
                        if (result.status == 200) {
                            location.href = "/pickCommodity/apply";
                        }
                    })
                    // pickVo.pickCommodityVoList = list;
                })
            },
            bindEvent: function() {
                var self = this,
                        currId = 'empty', // 是否可选商品的id
                        $wrap = $('#pick_commodity');

                var showWarning = function() {
                    layer.open({
                        className: 'layer-custom'
                        ,content: '<div class="bd">每次只能选择一个供应商的货物登记，如果您需要多个供应商的货物请分两次提交</div>'
                        ,btn: ['确定']
                    })
                }


                // 全选 & 选择供应商
                $wrap.on('click', '.company .cbx', function() {
                    var $group = $(this).closest('.group'),
                            key     = 'c' + this.value,
                            cbx    = self.cbx;

                    if (currId !== this.value && currId !== 'empty') {
                        showWarning();
                        return false;
                    }
                    currId = this.checked ? this.value : 'empty';

                    cbx[key][0] = this.checked ? cbx[key][1] : 0;
                    $group.find('.cbx').prop('checked', this.checked);
                })
                $wrap.on('click', '.floor .cbx', function() {
                    var $group = $(this).closest('.group'),
                            key     = 'c' + this.value,
                            cbx    = self.cbx;

                    if (currId !== this.value && currId !== 'empty') {
                        showWarning();
                        return false;
                    }
                    cbx[key][0] +=  this.checked ? 1 : -1;
                    currId = cbx[key][0] != 0 ? this.value : 'empty';
                    $group.find('.company .cbx').prop('checked', cbx[key][0] != 0);
                })

                // 默认勾选第一个商品
                $wrap.find('.company').eq(0).find('.cbx').trigger('click');
                //删除
                $wrap.on('click', '.del', function() {
                    var $el = $(this).parent(),
                            id = this.getAttribute('cid'),
                            key = 'c' + this.getAttribute('key');

                    layer.open({
                        className: 'layer-custom'
                        ,content: '确定要删除吗？'
                        ,btn: ['确定', '取消']
                        ,yes: function(index) {
                            deleteCommodity(id);
                            if ($el.siblings().length === 1) {
                                currId = 'empty';
                                if ($el.parent().siblings().length === 1) {
                                    $wrap.empty();
                                    self.empty(true);
                                } else {
                                    $el.parent().remove();
                                }
                            } else {
                                $el.remove();
                            }
                            $el.find('.cbx:checked').length === 1 && self.cbx[key][0]--;
                            self.cbx[key][1]--;
                            layer.close(index);
                        }
                    });
                })

                // 数量加
                $wrap.on('click', '.fa-plus', function() {
                    var $ipt = $(this).prev(),
                            min = $ipt.data('min') || 1,
                            num = Math.max($ipt.val() || 1, min);
                    $ipt.val(++num);
                    updateCommodity($ipt.attr('cid'), num);
                })
                // 数量减
                $wrap.on('click', '.fa-reduce', function() {
                    var $ipt = $(this).next(),
                            min = $ipt.data('min') || 1,
                            num = Math.max($ipt.val() || 1, min);

                    num > min && $ipt.val(--num);
                    updateCommodity($ipt.attr('cid'), num);
                })
                // 输入数量
                $wrap.on('blur', '.num-input', function() {
                    var val = this.value,
                            min = $(this).data('min') || 1;

                    if (val) {
                        val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : min;
                        this.value = Math.max(val, min);
                    } else {
                        this.value = min;
                    }
                    updateCommodity($(this).attr('cid'), this.value);
                })

            }
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>