<!DOCTYPE html>
<html lang="en">
<head>
    <title>订单发票-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">发票</div>
    <div class="abs-l mid">
        <a href="/pick/detail/${id}" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="invoice">
        <div class="item">
            <div class="tit">发票抬头</div>
            <label><input type="radio" name="taitou" class="cbx" value="1"><span>个人</span></label>
            <label><input type="radio" name="taitou" class="cbx" value="2"><span>公司</span></label>
            <input type="text" class="ipt" placeholder="请输入公司名称" id="companyName">
        </div>
        <div class="item">
            <div class="tit">发票内容</div>
            <label><input type="radio" name="detail" class="cbx" value="不开发票"><span>不开发票</span></label>
            <label><input type="radio" name="detail" class="cbx" value="明细"><span>明细</span></label>
        </div>

        <div class="button">
            <button type="button" class="ubtn ubtn-primary" id="submit">确认</button>
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
                this.submit();
                // 初始化赋值TODO:
                var invoice = sessionStorage.getItem("pickInvoice${id}");
                if (invoice) {
                    invoice = JSON.parse(invoice);

                    $("input[name=taitou]").each(function(){
                        if($(this).val() == invoice.type){
                            if (invoice.type == 2){
                                $(this).trigger("click");
                            }
                            $(this).attr("checked",true)
                        }
                    });

                    $("input[name=detail]").each(function(){
                        if($(this).val() == invoice.content){
                            $(this).attr("checked",true)
                        }
                    });
                    $("#companyName").val(invoice.name);
                }
            },
            bindEvent: function() {
                var self = this;
                $('.cbx[name="taitou"]').on('click', function() {
                    $('#companyName')[this.value === '2' ? 'show' : 'hide']();
                })
            },
            submit: function() {
                var self = this;
                $('#submit').on('click', function() {
                    var invoice = {};
                    // name 单位名称
                    // type 1.个人发票 2.增值税发票
                    // content 发票内容
                    invoice.name = $("#companyName").val();
                    invoice.content = $("input[name='detail']:checked").val();
                    invoice.type = $("input[name='taitou']:checked").val();
                    sessionStorage.setItem("pickInvoice${id}", JSON.stringify(invoice))
                    location.href = '/pick/detail/${id}';
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