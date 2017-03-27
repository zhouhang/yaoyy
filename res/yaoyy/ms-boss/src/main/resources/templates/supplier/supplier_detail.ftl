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
            <span class="on">基本信息</span>
            <a href="supplier/judge/${(supplierVo.id?c)!}">评价信息</a>
            <!--<a href="">身份信息</a>-->
            <a href="supplier/${(supplierVo.id?c)!}/commodity">商品调价</a>
        </div>

		<div class="box fa-form">
            <form id="myform">
                <input type="hidden" name="id" value="${(supplierVo.id?c)!}">
                <div class="hd">基本信息</div>
                <div class="item">
                    <div class="txt">当前状态：</div>
                    <div class="val"><span class="c-red">${(supplierVo.statusText)!}</span></div>
                </div>
                <div class="item">
                    <div class="txt">供应商编号：</div>
                    <div class="val">${(supplierVo.id?c)!}</div>
                </div>
				<div class="item">
					<div class="txt"><i>*</i>姓名：</div>
					<div class="cnt">
						<input type="text" name="name" value="${(supplierVo.name)!}" class="ipt" placeholder="请输入姓名" autocomplete="off">
					</div>
				</div>
				<div class="item">
					<div class="txt"><i>*</i>手机号：</div>
					<div class="cnt">
						<input type="text" name="phone" value="${(supplierVo.phone)!}" class="ipt" placeholder="请输入手机号" autocomplete="off">
					</div>
				</div>
                <div class="item">
                    <div class="txt">用户输入的品种：</div>
                    <div class="val">${(supplierVo.enterCategoryStr)!}</div>
                </div>
                <div class="item">
                    <div class="txt"><i>*</i>主营品种：</div>
                    <div class="cnt">
                        <div class="choose" id="chooseBreeds">
                        <#if supplierVo?exists && supplierVo.enterCategoryList??>
                            <#list supplierVo.enterCategoryList as category>
                                <span>${category.name}<i data-id="${category.id}"></i></span>
                            </#list>
                        </#if>
                        </div>
                        <input type="text"  id="breeds" class="ipt" placeholder="请输入入驻品种" autocomplete="off">
                        <input type="hidden" name="enterCategory" value="${supplierVo.enterCategory!}" id="breedsId">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">经营商品：</div>
                    <div class="cnt table tc" id="commodity">
                        <table>
                            <thead>
                                <tr>
                                    <th>品种</th>
                                    <th>规格等级</th>
                                    <th>产地</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <#if commodityVos??>
                                <#list commodityVos as commodity>
                                <tr>
                                    <input type="hidden" value="${commodity.id!}" attr="supplierCommodtiyId">
                                    <td><div class="ipt-wrap"><input type="text" class="ipt jname" attr="name" value="${commodity.name!}" autocomplete="off"></div></td>
                                    <td><div class="ipt-wrap"><input type="text" class="ipt" attr="spec" value="${commodity.spec!}" autocomplete="off"></div></td>
                                    <td><div class="ipt-wrap"><input type="text" class="ipt" attr="origin" value="${commodity.origin!}" autocomplete="off"></div></td>
                                    <td><button type="button" class="ubtn ubtn-red">删除</button></td>
                                </tr>
                                </#list>
                                </#if>

                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4"><a href="javascript:;" class="c-blue" id="addCommodity">+新增一行</a></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">地区：</div>
                    <div class="cnt">
                        <select class="slt" name="province" id="province">
                            <option value="">-省-</option>
                        <#list provinces as province>
                            <option value="${province.id?c}" <#if areaVo?? && province.id == areaVo.provinceId>selected</#if>>${province.areaname}</option>
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
                    <div class="txt">来源：</div>
                    <div class="cnt">
                        <select class="slt" name="source" id="source">
                            <option value="1" <#if supplierVo.source??><#if supplierVo.source==1>selected</#if></#if>>系统录入</option>
                            <option value="2" <#if supplierVo.source??><#if supplierVo.source==2>selected</#if></#if>>沪樵导入</option>
                            <option value="3" <#if supplierVo.source??><#if supplierVo.source==3>selected</#if></#if>>天济导入</option>
                            <option value="4" <#if supplierVo.source??><#if supplierVo.source==4>selected</#if></#if> >微信登记</option>
                        </select>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">详细地址：</div>
                    <div class="cnt">
                        <input type="text" name="address" value="${(supplierVo.address)!}" class="ipt" placeholder="请输入详细地址" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">组织类型：</div>
                    <div class="cnt cbxs" id="changeCompanyType">
                        <label><input type="radio" name="org" class="cbx" value="1"<#if supplierVo.org??><#if supplierVo.org==1>checked</#if></#if>>个人主体</label>
                        <label><input type="radio" name="org" class="cbx" value="2" <#if supplierVo.org??><#if supplierVo.org==2>checked</#if></#if>>公司或者合作社</label>
                    </div>
                </div>

                <div class="item  <#if !supplierVo.org??||supplierVo.org==1>hide</#if>" id="companyName">
                    <div class="txt">公司名称：</div>
                    <div class="cnt">
                        <input type="text" name="company" value="${(supplierVo.company)!}"class="ipt" placeholder="请输入公司名称" autocomplete="off">
                    </div>
                </div>

                <div class="hd">业务概况</div>
                <div class="item">
                    <div class="txt">年业务量：</div>
                    <div class="cnt">
                        <input type="text" name="bizYear" value="${(supplierVo.bizYear)!}" class="ipt" placeholder="请输入年业务量" autocomplete="off">
                    </div>
                </div>
                <div class="item">
                    <div class="txt">业务类型：</div>
                    <div class="cnt cbxs">
                        <label><input type="radio" name="bizType" value="1" class="cbx" <#if supplierVo.bizType??><#if supplierVo.bizType==1>checked</#if></#if>>大货</label>
                        <label><input type="radio" name="bizType" value="2" class="cbx" <#if supplierVo.bizType??><#if supplierVo.bizType==2>checked</#if></#if>>加工</label>
                        <label><input type="radio" name="bizType" value="3" class="cbx" <#if supplierVo.bizType??><#if supplierVo.bizType==3>checked</#if></#if>>大货+加工</label>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">主要经营地：</div>
                    <div class="cnt cbxs">
                        <label><input type="radio" name="bizPlace" value="1" <#if supplierVo.bizPlace??><#if supplierVo.bizPlace==1>checked</#if></#if> class="cbx">产地</label>
                        <label><input type="radio" name="bizPlace" value="2" <#if supplierVo.bizPlace??><#if supplierVo.bizPlace==2>checked</#if></#if> class="cbx">市场</label>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">主要客户群体：</div>
                    <div class="cnt cbxs">
                        <label><input type="checkbox" name="bizCustomerType" class="cbx" value="1" <#if supplierVo.bizCustomerType??><#if supplierVo.bizCustomerType?contains("1")>checked</#if></#if>>饮片长</label>
                        <label><input type="checkbox" name="bizCustomerType" class="cbx" value="2" <#if supplierVo.bizCustomerType??><#if supplierVo.bizCustomerType?contains("2")>checked</#if></#if>>制药厂</label>
                        <label><input type="checkbox" name="bizCustomerType" class="cbx" value="3" <#if supplierVo.bizCustomerType??><#if supplierVo.bizCustomerType?contains("3")>checked</#if></#if>>经营户</label>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">知名客户：</div>
                    <div class="cnt">
                        <input type="text" name="bizPartner" value="${(supplierVo.bizPartner)!}" class="ipt" placeholder="" autocomplete="off">
                    </div>
                </div>
				<div class="ft">
                    <button type="submit" class="ubtn ubtn-blue" id="jsubmit1">信息核实正确并保存</button>
                    <#if supplierVo.status!=3&&supplierVo.status!=4>
                        <button type="button" class="ubtn ubtn-red" id="jsubmit2">信息核实不正确</button>
                    </#if>


				</div>
            </form>
		</div>

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
                    <input type="hidden" name="supplierId" value="${(supplierVo.id?c)!}">
                    <button type="submit" class="ubtn ubtn-blue submit">提交</button>
                </div>
            </form>
        </div>
        </#if>

        <#if supplierVo.status!=4>
        <div class="box fa-form">
            <div class="hd">供应商签约</div>
            <form id="myform3">
                <div class="item">
                    <div class="txt">登录帐号：</div>
                    <div class="val">${(supplierVo.phone)!}
                        <#if supplierVo.binding=='1'>
                        <span class="c-red">已绑定</span>
                        <#else>
                            <span class="c-red">未绑定</span>
                        </#if>
                    </div>
                </div>
                <div class="item">
                    <div class="txt">密码：</div>
                    <div class="cnt">
                        <input type="text" name="pwd" id="pwd" class="ipt ipt-short" autocomplete="off">
                        <a href="javascript:;" id="generate" class="c-blue ml">生成随机密码</a>
                    </div>
                </div>
                <div class="ft">
                    <button type="submit" class="ubtn ubtn-blue submit">供应商签约</button>
                    <span class="tips">注：点击同意入驻后帐号和密码将以短信形式发送到供应商手机</span>
                </div>
            </form>
        </div>
        </#if>
	</div>
<#include "../common/footer.ftl"/>
</div>


<!-- 输入框联想 start -->
<div class="suggestions" id="suggestions"></div><!-- 输入框联想 end -->

<script src="assets/js/jquery.autocomplete.js"></script>
<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script src="assets/js/area.js"></script>
<script src="assets/js/jquery.pagination.min.js"></script>

<script>
!(function($, window) {
    var _global = {
        init: function() {
            navLight('8-1');
            this.commodity();
            this.checkForm();
            this.changeCompanyType();
            this.searchBreeds();
            this.submitEvent();
        },
        // 经营商品
        commodity: function() {
            var that = this,
                $body = $('body');
                $table = $('#commodity').find('tbody'),
                $suggestions = $('#suggestions');
            
            // 新增
            $('#addCommodity').on('click', function(){
                var tr = '  <tr> \n<input type="hidden" value="" attr="supplierCommodtiyId"> <td><div class="ipt-wrap"><input type="text" class="ipt jname" attr="name" value="" autocomplete="off"></div></td> \n <td><div class="ipt-wrap"><input type="text" class="ipt" attr="spec" value="" autocomplete="off"></div></td> \n <td><div class="ipt-wrap"><input type="text" class="ipt" attr="origin" value="" autocomplete="off"></div></td> \n <td><button type="button" class="ubtn ubtn-red">删除</button></td> \n </tr>';
                $table.append(tr);
            })

            // 删除
            $table.on('click', '.ubtn-red', function() {
                $(this).closest('tr').remove();
            })

            // 商品查询
            $table.on({
                'click': function(event) {
                    event.stopPropagation();
                },
                'focus': function() {
                    $(this).after($suggestions);
                },
                'input': function() {
                    that.getKeywords(this.value);                           
                }
            }, '.jname');

            // 关闭联想层
            $body.on('click', function() {
                $suggestions.hide();
            })
            $body.on('click', '.suggestions', function(event) {
                event.stopPropagation();
            })

            // 关键字自动填充
            $body.on('click', '.suggestions .options', function() {
                $suggestions.prev().val($(this).data('val'))
                //.closest('td').next().find('.ipt').val(data[1]).end()
                //.closest('td').next().find('.ipt').val(data[2]).end()
                $suggestions.hide();
            })
        },
        changeCompanyType: function() {
            $('#changeCompanyType').on('click', '.cbx', function() {
                $('#companyName')[this.value == 2 ? 'show' : 'hide']();
            })
        },
        // ajax 查询关键词
        getKeywords: function(keywords) {
            var that = this;
            var keywords = $.trim(keywords);
            if (keywords === '') {
                $('#suggestions').hide();
            } else {
                // ajax 查询关键词
                that.timer && clearTimeout(that.timer);
                that.timer = setTimeout(function() {
                    that.ajaxSearch(keywords);
                }, 500);                
            }               
        },
        ajaxSearch: function(keywords) {
            var that = this;
            $.ajax({
                url: '/category/search',
                dataType: 'json',
                data:{name:keywords},
                success: function(res) {
                    // 显示查询结果
                    if (res.status === 200) {
                        if (res.data.length === 0) {
                            $('#suggestions').show().empty().html('<div class="options"><em>暂无此商品:)</em></div>');
                        } else {
                            that.toHtml(res.data, 0, 7);
                        }
                    } else {
                        $('#suggestions').hide();
                    }
                }
            })
        },
        // 显示查询结果
        toHtml: function(item, page_index, pageSize) {
            var modal = [],
                maxPage = Math.min((page_index + 1) * pageSize, item.length),
                hasPage = pageSize < item.length;

            for (var i = page_index * pageSize; i < maxPage; i++) {
                var val = item[i].name;
                modal.push('<div class="options" data-val="', val, '">');
                modal.push(     '<em>', item[i].name, '</em>');
                modal.push('</div>');
            }
            hasPage && modal.push('<div class="jq-page"></div>');
            $('#suggestions').empty().show().html(modal.join(''));
            hasPage && this.showPage(item, page_index, pageSize);
        },
        showPage: function(item, page_index, pageSize) {
            var that = this;
            $('.jq-page').pagination(item.length, {
                items_per_page: pageSize, //pageSize 每页显示数量
                current_page: page_index, //默认pageIndex,0(默认),false(不加载)
                num_edge_entries: 2, //1(任何情况下都显示第一页和最后一页),0(不显示)
                callback: function(page_index) {
                    that.toHtml(item, page_index, pageSize);
                }
            })
            $('.jq-page').prepend('<div class="p-size">总共' + item.length + '条记录</div>')
        },
        checkForm: function() {
            // 表单验证

            $("#myform").validator({
                fields: {
                    name: '姓名: required',
                    phone: '手机号: required; mobile',
                    enterCategory: '经营品种: required'
                },
                valid: function(form) {
                    // 验证成功
                    _global.certifySupplier(1);
                }
            });
            $("#jsubmit2").click(function(){
                _global.certifySupplier(2);
            });


        },
        certifySupplier:function(status){
            var param={};
            param.supplier=$("#myform").serializeObject();
            var bizCustomerType=param.supplier.bizCustomerType;
            if(bizCustomerType!=undefined){
                if(bizCustomerType instanceof Array){
                    param.supplier.bizCustomerType=bizCustomerType.join(",");
                }

            }else{
                param.supplier.bizCustomerType="";
            }



            var commdityList=[];
            $("#commodity").find("tbody tr").each(function () {
                var commodity={};
                var id=$(this).find("input[attr='supplierCommodtiyId']").val();
                if(id!=""){
                    commodity.id=id;
                }

                commodity.name=$(this).find("input[attr='name']").val();
                commodity.origin=$(this).find("input[attr='origin']").val();
                commodity.spec=$(this).find("input[attr='spec']").val();
                commdityList.push(commodity);
            })
            if(commdityList.length!=0){
                param.supplierCommodityVos=commdityList;
            }
            param.supplier.status=status;
            $.ajax({
                url: 'supplier/verify',
                data: JSON.stringify(param),
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function(res) {
                    // 显示查询结果
                    if (res.status === 200) {
                        location.reload();
                    }
                }
            })

        },
        // 查询品种
        searchBreeds: function() {
            var that = this;
                vals = [${supplierVo.enterCategory!}],
                timer = 0,
                $breeds = $('#breeds'),
                $breedsId = $('#breedsId'),
                $chooseBreeds = $('#chooseBreeds'),
                $breedsSuggestions = $('#breedsSuggestions');

            $breeds.autocomplete({
                serviceUrl: '/category/search',
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
                    if (that.inArray(id, vals)) {
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
                that.inArray(id, vals, true); // 删除当前id
                $breedsId.val(vals.join(','));
            })
        },
        submitEvent: function() {
            var that = this,
                $trace = $('#trace'),
                $pa = $trace.parent();

            // 提交记录
            $pa.on('click', '.submit', function(){
                $.ajax({
                    url: '/usertrack/save',
                    data: $('#traceForm').serialize(),
                    type:"POST",
                    success: function(data) {
                        if (data.status == 200) {
                            $.notify({
                                type: 'success',
                                title: '操作成功',
                                callback: function() {
                                    location.reload();
                                }
                            });
                        }
                        //that.addNewRevord(data);
                    }
                })
            })

            var $myform = $('#myform3');
            // 同意入驻
            $myform.find('.submit').on('click', function() {
                $myform.validator({
                    fields: {
                        pwd: '密码: required'
                    },
                    valid: function(form) {
                        $.post('/supplier/sign', $("#myform").serialize() + '&pwd='+$('#pwd').val()).done(function(d){
                            if (d.status == 200) {
                                $.notify({
                                    type: 'success',
                                    title: '操作成功',
                                    callback: function() {
                                        location.href = '/supplier/list';
                                    }
                                });
                            }
                            else{
                                $.notify({
                                    type: 'error',
                                    title: d.msg
                                });
                            }
                        });
                    }
                });
            })
            // 随机密码
            $myform.find('.ml').on('click', function() {
                $(this).prev().val((Math.random()).toString().substr(2, 6));
            })
        },
        // 添加记录
        addNewRevord: function(data) {
            var html = [];
            $.each(data, function(i, item) {
                html.push('<span>' + item + '</span>');
            })
            html.length > 1 && $('#trace').append('<li>' + html.join('') + '</li>');
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
    _global.init();
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
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>