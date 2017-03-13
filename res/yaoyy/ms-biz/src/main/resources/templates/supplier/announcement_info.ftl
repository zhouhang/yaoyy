<!DOCTYPE html>
<html lang="en">
  <head>
    <#include "../common/meta.ftl"/>
    <title>网站公告-药优优</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
    <#include "./common/navigation.ftl"/>
    <div class="ui-content">
        <div class="news">
            <ul>
                <li style="border:0;">
                    <h3 class="title">${announcement.title!}</h3>
                    <time>${announcement.createTime?datetime}</time>
                    <div class="summary">
                    ${announcement.content!}
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <#include "../common/footer.ftl"/>

</body>
</html>