<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>供应商入驻-药优优</title>
        <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
    <div class="ui-content">
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
                    <div class="item item-btn">
                        <input type="tel" class="ipt" name="phone" id="mobile" placeholder="手机号" autocomplete="off">
                        <span class="error"></span>
                        <button type="button" class="btn" id="send">发送验证码</button>
                    </div>
                    <div class="item">
                        <input type="text" class="ipt" name="code" id="SMSCode" placeholder="验证码" autocomplete="off">
                        <span class="error"></span>
                    </div>
                    <div class="item">
                        <input type="text" class="ipt" name="enterCategoryStr" id="category" placeholder="经营品种（多个品种请用逗号隔开）" autocomplete="off">
                        <input type="hidden" name="enterCategory" id="enterCategory" >
                        <span class="error"></span>
                        <div class="suggest">
                            <div class="suggest-panel"></div>
                            <div class="suggest-close"></div>
                        </div>
                    </div>
                    <div class="ft">
                        <button type="submit" class="ubtn ubtn-primary" id="submit">注册成为药优优供应商</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <#include "../common/footer.ftl"/>
    <script src="../assets/js/layer.js"></script>
    <script>

    var _global = {
        fn: {
            init: function() {
                this.validator();
                this.category();
            },
            validator: function() {
                var self = this;

                $('#submit').on('click', function() {

                    if (self.checkName() && self.checkMobile()){
                        $.ajax({
                            url: "/user/supplier/join",
                            dataType: 'json',
                            data: {name:$("#name").val(), phone:$("#mobile").val(),enterCategoryStr:$("#category").val(),
                                   code:$("#SMSCode").val()},
                            type: "POST",
                            success: function (result) {
                                if (result.status === 200) {
                                    window.location.href =  result.data;
                                } else {
                                    layer.open({
                                        className: 'layer-custom2'
                                        ,content: '<div class="hd">供应商信息已登记</div><div class="bd">result.msg</div>'
                                        ,btn: ['确定']
                                    });
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
                        url: 'user/sendRegistSms',
                        dataType: 'json',
                        data: 'phone='+$('#mobile').val(),
                        type:"POST",
                        success: function(data) {
                            if (data.status == '200') {
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
            },
            category: function() {
                var t,
                    self = this,
                    $suggestions = $('.suggest'),
                    $category = $('#category'),
                    $categoryId = $('#enterCategory'),
                    colors = ['aqua', 'green', 'yellow', 'red', 'navy', 'teal', 'olive', 'orange', 'fuchsia', 'purple', 'maroon'],
                    choosed = {};

                var getColor = function() {
                    var idx = Math.floor(Math.random() * colors.length);
                    return colors[idx];
                }

                var getInputCart = function() {
                    var value = [];
                    $.each(choosed, function(key, val) {
                        value.push(val);
                    })
                    return value.length > 0 ? value.join() + ',' : '';
                }

                var search = function() {
                    var value = $.trim($category.val()).split(',');


                    $.ajax({
                        url: 'category/search',
                        type:"POST",
                        data:{name:value.pop()},
                        success: function(data) {
                            var model = [],
                                idx = 0;
                            $.each(data.data, function(i, item) {
                                var className = 'bg-' + colors[idx++] + (choosed[item.name] ? ' disabled' : '');
                                model.push('<a href="javascript:;" class="', className, '" id="', item.id, '">', item.name, '</a>');
                                if (idx >= colors.length) {
                                    idx = 0;
                                }
                            })
                            if (model.length === 0) {
                                model.push('<span>暂无此商品</span>');
                            }
                            $suggestions.show().find('.suggest-panel').html(model.join(''));
                        }
                    })
                }
                var _s = function() {
                    t && clearTimeout(t);
                    t = setTimeout(function() {
                        search();
                    }, 300);
                }
                $category.on('input', _s).on('blur', function() {
                    var value = $.trim(this.value).split(','),
                        valid = [],
                        _choosed = {};

                    $.each(value, function(key, val) {
                        if (choosed[val]) {
                            valid.push(val);
                            _choosed[val] = key;
                        }
                    })

                    choosed = _choosed;
                    $category.val(valid.length > 0 ? valid.join() + ',' : '');
                    $('#enterCategory').val()
                });

                $suggestions.on('click', 'a', function() {
                    if (choosed[$(this).html()]) {
                        delete choosed[$(this).html()];
                    } else {
                        choosed[$(this).html()] = $(this).html();
                    }
                    $(this).toggleClass('disabled');

                    var valid = [];
                    $.each(choosed, function(key, val) {
                        valid.push(val);
                    })
                    
                    $category.val(valid.length > 0 ? valid.join() + ',' : '');
                })

                // 关闭
                $suggestions.on('click', '.suggest-close', function() {
                    $suggestions.hide();
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