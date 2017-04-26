<!DOCTYPE html>
<html lang="en">
<head>
<title>收货地址-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body2 body-bg">
<header class="ui-header">
    <div class="title">收货地址</div>
    <div class="abs-l mid">
        <a href="/center/index" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="consignee" id="attention_commodity">
        <#list addressList as addresss>
        <div class="item">
            <label>
                <#if addresss.isDefault==true><input type="radio" class="fa-cbx cbx mid" checked></#if>
                <strong>${addresss.consignee}  ${addresss.tel}</strong>
                <span>${addresss.fullAdd} ${addresss.detail}</span>
            </label>
            <div class="op">
                <a href="javascript:;" class="add-del" rid="${addresss.id}"><i class="fa fa-remove"></i> 删除</a>
                <a href="/address/detail/${addresss.id}"><i class="fa fa-edit"></i> 编辑</a>
            </div>
        </div>
        </#list>

        <div class="item">
            <a href="/address/add" class="add"><i class="fa fa-add"></i> 新增收货地址</a>
        </div>
    </div>
</section><!-- /ui-content -->


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

                //删除
                $wrap.on('click', '.add-del', function() {
                    var $this = $(this),
                        rid = $this.attr('rid');
                    layer.open({
                        className: 'layer-custom',
                        content: '确定要删除吗？',
                        btn: ['确定', '取消'],
                        yes: function(index) {
                            $.ajax({
                                url: '/address/delete/' + rid,
                                type: 'POST',
                                success: function(result) {
                                    $this.closest('.item').remove();
                                    layer.close(index);
                                }
                            })
                        }
                    });
                    return false;
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