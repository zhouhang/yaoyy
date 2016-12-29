<!DOCTYPE html>
<html lang="en">
<head>
    <title>新增收货地址-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">新增收货地址</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<div class="ui-content">
    <div class="ui-form">
        <form action="" id="addressForm">
            <input type="hidden" class="ipt" name="id" >
            <div class="item">
                <input type="text" class="ipt" name="consignee" id="name" placeholder="收货人" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="tel" class="ipt" name="tel" id="mobile" placeholder="联系电话" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <input type="hidden" class="ipt" name="areaId" id="areaId" >
                <input type="text" class="ipt" name="region" id="region"  placeholder="-省-市-区/县-" readonly="" autocomplete="off">
                <span class="error"></span>
                <em class="fa fa-front mid"></em>
            </div>
            <div class="item">
                <input type="text" class="ipt" name="detail" id="address"  placeholder="详细地址" autocomplete="off">
                <span class="error"></span>
            </div>
            <div class="item">
                <label class="cbx">
                    <input type="checkbox" id="isDefault" class="fa-cbx" checked="" >
                    设为默认收货地址（每次购买时会默认使用该地址）
                </label>
            </div>
            <div class="item">
                <button type="submit" class="ubtn ubtn-primary" id="submit">确认</button>
            </div>
        </form>
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

<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.submit();
                this.region();
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
                        //console.log('验证成功')
                        $.ajax({
                            url: '/address/save',
                            type: 'POST',
                            data: $("#addressForm").serialize()+"&isDefault="+isDefault,
                            success: function(result) {
                                location.href = document.referrer;
                            }
                        })
                    } else {
                        //console.log('验证失败')
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
            },
            region: function() {

                var self = this,
                        $tab = $('.tab'),
                        $tabcont = $('.tabcont'),
                        $item = $tabcont.find('ul'),
                        $cont = $('.cont'),
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

                    $('.pick-region').show();
                    $('.ui-form').hide();
                })

                // 返回
                $('#back').on('click', function() {
                    $('.pick-region').hide();
                    $('.ui-form').show();
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
                        $('.pick-region').hide();
                        $('.ui-form').show();
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