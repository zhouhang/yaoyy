<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>专场详情-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>


    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>专场广告</li>
                <li>专场详情</li>
            </ul>
        </div>

        <form action="special/save" id="myform" method="post">
            <input type="hidden"  class="ipt" value="${special.id?default('')}" name="id" id="cId">
            <div class="box fa-form">
                <div class="item">
                    <div class="txt"><i>*</i>标题：</div>
                    <div class="cnt">
                        <input type="text" name="title" value="${special.title?default('')}" class="ipt" placeholder="标题" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>专场图片：</div>
                    <div class="cnt">
                        <div class="thumb up-img x3">
                            <#if special.pictuerUrl??>
                                <img src="${special.pictuerUrl?default('')}" /><i class="del"></i>
                            </#if>
                            <!-- <img src="images/blank.gif"><i class="del"></i> -->
                        </div>
                        <input type="hidden" value="${special.pictuerUrl?default('')}" name="pictuerUrl" id="pictuerUrl">
                        <span class="tips">图片尺寸：750 X 400</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>添加商品：</div>
                    <div class="cnt">
                        <div class="choose" id="chooseGoods">
                          <#if commodities??>
                            <#list commodities as commodity>
                                <span>${commodity.name}  ${commodity.spec}<i data-id="${commodity.id}"></i></span>
                            </#list>
                          </#if>
                        </div>
                        <input type="text" name="search" id="searchGoods" class="ipt" placeholder="商品名称" autocomplete="off">
                        <input type="hidden" name="commodities" id="goodsName" value="${ids?default('')}">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">排序：</div>
                    <div class="cnt">
                        <input type="text" value="${special.sort?default('')}" name="sort" class="ipt" placeholder="数字越大越靠前" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">上/下架：</div>
                    <div class="cnt">
                        <select name="status" id="status" class="slt">
                            <option value="1"<#if special.status??&&special.status==1 >selected</#if>>上架</option>
                            <option value="0" <#if special.status??&&special.status==0 >selected</#if>>下架</option>
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

<script src="assets/js/jquery.autocomplete.js"></script>
<script src="assets/js/croppic.min.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        v: {
            searchComodityUrl:'commodity/search',
            saveUrl:'special/save'
        },
        fn: {
            init: function() {
                navLight('1-1');
                this.cropImg();
                this.validator();
                this.searchGoods();
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

                // 图片裁剪弹层框
                $('.up-img').on('click', function() {
                    if (isMobile) {
                        layer.msg('请在电脑上操作', {success: function() {$('body').removeClass('no-scroll');}});
                        return;
                    }
                    layer.open({
                        skin: 'layui-layer-molv',
                        area: ['810px'],
                        closeBtn: 1,
                        type: 1,
                        content: '<div class="img-upload-main"><div class="clip clip-x3" id="imgCrop"></div></div>',
                        title: '上传专场图片',
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
                    uploadUrl: '/gen/upload',
                    cropUrl: '/gen/clipping',
                    onBeforeImgUpload: function() {
                        $('#imgCrop').find('.upimg-msg').remove();
                    },
                    onBeforeImgCrop: function() {
                        $('#imgCrop').append('<span class="upimg-msg">图片剪裁中...</span>');
                    },
                    onAfterImgCrop:function(response){ 
                        $el.html('<img src="' + response.url + '" /><i class="del" title="删除"></i>').next(':hidden').val(response.url).trigger('validate');
                        layer.closeAll();
                    },
                    onError:function(msg){
                        $('#imgCrop').append('<span class="upimg-msg">' + msg + '</span>');
                    }
                });
            },
            validator: function() {
                var that = this;
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
                                window.location.href = 'special/list';
                            }
                        },
                        complete: function() {
                            that.enable = true;
                        }
                    })
                }

                // 表单验证
                $("#myform").validator({
                    fields: {
                        title: '标题: required',
                        pictuerUrl: '专场图片: required',
                        commodities: '商品: required'
                    },
                    valid: function(form) {
                        that.enable && response(_global.v.saveUrl, $(form).serializeObject());
                        return false;
                    }
                });
            },
            // 查询商品
            searchGoods: function() {

                var that = this,
                    vals = [${ids?default('')}],
                    $searchGoods = $('#searchGoods'),
                    $chooseGoods = $('#chooseGoods'),
                    $goodsName = $('#goodsName');

                $searchGoods.autocomplete({
                    serviceUrl: _global.v.searchComodityUrl,
                    type: 'POST',
                    paramName: 'name',
                    deferRequestBy: 300,
                    dataType: 'json',
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: '未查询到商品，请重新输入',
                    width: '550px',
                    transformResult: function (res) {
                        var data = [];
                        res.data && $.each(res.data, function(key, item) {
                            if (!that.inArray(item.id, vals)) {
                                data.push({value: item.name + ' ' + item.spec + ' (￥' + item.price + ')', id: item.id, name: item.name + item.spec});
                            }
                        })
                        return {
                            suggestions: data
                        }
                    },
                    onSelect: function (suggestion) {
                        vals.push(suggestion.id);
                        $chooseGoods.show().append('<span>' + suggestion.name + '<i data-id="' + suggestion.id + '"></i></span>');
                        $goodsName.val(vals.join(','));
                        $searchGoods.val('');
                    }
                });

                // 删除商品
                $chooseGoods.on('click', 'i', function() {
                    var id = $(this).data('id');
                    $(this).parent().remove();
                    that.inArray(id, vals, true);
                    $goodsName.val(vals.join(','));
                })
            },
            /**
             * [inArray 查询数组元素]
             * @param  {[string]} needle [查询值]
             * @param  {[Array]} array  [查询数组]
             * @param  {[bollen]} del    [选填，为true时删除该值]
             * @return {[bollen]}        [true or false]
             */
            inArray: function(needle, array, del) {
                if (typeof needle == 'string' || typeof needle == 'number') {
                    for (var i in array) {
                        if (array[i] == needle) {
                            del && array.splice(i, 1);
                            return true;
                        }
                    }
                }
                return false;
            }
        }
    }

    $(function() {
        _global.fn.init();
    })
</script>
</body>
</html>