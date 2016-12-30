<!DOCTYPE html>
<html lang="en">
<head>
    <title>报价单-药优优</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body">
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
           <div class="item">
              <div class="desc"> ${(quotationVo.description)!}</div>
            </div>
        <#assign content=quotationVo.content?eval />
        <div class="item">
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
            <div class="his">
                <h3>历史报价单</h3>
                <ul>
                    <#list historyVos as historyVo >
                        <li><a href="/quotation/detail/${historyVo.id}">${historyVo.title}</a></li>
                    </#list>
                </ul>
            </div>
        </div>
        <#else>
        <div class="ui-notice ui-notice-extra">
           暂时没有报价单
            <br>
            <a class="ubtn ubtn-primary" href="/">返回首页</a>
        </div>
        </#if>


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
            }
        }
    }

    $(function(){
        _global.fn.init();

    });

</script>
</body>
</html>