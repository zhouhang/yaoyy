<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<title>修改密码-药优优</title>
<meta name="renderer" content="webkit" >
<base href="${baseUrl}"/>
<link rel="stylesheet" href="assets/css/style.css" />
<style>
body,form{margin:0;padding:0;}
body,button,input{background:#fff;font:14px/1.5 arial,tahoma,'Microsoft Yahei','\5b8b\4f53';color:#333}
body{background:#fff;}
::-ms-clear,::-ms-reveal{display:none;}
.fa-form{width:300px;padding-top:30px;font-size:12px;}
.fa-form .item{padding-left:90px;}
.fa-form .txt{width:80px;position:absolute;text-align:right;}
.fa-form .cnt .ipt{width:180px;height:30px;line-height:30px;font-size:12px;}
.fa-form .button{padding-top:10px;text-align:center;}
.fa-form .button .ubtn{min-width:60px;margin:0 6px;}
</style>
</head>

<body>
<form id="myform">
    <div class="fa-form">
        <div class="item">
            <div class="txt"><i>*</i>原密码：</div>
            <div class="cnt">
                <input class="ipt" name="oldpwd" id="oldpwd" type="password">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>新密码：</div>
            <div class="cnt">
                <input class="ipt" name="newpwd" id="newpwd" type="password">
            </div>
        </div>
        <div class="button">
            <button type="submit" class="ubtn ubtn-blue">保存</button>
            <button type="button" class="ubtn ubtn-gray">取消</button>
        </div>
    </div>
</form>

<script src="/assets/js/jquery191.js"></script>
<script src="/assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        fn: {
            init: function() {
                this.checkForm();
            },
            checkForm: function() {
                var self = this;
                $('#myform').validator({
                    fields: {
                        oldpwd: '原密码: required',
                        newpwd: '新密码: required'
                    },
                    valid : function(form) {
                        var newpwd = $("#newpwd").val();
                        var oldpwd = $("#oldpwd").val();
                        $.post("/member/changePassword",{oldPassword:oldpwd,newPassword:newpwd}, function (data) {
                            if(data.status == 200) {
                                self.success();
                            } else {
                                window.parent.$.notify({
                                    type: 'error',
                                    title: data.msg
                                })
                            }
                        })
                        return false;
                    }
                });

                // 取消按钮
                $('#myform').on('click', '.ubtn-gray', function() {
                    window.parent.layer.closeAll();
                })
            },
            // 密码修改成功后关闭弹层并提示
            success: function() {
                window.parent.$.notify({
                    type: 'success',
                    title: '密码修改成功'
                })
                window.parent.layer.closeAll();
            }
        }
    }
    $(function() {
        _global.fn.init();
    })
</script>
</body>

</html>
