<!DOCTYPE html>
<html lang="en">
<head>
<title>品种列表</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body">
<header class="ui-header">
    <div class="title">品种列表</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
    <div class="abs-r mid">
        <a href="category/search"><i class="fa fa-search"></i></a>
    </div>
</header><!-- /ui-header -->

<#include "./common/navigation.ftl">

<section class="ui-content">
    <div class="plist" id="categroyList"></div>
</section><!-- /ui-content -->
<#include "./common/footer.ftl"/>
<script>

    var _global = {
        v:{
            dataUrl:"/category/list"
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
                            data: {pageNum:pageNum, name:'${name?default('')}'},
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
                html.push('<ul>');
                $.each(data, function(i, item) {
                    html.push('<li>\n');
                    html.push( '<a href="/commodity/detail/' + data[i].defaultCommodityId + '">\n');
                    html.push(     '<div class="cnt">\n');
                    html.push(         '<div class="title">', data[i].name, '</div>\n');
                    html.push(         '<div class="summary">', data[i].title, '</div>\n');
                    html.push(         '<div class="price"><i>¥</i>\n<em>');
                    html.push(              data[i].defaultCommodityPrice,'</em>元/', data[i].defaultCommodityUnitName);
                    html.push(          '</div>\n');
                    html.push(     '</div>');
                    html.push(     '<div class="pic"><img src="', data[i].pictureUrl, '" width="110" height="90" alt="', data[i].name, '"></div>\n');
                    html.push( '</a>\n');
                    html.push('</li>');
                })
                html.push('</ul>');
                $('.plist').append(html.join(''));
            },
            empty: function(isEmpty) {
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 品种列表还没有商品，<br>去商品详情页面可以添加商品到选货单！ \n <a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
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