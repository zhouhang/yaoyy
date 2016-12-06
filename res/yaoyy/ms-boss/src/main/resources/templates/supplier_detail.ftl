<!DOCTYPE html>
<html lang="en">
<head>
    <title>供应商详情-boss</title>
    <#include "./common/meta.ftl"/>
</head>
<body class='wrapper'>

<#include "./common/header.ftl"/>
<#include "./common/aside.ftl"/>

<div class="content">
    <div class="breadcrumb">
        <ul>
            <li>供应商管理</li>
            <li>供应商详情</li>
        </ul>
    </div>

    <div class="box fa-form">
        <div class="hd">基本信息</div>
        <form id="myform" action="/supplier/save" method="post">
            <input type="hidden" name="id" value="${(supplierVo.id)!}">
            <div class="item">
                <div class="txt"><i>*</i>姓名：</div>
                <div class="cnt">
                    <input type="text" name="name" value="${(supplierVo.name)!}" class="ipt" placeholder="请输入姓名" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt"><i>*</i>手机号：</div>
                <div class="cnt">
                    <input type="text" name="phone" value="${(supplierVo.phone)!}"  class="ipt" placeholder="请输入手机号" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt">手机号2：</div>
                <div class="cnt">
                    <input type="text" name="phone2" value="${(supplierVo.phone2)!}"  class="ipt" placeholder="请输入手机号" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt"><i>*</i>邮箱：</div>
                <div class="cnt">
                    <input type="text" name="email" value="${(supplierVo.email)!}" class="ipt" placeholder="请输入邮箱" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt">座机：</div>
                <div class="cnt">
                    <input type="text" name="telephone" value="${(supplierVo.telephone)!}" class="ipt" placeholder="请输入座机号" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt"><i>*</i>所在地区：</div>
                <div class="cnt">
                    <input type="text" name="area" value="${(supplierVo.area)!}" class="ipt" placeholder="请输入所在地区" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt"><i>*</i>入驻品种：</div>
                <div class="cnt">
                    <div class="choose" id="chooseBreeds">
                        <#if supplierVo?exists>
                        <#list supplierVo.enterCategoryList as category>
                        <span>${category.variety}<i data-id="${category.id}"></i></span>
                        </#list>
                        </#if>
                    </div>
                    <input type="text" name="breeds" id="breeds" class="ipt" placeholder="请输入入驻品种" autocomplete="off">
                    <input type="hidden" value="${(supplierVo.enterCategory)!}" name="enterCategory" id="breedsId">
                </div>
            </div>
            <div class="item">
                <div class="txt">QQ：</div>
                <div class="cnt">
                    <input type="text" name="qq" value="${(supplierVo.qq)!}" class="ipt" placeholder="请输入QQ" autocomplete="off">
                </div>
            </div>
            <div class="item">
                <div class="txt">备注：</div>
                <div class="cnt">
                    <textarea name="mark" id="remark"class="ipt ipt-mul" cols="30" rows="10">${(supplierVo.mark)!}</textarea>
                </div>
            </div>

            <div class="ft">
                <button type="submit" class="ubtn ubtn-blue" id="jsubmit">保存</button>
            </div>
        </form>
    </div>
<#if commodityVos?exists>
    <div class="box fa-form">
        <div class="hd">入驻商品</div>
        <div class="list">
            <ul>
                <#list commodityVos as commodityVo>
                <li>
                    <div class="pimg">
                        <img class="" src="${commodityVo.thumbnailUrl}" width="100" alt="">
                    </div>
                    <div class="info">
                        <strong>${commodityVo.name}</strong>
                        <span>${commodityVo.spec}</span>
                    </div>
                    <div class="edit">
                        <a href="javascript:;" class="ubtn ubtn-blue jprice" data-id="${commodityVo.id}">调价</a>
                    </div>
                    <div class="price">
                        <i>&yen;</i> ${commodityVo.price}元/${commodityVo.unitName}
                    </div>
                </li>
                </#list>
            </ul>
        </div>
    </div>
    </#if>
</div>

<#include "./common/footer.ftl"/>


<!-- 快速调价弹出框 -->
<form id="priceForm" class="hide">
    <div class="fa-form fa-form-layer">
        <div class="item" style="max-height:300px;overflow:hidden;overflow-y:auto;">
        </div>
        <div class="button">
            <button type="submit" class="ubtn ubtn-blue">保存</button>
            <button type="button" class="ubtn ubtn-gray">取消</button>
        </div>
    </div>
</form>


<script src="assets/js/jquery191.js"></script>
<script src="assets/js/common.js"></script>
<script src="assets/js/jquery.autocomplete.js"></script>
<script src="assets/plugins/layer/layer.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        v: {
            flag: false
        },
        fn: {
            init: function() {
                this.changePrice();
                this.checkForm();
                this.searchBreeds();
            },
            changePrice: function() {
                var self = this;
                // 调价
                $('.list').on('click', '.jprice', function() {
                    if (_global.v.flag) {
                        return false;
                    }
                    _global.v.flag = true;
                    self.showinfo($(this).data('id'));
                    return false; // 阻止链接跳转
                })


                // 关闭弹层
                $('#priceForm').on('click', '.ubtn-gray', function () {
                    layer.closeAll();
                })
                        .validator({
                            fields: {
                                price: '价格: required; range(1~9999)'
                            },
                            valid: function(form) {
                                alert('form passed');
                                // layer.closeAll(); // 关闭弹层
                                // location.reload(true);// 强制删除页面
                            }
                        });
            },
            showinfo: function(id) {
                var showBox = function(data) {
                    var html = [];
                    switch (typeof data.price) {
                        case 'string':
                            html.push('<div class="txt"><i>*</i>价格：</div> \n <div class="cnt"> \n <div class="ipt-wrap"> \n <input type="text" name="price" class="ipt" id="jprice" value=' + data.price + ' placeholder="价格" autocomplete="off"> \n <span class="unit">元</span> \n </div> \n <label class="ml"><input type="checkbox" class="cbx" id="jsales">量大价优</label> \n </div>');
                            break;
                        case 'object':
                            html.push('<div class="txt"><i>*</i>公斤/价格：</div>');
                            $.each(data.price, function(i, item) {
                                var idx = i + 1;
                                html.push('<div class="cnt"> \n <div class="ipt-wrap"><input type="text" name="minKg' , idx , '" class="ipt ipt-short" value="' , item[0] , '" data-rule="required; range(1~99999)" placeholder="1-99999" autocomplete="off"></div> \n <em>-</em> \n <div class="ipt-wrap"><input type="text" name="maxKg' , idx , '" class="ipt ipt-short" value="' , item[1] , '" data-rule="required; range(1~99999)" placeholder="1-99999" autocomplete="off"></div> \n <em>公斤</em> \n <div class="ipt-wrap ml"> \n <input type="text" name="price' , idx , '" class="ipt ipt-short" value="' , item[2] , '" placeholder="1-9999" data-rule="required; range(1~9999)" autocomplete="off"> \n <span class="unit">元</span> \n </div> \n </div>');
                            });
                            break;
                    }

                    $('#priceForm').find('.item').html(html.join(''));

                    layer.closeAll();
                    layer.open({
                        area: ['600px'],
                        type: 1,
                        moveType: 1,
                        content: $('#priceForm'),
                        title: '快速调价'
                    });
                }

                // 加载数据
                var k = $.ajax({
                    url: 'json/getPrice.php',
                    data: {id: id},
                    dataType: 'json',
                    success: function(data) {
                        showBox(data);
                    },
                    complete: function() {
                        _global.v.flag = false;
                    }
                })

                // loading
                layer.open({
                    area: ['200px'],
                    type: 1,
                    moveType: 1,
                    content: '<div class="layer-loading">加载中...</div>',
                    title: '快速调价',
                    cancel: function() {
                        k.abort();
                    }
                });
            },
            checkForm: function() {
                // 表单验证
                $("#myform").validator({
                    fields: {
                        name: '姓名: required',
                        phone: '手机号: required; mobile',
                        phone2: 'mobile',
                        email: '邮箱: required; email',
                        telephone: 'tel',
                        area: '所在地区: required',
                        enterCategory: '入驻品种: required',
                        qq: 'qq'
                    },
                    valid: function(form) {
                        // 验证成功
                        $.ajax({
                            url: "/supplier/save",
                            type: "POST",
                            data: $("#myform").serialize()+"&remark="+$("#remark").val(),
                            success: function(data) {
                                if (data.status == "200") {
                                    // 成功提示
                                    $.notify({
                                        type: 'success',
                                        title: '操作成功',
                                        delay: 1e3,
                                        call: function() {
                                            setTimeout(function() {
                                                location.href = '/supplier/list';
                                            }, 1e3);
                                        }
                                    });
                                }
                            }
                        })
                    }
                });
            },
            // 查询品种
            searchBreeds: function() {
                var self = this;
                vals = [],
                        timer = 0,
                        $breeds = $('#breeds'),
                        $breedsId = $('#breedsId'),
                        $chooseBreeds = $('#chooseBreeds'),
                        $breedsSuggestions = $('#breedsSuggestions');

                $breeds.autocomplete({
                    serviceUrl: 'category/search',
                    paramName: 'variety',
                    deferRequestBy: 100,
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: '没有该品种',
                    transformResult: function (response) {
                        response = JSON.parse(response);
                        if (response.status == "200") {
                            return {
                                suggestions: $.map(response.data, function (dataItem) {
                                    return {value: dataItem.variety, data: dataItem.id};
                                })
                            };
                        } else {
                            return {
                                suggestions: []
                            }
                        }
                    },
                    onSelect: function (suggestion) {
                        var id = suggestion.data,
                                val = suggestion.value;
                        if (self.inArray(id, vals)) {
                            $.notify({
                                type: 'error',
                                title: '商品添加失败',
                                text: '此商品已在添加列表',
                                delay: 3e3
                            });
                        } else {
                            vals.push(id);
                            $chooseBreeds.show().append('<span>' + val + '<i data-id="' + id + '"></i></span>');
                            $breedsId.val(vals.join(','));
                            $breeds.val(''); // 清空输入框
                            $breedsSuggestions.hide();
                        }
                    }
                });

                // 删除品种
                $chooseBreeds.on('click', 'i', function() {
                    var id = $(this).data('id');
                    $(this).parent().remove();
                    self.inArray(id, vals, true); // 删除当前id
                    $breedsId.val(vals.join(','));
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