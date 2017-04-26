<!DOCTYPE html>
<html lang="en">
<head>
<title>新增收货地址-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body2">
<header class="ui-header">
    <div class="title">新增收货地址</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="ui-form">
        <form action="" id="addressForm">
            <input type="hidden" class="ipt" name="id" value="${vo.id?c}">
            <div class="item">
                <input type="text" class="ipt" name="consignee" id="name" value="${vo.consignee!}" placeholder="收货人" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="tel" class="ipt" name="tel" id="mobile" value="${vo.tel!}" placeholder="联系电话" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="hidden"name="areaId" id="areaId" value="${(vo.areaId?c)!}">
                <input type="text" class="ipt" name="region" id="region" value="${vo.fullAdd!}" placeholder="-省-市-区/县-" readonly="" autocomplete="off">
                <span class="error"></span>
                <em class="fa fa-front mid"></em>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="detail" id="address" value="${vo.detail!}" placeholder="详细地址" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <label class="cbx">
                    <input type="checkbox" id="isDefault" class="fa-cbx" <#if vo.isDefault==true>checked="checked"</#if>>
                    设为默认收货地址（每次购买时会默认使用该地址）
                </label>
            </div>
            <div class="item">
                <button type="submit" class="ubtn ubtn-primary" id="submit">确认</button>
            </div>
        </form>
    </div>
</section>

<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.submit();
                _YYY.regionArea.init('#region');
            },
            submit: function() {
                var self = this;
                $('#submit').on('click', function() {
                    var isDefault=0;
                    if($('#isDefault').is(':checked')){
                        isDefault=1;
                    }
                    var pass = self.validator();
                    if (pass) {
                        $.ajax({
                            url: '/address/save',
                            type: 'POST',
                            data: $("#addressForm").serialize()+"&isDefault="+isDefault,
                            success: function(result) {
                                location.href = document.referrer;
                            }
                        })
                    }
                    return false;
                })
            },
            validator: function() {
                return this.checkName() && this.checkMobile() && this.checkRegion() && this.checkAddress();
            },
            checkName: function() {
                var $el = $('#name'),
                        val = $el.val();
                if (!val) {
                    $el.next().html('请输入收货人！').show();

                } else {
                    $el.next().hide();
                    return true;
                }
                return false;
            },
            checkMobile: function() {
                var $el = $('#mobile'),
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
            checkRegion: function() {
                var $el = $('#region'),
                        val = $el.val();
                if (!val) {
                    $el.next().html('请选择地区！').show();

                } else {
                    $el.next().hide();
                    return true;
                }
                return false;
            },
            checkAddress: function() {
                var $el = $('#address'),
                        val = $el.val();

                if (!val) {
                    $el.next().html('请输入详细地址！').show();

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