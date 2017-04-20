<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>添加商品-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl"/>
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>商品管理</li>
                <li>商品新增</li>
            </ul>
        </div>

        <form id="myform">
            <div class="box fa-form">
                <div class="hd">基本信息</div>
                <div class="item">
                    <div class="txt"><i>*</i>品种：</div>
                    <div class="cnt">
                        <input type="text" name="categoryName" id="jcatname" class="ipt" placeholder="品种" autocomplete="off">
                        <input type="hidden" name="categoryId">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>商品名称：</div>
                    <div class="cnt">
                        <input type="text" name="name" id="name" class="ipt" placeholder="商品名称" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>规格等级：</div>
                    <div class="cnt">
                        <input type="text" name="spec" id="spec" class="ipt" placeholder="规格等级" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>产地：</div>
                    <div class="cnt">
                        <input type="text" name="origin" id="origin" class="ipt" placeholder="产地" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>标题：</div>
                    <div class="cnt">
                        <input type="text" name="title" id="title" class="ipt" placeholder="标题" autocomplete="off">
                    </div>
                </div>
                <div class="item" id="junitPrice">
                    <div class="txt"><i>*</i>价格：</div>
                    <div class="cnt">
                        <input type="text" name="price" class="ipt" id="jprice" placeholder="价格" autocomplete="off">
                        <span class="unit">元</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>单位：</div>
                    <div class="cnt">
                        <select id="unit" name="unit" class="slt">
                            <option value="1">吨</option>
                        </select>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>采收时间：</div>
                    <div class="cnt">
                        <input type="text" name="harYear" id="harYear" class="ipt" placeholder="采收时间(201703)" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>加工方式：</div>
                    <div class="cnt">
                        <input type="text" name="process" class="ipt"  placeholder="加工方式" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>性状特征：</div>
                    <div class="cnt">
                        <input type="text" name="exterior" class="ipt"  placeholder="性状特征" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>执行标准：</div>
                    <div class="cnt">
                        <input type="text" name="executiveStandard" class="ipt"  placeholder="执行标准" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">起购数量：</div>
                    <div class="cnt">
                        <input type="text" name="minimumQuantity" value="1" class="ipt" placeholder="起购数量" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">库存数量：</div>
                    <div class="cnt">
                        <input type="text" name="unwarehouse" value="0" class="ipt" placeholder="库存数量" autocomplete="off">
                        <span class="unit">公斤</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">商品标语：</div>
                    <div class="cnt">
                        <input type="text" name="slogan" class="ipt" placeholder="商品标语" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>绑定供应商：</div>
                    <div class="cnt">
                        <input type="text" name="supplier" id="supplier" class="ipt" placeholder="绑定供应商" autocomplete="off">
                        <input type="hidden" name="supplierId" id="supplierId">
                    </div>
                </div>
            </div>

            <div class="box fa-form">
                <div class="hd">商品属性</div>
                <div class="item">
                    <div class="cnt table">
                        <table class="tc">
                            <thead>
                                <tr>
                                    <th width="180">属性名</th>
                                    <th>属性值</th>
                                    <th width="60">操作</th>
                                </tr>
                            </thead>
                            <tbody id="attribute"></tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3"><a href="javascript:;" class="c-blue" id="addAttribute">+增加新属性</a></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="box fa-form">
                <div class="hd">商品图片与详情</div>
                <div class="item">
                    <div class="txt"><i>*</i>商品缩略图：</div>
                    <div class="cnt">
                        <span class="thumb up-img x4" id="jpic1"></span>
                        <input type="hidden" value="" name="thumbnailUrl" id="thumbnailUrl">
                        <span class="tips">图片尺寸：220 X 180</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>商品图片：</div>
                    <div class="cnt">
                        <span class="thumb up-img x3" id="jpic2"></span>
                        <input type="hidden" value="" name="pictureUrl" id="pictureUrl">
                        <span class="tips">图片尺寸：750 X 400</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">
                        <i>*</i>详细信息：
                    </div>
                    <div class="cnt">
                        <script id="detail" name="detail" type="text/plain"></script>
                        <span id="detailsError"></span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">排序：</div>
                    <div class="cnt">
                        <input type="text" name="sort" class="ipt" value="0" placeholder="数字越大越靠前" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">上/下架：</div>
                    <div class="cnt">
                        <select name="status" id="status" class="slt">
                            <option value="1">上架</option>
                            <option value="0">下架</option>
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

<script src="assets/js/croppic.min.js"></script>
<script src="assets/js/jquery.autocomplete.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>

<!-- 编辑器相关 -->
<link href="assets/plugins/umeditor/themes/default/css/umeditor.css" rel="stylesheet">
<script src="assets/plugins/umeditor/umeditor.config.js"></script>
<script src="assets/plugins/umeditor/umeditor.min.js"></script>
<script src="assets/plugins/umeditor/lang/zh-cn/zh-cn.js"></script>

<script>
    var _global = {
        v: {},
        fn: {
            init: function () {
                navLight('6-2');
                this.createTitle();
                this.umeditor();
                this.catname();
                this.myform();
                this.cropImg();
                this.parameter();
                this.supplier();
            },
            // 自动生成标题
            createTitle: function() {
                var $name = $('#name'),
                    $spec = $('#spec'),
                    $origin = $('#origin'),
                    $title = $('#title'),
                    $harYear = $('#harYear');
                
                var setTitle = function() {
                    var name = $name.val(),
                        spec = $spec.val(),
                        origin = $origin.val();

                    name && spec && origin && $title.val(name + ' ' + spec + ' ' + origin);
                }
                
                $name.on('blur', function() {
                    setTitle();
                })
                $spec.on('blur', function() {
                    setTitle();
                })
                $origin.on('blur', function() {
                    setTitle();
                })

                // 采收时间
                $harYear.on('keyup', function() {
                    if (/^\d{6}$/.test(this.value)) {
                        this.value = this.value.substr(0, 4) + '年' + this.value.substr(4, 2) + '月'
                    }
                })
            },
            umeditor: function() {
                //初始化详细信息
                var um = UM.getEditor('detail', {
                    initialFrameWidth: isMobile ? '100%' : 750,
                    initialFrameHeight: 320
                })
            },
            // 查询品种
            catname: function () {
                var $jcatname = $('#jcatname');

                $jcatname.autocomplete({
                    serviceUrl: '/category/search',
                    paramName: 'name',
                    deferRequestBy: 100,
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: '没有该品种',
                    transformResult: function (res) {
                        res = JSON.parse(res);
                        if (res.status == 200) {
                            return {
                                suggestions: $.map(res.data, function (dataItem) {
                                    return {value: dataItem.name, data: dataItem.id};
                                })
                            };
                        } else {
                            return {
                                suggestions: []
                            }
                        }
                    },
                    onSelect: function (suggestion) {
                        $jcatname.next().val(suggestion.data).trigger('hidemsg'); // 保存品种id到隐藏文本域
                    }
                });
            },
            myform: function () {
                var that = this;

                that.enable = true; // 防止重复提交
                // 单位
                $('#unit').code('UNIT');

                // 表单验证
                $("#myform").validator({
                    ignore: $('.edui-image-searchTxt'),
                    fields: {
                        categoryId: '品种: required',
                        name: '商品名称: required; length(1~20)',
                        title: '标题: required; length(1~50)',
                        price: '价格: required; range(1~9999)',
                        spec: '规格等级: required',
                        process: '加工方式: required',
                        exterior: '性状特征: required',
                        executiveStandard: '执行标准: required',
                        origin: '产地: required',
                        harYear: '采收时间: required',
                        thumbnailUrl: '商品缩略图: required',
                        pictureUrl: '商品图片: required',
                        minimumQuantity: '起购数量: range(0~9999)',
                        detail: {
                            rule: '商品详情: required',
                            target: '#detailsError'
                        },
                        supplierId: '绑定供应商: required'
                    },
                    valid: function () {
                        that.enable && that.submitForm();
                    }
                });


            },
            // 提交事件
            submitForm: function () {
                var that = this;
                var data = $('#myform').serializeObject();
                var attr = {};
                $('#attribute').find('tr').each(function(i) {
                    attr[$(this).find('.ipt').eq(0).val()] = $(this).find('.ipt').eq(1).val();
                })
                data.attribute = JSON.stringify(attr);
                data.mark = 0;
                $.ajax({
                    type: 'POST',
                    url: '/commodity/save',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    beforeSend: function() {
                        that.enable = false;
                    },
                    success: function(res) {
                        res.status == 200 && $.notify({
                            type: 'success',
                            title: '添加成功',
                            callback: function() {
                                location.href = '/commodity/list';
                            }
                        });
                    },
                    complete: function() {
                        that.enable = true;
                    }
                })
            },
            // 商品图片
            cropImg: function () {
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
                $('#jpic1').on('click', function () {
                    if (isMobile) {
                        layer.msg('请在电脑上操作', {success: function() {$('body').removeClass('no-scroll');}});
                        return;
                    }
                    layer.open({
                        skin: 'layui-layer-molv',
                        area: ['500px'],
                        closeBtn: 1,
                        type: 1,
                        content: '<div class="img-upload-main"><div class="clip clip-x4" id="imgCrop"></div></div>',
                        title: '上传商品缩略图片',
                        cancel: function() {
                            self.cropModal.destroy();
                        }
                    });
                    self.croppic($(this));
                })

                // 商品图
                $('#jpic2').on('click', function () {
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
                        title: '上传商品图片',
                        cancel: function() {
                            self.cropModal.destroy();
                        }
                    });

                    self.croppic($(this));
                })
            },
            croppic: function ($el) {
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
            // 商品自定义参数
            parameter: function () {
                var $table = $('#attribute'),
                    temp = '<tr> \n <td><div class="ipt-wrap"><input type="text" class="ipt" value="" autocomplete="off" data-rule="required;length[1~100]"></div></td> \n <td><div class="ipt-wrap"><input type="text" class="ipt" value="" autocomplete="off" data-rule="required;length[1~100]"></div></td> \n <td><button class="ubtn ubtn-red">删除</button></td> \n </tr>';

                // 新增
                $('#addAttribute').on('click', function () {
                    $table.append(temp);
                })

                // 删除
                $table.on('click', '.ubtn-red', function () {
                    $(this).closest('tr').remove();
                })
            },
            supplier: function () {
                var $supplier = $('#supplier');
                $supplier.autocomplete({
                    serviceUrl: '/supplier/search',
                    type: 'post',
                    paramName: 'name',
                    deferRequestBy: 300,
                    dataType: 'json',
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: '未查询到供应商，请重新输入',
                    transformResult: function (res) {
                        var data = [];
                        res.data && $.each(res.data, function(key, item) {
                            data.push({value: item.name + ' ' + item.phone + ' ' + item.position, id: item.id, name: item.name});
                        })
                        return {
                            suggestions: data
                        }
                    },
                    onSelect: function (suggestion) {
                        $supplier.val(suggestion.name).next().val(suggestion.id).trigger('hidemsg'); // 保存供应商id到隐藏文本域
                    }
                });
            }
        }
    }

    $(function () {
        _global.fn.init();
    })
</script>

</body>
</html>