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
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="consignee" id="attention_commodity">
        <#list addressList as addresss>
        <div class="item">
            <label class="item-select" rid="${addresss.id}">
                <input type="radio" class="fa-cbx cbx mid">
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
                // 初始化选择之前选择的地址
                var addr = sessionStorage.getItem('pickAddrId${orderId!}');
                if (addr) {
                    addr = JSON.parse(addr);
                    if(addr.id != -1){
                        // 选择地址
                        $("label[rid='"+addr.id+"']").find('input').prop('checked', true);
                    }
                }
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
                                    // 删除时要删除对应 session 缓存值
                                    var addr = sessionStorage.getItem('pickAddrId${orderId!}');
                                    if (addr) {
                                        addr = JSON.parse(addr);
                                        if(addr.id == rid){
                                            sessionStorage.removeItem('pickAddrId${orderId!}');
                                        }
                                    }
                                }
                            })
                        }
                    });
                    return false;
                })

                // 选中地址
                $wrap.on('click', '.item-select', function() {
                    var $this = $(this);
                    var addr = {
                        id: $this.attr('rid'),
                        title: $this.find('strong').html(),
                        detail: $this.find('span').html()
                    };
                    sessionStorage.setItem("pickAddrId${orderId!}",JSON.stringify(addr));
                    <#if callback?exists>
                    window.location.href = "${callback!}";
                    <#else>
                    window.location.href = "/pick/detail/${orderId!}";
                    </#if>
                });
            }
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>