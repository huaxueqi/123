<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	// 未登录，跳转到登录页面
	if (session.getAttribute("user") == null)
		response.sendRedirect("");
%>

<!DOCTYPE HTML>
<html>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>个人博客主页</title>
<link href="<%=basePath%>bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
<script src="<%=basePath%>bootstrap/js/jquery-1.11.1.js"></script>
<script src="<%=basePath%>bootstrap/js/bootstrap.js"></script>
<script src="<%=basePath%>ckeditor/ckeditor.js"></script>
<script src="<%=basePath%>js/util.js"></script>
</head>
<style>
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.data_list {
	border: 1px solid #E5E5E5;
	padding: 10px;
	background-color: #FDFDFD;
	margin-top: 15px;
}

.data_list .data_list_title {
	font-size: 15px;
	font-weight: bold;
	border-bottom: 1px solid #E5E5E5;
	padding-bottom: 10px;
	padding-top: 5px;
}

.data_list .data_list_title img {
	vertical-align: top;
}

.data_list .diary_datas {
	padding: 5px;
}

.data_list .diary_datas ul {
	list-style-type: none;
}

.data_list .diary_datas ul li {
	margin-top: 15px;
}

.data_list .datas {
	padding: 5px;
}

.data_list .datas ul {
	list-style-type: none;
}

.data_list .datas ul li {
	margin-top: 10px;
}

.data_list .user_image {
	text-align: center;
}

.data_list .user_image img {
	padding-top: 10px;
	width: 200px;;
	height: 250px;;
}

.data_list .nickName, .data_list .userSign {
	text-align: center;
}

.data_list .diary_title {
	margin-top: 20px;
	text-align: center;
}

.data_list .diary_info {
	text-align: center;
}

.data_list .diary_content {
	margin-top: 20px;
}

.data_list .diary_action {
	margin-top: 20px;
}

.data_list .diary_type {
	margin-top: 10px;
}

.data_list .diary_title {
	margin-top: 20px;
	text-align: center;
}

.data_list .data_list_title .diaryType_add {
	float: right;
	margin-right: 20px;
}

.data_list .diaryType_form {
	margin-top: 20px;
}

.form-signin {
	max-width: 300px;
	height: 260px;
	margin: 0 auto;
	background-color: #fff;
	border: 1px solid #e5e5e5;
	border-radius: 5px;
	padding: 15px 60px 50px;
}

input[type="password"] {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 11px;
}
</style>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<span class="brand">${user.nickName }的博客</span>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="active">
							<a href="Diary!list.do">
								<i class="icon-home"></i>
								&nbsp;主页
							</a>
						</li>
						<li class="active">
							<a href="Diary!preSave.do">
								<i class="icon-pencil"></i>
								&nbsp;写博客
							</a>
						</li>
						<li class="active">
							<a href="User!show.do">
								<i class="icon-user"></i>
								&nbsp;个人中心
							</a>
						</li>
						<li class="active">
							<a href="#" data-toggle="modal" data-target="#modify">
								<i class="icon-edit"></i>
								&nbsp;密码修改
							</a>
						</li>
						<li class="active">
							<a href="User!logout.do">
								<i class="icon-off"></i>
								&nbsp;退出
							</a>
						</li>
					</ul>
				</div>
				<form name="myForm" class="navbar-form pull-right" method="get" action="Diary!list.do">
					<input class="span2" name="title" type="text" style="margin-top:5px;height:30px;" placeholder="往事如烟...">
					<button type="submit" class="btn">
						<i class="icon-search"></i>
						&nbsp;搜索日志
					</button>
				</form>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row-fluid">
			<div class="span9">
				<jsp:include page="${empty mainPage ? 'diary/diaryList.jsp' : mainPage }"></jsp:include>
			</div>
			<div class="span3">
				<div class="data_list">
					<div class="data_list_title">
						<img src="images/user_icon.png" />
						个人中心
					</div>
					<div class="user_image">
						<img src="userImages/${user.imageName }" />
					</div>
					<div class="nickName">${user.nickName }</div>
					<div class="userSign">(${user.mood })</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<a class="close" data-dismiss="modal" aria-hidden="true">&times;</a>
					<h4 class="modal-title" id="editLabel">密码修改</h4>
				</div>
				<div class="modal-body">
					<form id="pwd_fm" style="max-width: 360px;margin: 0 auto;">
						<table align="center">
							<tr>
								<td style="text-align: right;">
									<label for="old_pwd">原密码：</label>
								</td>
								<td style="width: 75%;">
									<input id="old_pwd" name="pwd" type="password" class="input-block-level" placeholder="请输入原始密码">
								</td>
							</tr>
							<tr>
								<td style="text-align: right;">
									<label for="new_pwd">新密码：</label>
								</td>
								<td>
									<input id="new_pwd" type="password" class="input-block-level" placeholder="请输入新密码">
								</td>
							</tr>
							<tr>
								<td style="text-align: right;">
									<label for="re_pwd">确认新密码：</label>
								</td>
								<td>
									<input id="re_pwd" name="password" type="password" class="input-block-level" placeholder="请确认新密码">
								</td>
							</tr>
							<tr>
								<td colspan="2" style="color: red;height: 20px;text-align: right;" id="error"></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<a class="btn btn-large btn-default" data-dismiss="modal">关闭</a>
					<a class="btn btn-large btn-primary" onclick="modify()">提交</a>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function() {
				modify = function() {
					var dlg = $("#modify"), fm = $("#pwd_fm"), pwd = $("#old_pwd"), new_pwd = $("#new_pwd"), re_pwd = $("#re_pwd"), error = $("#error");

					if (!$.trim(pwd.val())) return error.html("原密码不能为空");
					if (!$.trim(new_pwd.val())) return error.html("新密码不能为空");
					if (!$.trim(re_pwd.val())) return error.html("确认密码不能为空");
					if (new_pwd.val() != re_pwd.val()) return error.html("两次输入的密码不一致");

					$.post("User!modify.do", fm.serialize(), function(r) {

						if (r.success) {
							// 修改成功，隐藏对话框，清空表单内容
							pwd.val("");
							new_pwd.val("");
							re_pwd.val("");
							error.html("");
							dlg.modal("hide");
							alert("密码修改成功，下次登录生效！");
						} else {
							error.html(r.msg);
						}
					});

				}

			});
		</script>
</body>
</html>
