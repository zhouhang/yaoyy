<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<title>登录-药优优</title>
<meta name="renderer" content="webkit" >
<base href="${baseUrl}"/>
<link type="image/x-icon" rel="shortcut icon" href="assets/images/favicon.ico" />
<link rel="stylesheet" href="assets/awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
    <div class="login-box">
        <div class="title"><strong>药优优</strong>电子商务管理系统</div>
        <div class="form">
            <form id="loginForm" action="/login" method="post">
                <div id="msg" class="msg"></div>

                <div class="group">
                    <div class="txt">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="cnt">
                        <input type="text" placeholder="用户名" id="username" name="username" autocomplete="off" value="" class="ipt">
                    </div>
                </div>

                <div class="group">
                    <div class="txt">
                        <i class="fa fa-lock"></i>
                    </div>
                    <div class="cnt">
                        <input type="password" placeholder="密码" id="password" name="password" autocomplete="off" value="" class="ipt">
                    </div>
                </div>

                <div class="button">
                    <button type="submit" class="ubtn ubtn-red" id="submit">登 录</button>
                </div>
            </form>
        </div>
    </div>
    <script src="assets/js/jquery191.js"></script>
    <script src="assets/js/jquery.form.js"></script>
    <script>
        !(function() {
        var 
            $username = $('#username'),
            $password = $('#password'),
            $submit   = $('#submit'),
            $msg      = $('#msg'),
            abled     = true;

        var showMsg = function(text) {
            if (text) {
                $msg.html('<i class="fa fa-exclamation-circle"></i> ' + text);
            } else {
                $msg.empty();
            }   
        }

        var checkUsername = function() {
            var msg = $username.val() ? '' : '请输入用户名';
            showMsg(msg);
            msg && $username.focus();
            return msg;
        }
        var checkPassword = function() {
            var msg = $password.val() ? '' : '请输入密码';
            showMsg(msg);
            msg && $password.focus();
            return msg;
        }

        var checkForm = function() {
            var c2 = checkPassword();
            var c1 = checkUsername();

            if (c2 || c1) {
                showMsg(c1 && c2 ? '请输入用户名和密码' : c1 + c2);
            } else {
                showMsg('');
            }
            return !c1 && !c2;
        }

        $('.ipt').on('blur', function() {
            $(this).parent('.group').removeClass('on');
        }).on('focus', function() {
            $(this).parent('.group').addClass('on');
        });


        $submit.on('click', function() {
            if (checkForm() && abled) {
                $submit.prop('disabled', true);
                abled = false;
                $("#loginForm").ajaxSubmit({
                    dataType: "json",
                    success: function (result) {
                        if(result.status=="200"){
                            location.href="/index"
                        }else{
                            showMsg(result.msg)
                        }
                    },
                    complete: function() {
                        $submit.prop('disabled', false);
                        abled = true;
                    }
                });
            }
            return false;
        });
    })(jQuery, window);

    </script>
</body>
</html>