<!DOCTYPE html>
<html lang="en">
<head>
    <title>银行转账-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">银行转账</div>
    <div class="abs-l mid">
        <a href="/pick/detail/${orderId}" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">

    <div class="pay">
        <div class="hd">
            <em>需付金额：<strong>&yen;${total?string}</strong>元</em>
            <span>请在三天内完成汇款，否则订单会自动被取消。</span>
        </div>
        <div class="bd">
            <div class="row">
                <div class="txt">支付方式：</div>
                <div class="val">银行汇款</div>
            </div>
            <div class="row">
                <div class="txt">账户名称：</div>
                <div class="val">亳州市东方康元中药材信息咨询有限公司</div>
            </div>
            <div class="row">
                <div class="txt">帐号：</div>
                <div class="val">1318040809266666630</div>
            </div>
            <div class="row">
                <div class="txt">开户行：</div>
                <div class="val">中国工商银行亳州谯陵分理处</div>
            </div>
        </div>
        <div class="ft">
            <span>上传支付凭证：</span>
                <span class="ui-file">
                <#if url?exists>
                    <img src="${url}" alt="" style="width: 60px; height: 60px;"><i class="del fa fa-del"></i>
                <#else >
                    <input type="file" name="file" accept="image/gif,image/jpeg,image/png" class="upfile" />
                </#if>
                </span>
        </div>
        <form id="bankTransfer" method="post" action="/pick/bankTransfer">
        <input type="text" style="display: none" name="url" id="url" <#if url?exists>value="${url}" </#if> >
        <input type="text" style="display: none" name="orderId" value="${orderId}">
        <input type="text" style="display: none" name="id" <#if id?exists>value="${id}"</#if>>
        <div class="button">
            <button type="submit" class="ubtn ubtn-primary" id="submit">确认支付</button>
        </div>
        </form>
    </div>

</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script src="assets/js/layer.js"></script>
<script src="assets/js/lrz.bundle.js"></script>
<script>
    var _global = {
        fn: {
            init: function() {
                this.submit();
                this.upfile();
            },
            submit: function() {
                var self = this;
                $('#bankTransfer').submit(function () {
                    if ($("#url").val()== null || $("#url").val() == "") {
                        popover('请上传转账凭证');
                        return false;
                    } else {
                        return true;
                    }
                });
            },
            upfile: function() {
                $('.ui-file').on('change', '.upfile', function(ev) {
                    //图片lrz压缩上传
                    var self = $(this);
                    lrz($(this).get(0).files[0], {
                        width: 800
                    }).then(function (rst) {
                        base64 = rst.base64;
                        base64 = base64.substr(base64.indexOf(',') + 1);
                        $.ajax({
                            url: "/pick/upload",
                            data: {
                                img: base64,
                                fileName:rst.origin.name
                            },
                            type: 'post',
                            dataType: 'json',
                            beforeSend: function (jqXHR, settings) {
                                popover('图片正在上传，请稍后...');
                            },
                            success: function (result) {
                                if (result.status === 'success') {
                                    popover('上传图片成功');
                                    self.parent().append('<img src="' + result.url + '" alt=""><i class="del fa fa-del"></i>');
                                    $("#url").val(result.url);
                                } else {
                                    popover('上传图片失败，请刷新页面重试！');
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                popover('网络连接超时，请您稍后重试！');
                            }
                        })
                    }).catch(function (err) {
                        // 处理失败会执行
                    }).always(function () {
                        // 不管是成功失败，都会执行
                    });
                });
                $('.ui-file').on('click', '.del', function() {
                    $(this).parent().html('<input type="file" name="file" accept="image/gif,image/jpeg,image/png" class="upfile" />');
                    $("#url").val(null);
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