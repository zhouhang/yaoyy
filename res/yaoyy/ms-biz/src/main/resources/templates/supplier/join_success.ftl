<!DOCTYPE html>
<html lang="en">
<title>药优优-供应商注册成功</title>
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商注册成功</title>
    <link rel="stylesheet" href="${urls.getForLookupPath('/assets/css/supplier.css')}">
</head>
<body>
<div class="ui-content">
    <div class="qrcode">
        <span>恭喜您，您已经成功注册成为药优优供应商。我们近期会在药优优平台发布各大饮片厂的采购单，敬请您的关注！</span>
        <div class="button">
            <button type="button" class="ubtn ubtn-primary" onclick="location.href='/supplier/index'" id="submit">去供应商个人中心</button>
        </div>
    </div>
</div>

</body>

<#include "../common/footer.ftl"/>
</html>
