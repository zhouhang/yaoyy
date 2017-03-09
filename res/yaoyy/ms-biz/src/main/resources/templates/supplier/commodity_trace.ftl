<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>寄卖商品-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
<#include "./common/navigation.ftl"/>

<div class="ui-content">
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
                        当前价格：<em>&yen;${commodity.price!}</em> 元/${commodity.unit!}<br>
                        当前库存：;${commodity.warehouse!} 公斤
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
            <li>
                <span>您的商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须）以15元/公斤价格交易完成100公斤，我们会在3天之内与您结算。</span>
                <time>四小时前</time>
            </li>
            <li>
                <span>您的商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留毛须）被下单100公斤。</span>
                <time>2017-02-28</time>
            </li>
        </ul>
    </div>
</div>

<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/dragloader.min.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.pagesize = 0;
                this.loadmore();
                this.loading();
            },
            loading: function() {
                var self = this,
                        $ul = $('#trace');

                $.ajax({
                    type: 'GET',
                    url: '../json/trace.php',
                    dataType: 'json',
                    data: {pagesize: self.pagesize},
                    success: function(data){
                        if (!data.list) {
                            return;
                        }
                        var result = self.toHtml(data.list);
                        $ul.append(result);
                        if (data.nomore) {
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
                    html.push(         '<span>', data[i].text, '</span>\n');
                    html.push(         '<time>', _YYY.timeago.elapsedTime(data[i].date), '</time>\n');
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