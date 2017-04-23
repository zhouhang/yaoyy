<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
    <title>药商头条-药优优</title>
</head>
<body class="ui-body-nofoot">
<div class="ui-content">

    <div class="scroll-menu">
        <#list tags as tag>
        <a href="/headline?tagId=${tag.id!}" <#if (tag.id==tagId?default(-1))>class="curr"</#if>>${tag.name!}</a>
        </#list>
    </div>

    <div class="news2">
        <ul id="plist"></ul>
    </div>
</div>
<div class="copyright">
    <p>亳州市东方康元中药材信息咨询有限公司</p>
    <p>版权所有 2016-2017</p>
</div>

<#include "./common/footer.ftl"/>
<script src="/assets/js/dragloader.min.js"></script>
<script>

    var _global = {
        fn: {
            init: function () {
                this.loadPlist();
            },
            loadPlist: function () {
                var that = this;
                that.pageNum = 1; // 当前页

                that.me = $('.ui-content').dropload({
                    scrollArea: window,
                    threshold: 50,
                    loadDownFn: function () {
                        that.getData({
                            pageNum: that.pageNum
                        });
                    }
                });
            },
            getData: function (parameter) {
                var that = this;
                $.ajax({
                    type: 'POST',
                    url: '/headline',
                    dataType: 'json',
                    data: parameter,
                    success: function (res) {
                        res = res.data;
                        if (res.isLastPage) {
                            that.me.lock();
                            that.me.noData();
                        }
                        that.toHtml(res.list);
                        that.pageNum++;
                    },
                    error: function (xhr, type) {
                        popover('网络连接超时，请您稍后重试!');
                    },
                    complete: function () {
                        that.me.resetload();
                    }
                });
            },
            toHtml: function (data) {
                var html = [];
                $.each(data, function (i, item) {
                    html.push('<li>\n');
                    html.push('<div class="cnt">\n');
                    html.push('<div class="name"><a href="/headline/' + item.id + '">', item.title, '</a></div>\n');
                    html.push('<div class="cat">');
                    html.push(item.descript);
                    html.push('</div>\n');
                    html.push('<div class="time">\n');
                    html.push('<span class="">阅读数：', item.hits, '</span>\n');
                    html.push('<time>', _YYY.timeago.elapsedTime(item.createTime, true), '</time>\n');
                    $.each(item.tagStr.split(","), function (k, tag) {
                        html.push('<a href="/headline?tagStr=',tag, '" class="ui-tag">', tag, '</a>');
                    })
                    html.push('</div>\n');
                    html.push('</div>');
                    html.push('<div class="pic"><img src="', item.url, '" width="110" height="90" alt="', item.title, '"></div>\n');
                    html.push('</li>');
                })
                $('#plist').append(html.join(''));
            },
            empty: function (isEmpty) {
                if (isEmpty) {
                    $('.ui-content').prepend('<div class="ui-notice ui-notice-extra"> \n 暂无头条信息<br><a class="ubtn ubtn-primary" href="/">返回首页</a> \n </div>');
                }
            }
        }
    }

    $(function () {
        _global.fn.init();

    });

</script>
</body>
</html>