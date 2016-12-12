<!DOCTYPE html>
<html lang="en">
<head>
    <title>药优优系统微信绑定</title>
    <#include "./common/meta.ftl"/>
</head>
<body class="ui-body-nofoot">
<header class="ui-header">
    <div class="title">药优优系统微信绑定</div>
    <div class="abs-l mid">
        <a href="javascript:history.back();" class="fa fa-back"></a>
    </div>
</header><!-- /ui-header -->

<div class="ui-content">
    <div class="ui-notice">
        绑定微信后可以通过微信实时接收系统消息！绑定失败请咨询qq:327075297
    </div>
    <div class="ui-form">
        <form id="bindForm"action="">
            <input type="hidden" name="openId" value="${openId!}">
            <input type="hidden" name="memberId" value="${memberId!}">
            <div class="weinxin">
                <span>微信号：</span>
                <img src="${headImgUrl!}" width="30" height="30" alt="">
                <em>${nickname!}</em>
            </div>
            <div class="weinxin">
                <span>微信号：</span>
                <em>${nickname!}</em>
            </div>
            <div class="weinxin">
                <span>姓&#12288;名：</span>
                <em>${memberName!}</em>
            </div>
            <div class="item">
                <button type="button" class="ubtn ubtn-primary" id="submit">绑定</button>
            </div>
        </form>
    </div>
</div>
<#include "./common/footer.ftl"/>
<script>

    var _global = {
        fn: {
            init: function() {
                this.formInit();
            },
            formInit: function() {
              $("#submit").click(function(){
                  $.ajax({
                      url: "/wechat/memberBind",
                      type:'POST',
                      dataType: 'json',
                      data: $("#bindForm").serialize(),
                      success: function(data) {
                          if (data.status == '200') {
                              location.href="/wechat/bindsuccess?memberId="+data.data;
                          } else {
                              popover(data.msg);
                          }
                      },
                      error: function(XMLHttpRequest, textStatus, errorThrown) {
                          popover('网络连接超时，请您稍后重试!');
                      }
                  })
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