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
        <a href="/bill/detail/${billId!}" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">

    <div class="pay">
        <div class="hd">
            <em>需付金额：<strong>&yen;${total?string}</strong>元</em>
        </div>
        <div class="bd">
            <div class="row">
                <div class="txt">支付方式：</div>
                <div class="val">银行汇款</div>
            </div>
            <div class="row">
                <div class="txt">账户名称：</div>
                <div class="val">${setting.payAccount}</div>
            </div>
            <div class="row">
                <div class="txt">帐号：</div>
                <div class="val">${setting.payBankCard}</div>
            </div>
            <div class="row">
                <div class="txt">开户行：</div>
                <div class="val">${setting.payBank}</div>
            </div>
        </div>
        <div class="ft">
            <span>上传支付凭证：</span>
            <span class="ui-file thumb">
            <#if url?exists>
                <img src="${url}" alt=""><i class="del"></i>
            <#else >
                <input type="file" name="file" accept="image/gif,image/jpeg,image/png" class="upfile" />
            </#if>
            </span>
        </div>
        <form id="bankTransfer" method="post" action="/bill/bankTransfer">
        <input type="text" style="display: none" name="url" id="url" <#if url?exists>value="${url}" </#if> >
        <input type="text" style="display: none" name="accountBillId" value="${billId!}">
        <input type="text" style="display: none" name="id" <#if id?exists>value="${id}"</#if>>
        <div class="button">
            <button type="submit" class="ubtn ubtn-primary" id="submit">确认支付</button>
        </div>
        </form>
    </div>

</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/lrz.bundle.js')}"></script>
<script>
    var _global = {
        fn: {
            init: function() {
                this.submit();
                this.upfile();
                gallery();
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
                var $el = $('.ui-file');
                var reset = function() {
                    $el.html('<input type="file" name="file" accept="image/gif,image/jpeg,image/png" class="upfile" />');
                    $("#url").val('');
                }
                var showLader = function() {
                    $el.html('<i class="loader"></i>');
                }
                $el.on('change', '.upfile', function(ev) {
                    showLader();
                    lrz(this.files[0], {
                        width: 800
                    }).then(function (rst) {
                        var base64 = rst.base64;
                        base64 = base64.substr(base64.indexOf(',') + 1);
                        $.ajax({
                            url: "/pick/upload",
                            data: {
                                img: base64,
                                fileName:rst.origin.name
                            },
                            type: 'POST',
                            dataType: 'json',
                            success: function (result) {
                                if (result.status === 'success') {
                                    $el.html('<img src="' + result.url + '" alt="" data-src="' + result.url + '"><i class="del"></i>');
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
                        reset();
                    }).always(function () {
                        // 不管是成功失败，都会执行
                    });
                });
                $el.on('click', '.del', function() {
                    reset();
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