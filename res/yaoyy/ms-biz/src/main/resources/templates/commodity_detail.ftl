<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "./common/meta.ftl"/>
    <title>商品详情-药优优</title>
</head>
<body class="ui-body body-gray">
    <header class="ui-header">
        <div class="title">产品详情-${commodityVo.name}-${commodityVo.origin}</div>
        <div class="abs-l mid">
            <a href="javascript:history.back();" class="fa fa-back"></a>
        </div>
    </header><!-- /ui-header -->

    <footer class="ui-footer">
        <nav class="ui-nav extra">
            <ul>
                <li>
                    <a href="/category/list">
                        <i class="fa fa-list"></i>
                        <span>品种列表</span>
                    </a>
                </li>
                <li>
                    <a href="/pickCommodity/list">
                        <i class="fa fa-cart"></i>
                        <span>采购单</span>
                        <b id="cartNum"></b>
                    </a>
                </li>
                <li class="wide">
                    <a class="sample" href="apply/sample/${commodityVo.id}">免费寄样</a>
                </li>
                <li class="wide">
                    <a class="cart" href="javascript:;" id="addCommodity">加入选货单</a>
                </li>
            </ul>
        </nav>
    </footer>

    <section class="ui-content">
        <div class="ui-slide ui-slide-b" id="slide1">
            <ul>
                <li><a href="javascript:;"><img src="${commodityVo.pictureUrl}" alt=""></a></li>
            </ul>
        </div>

        <div class="pinfo">
            <h1 class="title">
                ${commodityVo.title}
                <#if commodityVo.minimumQuantity?exists><em>${commodityVo.minimumQuantity!}公斤起购</em></#if>
            </h1>
            <div class="tag">${commodityVo.slogan!}</div>
            <div class="norms">
                <#list commodityVoList as commodity>
                <a href="commodity/detail/${commodity.id?c}" <#if commodity.id==commodityVo.id>class="current"</#if>>${commodity.spec}</a>
                </#list>
            </div>
            <div class="price">
                <i>&yen;</i>
                <em>${commodityVo.price}</em>
                <b>元/${commodityVo.unitName!}</b>
                <#if commodityVo.mark!=0>
                    <span>量大价优</span>
                </#if>

                <div class="ui-quantity" id="quantity">
                    <button type="button" class="fa fa-reduce op"></button>
                    <input id="num"type="tel" class="ipt" value="${commodityVo.minimumQuantity?default(1)}" data-min="${commodityVo.minimumQuantity?default(1)}" autocomplete="off">
                    <button type="button" class="fa fa-plus op"></button>
                    <b>${commodityVo.unitName!}</b>
                </div>

                <div class="tel">
                    <i class="fa fa-tel"></i>
                </div>
            </div>

            <div class="attention">
            <#if commodityVo.watch>
                <a href="javascript:;" class="faved"><i class="fa fa-heart"></i>已关注</a>
            <#else >
                <a href="javascript:;"><i class="fa fa-heart"></i>关注该商品报价</a>
            </#if>
            </div>
            <div class="his">
                <a href="/commodity/price/${commodityVo.id}">查看历史价格</a>
                <span>价格更新时间：${commodityVo.priceUpdateTime?date}</span>
            </div>

            <div class="sales">
                <#list commodityVo.gradient as gradient>
                <dl>
                    <dt>${gradient.start}-${gradient.end}${commodityVo.unitName!}</dt>
                    <dd>${gradient.price}元/${commodityVo.unitName!}</dd>
                </dl>
                </#list>
            </div>
        </div>

        <div class="pdetail">
            <div class="tab">
                <ul>
                    <li class="current">产品详情</li>
                    <li>规格详情</li>
                    <li>质量保证</li>
                </ul>
            </div>
            <div class="tabcont">
                <div class="detailCont">
                    <div class="item">
                        ${commodityVo.detail}
                    </div>
                    <div class="item" id="attributeItem"></div>
                    <div class="item">
                        ${article!}
                    </div>
                </div>
            </div>
        </div>
    </section><!-- /ui-content -->


    <#include "./common/footer.ftl"/>
    <script src="/assets/js/layer.js"></script>
    <script>

    var _global = {
        v: {
            tel: ['18801285391', '027-1326541']
        },
        fn: {
            init: function() {
                this.slide();
                this.tab();
                this.quantity();
                this.initAttr();
                this.addCommodity();
                this.attention();
            },
            slide: function() {
                var $slide = $('#slide1'),
                    $nav,
                    length = $slide.find('li').length;

                var nav = ['<div class="nav"><b>1</b>/', length, '</div>'];
                $slide.append(nav.join(''));
                $nav = $slide.find('.nav b');

                length > 2 && $slide.swipeSlide({
                    callback : function(i){
                        $nav.html(++i);
                    }
                });
            },
            // 详情内容
            tab: function() {
                var $tab = $('.tab'),
                    $tabcont = $('.tabcont'),
                    $item = $tabcont.find('.item'),
                    $detailCont = $('.detailCont'),
                    _distance = $tab.offset().top,
                    timer = 0;

                $tab.on('click', 'li', function() {
                    var idx = $(this).index(),
                        distance = idx * $tabcont.width();
                    // window.scrollTo(0, _distance);
                    $(this).addClass('current').siblings().removeClass('current');
                    $item.css('position','absolute').eq(idx).css('position','relative');
                    $detailCont.css({
                        '-webkit-transition':'all .3s ease',
                        'transition':'all .3s ease',
                        '-webkit-transform':'translate3d(-' + distance + 'px,0,0)',
                        'transform':'translate3d(-' + distance + 'px,0,0)'
                    });
                })

                var tabFix = function() {
                    var st = document.body.scrollTop || document.documentElement.scrollTop;
                    if (st >= _distance) {
                        $tab.addClass('tab-fix');
                        $('.ui-header').addClass('ui-header-hide');
                    } else {
                        $tab.removeClass('tab-fix');
                        $('.ui-header').removeClass('ui-header-hide');
                    }
                }

                $(window).on('scroll', function() {
                    timer && clearTimeout(timer);
                    timer = setTimeout(function() {
                        tabFix();
                    }, 50);
                })

                // $detailCont.on('webkitTransitionEnd MSTransitionEnd transitionend',function(){});
            },
            // 加减数量
            quantity: function() {
                var $quantity = $('#quantity'), 
                    $ipt = $quantity.find('.ipt'),
                    min = $ipt.data('min') || 1,
                    num = Math.max($ipt.val() || 1, min);

                $quantity.on('click', '.fa-plus', function() {
                    $ipt.val(++num);
                })
                $quantity.on('click', '.fa-reduce', function() {
                    num > min && $ipt.val(--num);
                })
                // 只能输入数字
                $ipt.on('blur', function() {
                    var val = this.value;
                    if (val) {
                        val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : min;
                        this.value = Math.max(val, min);
                    } else {
                        this.value = min;
                    }
                    num = this.value;
                }).val(min);

                // 联系我们
                var tel = [];
                $.each(_global.v.tel, function(i, val) {
                    tel.push('<dd><a href="tel:' , val , '">' , val , '</a></dd>');
                })
                tel.push('</dl>');
                tel.unshift('<dl><dt>拨打电话：</dt>');
                $quantity.next().on('click', '.fa-tel', function() {
                    layer.open({
                        // shade: false,
                        className: 'layer-tel',
                        content: tel.join('')
                    });
                })
            },
            initAttr: function () {
                var html = ['<table><tbody>'];
                //品种，切制规格和产地
                html.push('<tr><td class="tit">商品名称</td><td>${commodityVo.name}</td></tr>');
                html.push('<tr><td class="tit">品名</td><td>${commodityVo.categoryName}</td></tr>');
                html.push('<tr><td class="tit">切制规格</td><td>${commodityVo.spec}</td></tr>');
                html.push('<tr><td class="tit">产地</td><td>${commodityVo.origin}</td></tr>');
                html.push('<tr><td class="tit">采收时间</td><td>${commodityVo.harYear}</td></tr>');
                <#if commodityVo.process??>
                    html.push('<tr><td class="tit">加工方式</td><td>${commodityVo.process!}</td></tr>');
                </#if>
                <#if commodityVo.exterior??>
                    html.push('<tr><td class="tit">性状特征</td><td>${commodityVo.exterior!}</td></tr>');
                </#if>
                <#if commodityVo.attribute?exists && commodityVo.attribute != "">
                    var parameter = ${commodityVo.attribute};
                    $.each(parameter, function (k, v) {
                        html.push('<tr><td class="tit">' , k , '</td><td>' , v , '</td></tr>');
                    })
                </#if>
                <#if commodityVo.executiveStandard??>
                    html.push('<tr><td class="tit">执行标准</td><td>${commodityVo.executiveStandard!}</td></tr>');
                </#if>
                html.push('</tbody></table>');
                $('#attributeItem').html(html.join(''));
            },
            addCommodity:function(){
                var self = this;
                $('#addCommodity').on('click', function (){
                    var id = ${commodityVo.id};
                    var num = parseInt($('#num').val(), 10);
                    !isNaN(num) && self.cartAnim(id, num);
                    return false;
                })
            },
            cartAnim: function(id, num) {
                var offset1 = $('.norms .current').offset(),
                    offset2 = $('#cartNum').offset(),
                    width = 20,
                    st = document.body.scrollTop || document.documentElement.scrollTop,
                    flyer = $('<div class="cartAnim"><i class="fa fa-cart"></i></div>');
                flyer.fly({
                    start: {
                        left: offset1.left + width/2,
                        top: offset1.top - st
                    },
                    end: {
                        left: offset2.left,
                        top: offset2.top - st,
                        width: 20,
                        height: 20
                    },
                    onEnd: function(){
                        pickCommodity(id, num);
                        this.destroy();
                    }
                });
            },
            // 关注商品价格
            attention: function() {
                var timer = 0;
                var url;
                $('.attention').on('click', 'a', function () {
                    // 用户未登入点关注按钮直接跳转到登入界面
                <#if login>
                    var faved = true;
                    if (this.className) {
                        this.className = '';
                        this.innerHTML = '<i class="fa fa-heart"></i>关注该商品报价';
                        faved = false;
                        url = "/follow/unwatch";
                    } else {
                        this.className = 'faved';
                        this.innerHTML = '<i class="fa fa-heart"></i>已关注';
                        faved = true;
                        url = "/follow/watch";
                    }
                    clearTimeout(timer);
                    timer = setTimeout(function () {
                        $.ajax({
                            url: url,
                            type: "POST",
                            data: {commodityId: ${commodityVo.id}},
                            success: function (result) {
                                //关注成功
                            }
                        })
                    }, 300);
                <#else >
                    window.location.href = "/follow/watch?commodityId=${commodityVo.id}";
                </#if>
                })
            }

        }
    }

    $(function(){
        _global.fn.init();
    });

</script>


<script>
    var weixinShare = {
        appId: '${signature.appid!}',
        title: '${commodityVo.title!}《药优优》',
        desc: '药优优——原药材销售平台 优选好药，底价直采！ 质量保障，价格保障，货源保障！',
        link: '${signature.url!}',
        imgUrl: "${commodityVo.thumbnailUrl}",
        timestamp: ${signature.timestamp?string("#")},
        nonceStr: '${signature.noncestr!}',
        signature: '${signature.signature!}'
    }
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="assets/js/weixin_share.js"></script>

</body>
</html>