<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的关注-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body body-gray">
<header class="ui-header">
    <div class="title">我的关注</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->
<section class="ui-content">
    <!--  <div class="ui-notice ui-notice-extra">
         您还没有关注商品！
         <a class="ubtn ubtn-primary" href='/'>返回首页</a>
     </div> -->
    <div class="pick-form">
        <form action="" id="attention_commodity">
        <#list list as follow>
            <div class="floor">
                <div class="hd">
                    <a href="/commodity/detail/${follow.commodityId}">
                    <em>${follow.name}</em>
                    <span>${follow.title}</span>
                    </a>
                </div>
                <div class="price">
                    <i>&yen;</i> <b>${follow.currentPrice}</b> 元
                </div>
                <#if follow.difference gt 0>
                    <div class="trend up">
                        <span>比关注时涨价${follow.difference}元</span>
                        <i class="fa fa-up"></i>
                    </div>
                <#elseif follow.difference lt 0>
                    <div class="trend down">
                        <span>比关注时降价${-follow.difference}元</span>
                        <i class="fa fa-down"></i>
                    </div>
                </#if>
                <div class="del" cid="${follow.id}">
                    <button type="button" class="fa fa-remove"></button>
                </div>
            </div>
        </#list>
        </form>
    </div>
</section><!-- /ui-content -->

<div class="ui-loading"></div>

<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.bindEvent();

            },
            bindEvent: function() {
                var self = this,
                    $wrap = $('#attention_commodity');

                if ($wrap.find('.item').length === 0) {
                    $wrap.empty();
                    self.empty(true);
                }

                //删除
                $wrap.on('click', '.del', function() {
                    var $this = $(this);
                        id = this.getAttribute('cid');
                        
                    layer.open({
                        className: 'layer-custom',
                        content: '确定要删除吗？',
                        btn: ['确定', '取消'],
                        yes: function(index) {
                            $.post("/follow/unwatch",{id:id}, function(result){
                                if (result.status == 200){
                                    $this.closest('.floor').remove();
                                    layer.close(index);
                                    if ($wrap.find('.floor').length === 0) {
                                        $wrap.empty();
                                        self.empty(true);
                                    }
                                }
                            })
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