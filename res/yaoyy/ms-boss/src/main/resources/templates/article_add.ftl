<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>新增文章-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>CMS管理</li>
                <li>新增文章</li>
            </ul>
        </div>

        <form action="" id="myform">
            <div class="box fa-form">
                <div class="item">
                    <div class="txt"><i>*</i>标题：</div>
                    <div class="cnt">
                        <input type="text" name="title" class="ipt" placeholder="标题" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">
                        <i>*</i>详细信息：
                    </div>
                    <div class="cnt cnt-mul">
                        <script id="content" name="content" type="text/plain"></script>
                        <span id="detailsError"></span>
                    </div>
                </div>
                <div class="ft">
                    <button type="submit" class="ubtn ubtn-blue" id="jsubmit">保存</button>
                </div>
            </div>
        </form>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<script src="/assets/plugins/validator/jquery.validator.min.js"></script>
<!-- 编辑器相关 -->
<link href="/assets/plugins/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="/assets/plugins/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/assets/plugins/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="/assets/plugins/umeditor/lang/zh-cn/zh-cn.js"></script>
<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('2-1');
            this.umeditor();
            this.validator();
        },
        umeditor: function() {
            //实例化编辑器
            UM.getEditor('content', {
                initialFrameWidth: isMobile ? '100%' : 700,
                initialFrameHeight: 320
            })
        },
        validator: function() {
            var that = this,
                $myform = $('#myform');

            that.enable = true; // 防止重复提交

            var response = function(url, data) {
                $.ajax({
                    type: 'POST',
                    url: url,
                    dataType: 'json',
                    data: data || {},
                    beforeSend: function() {
                        that.enable = false;
                    },
                    success: function(data) {
                        if (data.status == 200) {
                            $.notify({
                                type: 'success',
                                title: '添加成功',
                                callback: function() {
                                    window.location.href = '/cms/list';
                                }
                            });
                        }
                    },
                    error: function() {
                        that.enable = true;
                    }
                })
            }

            // 表单验证
            $myform.validator({
                fields: {
                    title: '标题: required',
                    content: {
                        rule: '详细信息: required',
                        target: '#detailsError'
                    }
                },
                valid: function(form) {
                    that.enable && response('/cms/save', $(form).serializeObject());
                }
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>