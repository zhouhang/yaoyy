<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "./common/meta.ftl"/>
    <title>品种列表-药优优</title>
</head>
<body class="ui-body body-gray">
    <header class="ui-header">
        <div class="title">品种列表</div>
        <div class="abs-l mid">
            <a href="javascript:history.back();" class="fa fa-back"></a>
        </div>
        <div class="abs-r mid search">
            <form>
                <input type="text" name="keyword" value="" class="ipt" />
                <button type="button" id="search" class="fa fa-search mid submit"></button>
            </form>
        </div>
    </header><!-- /ui-header -->

    <#include "./common/navigation.ftl">

    <section class="ui-content">
        <div class="plist">
            <dl class="side">
                <dd>品种列表</dd>
                <#if categoryVos??>
                <#list categoryVos as categoryVo>
                <dd <#if categoryId?? && categoryId == categoryVo.id>class="curr"</#if>><a href="javascript;" data-id="${categoryVo.id}">${categoryVo.name!}</a></dd>
                </#list>
                </#if>
            </dl>
            <input type="hidden" name="categoryId" value="${categoryId!}"/>
            <ul id="categoryList">
            </ul>
        </div>
    </section><!-- /ui-content -->

    <#include "./common/footer.ftl"/>
    <script>

    var _global = {
        fn: {
            init: function() {
                this.bindEvent();
                this.loadPlist();
            },
            bindEvent: function() {
                var self = this;

                $side = $('.side').on('click', 'a', function() {
                    var categoryId = $(this).attr("data-id");
                    var parameter = {categoryId: categoryId};
                    $(this).parent().addClass('curr').siblings().removeClass('curr');
                    $("#categoryList").empty();
                    $("input[name=keyword]").val("");
                    $("input[name=categoryId]").val(categoryId);
                    self.getData(parameter);
                    return false;
                })

            },
            loadPlist: function() {
                var self = this;
                self.pageNum = 1; // 当前页

                $('.ui-content').dropload({
                    scrollArea : window,
                    threshold : 50,
                    loadDownFn : function(me){
                        self.getData({pageNum:self.pageNum, categoryId: $("input[name=categoryId]").val(), keyword:$("input[name=keyword]").val()}, me);
                    }
                });
                //self.getData({pageNum:self.pageNum, categoryId: $("input[name=categoryId]").val(), keyword:$("input[name=keyword]").val()});
            },
            getData: function(parameter, me) {
                var self = this;
                $.ajax({
                    type: 'POST',
                    url: 'commodity/list',
                    dataType: 'json',
                    data: parameter,
                    success: function(data){
                        var list=data.data.list;
                        if (!list) {
                            return false;
                        }
                        self.toHtml(list);
                        if(data.data.isLastPage){
                            me && me.lock();
                            me && me.noData();
                            me && me.resetload();
                            return;
                        }
                        setTimeout(function(){
                            self.pageNum ++;
                            me && me.resetload();
                        }, 1e3);
                    },
                    error: function(xhr, type){
                        popover('网络连接超时，请您稍后重试!');
                        me && me.resetload();
                    }
                });
            },
            toHtml: function(data) {
                var html = [];
                $.each(data, function(i, item) {
                    html.push('<li>\n');
                    html.push( '<a href="/commodity/detail/' + data[i].id + '">\n');
                    html.push(     '<div class="cnt">\n');
                    html.push(         '<div class="title">', data[i].name, '</div>\n');
                    html.push(         '<div class="summary">', data[i].title, '</div>\n');
                    html.push(         '<div class="price">\n');
                    html.push(              '<i>&yen;</i>\n');
                    html.push(              '<em>', data[i].price, '</em>\n');
                    html.push(              '<b>', data[i].unitName, '</b>\n');
                    html.push(          '</div>\n');
                    html.push(     '</div>');
                    html.push(     '<div class="pic"><img src="', data[i].thumbnailUrl, '" width="110" height="90" alt="', data[i].title, '"></div>\n');
                    html.push( '</a>\n');
                    html.push('</li>');
                })
                $('#categoryList').append(html.join(''));
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

        $("#search").click(function(){
            var keyword = $("input[name=keyword]").val();
            $("#categoryList").empty();
            $("input[name=categoryId]").attr("value","");
            _global.fn.getData({keyword: keyword});
            return false;
        });

        $("form").submit(function(e){
            $('#search').trigger("click");
            return false;
        });

    });

</script>
</body>
</html>