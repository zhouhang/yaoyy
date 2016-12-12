<!DOCTYPE html>
<html lang="en">
  <head>
    <title>药优优系统微信绑定成功</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot body-gray">
    <header class="ui-header">
        <div class="title">药优优系统微信绑定成功</div>
        <div class="abs-l mid">
            <a href="javascript:history.back();" class="fa fa-back"></a>
        </div>
    </header><!-- /ui-header -->

    <section class="ui-content">
        <div class="ui-notice ui-notice-extra">
            系统用户【${(memberName)!}】，恭喜您！您的账号成功与微信绑定，现在可以用微信接收系统消息了！
            <a class="ubtn ubtn-primary" href='/'>关闭</a>
        </div>
    </section><!-- /ui-content -->

    <#include "./common/footer.ftl"/>
</body>
</html>