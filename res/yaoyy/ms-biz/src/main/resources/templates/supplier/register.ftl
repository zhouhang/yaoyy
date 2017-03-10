<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商入驻-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
<div class="ui-content">
    <div class="ui-content">
        <div class="ui-form2">
            <div class="banner">
                <div class="logo">药优优</div>
                <div class="txt"></div>
            </div>

            <div class="form">
                <form action="">
                    <div class="item">
                        <input type="tel" class="ipt" name="name" id="name" placeholder="姓名" autocomplete="off">
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
                        <input type="text" class="ipt" name="region" id="region" placeholder="-省-市-区/县-" readonly="" autocomplete="off">
                        <span class="error"></span>
                        <em class="mid ico-arrow-r"></em>
                        <input id="areaId" type="text" style="display: none">
                    </div>
                    <div class="ft">
                        <button type="submit" class="ubtn ubtn-primary" id="submit">申请入驻</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="pick-region">
            <div class="ui-header">
                <div class="title">地址选择</div>
                <div class="abs-l mid">
                    <a href="javascript:;" class="fa fa-back" id="back"></a>
                </div>
                <div class="tab">
                    <span>请选择</span>
                    <span></span>
                    <span></span>
                </div>
            </div>

            <div class="tabcont">
                <div class="cont">
                    <ul>
                    </ul>
                    <ul>
                    </ul>
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
</div>
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
    <script>

        var _global = {
            fn: {
                init: function() {
                    this.validator();
                    this.region();
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
                                       phone:$("#mobile").val(),enterCategory:$("#category").val(),
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
                },
                region: function() {

                    var self = this,
                            $tab = $('.tab'),
                            $tabcont = $('.tabcont'),
                            $item = $tabcont.find('ul'),
                            $cont = $('.cont'),
                            $form = $('.ui-form2'),
                            $regin = $('.pick-region'),
                            choose = [];

                    var tab = function(idx) {
                        var distance = idx * $tabcont.width();
                        $item.css('position','absolute').eq(idx).css('position','relative');
                        $cont.css({
                            '-webkit-transition':'all .3s ease',
                            'transition':'all .3s ease',
                            '-webkit-transform':'translate3d(-' + distance + 'px,0,0)',
                            'transform':'translate3d(-' + distance + 'px,0,0)'
                        });
                    }

                    // 选择地区
                    $('#region').on('click', function() {
                        var name = this.innerHTML;
                        if($("#region").val()==""){
                            $.ajax({
                                url: '/area',
                                success: function(result) {
                                    $tab.find('span').eq(0).html(name).next().html('请选择');
                                    self.toHtml(result.data, $item.eq(0));
                                }
                            })
                        }
                        $regin.show();
                        $form.hide();
                    })

                    // 返回
                    $('#back').on('click', function() {
                        $regin.hide();
                        $form.show();
                    })

                    // tab
                    $tab.on('click', 'span', function() {
                        var idx = $(this).index();

                        $(this).html('请选择');
                        $tab.find('span').each(function(i) {
                            i > idx && $(this).empty();
                        })
                        tab(idx);
                    })

                    // 城市级联
                    $tabcont.on('click', 'li', function() {
                        var idx = $(this).parent().index(),
                                name = this.innerHTML,
                                cid = $(this).data('id');
                        if(idx==2){
                            $regin.hide();
                            $form.show();
                            var cities=$(this).data('name');
                            var areas=[];
                            $.each(cities.split(","),function(index,value){
                                        if(index!=0){
                                            areas.push(value);
                                        }
                                    }
                            );
                            $("#region").val(areas.join(""));
                            $("#areaId").val(cid);
                        }
                        $.ajax({
                            url: '/area',
                            data: {parentId: cid},
                            success: function(result) {
                                $tab.find('span').eq(idx).html(name).next().html('请选择');
                                self.toHtml(result.data, $item.eq(++idx));
                                tab(idx);
                            }
                        })
                    })
                },
                toHtml: function(data, $wrap) {
                    var model = [];
                    $.each(data, function(i, item) {
                        model.push('<li data-id="', item.id ,'" data-name="',item.position,'">', item.areaname, '</li>');
                    })
                    $wrap.html(model.join(''));
                }
            }
        }

        $(function(){
            _global.fn.init();

        });

    </script>
</body>
</html>