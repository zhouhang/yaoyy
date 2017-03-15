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
                        <button type="button" class="ubtn ubtn-blue" id="createTitle">生成标题</button>
                    </div>
                </div>
                <div class="item" id="junitPrice">
                    <div class="txt"><i>*</i>价格：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" name="price" class="ipt" id="jprice" placeholder="价格" autocomplete="off">
                            <span class="unit">元</span>
                        </div>
                        <#--<label class="ml"><input type="checkbox" name="mark" class="cbx" id="jsales">量大价优</label>-->
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
                <div class="item hide" id="jsalesPrice">
                    <div class="txt"><i>*</i>公斤/价格：</div>
                    <div class="cnt">
                        <div class="ipt-wrap">
                            <input type="text" name="minKg1" class="ipt ipt-short" placeholder="1-99999"
                                   data-rule="required; range(1~99999)" autocomplete="off">
                        </div>
                        <em>-</em>
                        <div class="ipt-wrap">
                            <input type="text" name="maxKg1" class="ipt ipt-short" placeholder="1-99999"
                                   data-rule="required; range(1~99999)" autocomplete="off">
                        </div>
                        <em name="unitD"></em>
                        <div class="ipt-wrap ml">
                            <input type="text" name="price1" class="ipt ipt-short" placeholder="1-9999"
                                   data-rule="required; range(1~9999)" autocomplete="off">
                            <span class="unit">元</span>
                        </div>
                        <button type="button" class="ubtn ubtn-blue ml" id="jaddNewPrice">添加一行</button>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>采收时间：</div>
                    <div class="cnt">
                        <input type="text" name="harYear" class="ipt" placeholder="采收时间" autocomplete="off">
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
                        <div class="cnt-table hide" id="supplierSuggestions">
                            <table class="suggestions">
                                <thead>
                                <tr>
                                    <th>姓名</th>
                                    <th>手机</th>
                                    <th>地区</th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="box fa-form">
                <div class="hd">商品属性</div>
                <div class="table">
                    <table id="attribute">
                        <thead>
                            <tr>
                                <th width="180">属性名</th>
                                <th>属性值</th>
                                <th width="80">操作</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="3"><a href="javascript:;" class="c-blue" id="addAttribute">+增加新属性</a></td>
                            </tr>
                        </tfoot>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="ipt-wrap"><input type="text" name="attrN_1" class="ipt" value="含硫情况"
                                                                 autocomplete="off"></div>
                                </td>
                                <td>
                                    <div class="ipt-wrap"><input type="text" name="attrV_1" class="ipt" value="无硫"
                                                                 autocomplete="off"></div>
                                </td>
                                <td>
                                    <button class="ubtn ubtn-red">删除</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="box fa-form">
                <div class="hd">商品图片与详情</div>
                <div class="item">
                    <div class="txt"><i>*</i>商品缩略图：</div>
                    <div class="cnt cnt-mul">
                        <span class="thumb up-img x4" id="jpic1"></span>
                        <input type="hidden" value="" name="thumbnailUrl" id="thumbnailUrl">
                        <span class="tips">图片尺寸：220 X 180</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>商品图片：</div>
                    <div class="cnt cnt-mul">
                        <span class="thumb up-img x3" id="jpic2"></span>
                        <input type="hidden" value="" name="pictureUrl" id="pictureUrl">
                        <span class="tips">图片尺寸：750 X 400</span>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">
                        <i>*</i>详细信息：
                    </div>
                    <div class="cnt cnt-mul">
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
                    $title = $('#title');
                
                $('#createTitle').on('click', function() {
                    $title.val($name.val() + ' ' + $spec.val() + ' ' + $origin.val());  
                })
            },
            umeditor: function() {
                //初始化详细信息
                var um = UM.getEditor('detail', {
                    initialFrameWidth: isMobile ? '100%' : 700,
                    initialFrameHeight: 320
                }).setContent('');
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
                    transformResult: function (response) {
                        response = JSON.parse(response);
                        if (response.status == 200) {
                            return {
                                suggestions: $.map(response.data, function (dataItem) {
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
                var self = this,
                    $jsalesPrice = $('#jsalesPrice'),
                    $jprice = $('#jprice'),
                    idx = $jsalesPrice.find('.cnt').length,
                    _unit = $('#unit').find('option:selected').text();


                // 添加价格
                $('#jaddNewPrice').on('click', function () {
                    $jsalesPrice.append('<div class="cnt"> \n <div class="ipt-wrap">' +
                            '<input type="text" name="minKg' + (++idx) + '" class="ipt ipt-short" data-rule="required; range(1~99999)" placeholder="1-99999" autocomplete="off">' +
                            '</div> \n <em>-</em> \n <div class="ipt-wrap"><input type="text" name="maxKg' + idx + '" class="ipt ipt-short" data-rule="required; range(1~99999)" ' +
                            'placeholder="1-99999" autocomplete="off"></div> \n <em name="unitD">' + _unit + '</em> \n <div class="ipt-wrap ml"> \n ' +
                            '<input type="text" name="price' + idx + '" class="ipt ipt-short" placeholder="1-9999" data-rule="required; range(1~9999)" autocomplete="off"> \n' +
                            ' <span class="unit">元</span> \n </div> \n <button type="button" class="ubtn ubtn-red ml">删除</button> \n </div>');
                })

                // 单位
                $('#unit').code('UNIT');
                $('#unit').on('change', function () {
                    _unit = $(this).find('option:selected').text();
                    $('em[name=unitD]').html(_unit);
                })

                // 删除价格
                $jsalesPrice.on('click', '.ubtn-red', function () {
                    $(this).parent().remove();
                })

                // 表单验证
                $("#myform").validator({
                    ignore: $('#jsalesPrice .ipt, .edui-image-searchTxt'),
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
                        harYear: '采收年份: required',
                        thumbnailUrl: '商品缩略图: required',
                        pictureUrl: '商品图片: required',
                        minimumQuantity: '起购数量: range(0~9999)',
                        detail: {
                            rule: '商品详情: required',
                            target: '#detailsError'
                        },
                        supplierId: '绑定供应商: required',
                        supplier: '绑定供应商: required'
                    },
                    valid: function () {
                        self.submitForm();
                    }
                });

                // 量大价优
                $('#jsales').on('click', function () {
                    $jsalesPrice[this.checked ? 'show' : 'hide']()
                            .find('.ipt').removeClass('n-invalid').trigger("hidemsg");
                    $jprice.attr('class', 'ipt').prop('disabled', this.checked).val('').trigger("hidemsg");
                    $('#myform').data('validator').options.ignore = this.checked ? $('#jprice, .edui-image-searchTxt') : $('#jsalesPrice .ipt, .edui-image-searchTxt');
                    $("em[name=unitD]").html(_unit);
                }).prop('checked', false);
            },
            // 提交事件
            submitForm: function () {
                // 序列化属性值
                var attr = {};
                $('#attribute').find('tbody tr').each(function(i) {
                    attr[$(this).find('.ipt').eq(0).val()] = $(this).find('.ipt').eq(1).val();
                })
                var data = $('#myform').serializeObject();
                $.each(data, function (k, v) {
                    k.match('attr') && delete data[k];
                })
                data.attribute = JSON.stringify(attr);

                if ($("input[name='mark']").is(':checked')) {
                    var gradient = new Array();
                    // 量大价优按钮被选中
                    var divs = $("#jsalesPrice > .cnt ");
                    $.each(divs, function (k, v) {
                        gradient.push({
                            start: $($(v).find("input")[0]).val(),
                            end: $($(v).find("input")[1]).val(),
                            price: $($(v).find("input")[2]).val()
                        });
                    })
                    data.gradient = gradient;
                    data.mark = 1;
                } else {
                    data.mark = 0;
                }

                $("#jsubmit").prop("disabled", true);
                $.ajaxSetup({
                    contentType: 'application/json'
                });
                $.post("/commodity/save", JSON.stringify(data), function (data) {
                    if (data.status == 200) {
                        $.notify({
                            type: 'success',
                            title: '添加成功',
                            callback: function() {
                                location.href = '/commodity/list';
                            }
                        });
                    }
                    $("#jsubmit").prop("disabled", false);
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
                var $table = $('#attribute').find('tbody'),
                        idx = $table.find('tr').length;

                // 新增
                $('#addAttribute').on('click', function () {
                    var tr = '<tr> \n <td><div class="ipt-wrap"><input type="text" name="attrN_' + (++idx) + '" class="ipt" value="" autocomplete="off"></div></td> \n <td><div class="ipt-wrap"><input type="text" name="attrV_' + idx + '" class="ipt" value="" autocomplete="off"></div></td> \n <td><button class="ubtn ubtn-red">删除</button></td> \n </tr>';
                    $table.append(tr);
                })

                // 删除
                $table.on('click', '.ubtn-red', function () {
                    $(this).closest('tr').remove();
                })
            },
            supplier: function () {
                var self = this;
                vals = [],
                        timer = 0,
                        $supplier = $('#supplier'),
                        $supplierSuggestions = $('#supplierSuggestions');

                var ajaxSearch = function (val) {
                    timer && clearTimeout(timer);
                    timer = setTimeout(function () {
                        $.ajax({
                            url: 'supplier/search',
                            data: {name: val},
                            method:"POST",
                            success: function (response) {
                                var html = [''];
                                if (response && response.status === 200) {
                                    $.each(response.data, function (i, item) {
                                        html.push('<tr class="items" data-name="' + item.name + '"data-id="' + item.id + '"><td>' + item.name + '</td><td>' + item.phone + '</td><td>' + item.position + '</td></tr>');
                                    })
                                } else {
                                    html.push('<tr><td colspan="3">未查询到供应商，请重新输入</td></tr>');
                                }
                                $supplierSuggestions.show().find('tbody').html(html.join(''));
                            },
                            error: function () {
                                $supplierSuggestions.show().find('tbody').html('<tr><td colspan="3">网络错误</td></tr>');
                            }
                        })
                    }, 300);
                }

                $supplier.on('input', function () {
                    var val = this.value;
                    if (val) {
                        ajaxSearch(val);
                    } else {
                        $supplierSuggestions.hide();
                    }
                })

                $('body').on('click', function () {
                    $supplierSuggestions.hide();
                })

                // 添加商品
                $supplierSuggestions.on('click', '.items', function () {
                    var name = $(this).data('name'),
                            id = $(this).data('id');
                    $supplier.val(name);
                    $("#supplierId").val(id);
                    $supplierSuggestions.hide();
                }).on('click', 'table', function () {
                    return false;
                })
            }
        }
    }

    $(function () {
        _global.fn.init();
    })
</script>

</body>
</html>