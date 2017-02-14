<!DOCTYPE html>
<html lang="en">
<head>
    <title>报价单-药优优</title>
<#include "./common/meta.ftl"/>
</head>
<body class="ui-body body-gray">
<header class="ui-header">
    <div class="title">${(quotationVo.title)!}</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->
<#include "./common/navigation.ftl">

<section class="ui-content">
<#if quotationVo?exists>
    <div class="qoute">
        <!--
	    <div class="title">${(quotationVo.title)!}</div>
           -->
        <div class="item">
            <div class="text"> ${(quotationVo.description)!}</div>
        </div>
        <#assign content=quotationVo.content?eval />
        <div class="desc">
            <#list  content as data >
                <table>
                    <thead>
                    <tr><th colspan="3" class="cat">${data.categoryName}</th></tr>
                    <tr>
                        <#list data.attributes as attr >
                            <th>${attr}</th>
                        </#list>
                    </tr>
                    </thead>
                    <tbody>
                        <#list data.attrValues  as  attrValue>
                        <tr>
                            <#list attrValue.values as value>
                                <#if value_index==0>
                                    <td><a href="/commodity/detail/${attrValue.commdityId}">${value}</a></td>
                                <#else >
                                    <td><em>${value}</em></td>
                                </#if>
                            </#list>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            </#list>
        </div>
        <div class="hd">历史报价单</div>
        <div class="his">
            <ul>
                <#list historyVos as historyVo >
                    <li><a href="/quotation/detail/${historyVo.id}">${historyVo.title}&gt;&gt;</a></li>
                </#list>

                <li><a href="http://mp.weixin.qq.com/s/5z9URlzyn210PnHyrEjC8g">药优优简介</a></li>
            </ul>
        </div>
    </div>
    </div>
<#else>
    <div class="ui-notice ui-notice-extra">
        暂时没有报价单
        <br>
        <a class="ubtn ubtn-primary" href="/">返回首页</a>
    </div>
</#if>


<#if quoteFeedVos?exists>
    <div class="comment">
        <div class="hd"><span>评论</span></div>
        <div class="op"><button class="btn" id="write">写评论...</button></div>
        <#if quoteFeedVos?size!=0>
            <ul id="clist">
                <#list quoteFeedVos as feed>
                    <li>
                        <div class="avatar">
                            <#if feed.id%10!=0>
                                <img src="/assets/images/avatar/0${feed.id%10}.png" alt="">
                            <#else>
                                <img src="/assets/images/avatar/10.png" alt="">
                            </#if>
                        </div>
                        <div class="cnt">
                            <div class="uname">${feed.nickname?default('匿名用户')}</div>
                            <div class="words">${feed.content!}</div>
                        </div>
                    </li>
                </#list>
            </ul>
        <#else>
            <div class="words">暂时没有评论</div>
        </#if>



        <div class="ui-form ipt-wrap" id="commentWrap">
            <form action="" id="feedForm">
                <input type="hidden"  class="ipt" value="${(quotationVo.id)!}" name="qid">
                <input type="text" name="nickname" class="ipt" placeholder="您的昵称">
                <textarea name="words" id="msg" class="mul" cols="30" rows="10" placeholder="评论将显示在报价单下面，所有人可见"></textarea>
                <button type="submit" class="btn" id="submit">发表</button>
            </form>
        </div>
    </div>
</#if>

</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/dragloader.min.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                $("#newQuote").removeAttr("class");
            <#if quotationVo?exists>
                var timestamp= Date.parse(new Date('${(quotationVo.updateTime?datetime)!}'));
                udpateQuotetime(timestamp);
            </#if>
                this.comment();
                this.list();
            },
            comment: function() {
                var $comment = $('#commentWrap'),
                        $uname = $comment.find('.ipt'),
                        $words = $comment.find('.mul'),
                        $submit = $('#submit'),
                        flag = false;

                $('#write').on('click', function() {
                    $comment.addClass('slideInUp');
                    $uname.focus();
                    return false;
                })

                $comment.on('click', function() {
                    return false;
                })

                $('body').on('click', function() {
                    $comment.removeClass('slideInUp');
                })

                $words.on('keyup', function(){
                    flag = this.value != '';
                    if (flag) {
                        $submit.addClass('primary');
                    } else {
                        $submit.removeClass('primary');
                    }
                })

                $('#submit').on('click', function() {
                    var url="/quotation/feed";
                    if (flag) {
                        $.ajax({
                            url: url,
                            data: $("#feedForm").serialize()+"&content="+$("#msg").val(),
                            type: "POST",
                            success: function(data){
                                if (data.status == "200") {
                                    $comment.removeClass('slideInUp');
                                    window.location.reload();
                                }

                            }
                        });
                    }
                    return false;
                })
            },
            list: function() {
                var self = this;
                var pageNum = 2;
                var dragger = new DragLoader(document.body, {
                    disableDragDown: true,
                    dragUpLoadFn: function() {
                        $.ajax({
                            type: 'POST',
                            url: '/quotation/getFeed',
                            data: {qid:${(quotationVo.id)!},pageNum:pageNum, pageSize: 10},
                            dataType: 'json',
                            success: function(data){
                                if (data.data.pageNum<pageNum) {
                                    return;
                                }
                                var result = self.toHtml(data.data.list);
                                $('#clist').append(result);
                                pageNum ++;
                            },
                            error: function(xhr, type){
                                popover('网络连接超时，请您稍后重试!');
                            },
                            complete: function() {
                                dragger.reset();
                            }
                        });
                    },
                    dragUpDom: {
                        before : '继续上拉加载更多',
                        prepare : '释放加载',
                        load: '加载中...'
                    }
                });
                dragger.on('dragUpLoad', function() {
                    // dragger.reset();
                });
            },
            toHtml: function(data) {
                var model = [];

                $.each(data, function(i, item) {
                    var imgUrl="";
                    if(item.id%10==0){
                        imgUrl="/assets/images/avatar/10.png";
                    }else{
                        imgUrl="/assets/images/avatar/0"+item.id%10+".png";
                    }
                    model.push('<li>\n');
                    model.push(     '<div class="avatar"><img src="', imgUrl, '"></div>\n');
                    model.push(     '<div class="cnt">\n');
                    var nickname="";
                    if(item.nickname==undefined){
                        nickname="匿名用户";
                    }else{
                        nickname=item.nickname;
                    }

                    model.push(         '<div class="uname">',nickname , '</div>\n');
                    model.push(         '<div class="words">', item.content, '</div>\n');
                    model.push(     '</div>');
                    model.push('</li>');
                })
                return model.join('');
            }

        }
    }

    $(function(){
        _global.fn.init();

    });

</script>
<script>
    var weixinShare = {
        appId: '${signature.appid!}',
        title: '<#if quotationVo?exists>${(quotationVo.title)!} <#else> 药优优中药材报价单</#if>',
        desc: '亳州市场 <#list  content as data >${data.categoryName} </#list>报价..',
        link: '${signature.url!}',
        imgUrl: "${baseUrl}/assets/images/logo3.jpg",
        timestamp: ${signature.timestamp?string("#")},
        nonceStr: '${signature.noncestr!}',
        signature: '${signature.signature!}'
    }
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${urls.getForLookupPath('/assets/js/weixin_share.js')}"></script>
</body>
</html>
