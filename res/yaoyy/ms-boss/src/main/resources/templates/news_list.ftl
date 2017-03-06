<!DOCTYPE html>
<html lang="en">
<head>
	<#include "./common/meta.ftl"/>
    <title>新闻公告列表-药优优</title>
</head>
<body>

<div class="wrapper">
	<#include "./common/header.ftl"/>
	<#include "./common/aside.ftl"/>

	<div class="content">
		<div class="breadcrumb">
			<ul>
				<li>资讯管理</li>
        		<li>网站公告</li>
    		</ul>
		</div>

		<div class="box">
			<div class="tools">
				<!--<div class="filter">
					<form action="">
						<input type="text" class="ipt" placeholder="请输入标题">
						<button class="ubtn ubtn-blue">搜索</button>
					</form>
				</div>-->
				

				<div class="action-add">
					<a href="/announcement/add" class="ubtn ubtn-blue">新建公告</a>
				</div>
			</div>

			<div class="table">
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" class="cbx"></th>
							<th>标题</th>
							<th>推送对象</th>
							<th>创建时间</th>
							<th width="230" class="tc">操作</th>
						</tr>
					</thead>
					<tbody>
						<#list announcementVoPageInfo.list as announcement>
						<tr>
							<td><input type="checkbox" class="cbx"></td>
							<td>${announcement.title}</td>
							<td>${announcement.userTypeName?default("")}</td>
							<td>${announcement.createTime?datetime}</td>
							<td class="tc">
								<a href="/announcement/detail/${announcement.id?c}" class="ubtn ubtn-blue jedit">编辑</a>
								<a href="/announcement/delete/${announcement.id?c}" class="ubtn ubtn-gray jdel"">删除</a>
								<!--<a href="javascript:;" class="ubtn ubtn-gray jputaway" data-id="${announcement.id?c}">草稿</a>-->
							</td>
						</tr>
						</#list>
					</tbody>
				</table>
			</div>

		<#import "./module/pager.ftl" as pager />
		<@pager.pager info=announcementVoPageInfo url="announcement/list" params="" />
		</div>
	</div>
	<#include "./common/footer.ftl"/>

<script>
	var _global = {
		v: {
			deleteUrl: ''
		},
		fn: {
			init: function() {
                this.bindEvent();
			},
			bindEvent: function() {
				var $table = $('.table'),
					$cbx = $table.find('td input:checkbox'),
					$checkAll = $table.find('th input:checkbox'),
					count = $cbx.length;

				// 删除
				$table.on('click', '.jdel', function() {
					var url = _global.v.deleteUrl + $(this).attr('href');
                    layer.confirm('确认删除此品种？', {icon: 3, title: '提示'}, function (index) {
                        $.get(url, function (data) {
                            if (data.result.status == "200") {
                                window.location.reload();
                            }
                        }, "json");
                        layer.close(index);
                    });
                    return false; // 阻止链接跳转
				})

				// 全选
				$checkAll.on('click', function() {
					var isChecked = this.checked;
					$cbx.each(function() {
						this.checked = isChecked;
					})
				})
				// 单选
				$cbx.on('click', function() {
					var _count = 0;
					$cbx.each(function() {
						_count += this.checked ? 1 : 0;
					})
					$checkAll.prop('checked', _count === count);
				})
			}
		}
	}

	$(function() {
		_global.fn.init();
	})
</script>
</body>
</html>