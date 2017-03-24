<!DOCTYPE html>
<html lang="en">
<head>
    <#include "../common/meta.ftl"/>
    <title>供应商详情-boss</title>
</head>
<body>

<div class="wrapper">
<#include "../common/header.ftl"/>
<#include "../common/aside.ftl"/>
	<div class="content">
		<div class="breadcrumb">
			<ul>
                <li>供应商管理</li>
                <li>供应商详情</li>
    		</ul>
		</div>

        <div class="fa-tab">
            <a href="supplier/detail/${(supplierVo.id)!}">基本信息</a>
            <span class="on">评价信息</span>
            <!--<a href="#">身份信息</a>-->
            <a href="supplier/${(supplierVo.id)!}/commodity">商品调价</a>
        </div>

        <form id="myform">
            <div class="box fa-form">
                <input type="hidden" name="id" value="${(supplierVo.id)!}">
                <div class="hd">联系人</div>
                <div id="contactform">
                <#if contactVos??>
                    <#assign  num=3-contactVos?size>
                    <#list  contactVos as contactVo >
                        <div class="row">
                            <input type="hidden" name="contactVoId" value="${(contactVo.id)!}">
                            <div class="item">
                                <div class="txt">姓名：</div>
                                <div class="cnt ">
                                    <input type="text" attr="name" name="name${contactVo_index+1}" value="${contactVo.name}" class="ipt" placeholder="请输入姓名" autocomplete="off">
                                </div>
                            </div>
                            <div class="item">
                                <div class="txt">手机号：</div>
                                <div class="cnt ">
                                    <input type="text" attr="phone" name="phone${contactVo_index+1}" value="${contactVo.phone}" class="ipt" placeholder="请输入手机号" autocomplete="off">
                                </div>
                            </div>
                            <div class="item">
                                <div class="txt">职位：</div>
                                <div class="cnt ">
                                    <input type="text" attr="position" name="position${contactVo_index+1}" value="${contactVo.position}"  class="ipt" placeholder="职位" autocomplete="off">
                                </div>
                            </div>
                            <div class="op">
                                <label><input type="radio" name="contact" id="contact${contactVo_index+1}" class="cbx" <#if contactVo.kp==1>checked</#if>>key person</label>
                            </div>
                        </div>
                    </#list>

                <#else>
                  <#assign  num=3>
                </#if>
                    <#if num gt 0>
                 <#list 1..num as i>
                　<div class="row">
                     <input type="hidden" name="contactVoId" value="">
                     <div class="item">
                         <div class="txt">姓名：</div>
                         <div class="cnt ">
                             <input type="text" attr="name" name="name${i+3-num}" class="ipt" placeholder="请输入姓名" autocomplete="off">
                         </div>
                     </div>
                     <div class="item">
                         <div class="txt">手机号：</div>
                         <div class="cnt ">
                             <input type="text" attr="phone" name="phone${i+3-num}" class="ipt" placeholder="请输入手机号" autocomplete="off">
                         </div>
                     </div>
                     <div class="item">
                         <div class="txt">职位：</div>
                         <div class="cnt ">
                             <input type="text" attr="position" name="position${i+3-num}" class="ipt" placeholder="职位" autocomplete="off">
                         </div>
                     </div>
                     <div class="op">
                         <label><input type="radio" name="contact" id="contact${i+3-num}" value="1" class="cbx" <#if i==1&&num==3> checked</#if>>key person</label>
                     </div>
                 </div>　　　　
                　</#list>
                    </#if>
            </div>
            </div>

            <div class="box fa-form">
                <div class="hd">规模实力</div>
                <div id="supplierForm">
				<div class="item">
					<div class="txt"><i>*</i>员工规模</div>
					<div class="cnt cbxs2">
                        <label><input type="radio" name="scaleStaff" value="1" class="cbx" <#if supplierVo.scaleStaff??><#if supplierVo.scaleStaff==1>checked</#if></#if>>1-10人</label>
                        <label><input type="radio" name="scaleStaff" value="2" class="cbx" <#if supplierVo.scaleStaff??><#if supplierVo.scaleStaff==2>checked</#if></#if>>11-50人</label>
                        <label><input type="radio" name="scaleStaff" value="3" class="cbx" <#if supplierVo.scaleStaff??><#if supplierVo.scaleStaff==3>checked</#if></#if>>51-100人</label>
                        <label><input type="radio" name="scaleStaff" value="4" class="cbx" <#if supplierVo.scaleStaff??><#if supplierVo.scaleStaff==4>checked</#if></#if>>100人以上</label>
                        <label><input type="radio" name="scaleStaff" value="5" class="cbx" <#if supplierVo.scaleStaff??><#if supplierVo.scaleStaff==5>checked</#if></#if>>200人以上</label>
					</div>
				</div>
                <div class="item">
                    <div class="txt"><i>*</i>仓库情况：</div>
                    <div class="cnt cbxs2">
                        <label><input type="radio" name="scaleStore" class="cbx" value="1" <#if supplierVo.scaleStore??><#if supplierVo.scaleStore==1>checked</#if></#if>>正规仓库</label>
                        <label><input type="radio" name="scaleStore" class="cbx" value="2" <#if supplierVo.scaleStore??><#if supplierVo.scaleStore==2>checked</#if></#if>>自家仓库</label>
                        <label><input type="radio" name="scaleStore" class="cbx" value="3" <#if supplierVo.scaleStore??><#if supplierVo.scaleStore==3>checked</#if></#if>>租赁仓库</label>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">仓库情况备注：</div>
                    <div class="cnt">
                        <textarea name="scaleStoreMark"  class="ipt ipt-mul" placeholder="">${supplierVo.scaleStoreMark!}</textarea>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>加工条件：</div>
                    <div class="cnt cbxs2">
                        <label><input type="radio" name="scaleProcess" class="cbx" value="1" <#if supplierVo.scaleProcess??><#if supplierVo.scaleProcess==1>checked</#if></#if>>健全、丰富</label>
                        <label><input type="radio" name="scaleProcess" class="cbx" value="2" <#if supplierVo.scaleProcess??><#if supplierVo.scaleProcess==2>checked</#if></#if>>一般</label>
                        <label><input type="radio" name="scaleProcess" class="cbx" value="3" <#if supplierVo.scaleProcess??><#if supplierVo.scaleProcess==3>checked</#if></#if>>较差、没看到</label>
                    </div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>加工能力匹配性：</div>
                    <div class="cnt cbxs2">
                        <label><input type="radio" name="scaleProcessAble" class="cbx" value="1" <#if supplierVo.scaleProcessAble??><#if supplierVo.scaleProcessAble==1>checked</#if></#if>>是，跟业务匹配</label>
                        <label><input type="radio" name="scaleProcessAble" class="cbx" value="0" <#if supplierVo.scaleProcessAble??><#if supplierVo.scaleProcessAble==0>checked</#if></#if>>否，跟业务不匹配</label>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">加工条件备注：</div>
                    <div class="cnt">
                        <textarea name="scaleProcessMark" class="ipt ipt-mul" placeholder="">${supplierVo.scaleProcessMark!}</textarea>
                    </div>
                </div>
                </div>
                <div class="item" id="pics">
                    <div class="txt">供应商生产照片：</div>
                    <div class="cnt">
                        <div class="pics thumb">
                            <#if supplierAnnexVos??>
                            <#list supplierAnnexVos as supplierAnnex>
                            <div class="up-img">
                                <img src="${supplierAnnex.url!}">
                                <i class="del"></i>
                                <input type="hidden" value="${supplierAnnex.url!}">
                            </div>
                            </#list>
                            </#if>
                            <div class="up-img" id="jpic"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="box fa-form">
                <div class="hd">供应保障能力</div>
                <div id="supplierChoice">
                <#list questions as question>
                    <div suveyId="${question.id}" class="qus">
                    <div class="caption">
                        <em><i>*</i>${question_index+1}、${question.question}
                    </div>
                    <div class="item">
                        <div class="cnt cbxs2">
                            <#list question.anwser?split(",") as answer>
                                <label><input type="radio" name="answer_${question_index+1}" value="${answer_index+1}" class="cbx">${answer}</label>
                            </#list>
                        </div>
                    </div>
                    <div class="item">
                        <div class="txt">描述：</div>
                        <div class="cnt">
                            <textarea name="surveyDesc" class="ipt ipt-mul" placeholder=""></textarea>
                        </div>
                    </div>
                    </div>
                </#list>
                </div>

                <div class="ft">
                    <button type="submit" class="ubtn ubtn-blue" id="jsubmit1">保存并实地考察认证</button>
                </div>
            </div>
        </form>
	</div>
<#include "../common/footer.ftl"/>
</div>

<script src="assets/js/jquery191.js"></script>
<script src="assets/js/common.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script src="assets/js/croppic.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('8-1');
            this.bindEvent();
            this.goodsImg();
            this.iniSuvey();
        },
        bindEvent: function() {
            var that = this;

            $("#myform").validator({
                fields: {
                    name1: 'required(#contact1:checked)',
                    phone1: 'required(#contact1:checked); mobile ',
                    position1: 'required(#contact1:checked)',

                    name2: 'required(#contact2:checked)',
                    phone2: 'required(#contact2:checked); mobile',
                    position2: 'required(#contact2:checked)',

                    name3: 'required(#contact3:checked)',
                    phone3: 'required(#contact3:checked);mobile',
                    position3: 'required(#contact3:checked)',


                    scaleStaff: 'checked(1)',
                    scaleStore: 'checked(1)',
                    scaleProcess: 'checked(1)',
                    scaleProcessAble: 'checked(1)',
                    <#list questions as question>
                    answer_${question_index+1}: 'checked(1)',
                    </#list>

                },
                valid: function(form) {

                    // 验证通过

                    var param={};
                    param.supplierVo=$("#myform").serializeObject();
                    param.supplierVo.status=3;
                    var contacts=[];
                    var annexVos=[];
                    var choiceVos=[];


                    $("#contactform").find(".row").each(function(index){
                        var contact={};
                        var id=$(this).find("input[name='contactVoId']").val();
                        if(id!=""){
                            contact.id=id;
                        }
                        contact.supplierId=${(supplierVo.id)!};
                        contact.name=$(this).find("input[attr='name']").val();
                        contact.phone=$(this).find("input[attr='phone']").val();
                        contact.position=$(this).find("input[attr='position']").val();
                        if($("#contact"+(index+1).toString()).is(':checked')){
                            contact.kp=1;
                        }
                        else{
                            contact.kp=0;
                        }
                        if(contact.name!=""&&contact.phone&&contact.position!=""){
                            contacts.push(contact);
                        }

                    })
                    $("#pics").find(".up-img").each(function(){
                        var img=$(this).find("img");
                        if(img!=undefined){
                            var annexVo={};
                            annexVo.supplierId=${(supplierVo.id)!};
                            annexVo.url=img.attr("src");
                            if(annexVo.url!=undefined){
                                annexVos.push(annexVo);
                            }

                        }
                    })
                    $("#supplierChoice").find(".qus").each(function(){
                        var choiceVo={};
                        choiceVo.supplierId=${(supplierVo.id)!};
                        choiceVo.surveyId=$(this).attr("suveyId");
                        choiceVo.choose=$(this).find("input:radio:checked").val();
                        choiceVo.surveyDesc= $(this).find("textarea[name='surveyDesc']").val();
                        choiceVos.push(choiceVo);
                    })




                    param.contacts=contacts;
                    param.annexVos=annexVos;
                    param.choiceVos=choiceVos;
                    $.ajax({
                        url: 'supplier/saveJudge',
                        data: JSON.stringify(param),
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function(res) {
                            // 显示查询结果
                            if (res.status === 200) {
                                $.notify({
                                    type: 'success',
                                    title: '操作成功'
                                });
                                //location.reload();
                            }
                            else{
                                $.notify({
                                    type: 'error',
                                    title: res.msg
                                });
                            }
                        }
                    })



                    return false;
                }
            });

        },
        // 商品图片
        goodsImg: function() {
            var self = this,
                $el = $('#jpic');

            $('body').append('<div id="upload" style="position:fixed;bottom:0;left:0;width:0;height:0;visibility:hidden;"></div>');

            // 删除图片
            $('.thumb').on('click', '.del', function() {
                var $self = $(this);
                layer.confirm('确认删除图片？', function(index){
                    $el.css('display','inline-block');
                    $self.parent().remove();
                    layer.close(index);
                });
                return false;
            })

            // 上传图片
            $el.on('click', function() {
                if ($(this).siblings().length > 9) {
                    $.notify({
                        type: 'error',
                        title: '最多只能上传10张图片'
                    });
                } else {
                    $('#upload').find('.cropControlUpload').trigger('click');
                }
            })

            var options = {
                uploadUrl:'/gen/upload',
                onBeforeImgUpload: function() {
                    $el.html('<span class="loader">图片上传中...</span>');
                },
                onAfterImgUpload: function(response){
                    $el.empty('').before('<div class="up-img"><img src="' + response.url + '"/><i class="del"></i><input type="hidden" value="' + response.url + '" /></div>');
                    $el.siblings().length > 9 && $el.attr('style','display:none!important'); // 上传超过10张后隐藏
                },
                onError:function(msg){
                    $el.empty('');
                    $.notify({
                        type: 'error', 
                        title: '上传图片失败', 
                        text: msg,
                        delay: 3e3
                    });
                }
            }
            new Croppic('upload', options);
        },
        iniSuvey:function(){
            <#if supplierChoices??>
            <#list supplierChoices as choice>
            var div=$("#supplierChoice").find("[suveyId='${choice.surveyId}']");
            div.find("input:radio").eq(${choice.choose-1}).attr("checked",'checked');
            div.find("textarea[name='surveyDesc']").val('${choice.surveyDesc}');
            </#list>
            </#if>
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>