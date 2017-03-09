<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>网站公告-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
    <#include "../common/navigation.ftl"/>
    <div class="ui-content">
        <div class="news">
            <ul>
                <li>
                    <h3 class="title">网站维护公告</h3>
                    <time>2017-02-28</time>
                    <div class="summary">
                        <a href="notice_info.html">网站与2017年2月28日16：00-19：00进行系统维护，期间不能进行下单以及，调价操作。</a>
                    </div>
                </li>
                <li>
                    <h3 class="title">中药材大会即将盛大开启</h3>
                    <time>2017-02-27</time>
                    <div class="summary">
                        <a href="notice_info.html">网站与2017年2月28日16：00-19：00进行系统维护，期间不能进行下单以及，调价操作。进行系统维护，期间不能进行下单以及...</a>
                    </div>
                </li>
                <li>
                    <h3 class="title">亳州药材市场</h3>
                    <time>2017-02-26</time>
                    <div class="summary">
                        <a href="notice_info.html">网站与2017年2月28日16：00-19：00进行系统维护，期间不能进行下单以及，调价操作。</a>
                    </div>
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
                    $ul = $('.news').find('ul');

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
                    html.push(         '<div class="title">', data[i].title, '</div>\n');
                    html.push(         '<time>', data[i].date, '</time>\n');
                    html.push(         '<div class="summary"><a href="notice_info.html">', data[i].summary, '</a></div>\n');
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