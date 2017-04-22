<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>网站公告-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-bg">
    <#include "./common/navigation.ftl"/>
    <div class="ui-content">
        <div class="news">
            <ul>
            </ul>
        </div>
    </div>

    <#include "../common/footer.ftl"/>
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
                    url: 'announcement/getlist',
                    dataType: 'json',
                    data: {pagesize: self.pagesize},
                    success: function(data){
                        if (!data.data) {
                            return;
                        }
                        var result = self.toHtml(data.data);
                        $ul.append(result);
                        if (data.data.length) {
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
                    html.push(         '<time>', data[i].createTime, '</time>\n');
                    html.push(         '<div class="summary"><a href="/announcement/detail/', data[i].id,'">', data[i].content, '</a></div>\n');
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