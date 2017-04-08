<!DOCTYPE html>
<html lang="en">
<head>
<title>采购下单-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body>
<section class="ui-content">
    <div class="ui-form2">
        <form action="" class="form" id="myform">
            <div class="item">
                <input type="text" class="ipt" name="supplier" id="supplier" placeholder="供应商" autocomplete="off">
                <input type="hidden" class="ipt" name="supplierId" id="supplierId" data-msg="供应商填写无效">
                <span class="error"></span>
                <div class="suggest" id="supplierSuggest">
                    <div class="suggest-panel"></div>
                    <div class="suggest-close"></div>
                </div>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="breed" id="breed" placeholder="品种" autocomplete="off">
                <input type="hidden" class="ipt" name="categoryId" id="breedID" data-msg="品种填写无效">
                <span class="error"></span>
                <div class="suggest" id="breedSuggest">
                    <div class="suggest-panel"></div>
                    <div class="suggest-close"></div>
                </div>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="spec" id="level" placeholder="规格等级" autocomplete="off" data-msg="请输入规格等级">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="origin" id="origin" placeholder="产地" autocomplete="off" data-msg="请输入产地">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="price" id="price" placeholder="单价" autocomplete="off" data-msg="请输入单价">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="tel" class="ipt" name="num" id="amount" placeholder="数量" autocomplete="off" data-msg="请输入数量">
                <span class="error"></span>
                <span class="unit">公斤</span>
            </div>
            <div class="ft">
                <button type="submit" class="ubtn ubtn-primary" id="submit">下单</button>
            </div>
        </form>
    </div>
</section><!-- /ui-content -->
<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.autocomplete();
                this.checkForm();
            },
            autocomplete: function() {
                var t,
                        that = this,
                        colors = ['aqua', 'green', 'yellow', 'red', 'navy', 'teal', 'olive', 'orange', 'fuchsia', 'purple', 'maroon'],
                        $body = $('body'),
                        $supplierSuggest = $('#supplierSuggest'),
                        $breedSuggest = $('#breedSuggest');

                var search = function(url, call) {
                    $('.suggest').hide();
                    $.ajax({
                        url: url,
                        cache: false,
                        type:"POST",
                        success: function(res) {
                            call(res);
                        }
                    })
                }

                var search1 = function(val) {
                    t && clearTimeout(t);
                    t = setTimeout(function() {
                        search('/pick/purchaser/searchSup?name='+val, function(res) {
                            var model = [],
                                    idx = 0;
                            $.each(res.data, function(i, item) {
                                model.push('<li class="items" data-name="' + item.name + '"data-id="' + item.id + '"><span>' + item.name + '</span><span>' + item.phone + '</span><span>' + item.enterCategoryStr + '</span></li>');
                            })
                            if (model.length === 0) {
                                model.push('<span>暂无此供应商</span>');
                            } else {
                                model.push('</ul>');
                                model.unshift('<ul>');
                            }
                            $supplierSuggest.show().find('.suggest-panel').html(model.join(''));
                        })
                    }, 300);
                }

                var search2 = function(val) {
                    t && clearTimeout(t);
                    t = setTimeout(function() {
                        search('/category/search?name='+val, function(res) {
                            var model = [],
                                    idx = 0;
                            $.each(res.data, function(i, item) {
                                var className = 'bg-' + colors[idx++];
                                model.push('<a href="javascript:;" class="', className, '" id="', item.id, '">', item.name, '</a>');
                            })
                            if (model.length === 0) {
                                model.push('<span>暂无此品种</span>');
                            } else {
                                model.push('</div>');
                                model.unshift('<div class="inner">');
                            }
                            $breedSuggest.show().find('.suggest-panel').html(model.join(''));
                        })
                    }, 300);
                }

                $('#supplier').on('input', function() {
                    this.value ? search1($(this).val()) : $supplierSuggest.hide();
                })

                // 选择供应商
                $supplierSuggest.on('click', 'li', function() {
                    var name = $(this).data('name'),
                            id = $(this).data('id');
                    $('#supplier').val(name);
                    $('#supplierId').val(id);
                    $supplierSuggest.hide();
                })

                $('#breed').on('input', function() {
                    this.value ? search2($(this).val()) : $breedSuggest.hide();
                })

                // 选择品种
                $breedSuggest.on('click', 'a', function() {
                    $('#breed').val($(this).html());
                    $('#breedID').val(this.id);
                    $breedSuggest.hide();
                })

                // 关闭
                $body.on('click', '.suggest-close', function() {
                    $(this).parent().hide();
                })
            },
            checkForm: function() {
                var $ipt = $('#myform').find('.ipt');

                var msg = function(el, msg) {
                    $(el).parent().find('.error').html(msg)[msg ? 'show' : 'hide']();
                }

                $ipt.on('focus', function() {
                    msg(this);
                    // $(this).siblings('.error').hide();
                })

                // 数量
                $('#amount').on('keyup', function() {
                    var val = this.value;
                    if (val) {
                        val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : '';
                        this.value = val;
                    }
                })

                // 单价
                $('#price').on('keyup', function() {
                    var val = this.value;
                    if (!/^\d+\.?\d*$/.test(val)) {
                        val = Math.abs(parseFloat(val));
                        this.value = isNaN(val) ? '' : val;
                    }
                })


                $('#submit').on('click', function() {
                    var pass = true;
                    $ipt.each(function() {
                        console.log(this.value)
                        if (this.value) {
                            msg(this);
                        } else {
                            msg(this, $(this).data('msg') || '此处不能为空');
                            pass = false;
                        }
                    })
                    if (pass) {
                        var date = $("#myform").serializeArray();
                        $.post("/pick/purchaser/one",date,function(result){
                            if (result.status == 200) {
                                window.location.href="/pick/purchaser/two?pickId="+result.data;
                            }
                        })
                    }
                    return false;
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