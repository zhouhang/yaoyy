<!DOCTYPE html>
<html lang="en">
<head>
    <title>药优优系统微信绑定</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">药优优系统微信绑定</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<div class="ui-content">
    <div class="ui-notice">
        绑定微信后可以通过微信实时接收系统消息！绑定失败请咨询qq:327075297
    </div>
    <div class="ui-form">
        <form action="">
            <input type="hidden" name="openId" value="${openId!}">
            <div class="weinxin">
                <span>微信号：</span>
                <img src="${headImgUrl!}" width="30" height="30" alt="">
                <em>${nickname!}</em>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="username" id="username" placeholder="BOSS系统用户名" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <button type="submit" class="ubtn ubtn-primary" id="submit">绑定</button>
            </div>
        </form>
    </div>
</div>
<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.validator();
            },
            validator: function() {
                var self = this;
                $('#submit').on('click', function() {
                    return self.username();
                })

                self.SMSCodeEvent();
            },
            username: function() {
                var $el = $('#username'),
                        val = $el.val();

                if (!val) {
                    $el.next().html('请输入系统用户名！').show();

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