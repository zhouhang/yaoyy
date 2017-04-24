<!DOCTYPE html>
<html lang="en">
<head>
<title>品种列表-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="body1 body-bg">

<header class="ui-header">
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>

    <div class="search mid">
        <form id="searchForm">
            <input type="text" name="keyword" id="keyword" value="${keyword!}" class="ipt" />
            <button type="submit" id="search" class="ico ico-search mid submit"></button>
        </form>
    </div>
</header><!-- /ui-header -->

<section class="ui-content">
    <div class="plist">
        <ul id="plist"></ul>
        <dl class="side">
            <dd>品种列表</dd>
            <dd <#if categoryId?? && categoryId == 0>class="curr"</#if>><a href="javascript;" data-id="0">特价商品</a></dd>
            <#if categoryVos??>
            <#list categoryVos as categoryVo>
            <dd <#if categoryId?? && categoryId == categoryVo.id>class="curr"</#if>><a href="javascript;" data-id="${categoryVo.id}">${categoryVo.name!}</a></dd>
            </#list>
            </#if>
        </dl>
    </div>
</section><!-- /ui-content -->
<input type="hidden" id="categoryId" value="${categoryId!}"/>

<#include "./common/navigation.ftl">

<#include "./common/footer.ftl"/>

<script>
    var _global = {
        fn: {
            init: function() {
                this.bindEvent();
                this.loadPlist();
            },
            bindEvent: function() {
                var that = this,    
                    $plist = $('#plist'),
                    $keyword = $('#keyword'),
                    $cid = $('#categoryId');

                $('.side').on('click', 'a', function() {
                    var cid = $(this).data('id');

                    $(this).parent().addClass('curr').siblings().removeClass('curr');
                    $keyword.val('');
                    $cid.val(cid);
                    $plist.empty();
                    that.pageNum = 1;
                    that.me.unlock();
                    that.me.noData(false);
                    that.getData({categoryId: cid});
                    return false;
                })

                // 搜索
                $('#search').on('click', function(){
                    $cid.val('');
                    $plist.empty();
                    that.pageNum = 1;
                    that.me.unlock();
                    that.me.noData(false);
                    that.getData({keyword: $keyword.val()});
                    return false;
                });
            },
            loadPlist: function() {
                var that = this;
                that.pageNum = 1; // 当前页

                that.me = $('.ui-content').dropload({
                    scrollArea: window,
                    threshold: 50,
                    loadDownFn: function(){
                        that.getData({
                            pageNum: that.pageNum, 
                            categoryId: $('#categoryId').val(), 
                            keyword: $('#keyword').val()
                        });
                    }
                });
            },
            getData: function(parameter) {
                var that = this;
                $.ajax({
                    type: 'POST',
                    url: 'commodity/list',
                    dataType: 'json',
                    data: parameter,
                    success: function(res){
                        if (res.data.isLastPage) {
                            that.me.lock();
                            that.me.noData();
                        }
                        that.toHtml(res.data.list);
                        that.pageNum ++;
                    },
                    error: function(xhr, type){
                        popover('网络连接超时，请您稍后重试!');
                    },
                    complete: function() {
                        that.me.resetload();
                    }
                });
            },
            toHtml: function(data) {
                var html = [];
                $.each(data, function(i, item) {
                    html.push('<li>\n');
                    html.push( '<a href="/commodity/detail/' + item.id + '">\n');
                    html.push(     '<div class="cnt">\n');
                    html.push(         '<div class="title">', item.name);
                    if (item.specialOffers===1) {
                        html.push('<span class="ui-tag">特价</span>');
                    }
                    html.push('</div>\n');
                    html.push(         '<div class="summary">', item.title, '</div>\n');
                    html.push(         '<div class="price">\n');
                    html.push(              '<i>&yen;</i>\n');
                    html.push(              '<em>', item.price,'</em>\n');
                    html.push(              '<b>元/', item.unitName, '</b>\n');
                    html.push(          '</div>\n');
                    html.push(     '</div>');
                    html.push(     '<div class="pic"><img src="', item.thumbnailUrl, '" width="110" height="90" alt="', item.title, '"></div>\n');
                    html.push( '</a>\n');
                    html.push('</li>');
                })
                $('#plist').append(html.join(''));
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