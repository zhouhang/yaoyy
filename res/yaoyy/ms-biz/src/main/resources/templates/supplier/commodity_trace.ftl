<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>寄卖商品-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-bg">
<#include "./common/navigation.ftl"/>

<section class="ui-content">
    <div class="plist2">
        <ul>
            <#list list as commodity>
            <li>
                <div class="cnt">
                    <div class="title">${commodity.title!}</div>
                    <div class="summary">
                    ${commodity.spec!}
                    </div>
                    <div class="price">
                        当前价格：<em>&yen;${commodity.price!}</em> 元/${commodity.unitName!}<br>
                        当前库存：${commodity.warehouse!} 公斤
                    </div>
                </div>
                <div class="pic">
                    <img src="${commodity.thumbnailUrl!}" width="110" height="90" alt="">
                </div>
            </li>
            </#list>
        </ul>
    </div>

    <div class="floor">
        <div class="hd ico-trace">货物跟踪</div>
        <ul id="trace">
        </ul>
    </div>
</section>

<#include "../common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.pageNum = 1;
                this.loadmore();
                this.loading();
            },
            loading: function() {
                var self = this,
                        $ul = $('#trace');

                $.ajax({
                    type: 'POST',
                    url: '/supplier/commodityTrace',
                    dataType: 'json',
                    data: {pageSize:5, pageNum:self.pageNum},
                    success: function(result){
                        var data = result.data;
                        if (!data.list) {
                            return;
                        }
                        var result = self.toHtml(data.list);
                        $ul.append(result);
                        if (data.isLastPage) {
                            $('body').append('<div class="nomore">没有更多了...</div>');
                            self.dragger.options.disableDragUp = true;
                        }
                        self.pagesize ++;
                    },
                    error: function(xhr, type){
                        popover('网络连接超时，请您稍后重试!');
                    },
                    complete: function() {
                        self.dragger.reset();
                    }
                });
            },
            loadmore: function() {
                var self = this;

                self.dragger = new DragLoader(document.body, {
                    disableDragDown: true,
                    dragUpLoadFn: function() {
                        self.loading();
                    }
                });
            },
            toHtml: function(data) {
                var html = [];
                $.each(data, function(i, item) {
                    html.push('<li>\n');
                    html.push(         '<span>', data[i].content, '</span>\n');
                    html.push(         '<time>', _YYY.timeago.elapsedTime(data[i].createTime), '</time>\n');
                    html.push('</li>');
                })
                return html.join('');
            }
        }
    }

    $(function(){
        _global.fn.init();

    });

</script>
</body>
</html>