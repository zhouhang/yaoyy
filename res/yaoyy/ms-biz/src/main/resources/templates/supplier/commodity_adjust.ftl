<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>商品调价-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-bg">
    <#include "./common/navigation.ftl"/>

    <section class="ui-content">
        <div class="plist2 plist2-space">
            <ul>
            </ul>
        </div>
    </section>

    <#include "../common/footer.ftl"/>
    <script>

    var _global = {
        fn: {
            init: function() {
                this.pagesize = 0;
                this.bindEvent();
                this.loadmore();
                this.loading();
                navLight(1);
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
                    var $el = $(this),
                        input = $(this).prev()[0],
                        ipt = $(this).parent().find('.ipt')[0];

                    $(this).prop('disabled', true);
                    $.ajax({
                        type: 'post',
                        url: '/supplier/modCommodity',
                        data: {id: input.value, unwarehouse: (ipt.name=="unwarehouse"?ipt.value:null), price: (ipt.name=="price"?ipt.value:null)},
                        success: function(data) {
                            if(data.status == 200) {
                                popover('修改成功');
                            }
                        },
                        complete: function() {
                            $el.prop('disabled', false);
                        }
                    })

                })
            },
            loading: function() {
                var self = this,
                    $ul = $('.plist2').find('ul');

                $.ajax({
                    type: 'POST',
                    url: 'supplier/getCommodities',
                    dataType: 'json',
                    data: {pageNum: self.pagesize},
                    success: function(data){
                        if (!data.data) {
                            return;
                        }
                        var result = self.toHtml(data.data);
                        $ul.append(result);
                        if (data.data.length == 0) {
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
                    html.push('<div class="title">', data[i].categoryName, '</div>');
                    html.push('<div class="summary">');
                    html.push(data[i].spec);
                    html.push('</div>');
                    html.push('</div>');
                    html.push('<div class="pic">');
                    html.push('<img src="', data[i].thumbnailUrl, '" width="110" height="90" alt="">');
                    html.push('</div>');
                    html.push('<div class="edit">');
                    html.push('<div class="item">');
                    html.push('价格：<input type="text" name="price" class="ipt price" value="' + data[i].price + '">元/' + data[i].unitName);
                    html.push('<input type="hidden" value="', data[i].id, '">');
                    html.push('<button type="button" class="btn">修改</button>');
                    html.push('</div>');
                    html.push('<div class="item">');
                    html.push('库存：<input type="text" name="unwarehouse" class="ipt stock" value="' + data[i].unwarehouse + '">' + data[i].unitName);
                    html.push('<input type="hidden" value="', data[i].id, '">');
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