<!DOCTYPE html>
<html lang="en">
<head>
    <#include "./common/meta.ftl"/>
    <title>文章详情-药优优</title>
</head>
<body class="body2">
<header class="ui-header">
    <div class="title">${article.title}</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="ico ico-back"></a>
    </div>
</header><!-- /ui-header -->


<section class="ui-content">
    <div class="article">
        ${article.content}
    </div>
</section><!-- /ui-content -->
</body>
</html>