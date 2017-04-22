<!DOCTYPE html>
<html lang="en">
<head>
    <title>订单备注-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="body2">
<header class="ui-header">
    <div class="title">订单备注</div>
    <div class="abs-l mid">
        <a href="/pick/detail/${id}" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<div class="ui-content">
    <div class="ui-form">
        <form action="">
            <div class="item">
                <textarea name="" id="msg" class="mul" cols="30" rows="10" placeholder="备注"></textarea>
                <span class="error"></span>
            </div>
            <button type="submit" class="ubtn ubtn-primary" id="submit">保存</button>
        </form>
    </div>
</div>

<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                var note = sessionStorage.getItem("pickNote${id}");
                if (note) {
                    $("#msg").val(note);
                }
                this.validator();
            },
            validator: function() {
                var self = this;
                $('#submit').on('click', function() {
                    if (self.checkMsg()) {
                        //存入到 sessionStorage 中
                        sessionStorage.setItem("pickNote${id}",$("#msg").val())
                        location.href = "/pick/detail/${id}";
                    } else {

                    }
                    return false;
                })
            },
            checkMsg: function() {
                var $el = $('#msg'),
                        val = $el.val();

                if (!val) {
                    $el.next().html('留言内容不能为空！').show();

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