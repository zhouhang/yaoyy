<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商登录-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
<div class="ui-content">
    <div class="ui-form2">
        <div class="logo">药优优</div>

        <div class="form">
            <form action="">
                <div class="item">
                    <input type="tel" class="ipt" name="phone" id="phone" placeholder="手机号" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="item">
                    <input type="password" class="ipt" name="password" id="password" placeholder="密码" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="ft">
                    <button type="submit" class="ubtn ubtn-primary" id="submit">登录</button>
                </div>
            </form>
        </div>

        <div class="bar">
            <a href="/user/supplier/findPassword" class="">忘记密码？</a>
        </div>
    </div>
</div>
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script>
    var _global = {
        fn: {
            init: function() {
                this.validator();
            },
            validator: function() {
                var self = this;
                $('#submit').on('click', function() {
                    if (self.checkMobile() && self.checkPassword()) {
                        $.ajax({
                            url: "/user/supplier/login",
                            dataType: 'json',
                            data: {phone:$("#phone").val(),password:$("#password").val()},
                            type: 'POST',
                            success: function (result) {
                                if (result.status === 200) {
                                    window.location.href =  result.data;
                                } else {
                                    layer.open({
                                        className: 'layer-custom2'
                                        ,
                                        content: '<div class="hd">登录失败</div><div class="bd">您的账号在药优优供应商系统未激活，请联系工作人员激活或修改。</div>'
                                        ,
                                        btn: ['确定']
                                    });
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                popover('网络连接超时，请您稍后重试!');
                            }
                        });
                    }
                })
            },
            checkMobile: function() {
                var $el = $('#phone'),
                        val = $el.val();

                if (!val) {
                    $el.next().html('请输入手机号码！').show();

                } else if (!_YYY.verify.isMobile(val)) {
                    $el.next().html('请输入有效的手机号！').show();

                } else {
                    $el.next().hide();
                    return true;
                }
                return false;
            },
            checkPassword: function() {
                var $el = $('#password'),
                        val = $el.val();

                if (!val) {
                    $el.next().html('请输入密码！').show();

                } else {
                    $el.next().hide();
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