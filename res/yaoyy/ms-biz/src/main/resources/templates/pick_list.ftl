<!DOCTYPE html>
<html lang="en">
<head>
<title>选货单列表-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot body-gray">
<header class="ui-header">
    <div class="title">选货单列表</div>
    <div class="abs-l mid">
        <a href="/center/index" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="pick-list"></div>
</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>

<script>

    var _global = {
        v:{
            dataUrl:"/pick/list"
        },
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
                            url: _global.v.dataUrl,
                            data: {pageNum:pageNum, pageSize: 5},
                            dataType: 'json',
                            success: function(res){
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
                    html.push('<div class="item">\n <dl> \n <a href="/pick/detail/', item.id, '">');
                    html.push(     '<dt>\n');
                    html.push(         '状态：<em>', item.bizStatusText, '</em>\n');
                    html.push(         '<time>', item.createTime, '</time>\n');
                    html.push(     '</dt>\n');

                    $.each(item.pickCommodityVoList, function(j, list) {
                        if (j > 4) {
                            return false;
                        }
                        html.push(     '<dd>\n');
                        html.push(         '<em>', list.name, '</em><span>', list.origin, ' ', list.spec, ' ', list.num, ' ', list.unit, '</span>');
                        html.push(     '</dd>\n');
                    })

                    html.push('</dl> \n');
                    item.pickCommodityVoList.length> 5 && html.push('<div class="more">更多</div>'); // 选货单超过5条显示更多按钮

                    html.push('</a>\n </div>');
                })
                $('.pick-list').append(html.join(''));
            },
            empty: function(isEmpty) {
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 选货单列表还没有商品！ \n <a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
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