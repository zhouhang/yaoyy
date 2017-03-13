<!DOCTYPE html>
<html lang="en">
<title>登入-药优优</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商登录-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body class="body-gray">
<#include "./common/navigation.ftl"/>
<div class="ui-content">
       <div class="umenu2">
            <ul>
                <li>
                    <a href="/supplier/adjust">
                        <em>${(commodities?c)!}</em>
                        <span>上架商品</span>
                    </a>
                </li>
                <li>
                    <a href="/supplier/order">
                        <em>${(picks?c)!}</em>
                        <span>订单记录</span>
                    </a>
                </li>
                <li>
                    <a href="/message/list">
                        <em>${(mynews?c)!}</em>
                        <span>我的消息</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="floor">
            <div class="hd ico-notice">网站公告</div>
            <div class="bd">
                <ul class="list">
                    <#list announcementVos as announcementVo>
                    <li><time>${announcementVo.createTime?datetime}</time><a href="/announcement/detail/${announcementVo.id}">${announcementVo.title}</a></li>
                    </#list>
                </ul>
            </div>
            <div class="more">
                <a href="/announcement/list" class="ico-arrow-r">查看更多</a>
            </div>
        </div>

        <div class="floor">
            <div class="hd ico-news">我的消息</div>
            <div class="bd">
                <ul id="news">
                    <#if messageVos??>
                    <#list messageVos as messageVo>
                    <li>
                        <span>${messageVo.content!}</span>
                        <em class="e${messageVo.type!}">${messageVo.typeName!}</em>
                        <time data-time="${messageVo.createTime?datetime}"></time>
                    </li>
                    </#list>
                    </#if>
                </ul>
            </div>
            <div class="more">
                <a href="/message/list" class="ico-arrow-r">查看更多</a>
            </div>
        </div>
</div>
<#include "../common/footer.ftl"/>
<script src="${urls.getForLookupPath('/assets/js/layer.js')}"></script>
<script>

    var _global = {
        fn: {
            init: function() {
                this.timeago();
                navLight(0);
            },
            timeago: function() {
                $('#news').find('time').each(function() {
                    var date = $(this).data('time');
                    date && $(this).html(_YYY.timeago.elapsedTime(date));
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