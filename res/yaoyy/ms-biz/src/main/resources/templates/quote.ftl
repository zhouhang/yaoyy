<!DOCTYPE html>
<html lang="en">
<head>
    <title>报价单-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body body-gray">
<header class="ui-header">
    <div class="title">药优优中药材报价单</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->
<#include "./common/navigation.ftl">

<section class="ui-content">
        <#if quotationVo?exists>
            <div class="qoute">
            <div class="title">${(quotationVo.title)!}</div>

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
                <div class="item">
                    <div class="desc"> ${(quotationVo.description)!}</div>
                </div>
                <div class="hd">历史报价单</div>
                <div class="his">
                <ul>
                    <#list historyVos as historyVo >
                        <li><a href="/quotation/detail/${historyVo.id}">${historyVo.title}&gt;&gt;</a></li>
                    </#list>
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
            <div class="comment">
                <div class="hd"><span>评论</span></div>
                <div class="op"><button class="btn" id="write">写评论...</button></div>
                <#if quoteFeedVos?size!=0>
                <ul>
                    <#list quoteFeedVos as feed>
                    <li>
                        <div class="avatar">
                            <img src="uploads/avatar.jpg" alt="">
                        </div>
                        <div class="cnt">
                            <div class="uname">${feed.nickname?default("匿名用户")}</div>
                            <div class="words">${feed.content!}</div>
                        </div>
                    </li>
                    </#list>
                </ul>
                <#else>
                    <div class="words">暂时没有评论</div>
                </#if>


                <div class="ui-form ipt-wrap" id="commentWrap">
                    <form action="">
                        <input type="text" name="uname" class="ipt" placeholder="您的昵称">
                        <textarea name="words" id="msg" class="mul" cols="30" rows="10" placeholder="评论将显示在报价单下面，所有人可见"></textarea>
                        <button type="submit" class="btn" id="submit">发表</button>
                    </form>
                </div>
            </div>

</section><!-- /ui-content -->

<#include "./common/footer.ftl"/>
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
                    if (flag) {
                        alert(9);
                    }
                    return false;
                })
            }
        }
    }

    $(function(){
        _global.fn.init();

    });

</script>
</body>
</html>