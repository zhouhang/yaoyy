<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>供应商详情-药优优</title>
</head>
<body>
<div class="wrapper">

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
                <div class="item">
                    <div class="txt">供应商编号：</div>
                    <div class="val">${(supplierVo.id)!}</div>
                </div>
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
                <!--<div class="item">
                    <div class="txt">手机号2：</div>
                    <div class="cnt">
                        <input type="text" name="phone2" value="${(supplierVo.phone2)!}"  class="ipt" placeholder="请输入手机号" autocomplete="off">
                    </div>
                </div>-->
                <div class="item">
                    <div class="txt"><i>*</i>品种：</div>
                    <div class="cnt">
                        <div class="choose" id="chooseBreeds">
                        <#if supplierVo?exists>
                            <#list supplierVo.enterCategoryList as category>
                                <span>${category.name}<i data-id="${category.id}"></i></span>
                            </#list>
                        </#if>
                        </div>
                        <input type="text" name="breeds" id="breeds" class="ipt" placeholder="请输入入驻品种" autocomplete="off">
                        <input type="hidden" value="${(supplierVo.enterCategory)!}" name="enterCategory" id="breedsId">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">公司：</div>
                    <div class="cnt">
                        <input type="text" name="company" class="ipt" placeholder="请输入公司名" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">地区：</div>
                    <div class="cnt">
                        <select class="slt" name="province" id="province">
                            <option value="">-省-</option>
                            <#list provinces as province>
                            <option value="${province.id}?c" <#if areaVo?? && province.id == areaVo.provinceId>selected</#if>>${province.areaname}</option>
                            </#list>
                        </select>
                        <select class="slt" name="city" id="city">
                            <option value="">-市-</option>
                            <#if cities??>
                            <#list cities as city>
                                <option value="${city.id?c}" <#if areaVo?? && city.id == areaVo.cityId>selected</#if>>${city.areaname}</option>
                            </#list>
                            </#if>
                        </select>
                        <select class="slt" name="area" id="area">
                            <option value="">-区-</option>
                            <#if areaVos??>
                            <#list areaVos as area>
                                <option value="${area.id?c}" <#if areaVo?? && area.id == areaVo.id>selected</#if>>${area.areaname}</option>
                            </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">邮箱：</div>
                    <div class="cnt">
                        <input type="text" name="email" value="${(supplierVo.email)!}" class="ipt" placeholder="请输入邮箱" autocomplete="off">
                    </div>
                </div>
                <!--<div class="item">
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
                </div>-->
                <div class="item">
                    <div class="txt">信息来源：</div>
                    <div class="val">系统录入</div>
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

            <!--<div class="ab">
                <div class="block"><span>微信绑定：</span><em class="c-red">未绑定</em></div>
                <div class="block"><span>最后登录时间：</span><em class="c-red">未登录</em></div>
                <div class="block"><span>微信绑定：</span>bin <img src="https://avatar.tower.im/6d941fe33b084e528ce3cda3bedd4fd0"> <a href="javascript:;" class="c-blue ml" id="jwechat">取消绑定</a></div>
                <div class="block"><span>最后登录时间：</span>2017年3月2日  12：30</div>
            </div>-->
        </div>

        <!--<#if commodityVos?exists>
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
        </#if>-->

        <#if supplierVo?exists>
        <div class="box fa-form">
            <div class="hd">跟踪记录</div>
            <ol class="trace" id="trace">
                <#list userTrackRecordVos as userTrackRecordVo>
                <li>
                    <span>${userTrackRecordVo.member?default("")}</span>
                    <span>${userTrackRecordVo.createTime?datetime}</span>
                    <span>${userTrackRecordVo.content?default("")}</span>
                </li>
                </#list>
            </ol>
            <form action="" id="traceForm">
                <div class="item">
                    <div class="txt">跟踪记录：</div>
                    <div class="cnt">
                        <textarea name="content" class="ipt ipt-mul" placeholder="跟踪记录"></textarea>
                    </div>
                </div>
                <div class="ft">
                    <input type="hidden" name="memberId" value="${(member_session_boss.id)!}">
                    <input type="hidden" name="supplierId" value="${(supplierVo.id)!}">
                    <button type="submit" class="ubtn ubtn-blue submit">提交</button>
                </div>
            </form>
        </div>
        </#if>

        <!--<#if supplierVo?exists>
        <div class="box fa-form">
            <div class="hd">供应商照片</div>
            <div class="pics thumb">
                <div class="up-img" id="jpic"></div>
            </div>
        </div>
        </#if>-->

        <#if supplierVo?exists>
        <div class="box fa-form">
            <div class="hd">供应商入驻</div>
            <form id="myform3">
                <div class="item">
                    <div class="txt">登录帐号：</div>
                    <div class="val">${(supplierVo.phone)!}</div>
                </div>
                <div class="item">
                    <div class="txt">密码：</div>
                    <div class="cnt">
                        <input type="text" name="pwd" id="pwd" class="ipt ipt-short" autocomplete="off">
                        <a href="javascript:;" id="generate" class="c-blue ml">生成随机密码</a>
                    </div>
                </div>
                <div class="ft">
                    <button type="submit" class="ubtn ubtn-blue submit">同意入驻</button>
                    <span class="tips">注：点击同意入驻后帐号和密码将以短信形式发送到供应商手机</span>
                </div>
            </form>
        </div>
        </#if>

    </div>

    <#include "./common/footer.ftl"/>



<script src="assets/js/jquery.autocomplete.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
    var _global = {
        v: {
            flag: false
        },
        fn: {
            init: function() {
                this.validator();
                this.searchBreeds();
                this.traceForm();
                this.myform3();
            },
            validator: function() {
                var _enable = true,
                    $myform = $('#myform');

                // 表单验证
                $myform.validator({
                    fields: {
                        name: '姓名: required',
                        phone: '手机号: required; mobile',
                        phone2: 'mobile',
                        telephone: 'tel',
                        area: '所在地区: required',
                        enterCategory: '入驻品种: required',
                        qq: 'qq'
                    },
                    valid: function(form) {
                        _enable &&$.post('/supplier/save', $myform.serialize() + '&remark='+$('#remark').val()).done(function(d){
                            if (d.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '操作成功',
                                    callback: function() {
                                        location.href = '/supplier/list';
                                    }
                                });
                            }
                            _enable = true;
                        });
                        _enable = false;
                    }
                });
            },
            // 查询品种
            searchBreeds: function() {
                var self = this;
                vals = [${(supplierVo.enterCategory)!}],
                        timer = 0,
                        $breeds = $('#breeds'),
                        $breedsId = $('#breedsId'),
                        $chooseBreeds = $('#chooseBreeds'),
                        $breedsSuggestions = $('#breedsSuggestions');

                $breeds.autocomplete({
                    serviceUrl: 'category/search',
                    paramName: 'name',
                    deferRequestBy: 100,
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: '没有该品种',
                    transformResult: function (response) {
                        response = JSON.parse(response);
                        if (response.status == "200") {
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
                        var id = suggestion.data,
                                val = suggestion.value;
                        if (self.inArray(id, vals)) {
                            $.notify({
                                type: 'error',
                                title: '商品添加失败',
                                text: '此商品已在添加列表'
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
            },
            traceForm: function() {
                var _enable = true,
                        $traceForm = $('#traceForm');

                // 表单验证
                $traceForm.validator({
                    fields: {
                        content: '内容: required'
                    },
                    valid: function(form) {
                        _enable &&$.post('/usertrack/save', $traceForm.serialize()).done(function(d){
                            if (d.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '操作成功',
                                    callback: function() {
                                        location.reload();
                                    }
                                });
                            }
                            _enable = true;
                        });
                        _enable = false;
                    }
                });
            },
            myform3: function() {
                var _enable = true,
                        $myform3 = $('#myform3');

                // 表单验证
                $myform3.validator({
                    fields: {
                        pwd: '密码: required'
                    },
                    valid: function(form) {
                        _enable &&$.post('/supplier/sign', $("#myform").serialize() + '&pwd='+$('#pwd').val()).done(function(d){
                            if (d.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '操作成功',
                                    callback: function() {
                                        location.href = '/supplier/list';
                                    }
                                });
                            }
                            _enable = true;
                        });
                        _enable = false;
                    }
                });
            }
        }
    }

    $(function() {
        _global.fn.init();
        $("#province").change(function(){
            var provinceid = $("#province").val();
            if(provinceid!=""){
                $.ajax({
                    url: '/area',
                    data: {parentId: provinceid},
                    success: function(result) {
                        var $city = $("#city");
                        var data = result.data;
                        $city.empty();
                        for(i in data){
                            $city.append("<option value=\"" + data[i].id + "\">" + data[i].areaname + "</option>");
                        }
                        $city.change();
                    }
                })
            }
        });

        $("#city").change(function(){
            var cityid = $("#city").val();
            if(cityid!=""){
                $.ajax({
                    url: '/area',
                    data: {parentId: cityid},
                    success: function(result) {
                        var $area = $("#area");
                        var data = result.data;
                        $area.empty();
                        for(i in data){
                            $area.append("<option value=\"" + data[i].id + "\">" + data[i].areaname + "</option>");
                        }
                    }
                })
            }
        });

        $("#generate").click(function(){
            var num="";
            for(var i=0;i<6;i++) {
                num+=Math.floor(Math.random()*10);
            }
            $("#pwd").val(num);
        });
    })
</script>
</body>
</html>