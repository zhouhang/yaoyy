<!DOCTYPE html>
<html lang="en">
<head>
<#include "./common/meta.ftl"/>
<title>管理员列表-药优优</title>
</head>
<body>
<div class="wrapper">
    <#include "./common/header.ftl">
    <#include "./common/aside.ftl"/>
    <div class="content">
        <div class="breadcrumb">
            <ul>
                <li>账号权限</li>
                <li>管理员列表</li>
            </ul>
        </div>

        <div class="box">
            <div class="tools">
                <div class="filter">
                    <form id="filterForm" method="get" action="/member/index">
                        <input type="text" name="name" class="ipt" placeholder="姓名">
                        <select name="roleId" id="roleId" class="slt">
                            <option value="">全部角色</option>
                            <#list roleList as role>
                                <option value="${role.id}">${role.name}</option>
                            </#list>
                        </select>
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
                    </form>
                </div>
                <div class="action-add">
                    <button class="ubtn ubtn-blue" id="jaddNewAdmin">新建管理员</button>
                </div>
            </div>

            <div class="table">
                <table>
                    <thead>
                    <tr>
                        <th width="50"><input type="checkbox" class="cbx"></th>
                        <th>姓名</th>
                        <th>用户名</th>
                        <th>电话</th>
                        <th>角色</th>
                        <th width="150">创建时间</th>
                        <th width="180" class="tc">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list memberPage.list as member>
                        <tr>
                            <td><input type="checkbox" class="cbx" value="${member.id}"></td>
                            <td>${member.name}</td>
                            <td>${member.username}</td>
                            <td>${member.mobile!""}</td>
                            <td>${member.roleName!""}</td>
                            <td>${member.createDate?datetime}</td>
                            <td class="tc" data-id="${member.id}">
                                <a href="javascript:;" class="ubtn ubtn-blue jedit">编辑</a>
                                <a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
            <#import "./module/pager.ftl" as pager />
            <@pager.pager info=memberPage url="member/index" params=memberParams />
        </div>
    </div>

    <#include "./common/footer.ftl"/>
</div>

<!-- 管理员弹出框表单 -->
<form id="myform" class="hide">
    <div class="fa-form fa-form-layer">
        <input type="hidden" name="id" class="ipt">
        <div class="item">
            <div class="txt"><i>*</i>用户名：</div>
            <div class="cnt">
                <input type="text" name="username" class="ipt" placeholder="用户名" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>角色：</div>
            <div class="cnt">
                <select name="roleId" id="roleId" class="slt">
                    <#list roleList as role>
                        <option value="${role.id}">${role.name}</option>
                    </#list>
                </select>
            </div>
        </div>
        <div class="item">
            <div class="txt">密码：</div>
            <div class="cnt">
                <input type="text" name="password" class="ipt" placeholder="密码(修改密码时为空即不修改)" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>姓名：</div>
            <div class="cnt">
                <input type="text" name="name" class="ipt" placeholder="姓名" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt"><i>*</i>电话：</div>
            <div class="cnt">
                <input type="text" name="mobile" class="ipt" placeholder="电话" autocomplete="off">
            </div>
        </div>
        <div class="item">
            <div class="txt">邮箱：</div>
            <div class="cnt">
                <input type="text" name="email" class="ipt" placeholder="邮箱" autocomplete="off">
            </div>
        </div>
    </div>
    <button type="submit" class="hide"></button>
</form>

<script src="assets/plugins/validator/jquery.validator.min.js"></script>
<script>
!(function($, window) {
    var _global = {
        deleteUrl: '/member/delete/',
        init: function() {
            navLight('7-1');
            this.bindEvent();
        },
        bindEvent: function() {
            var that = this,
                $table = $('.table'),
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
                        data.status == 200 && window.location.reload();
                    },
                    complete: function() {
                        that.enable = true;
                    }
                })
            }

            $myform.validator({
                fields: {
                    username: '用户名: required',
                    name: '姓名: required',
                    mobile: '电话: required; mobile'
                },
                valid: function (form) {
                    that.enable && response('/member/save', $(form).serializeObject());
                    return false;
                }
            });

            // 删除
            $table.on('click', '.jdel', function() {
                var url = that.deleteUrl + $(this).parent().data('id');

                layer.confirm('确认删除？', {icon: 3}, function (index) {
                    response(url);
                });
                return false;
            })

            // 编辑
            $table.on('click', '.jedit', function() {
                if (that.enable) {
                    that.enable = true;
                    $myform[0].reset();
                    that.showinfo($(this).parent().data('id'));
                }
                return false;
            })

            // 新建
            $('#jaddNewAdmin').on('click', function() {
                $myform[0].reset();
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: $myform,
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    title: '新建管理员'
                });
            })
        },
        showinfo: function(id) {
            var that = this,
                $myform = $('#myform');

            var showBox = function(data) {
                $myform.find('.ipt[name="id"]').val(data.member.id);
                $myform.find('.ipt[name="username"]').val(data.member.username);
                $myform.find('.slt[name="roleId"]').val(data.member.roleId);
                //$myform.find('.ipt[name="password"]').val(data.member.password);
                $myform.find('.ipt[name="name"]').val(data.member.name);
                $myform.find('.ipt[name="mobile"]').val(data.member.mobile);
                $myform.find('.ipt[name="email"]').val(data.member.email);
                layer.closeAll();
                layer.open({
                    skin: 'layer-form',
                    area: ['600px'],
                    type: 1,
                    content: $myform,
                    btn: ['确定', '取消'],
                    btn1: function() {
                        $myform.submit();
                    },
                    title: '编辑管理员'
                });
            }

            // 加载数据
            var k = $.ajax({
                url: '/member/edit/' + id,
                success: function(data) {
                    showBox(data);
                },
                complete: function() {
                    that.enable = true;
                }
            })

            // loading
            layer.open({
                area: ['200px'],
                type: 1,
                content: '<div class="layer-loading">加载中...</div>',
                title: '编辑管理员',
                cancel: function() {
                    k.abort();
                }
            });
        }
    }
    _global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>