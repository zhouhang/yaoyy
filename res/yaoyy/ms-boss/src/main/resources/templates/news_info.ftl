<!DOCTYPE html>
<html lang="en">
<head>
	<#include "./common/meta.ftl"/>
    <title>新闻公告详情-药优优</title>
</head>
<body>

<div class="wrapper">
	<#include "./common/header.ftl"/>
	<#include "./common/aside.ftl"/>
	<div class="content">
		<div class="breadcrumb">
			<ul>
                <li>资讯管理</li>
                <li>网站公告</li>
    		</ul>
		</div>
		
		<form action="/news/" id="myform">
			<div class="box fa-form">
				<div class="item">
					<div class="txt"><i>*</i>标题：</div>
					<div class="cnt">
						<input type="text" name="title" class="ipt" placeholder="标题" autocomplete="off" value="<#if announcementVo??>${announcementVo.title?default('')}</#if>">
					</div>
				</div>
				<div class="item">
					<div class="txt">发布对象：</div>
					<div class="cnt">
                        <select id="userType" name="userType" class="slt">
							<option value="0" <#if announcementVo?? && announcementVo.userType==0>selected</#if>>全体用户</option>
							<option value="1" <#if announcementVo?? && announcementVo.userType==1>selected</#if>>供应商</option>
							<option value="2" <#if announcementVo?? && announcementVo.userType==2>selected</#if>>用户</option>
						</select>
					</div>
				</div>
                <div class="item">
                    <div class="txt">
                        公告内容：
                    </div>
                    <div class="cnt cnt-mul">
                        <script id="content" name="content" type="text/plain"><#if announcementVo??>${announcementVo.content?default('')}</#if></script>
                    </div>
                </div>
				<div class="ft">
                    <input type="hidden" name="id" value="<#if announcementVo??>${announcementVo.id!}</#if>">
					<button type="submit" class="ubtn ubtn-blue" id="jsubmit">发布</button>
				</div>
			</div>
		</form>
	</div>


<#include "./common/footer.ftl"/>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<!-- 编辑器相关 -->
<link href="assets/plugins/umeditor/themes/default/css/umeditor.css" rel="stylesheet">
<script src="assets/plugins/umeditor/umeditor.config.js"></script>
<script src="assets/plugins/umeditor/umeditor.min.js"></script>
<script src="assets/plugins/umeditor/lang/zh-cn/zh-cn.js"></script>
<script>
	var _global = {
		v: {
			deleteUrl: ''
		},
		fn: {
			init: function() {
                this.umeditor();
                this.validator();
			},
            umeditor: function() {
                //初始化详细信息
                var um = UM.getEditor('content', {
                    initialFrameWidth: isMobile ? '100%' : 700,
                    initialFrameHeight: 320
                })
            },
            validator: function() {
            	// 表单验证
                $("#myform").validator({
                    fields: {
                    	title: '标题: required'
                    },
                    valid: function () {
                        //self.submitForm();
                        var data = $('#myform').serializeObject();

                        $("#jsubmit").prop("disabled", true);
                        $.ajaxSetup({
                            contentType: 'application/json'
                        });
                        $.post("/announcement/save", JSON.stringify(data), function (data) {
                            if (data.result.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '添加成功',
                                    callback: function() {
                                        location.href = '/announcement/list';
                                    }
                                });
                            }
                            $("#jsubmit").prop("disabled", false);
                        })
                    }
                });
            },
            // 提交事件
            submitForm: function () {

            },
		}
	}

	$(function() {
		_global.fn.init();
	})
</script>
</body>
</html>