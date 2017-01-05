<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>网站设置-药优优</title>
</head>
<body class='wrapper'>
<#include "./common/header.ftl"/>
<#include "./common/aside.ftl"/>
<div class="content">
    <div class="breadcrumb">
        <ul>
            <li>网站设置</li>
        </ul>
    </div>

    <div class="box fa-form fa-form-info">
        <form action="" id="myform1">
            <div class="hd">网站客服电话</div>
            <div class="item">
                <div class="txt">客服电话：</div>
                <div class="cnt">
                    <input type="text" class="ipt" value="${setting.consumerHotline!}" name="consumerHotline" placeholder="" autocomplete="off">
                </div>
            </div>
            <div class="ft">
                <button type="submit" class="ubtn ubtn-blue" id="jsubmit">保存</button>
            </div>
        </form>
    </div>

    <div class="box fa-form fa-form-info">
        <form action="" id="myform2">
            <div class="hd">银行账号</div>
            <div class="item">
                <div class="txt">账户名称：</div>
                <div class="cnt">
                    <input type="text" class="ipt" value="${setting.payAccount!}" name="account" placeholder="" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt">账号：</div>
                <div class="cnt">
                    <input type="text" class="ipt" value="${setting.payBankCard!}" name="card" placeholder="" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt">开户行：</div>
                <div class="cnt">
                    <input type="text" class="ipt" value="${setting.payBank!}" name="bank" placeholder="" autocomplete="off">
                </div>
            </div>
            <div class="ft">
                <button type="submit" class="ubtn ubtn-blue" id="jsubmit">保存</button>
            </div>
        </form>
    </div>
</div>

<#include "./common/footer.ftl"/>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        fn: {
            init: function() {
                this.validator();
            },
            validator: function() {
                // 表单验证
                $('#myform1').validator({
                    fields: {
                        phone: {
                            rule: 'required, tel',
                            msg: {
                                required: '请输入客户电话'
                            }
                        }
                    },
                    valid: function(form) {
                        $.ajax({
                            url: 'setting/tel',
                            data: {tel: $(form[0]).val()},
                            method:"POST",
                            success: function (response) {
                                window.location.reload();
                            }
                        })
                    }
                });
                // 表单验证
                $('#myform2').validator({
                    fields: {
                        account: {
                            rule: 'required',
                            msg: {
                                required: '请输入账户名称'
                            }
                        },
                        card: {
                            rule: 'required, bankNumber',
                            msg: {
                                required: '请输入账户名称'
                            }
                        },
                        bank: {
                            rule: 'required',
                            msg: {
                                required: '请输入开户行'
                            }
                        }
                    },
                    valid: function(form) {

                        $.ajax({
                            url: 'setting/bank',
                            data: $(form).serializeObject(),
                            method:"POST",
                            success: function (response) {
                                window.location.reload();
                            }
                        })
                    }
                });
            }
        }
    }
    _global.fn.init();
</script>
</body>
</html>