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
				<!--<div class="filter" method="get" action="/news/list">
					<form id="filterForm">
						<input type="text" class="ipt" placeholder="请输入标题">
                        <button type="submit" class="ubtn ubtn-blue" id="search_btn">搜索</button>
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
							<th width="50"><input type="checkbox" class="cbx"></th>
							<th>标题</th>
							<th>推送对象</th>
							<th>创建时间</th>
							<th width="120" class="tc">操作</th>
						</tr>
					</thead>
					<tbody>
						<#list announcementVoPageInfo.list as announcement>
						<tr>
							<td><input type="checkbox" class="cbx"></td>
							<td>${announcement.title}</td>
							<td>${announcement.userTypeName?default("")}</td>
							<td>${announcement.createTime?datetime}</td>
							<td class="tc" data-id="${announcement.id?c}">
								<a href="/announcement/detail/${announcement.id?c}" class="ubtn ubtn-blue jedit">编辑</a>
								<a href="javascript:;" class="ubtn ubtn-gray jdel">删除</a>
								<!--<a href="javascript:;" class="ubtn ubtn-black jputaway" data-id="${announcement.id?c}">草稿</a>-->
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
</div>

<script>
!(function($, window) {
	var _global = {
		deleteUrl: '/announcement/delete/',
		init: function() {
            navLight('11-2');
			this.bindEvent();
		},
		bindEvent: function() {
			var that = this,
				$table = $('.table');

			// 删除
			$table.on('click', '.jdel', function() {
				var url = that.deleteUrl + $(this).parent().data('id');

                layer.confirm('确认删除？', {icon: 3}, function (index) {
                	$.get(url, function (data) {
                        if (data.result.status == "200") {
                            window.location.reload();
                        }
                    }, 'json');
                });
                return false;
			})
		}
	}
	_global.init();
})(window.Zepto||window.jQuery, window);
</script>
</body>
</html>