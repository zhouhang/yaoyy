<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>我的消息-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
    <#include "../common/navigation.ftl"/>

    <div class="ui-content">

        <div class="floor">
            <div class="bd">
                <ul id="news">
                    <li>
                        <span>客服张倩为你发出了商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须）的样品。</span>
                        <em class="e1">寄样</em>
                        <time>四小时前</time>
                    </li>
                    <li>
                        <span>管理员程斌上传了商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留的毛须）。</span>
                        <em class="e1">下单</em>
                        <time>2017-02-28</time>
                    </li>
                    <li>
                        <span>您的商品（三棱，统个，浙江，长2cm-6cm直径2cm-4cm，火燎或撞去毛，有些许残留毛须）被下单100公斤。</span>
                        <em class="e2">商品</em>
                        <time>2017-02-28</time>
                    </li>
                </ul>
            </div>
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
                    $ul = $('#news');

                $.ajax({
                    type: 'GET',
                    url: '../json/news.json',
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
                    html.push(         '<span>', data[i].title, '</span>\n');
                    html.push(         '<em class="e', data[i].class ,'">', data[i].type, '</em>\n');
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