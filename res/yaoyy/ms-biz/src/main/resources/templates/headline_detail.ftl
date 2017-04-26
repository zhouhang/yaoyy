<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>${article.title!}-药优优</title>
</head>
<body class="body2">
<section class="ui-content">
    <div class="news2">
        <h1>${article.title!}</h1>
        <div class="time tc">
            <span>阅读数：${article.hits}</span>
            <time>${article.createTime?datetime}</time>
        <#list article.tagStr?split(",") as tag>
            <span class="ui-tag"> ${tag!}</span>
        </#list>
        </div>
        <div class="text">
            ${article.content!}
        </div>
    </div>

</section>
<footer class="ui-copyright">
    <p>亳州市东方康元中药材信息咨询有限公司</p>
    <p>版权所有 2016-2017</p>
</footer>
</body>
</html>