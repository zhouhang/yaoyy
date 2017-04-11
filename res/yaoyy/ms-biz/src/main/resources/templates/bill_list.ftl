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
                 this.loadPlist();
            },
            loadPlist: function() {
                var that = this,
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
                            success: function(res) {
                                if (res.data.isLastPage) {
                                    me.lock();
                                    me.noData();
                                    if (res.data.list.length === 0) {
                                        that.empty(true);
                                        me.$domDown.hide();
                                    }
                                }
                                that.toHtml(res.data.list);
                                pageNum ++;
                            },
                            error: function(xhr, type){
                                popover('网络连接超时，请您稍后重试!');
                            },
                            complete: function() {
                                me.resetload();
                            }
                        });
                    }
                });
            },
            toHtml: function(data) {
                var html = [];
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
                $('.bill').append(html.join(''));
            },
            empty: function(isEmpty) {
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 订单列表还没有商品！ \n <a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
                }
            }
        }
    }

    $(function(){
        _global.fn.init();
    });

</script>
</body>
</html>