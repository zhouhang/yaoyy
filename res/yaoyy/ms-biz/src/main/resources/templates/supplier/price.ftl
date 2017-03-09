<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>商品调价-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
    <#include "../common/navigation.ftl"/>

    <div class="ui-content">
        <div class="plist2 plist2-space">
            <ul>
                <li>
                    <div class="cnt">
                        <div class="title">三七</div>
                        <div class="summary">
                            云南文山三七120/80/60头  上等货洗净   无硫  长期供应
                        </div>
                    </div>
                    <div class="pic">
                        <img src="../uploads/p5.jpg" width="110" height="90" alt="">
                    </div>

                    <div class="edit">
                        <div class="item">
                            价格：<input type="text" class="ipt price">元/公斤
                            <input type="hidden" name="price" value="1">
                            <button type="button" class="btn">修改</button>
                        </div>
                        <div class="item">
                            库存：<input type="text" class="ipt stock">公斤
                            <input type="hidden" name="stock" value="1">
                            <button type="button" class="btn">修改</button>
                        </div>
                    </div>
                    <div class="space"></div>
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
                this.bindEvent();
                this.loadmore();
                this.loading();
            },
            bindEvent: function() {
                // 数量
                $('.plist2').on('keyup', '.stock', function() {
                    var val = this.value;
                    if (val) {
                        val = (!isNaN(val = parseInt(val, 10)) && val) > 0 ? val : '';
                        this.value = val;
                    }
                })
                // 单价
                $('.plist2').on('keyup', '.price', function() {
                    var val = this.value;
                    if (!/^\d+\.?\d*$/.test(val)) {
                        val = Math.abs(parseFloat(val));
                        this.value = isNaN(val) ? '' : val;
                    }
                })

                $('.plist2').on('click', '.btn', function() {
                    var input = $(this).prev()[0],
                        ipt = $(this).parent().find('.ipt')[0];

                    $(this).prop('disabled', true);
                    $.ajax({
                        url: '',
                        data: {id: input.value, type: input.name, val: ipt.value},
                        success: function() {
                            console.log('修改成功')
                        },
                        complete: function() {
                            $(this).prop('disabled', false);
                        }
                    })

                })
            },
            loading: function() {
                var self = this,
                    $ul = $('.plist2').find('ul');

                $.ajax({
                    type: 'GET',
                    url: '../json/plist2.json',
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
                    html.push('<div class="cnt">');
                    html.push('<div class="title">', data[i].title, '</div>');
                    html.push('<div class="summary">');
                    html.push(data[i].summmary);
                    html.push('</div>');
                    html.push('</div>');
                    html.push('<div class="pic">');
                    html.push('<img src="', data[i].pic, '" width="110" height="90" alt="">');
                    html.push('</div>');
                    html.push('<div class="edit">');
                    html.push('<div class="item">');
                    html.push('价格：<input type="text" class="ipt price">元/公斤');
                    html.push('<input type="hidden" name="price" value="', data[i].id, '">');
                    html.push('<button type="button" class="btn">修改</button>');
                    html.push('</div>');
                    html.push('<div class="item">');
                    html.push('库存：<input type="text" class="ipt stock">公斤');
                    html.push('<input type="hidden" name="stock" value="', data[i].id, '">');
                    html.push('<button type="button" class="btn">修改</button>');
                    html.push('</div>');
                    html.push('</div>');
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