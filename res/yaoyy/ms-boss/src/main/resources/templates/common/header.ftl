<div class="header">
    <div class="logo">
        <a href="index.html">药优优</a>
    </div>
    <div class="menu">
        <ul>
            <li>
                <div class="">
                    <a id="msg_count" href="javascript:;"> <i class="fa fa-envelope"></i> 消息 <sup>4</sup></a>
                </div>
                <div id="msg_list" class="dropdown">
                </div>
            </li>
            <li>
                <a href="javascript:;" class="dropdown-toggle"> <i class="fa fa-question-circle"></i> 帮助 </a>
            </li>
            <li>
                <div class="">
                    <a href="javascript:;"> <i class="fa fa-user"></i><span class="hidden-xs">${(member_session_boss.username)!}</span></a>
                </div>
                <div class="dropdown">
                    <a href="javascript:;" id="jmodifyPwd">修改密码</a>
                </div>
            </li>
            <li>
                <a href="/logout">
                    <i class="fa fa-power-off"></i>
                    退出
                </a>
            </li>
        </ul>
    </div>
    <script>
        $(function() {
            $.post("/msg/list", function (result) {
                if (result.status == 200) {
                    var data = result.data;
                    var html = "";
                    $.each(data.list,function(k,v){
                        html += '<a href="'+ v.url+'">'+v.content+'</a>';
                    })
                    $("#msg_list").html(html);
                    $("#msg_count").find("sup").html(data.count).css(data.count == 0?"none":"inline-block");
                }
            })
        })
    </script>
</div>