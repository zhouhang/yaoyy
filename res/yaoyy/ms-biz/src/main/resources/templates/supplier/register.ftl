<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商入驻-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
<section class="ui-content">
    <div class="ui-form2">
        <div class="banner">
            <div class="logo">药优优</div>
            <div class="txt"></div>
        </div>

        <div class="form">
            <form action="">
                <div class="item">
                    <input type="text" class="ipt" name="name" id="name" placeholder="姓名" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="item">
                    <input type="tel" class="ipt" name="mobile" id="mobile" placeholder="手机号" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="item">
                    <input type="text" class="ipt" name="company" id="company" placeholder="公司名称" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="item">
                    <input type="text" class="ipt" name="category" id="category" placeholder="经营品种（多个品种请用逗号隔开）" autocomplete="off">
                    <span class="error"></span>
                </div>
                <div class="item">
                    <input type="hidden" name="areaId" id="areaId">
                    <input type="text" class="ipt" name="region" id="region" placeholder="-省-市-区/县-" readonly="" autocomplete="off">
                    <span class="error"></span>
                    <em class="mid ico-arrow-r"></em>
                </div>
                <div class="ft">
                    <button type="submit" class="ubtn ubtn-primary" id="submit">申请入驻</button>
                </div>
            </form>
        </div>
    </div>
</section>
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
    <script>

        var _global = {
            fn: {
                init: function() {
                    this.validator();
                    _YYY.regionArea.init('#region');
                },
                validator: function() {
                    var self = this;
                    $('#submit').on('click', function() {
                        if (self.checkName() && self.checkMobile() && self.checkRegion()){
                            $.ajax({
                                url: "/user/supplier/register",
                                dataType: 'json',
                                // name company phone enterCategory area
                                data: {name:$("#name").val(),company:$("#company").val(),
                                       phone:$("#mobile").val(),enterCategoryStr:$("#category").val(),
                                       area:$("#areaId").val()},
                                type: "POST",
                                success: function (result) {
                                    if (result.status === 200) {
                                        window.location.href =  result.data;
                                    } else {
                                        popover(result.msg);
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    popover('网络连接超时，请您稍后重试!');
                                }
                            });
                        }
                        return false;
                    })
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
                }
            }
        }

        $(function(){
            _global.fn.init();

        });

    </script>
</body>
</html>