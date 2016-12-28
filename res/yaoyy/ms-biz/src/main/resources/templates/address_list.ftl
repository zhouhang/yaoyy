<!DOCTYPE html>
<html lang="en">
<head>
    <title>收货地址-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">收货地址</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="consignee">
        <#list addressList as addresss>
        <div class="item">
            <label>
                <input type="radio"   class="fa-cbx cbx mid" <#if addresss.isDefault==true>checked</#if> >
                <strong>${addresss.consignee}  ${addresss.tel}</strong>
                <span>${addresss.detail}</span>
                <a href="/address/detail/${addresss.id}"><i class="fa fa-edit mid"></i></a>
            </label>
        </div>
        </#list>

        <div class="item">
            <a href="/address/add" class="add"><i class="fa fa-add"></i> 新增收货地址</a>
        </div>
    </div>
</section><!-- /ui-content -->

<div class="ui-loading"></div>


<#include "./common/footer.ftl"/>
<script src="assets/js/layer.js"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.bindEvent();
            },
            bindEvent: function() {
                var self = this,
                        $wrap = $('#attention_commodity');

                //删除
                $wrap.on('click', '.fa-remove', function() {
                    var $this = $(this);
                    layer.open({
                        content: '确定要删除吗？',
                        btn: ['确定', '取消'],
                        yes: function(index) {
                            $this.closest('.item').remove();
                            layer.close(index);
                            if ($wrap.find('.item').length === 0) {
                                $wrap.empty();
                                self.empty(true);
                            }
                        }
                    });
                })
            },
            empty: function(isEmpty) {
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 您还没有关注商品！ \n <a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
                } else {
                    $('.ui-notice').remove();
                }
            },
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>