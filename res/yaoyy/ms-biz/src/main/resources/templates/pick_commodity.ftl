<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>选货单-药优优</title>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">选货单</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
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
            commoditySearchUrl:"commodity/getDetail",
            saveUrl:"pickCommodity/save",
        },
        fn: {
            init: function() {
                this.initCart();
            },
            initCart:function(){
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
                            data: JSON.stringify(commodityIds),
                            type: "POST",
                            contentType : 'application/json',
                            success: function(data) {
                                $('.ui-loading').hide();
                                if (data.data.length !== 0) {
                                    self.empty(false);
                                    self.tohtml(data.data, arr);
                                } else {
                                    _YYY.localstorage.remove(_YYY.CARTNAME);
                                    self.empty(true);
                                }
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
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 选货单还没有商品，<br>去商品详情页面可以添加商品到选货单！ \n <a class="ubtn ubtn-primary" href="javascript:history.back();">返回上一页</a> \n </div>');
                } else {
                    $('.ui-content').prepend('<div class="ui-notice"> \n 您的选货单如下，“选货登记”后我们会在5分钟内与您取得联系如您需要寄样服务可以直接与我们电话沟通，我们为您提供寄样服务。联系电话：0558-5120088 \n </div>');
                }
            },
            tohtml:function (data, arr) {
                var html = [],
                    $wrap = $("#pick_commodity");
                $.each(data, function(i, item) {
                    html.push('<div class="floor">');

                    html.push('<div class="hd">');
                    html.push('<em>' , item.name , '</em>');
                    html.push('<span>' , item.origin , ' ' , item.spec , '</span>');
                    html.push('</div>');

                    html.push('<div class="price">');
                    html.push('<i>&yen;</i> <b>' , item.price , '</b> 元/', item.unitName);
                    html.push('</div>');

                    html.push('<div class="ui-quantity cale">');
                    html.push('<button type="button" class="fa fa-reduce op"></button>');
                    html.push('<input type="tel" class="ipt num-input" value="' , item.minimumQuantity , '" data-min="' , item.minimumQuantity , '" cid="' , item.id , '" data-unitname="' , item.unitName , '" autocomplete="off">');
                    html.push('<button type="button" class="fa fa-plus op"></button>');
                    html.push('</div>');

                    html.push('<div class="del" cid="' , item.id , '">');
                    html.push('<button type="button" class="fa fa-remove"></button>');
                    html.push('</div>');

                    html.push('</div>');
                })

                html.push('<div class="ft">');
                html.push('<input type="text" class="text" id="username" placeholder="姓名">');
                html.push('<input type="tel" class="text" id="mobile" placeholder="手机号">');
                html.push('<button type="button" class="ubtn ubtn-primary" id="submit">选货登记</button>');
                html.push('</div>');
                $wrap.html(html.join(''));

                // 商品数量
                $.each(arr, function(i, item) {
                    var $ipt = $wrap.find('.ipt[cid="' + item.commodityId + '"]');
                        if ($ipt.length === 1) {
                            $ipt.val(Math.max(item.num, $ipt.data('min') || 1));
                            updateCommodity(item.commodityId, $ipt.val());
                        } else {
                            deleteCommodity(item.commodityId);
                        }
                })
                this.submit();
                this.bindEvent();
            },
            submit: function() {
                var self = this,
                    isSubmit = false,
                    userinfo = getAppyInfo();

                if(userinfo){
                    $('#username').val(userinfo.nickname);
                    $('#mobile').val(userinfo.phone);
                }
                else{
                    $('#mobile').val(${phone!});
                }

                $('#submit').on('click', function() {
                    if (isSubmit || !self.checkName() || !self.checkMobile()) {
                        return false;
                    }
                    var list = [];
                    var pickVo = {
                        nickname: $('#username').val(),
                        phone: $('#mobile').val()
                    }
                    saveAppyinfo(pickVo);   // 保存联系人信息
                    isSubmit = true;        // 阻止重复提交
                    $("#pick_commodity").find('.ipt').each(function(){
                        list.push({
                            commodityId: $(this).attr('cid'),
                            num: this.value
                        });
                    })
                    pickVo.pickCommodityVoList = list;

                    $.ajax({
                        url: _global.v.saveUrl,
                        data: JSON.stringify(pickVo),
                        type: "POST",
                        contentType : 'application/json',
                        success: function(result) {
                            if(result.status=="200"){
                                //清空选货单
                                _YYY.localstorage.remove(_YYY.CARTNAME);
                                layer.open({
                                    className: 'layer-custom',
                                    content: '<div class="box"><div class="hd">您的选货单已提交成功！</div><div class="bd">我们会在5分钟之内与您取得联系。登录可以跟踪您的所有选货单申请。</div></div>'
                                    ,btn: ['历史选货单', '返回']
                                    ,yes: function(index){
                                        location.href = '/pick/list' + (_YYY.is_winxin ? '?source=WECHAT' : '');
                                    },no: function(index) {
                                        window.history.back(); // 返回按钮事件
                                    },shadeClose: false
                                });
                            } else {
                                isSubmit = false;
                            }
                        },
                        error: function() {
                            popover('网络错误，请刷新页面重试');
                            setTimeout(function() {
                                window.location.reload();
                            }, 1e3);
                        }
                    })
                })
            },
            bindEvent: function() {
                var self = this,
                    $wrap = $('#pick_commodity');

                //删除
                $wrap.on('click', '.fa-remove', function() {
                    var $this = $(this);
                    layer.open({
                        className: 'layer-custom',
                        content: '确定要删除吗？',
                        btn: ['确定', '取消'],
                        yes: function(index) {
                            deleteCommodity($this.attr('cid'));
                            $this.closest('.item').remove();
                            layer.close(index);
                            if ($wrap.find('.item').length === 0) {
                                $wrap.empty();
                                self.empty(true);
                                // window.location.reload();
                            }
                        }
                    });
                })

                // 数量加
                $wrap.on('click', '.fa-plus', function() {
                    var $ipt = $(this).prev(),
                        min = $ipt.data('min') || 1,
                        num = Math.max($ipt.val() || 1, min);
                    num  = Number(num) + min;
                    $ipt.val(num);
                    updateCommodity($ipt.attr('cid'), num);
                })
                // 数量减
                $wrap.on('click', '.fa-reduce', function() {
                    var $ipt = $(this).next(),
                        min = $ipt.data('min') || 1,
                        num = Math.max($ipt.val() || 1, min);
                    num = Number(num);
                    if (num > min) {
                        if ((num-min) >= min ) {
                            num = num - min;
                        } else {
                            num = min;
                        }
                        $ipt.val(num);
                        updateCommodity($ipt.attr('cid'), num);
                    } else {
                        popover('最低' + min + $ipt.data('unitname') + '起购！');
                    }
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
            },
            checkName: function() {
                var $el = $('#username'),
                    val = $el.val();
                if (!val) {
                    popover('请输入姓名');
                    return false;
                }
                return true;
            },
            checkMobile: function() {
                var $el = $('#mobile'),
                    val = $el.val();
                if (!val) {
                    popover('请输入手机号码！');
                } else if (!_YYY.verify.isMobile(val)) {
                    popover('请输入有效的手机号！');
                } else {
                    return true;
                }
                return false;
            }
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>