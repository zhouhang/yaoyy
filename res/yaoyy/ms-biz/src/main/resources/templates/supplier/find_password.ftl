<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>找回密码-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
<div class="ui-content">
    <div class="ui-form2">
        <div class="logo">药优优</div>

        <div class="form">
            <form action="">
                <div class="item item-btn">
                    <input type="text" class="ipt" name="phone" id="phone" placeholder="手机号" autocomplete="off">
                    <span class="error"></span>
                    <button type="button" class="btn" id="send">发送验证码</button>
                </div>
                <div class="item">
                    <input type="text" class="ipt" name="code" id="code" placeholder="验证码" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="item">
                    <input type="password" class="ipt" name="password" id="password" placeholder="新密码" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="ft">
                    <button type="submit" class="ubtn ubtn-primary" id="submit">修改密码</button>
                </div>
            </form>
        </div>
    </div>
</div>
<#include "../common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.validator();
            },
            validator: function() {
                var self = this;
                $('#submit').on('click', function() {
                    if (self.checkMobile() &&self.checkSMSCode() && self.checkPassword()){
                        $.ajax({
                            url: "/user/supplier/login",
                            dataType: 'json',
                            data: {phone:$("#phone").val(),password:$("#password").val(),code:$("#code").val()},
                            type: 'POST',
                            success: function (result) {
                                if (result.status === 200) {
                                    popover('密码找回成功!');
                                    window.location.href =  result.data;
                                } else {
                                    popover('密码找回失败!');
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                popover('网络连接超时，请您稍后重试!');
                            }
                        });
                    }
                    return false;
                })
                self.SMSCodeEvent();
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
            checkSMSCode: function() {
                var $el = $('#code'),
                        val = $el.val();
                if (!val) {
                    $el.next().html('请输入短信验证码！').show();

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
            },
            SMSCodeEvent: function() {
                var $send = $('#send'),
                        self = this;
                second = 0,
                        wait = 0,
                        txt = '秒后重试';

                var lock = function() {
                    wait && clearInterval(wait);
                    wait = setInterval(function() {
                        second--;
                        $send.text(second + txt).prop('disabled', true);
                        if (second === 0) {
                            clearInterval(wait);
                            $send.text("获取验证码").prop('disabled', false);
                        }
                    }, 1e3);
                }
                var sendMSM = function() {
                    popover('验证码发送中，请稍后...!');
                    $.ajax({
                        url: '../json/getsmscode.php',
                        dataType: 'json',
                        data: 'phone=13026584785',
                        success: function(data) {
                            if (data.status === 'y') {
                                $send.text(second + txt).prop('disabled', true);
                                lock();
                                popover(data.info);
                            } else {
                                popover(data.info);
                            }
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            popover('网络连接超时，请您稍后重试!');
                        }
                    })
                }
                $send.prop('disabled', false).on('click', function() {
                    if(second === 0 && self.checkMobile()) {
                        second = 60; // 60秒倒计时
                        sendMSM();
                    }
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