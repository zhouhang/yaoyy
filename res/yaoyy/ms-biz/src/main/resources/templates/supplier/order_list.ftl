<!DOCTYPE html>
<html lang="en">
<head>
    <#include "../common/meta.ftl"/>
        <title>订单列表-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
<#include "./common/navigation.ftl"/>
<div class="ui-content">
    <div class="plist2 plist2-space">
        <ul>
        </ul>
    </div>
</div>
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/dragloader.min.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.pageNum = 1;
                this.loadmore();
                this.loading();
                navLight(2);
            },
            loading: function() {
                var self = this,
                        $ul = $('.plist2').find('ul');

                $.ajax({
                    type: 'POST',
                    url: '/supplier/order',
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
                        self.pageNum ++;
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
                    html.push('<a href="supplier/detail/'+item.id+'">');
                    html.push('<div class="hd">');
                    html.push('<div class="row">');
                    var jimai = "";
                    if (item.userId == 1) {
                        jimai = "寄卖下单";
                    }
                    html.push('<b class="fr">',item.userBusinessTypeName,"：", item.userName,jimai,'</b>');
                    html.push('<b>订单号：', item.code, '</b>');
                    html.push('</div>');
                    html.push('<div class="row">');
                    html.push('<time class="fr">', _YYY.timeago.elapsedTime(item.createTime), '</time>');
                    html.push('<b>状    态：<em>',item.statusText, '</em></b>');
                    html.push('</div>');
                    html.push('</div>');
                    html.push('<div class="bd">');

                    $.each(item.pickCommodityVoList, function(j, commodity) {
                        html.push('<div class="row">');
                        html.push('<i>', commodity.num ,commodity.unit, '</i>');
                        html.push('<strong>', commodity.name, '</strong><span>', commodity.spec, '</span>');
                        html.push('</div>');
                    })

                    html.push('</div>');
                    html.push('<div class="hd">');
                    html.push('<div class="row">');
                    html.push('<span>商品总价：<i>¥', item.sum?item.sum:0, '</i> 元</span>');

                    if (item.amountsPayable != 0 && item.amountsPayable) {
                        html.push('<span>运费：<i>¥', item.shippingCosts?item.shippingCosts:0, '</i> 元</span>');
                        html.push('</div>');
                        html.push('<div class="row">');
                        html.push('<span>包装人工费：<i>¥', item.bagging?item.bagging:0, '</i> 元</span>');
                        html.push('<span>税费：<i>¥', item.taxation?item.taxation:0, '</i> 元</span>');
                    }

                    html.push('</div>');
                    html.push('</div>');

                    if (item.amountsPayable != 0 && item.amountsPayable) {
                        html.push('<div class="tf">');
                        html.push('<strong>订单金额：<i>¥', item.amountsPayable?item.amountsPayable:0, '</i> 元</strong>');
                        html.push('<span>付款方式：', item.settleTypeName, ' </span>');
                        if (item.settleType == 2 && item.billTimeLeft) {
                            html.push('<span>账期时间：', item.billTime, '天 剩余：',item.billTimeLeft,'</span>');
                        }
                        html.push('</div>');
                    }

                    html.push('</a>');
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