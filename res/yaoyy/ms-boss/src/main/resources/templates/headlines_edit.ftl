<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>编辑文章-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>资讯管理</li>
                <li>药商头条</li>
                <li>编辑头条</li>
            </ul>
        </div>

        <form action="" id="myform">
            <div class="box fa-form">
                <div class="item">
                    <div class="txt"><i>*</i>标题：</div>
                    <div class="cnt">
                        <input type="text" name="title" value="${(article.title)!}" class="ipt" placeholder="标题" autocomplete="off">
                        <input type="hidden" name="id" value="${(article.id)!}">
                    </div>
                </div>
                <div class="item">
                <div class="txt"><i>*</i>副标题：</div>
                <div class="cnt">
                    <input type="text" name="descript" value="${(article.descript)!}" class="ipt" placeholder="副标题" autocomplete="off">
                </div>
            </div>

                <div class="item">
                    <div class="txt"><i>*</i>标签：</div>
                    <div class="cnt">
                        <div class="his" id="his">
                            <#if tags?exists>
                                <#list tags as tag>
                            <a href="javascript:;">${tag.name}</a>
                                </#list>
                            </#if>
                        </div>
                        <input type="text" name="tagStr" id="tagStr" value="${(article.tagStr)!}" class="ipt" placeholder="请输入标签" autocomplete="off">
                        <span class="tips">多个标签用“,”隔开</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>基础阅读量：</div>
                    <div class="cnt">
                        <input type="text" name="hits" value="${(article.hits)!}" id="hits" class="ipt" placeholder="请输入基础阅读量" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>图片：</div>
                    <div class="cnt cnt-mul">
                        <div class="thumb up-img x4">
                            <#if article?exists>
                                <img src="${article.url!}"><i class="del"></i>
                            </#if>
                            <!--  -->
                        </div>
                        <input type="hidden" value="${(article.url)!}" name="url" id="imgUrl">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">
                        <i>*</i>公告内容：
                    </div>
                    <div class="cnt">
                        <script id="content" name="content" type="text/plain">
                        ${(article.content)!}
                        </script>
                        <span id="detailsError"></span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">状态：</div>
                    <div class="cnt">
                        <select name="status" id="status" class="slt">
                            <option value="0">草稿</option>
                            <option value="1">发布</option>
                        </select>
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

<script src="assets/js/croppic.min.js"></script>
<script src="assets/js/jquery.autocomplete.js"></script>

<script>
!(function($, window) {
    var _global = {
        init: function () {
            navLight('11-3');
            this.umeditor();
            this.validator();
            this.bindEvent();
            $("#status").val("${(article.status)!}")

            this.cropImg();
        },
        cropImg: function() {
            var self = this;

            // 删除图片
            $('.up-img').on('click', '.del', function() {
                var $self = $(this);
                layer.confirm('确认删除图片？', function(index){
                    $self.parent().empty().next(':hidden').val('');
                    layer.close(index);
                });
                return false;
            })


            // 缩略图
            $('.up-img').on('click', function() {
                if (isMobile) {
                    layer.msg('请在电脑上操作', {success: function() {$('body').removeClass('no-scroll');}});
                    return;
                }
                layer.open({
                    skin: 'layui-layer-molv',
                    area: ['500px'],
                    closeBtn: 1,
                    type: 1,
                    moveType: 1,
                    content: '<div class="img-upload-main"><div class="clip clip-x4" id="imgCrop"></div></div>',
                    title: '上传头条缩略图片',
                    cancel: function() {
                        self.cropModal.destroy();
                    }
                });
                self.croppic($(this));
            })
        },
        croppic: function($el) {
            var self = this;
            self.cropModal = new Croppic('imgCrop', {
                hideButton: true,
                uploadUrl:'/gen/upload',
                cropUrl:'/gen/clipping',
                onBeforeImgUpload: function() {
                    $('#imgCrop').find('.upimg-msg').remove();
                },
                onBeforeImgCrop: function() {
                    $('#imgCrop').append('<span class="upimg-msg">图片剪裁中...</span>');
                },
                onAfterImgCrop:function(response){
                    if (response.status && response.status === 'success') {
                        $el.html('<img src="' + response.url + '" /><i class="del" title="删除"></i>').next(':hidden').val(response.url).trigger('validate');
                        layer.closeAll();
                    }
                },
                onError:function(msg){
                    $('#imgCrop').append('<span class="upimg-msg">' + msg + '</span>');
                }
            });
        },
        bindEvent: function () {
            var that = this,
                    $tag = $('#tagStr'),
                    $table = $('.table');

            // 标签
            $('#his').on('click', 'a', function () {
                var val = $tag.val(),
                        text = $(this).html();

                if (val.indexOf(text) > -1) {
                    $.notify({
                        title: '标签已经填入，请勿重复添加',
                        delay: 3e3
                    })
                } else {
                    $tag.val(val === '' ? text : val + ', ' + text);
                }
            })
        },
        umeditor: function () {
            //实例化编辑器
            UM.getEditor('content', {
                initialFrameWidth: isMobile ? '100%' : 750,
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
                                title: '修改成功',
                                callback: function() {
                                    window.location.href = '/headlines/list';
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
                    tag: '标签: required',
                    hits: '基础阅读量: required',
                    descript:'副标题: required',
                    content: {
                        rule: '详细信息: required',
                        target: '#detailsError'
                    }
                },
                valid: function(form) {
                    that.enable && response('/headlines/save', $(form).serializeObject());
                }
            })
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>