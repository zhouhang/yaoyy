<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>账单列表-药优优</title>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">账单列表</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="ui-notice ui-notice-extra hide">
        您还没有未结清的账单！
        <a class="ubtn ubtn-primary" href='/'>返回首页</a>
    </div>
    <div class="bill">
    </div>
</section><!-- /ui-content -->
<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                 this.page();
                 this.loadPlist();
            },
            loadPlist: function() {
                var self = this,
                        pageNum = 1; // 当前页

                $('.ui-content').dropload({
                    scrollArea : window,
                    threshold : 50,
                    loadDownFn : function(me){
                        $.ajax({
                            type: 'POST',
                            url: '/bill',
                            data: {pageSize:5, pageNum:pageNum},
                            dataType: 'json',
                            success: function(result){
                                result = result.data;
                                if (pageNum > 2) {
                                    result.isLastPage = true;
                                }
                                if (result.list.length !== 0) {
                                    self.toHtml(result.list, pageNum);
                                    if (result.isLastPage) {
                                        me.lock();
                                        me.noData();
                                        setTimeout(function() {
                                            me.$domDown.addClass('dropload-down-hide');
                                        }, 2e3);
                                    }
                                    self.pagenav(pageNum, 10);
                                } else{
                                    if (result.isLastPage) {
                                        self.empty(true);
                                        me.$domDown.hide();
                                    }
                                }
                                pageNum ++;
                                me.resetload();
                            },
                            error: function(xhr, type){
                                popover('网络连接超时，请您稍后重试!');
                                me.resetload();
                            }
                        });
                    }
                });
            },
            toHtml: function(data, pageNum) {
                var html = [];
                html.push('<div id="page' + pageNum + '">');
                $.each(data, function(i, item) {
                    html.push('<div class="item">');
                    html.push('<p><span>订单号：</span><em class="blue">'+item.orderCode+'</em></p>');
                    html.push('<p><span>账单号：</span>'+item.code+'</p>');
                    html.push('<p><span>订单总金额：</span><b>&yen;'+item.amountsPayable+'</b>元</p>');
                    html.push('<p><span>已支付：</span><b>&yen;'+item.alreadyPayable+'</b>元</p>');
                    if (item.status == 0) {
                        html.push('<p><span>欠款：</span><b>&yen;'+(item.unpaid)+'</b>元</p>');
                        html.push('<p><span>剩余账期：</span>'+item.billTime+'天</p>');
                        html.push(' <strong>状态：<em class="red">未结清</em></strong>');
                    } else {
                        html.push('<strong>状态：<em class="blue">已结清</em></strong>');
                    }
                    html.push('<a href="/bill/detail/'+item.id+'" class="mid"><i class="fa fa-front"></i></a>');
                    html.push('</div>');
                })
                html.push('</div>');
                $('.bill').append(html.join(''));
                this.offset[pageNum] = $('#page' + pageNum).offset().top;
            },
            empty: function(isEmpty) {
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 订单列表还没有商品！ \n <a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
                }
            },
            pagenav: function(pageNum, pages) {
                $('#pagenav').show().html('<em>' + pageNum + '</em>/' + pages);
            },
            page: function() {
                var self = this;
                self.offset = {};
                $(window).on('scroll', function() {
                    var st = document.body.scrollTop || document.documentElement.scrollTop,
                            winHeight = $(window).height() / 1.5;
                    $.each(self.offset, function(key, val) {
                        if (st + winHeight >= val) {
                            $('#pagenav').find('em').html(key);
                        }
                    })
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