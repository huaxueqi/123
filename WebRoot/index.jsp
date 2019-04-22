<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>个人博客登录</title>
<link href="<%=basePath%>bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
<script src="<%=basePath%>bootstrap/js/jquery-1.11.1.js"></script>
<script src="<%=basePath%>bootstrap/js/bootstrap.js"></script>
<script src="<%=basePath%>js/util.js"></script>
<style type="text/css">
body {
	padding-top: 8%;
	background-image: url('images/star.gif');
}

.modal.fade.in {
	top: 25%;
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

input[type="text"], input[type="password"] {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 11px;
}
</style>
</head>
<script type="text/javascript">
	$(function() {
		onSubmit = function() {
			var username = $("#username"), password = $("#password"), error = $("#error");

			if (!$.trim(username.val())) {
				error.html("用户名不能为空");
				return false;
			}

			if (!$.trim(password.val())) {
				error.html("密码不能为空");
				return false;
			}

			return true;
		}

		/**
		 *用户注册
		 */
		register = function() {
			var fm = $("#reg_fm"), uname = $("#uname"), nick = $("#nick"), pwd = $("#pwd"), error = $("#reg_error");

			if (!$.trim(uname.val())) return error.html("用户名不能为空");
			if (!$.trim(nick.val())) return error.html("昵称不能为空");
			if (!$.trim(pwd.val())) return error.html("密码不能为空");

			// 用ajax进行数据提交
			$.post("User!register.do", fm.serialize(), function(r) {

				if (r.success) {
					$("#username").val(uname.val());
					// 注册成功，隐藏注册对话框，清空表单内容
					uname.val("");
					pwd.val("");
					nick.val("");
					error.html("");
					$("#register").modal("hide");
					alert("注册成功！");
				} else {
					error.html(r.msg);
				}
			});
		}
	})
</script>
<body>
	<div class="container">
		<form action="User!login.do" method="post" id="user_fm" class="form-signin" onsubmit="return onSubmit()">
			<h2 style="text-align: center;">个人博客</h2>
			<input id="username" name="username" type="text" class="input-block-level" placeholder="用户名" required autofocus>
			<input id="password" name="password" type="password" class="input-block-level" placeholder="密码" required>
			<input class="btn btn-large btn-primary btn-block" type="submit" value="登录" />
			<a class="btn btn-large btn-default btn-block" data-toggle="modal" data-target="#register">注册</a>
			<p id="error" style="height: 20px;color: red;margin: 10px 0;">${error }</p>
		</form>
	</div>

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="register" tabindex="-1" role="dialog" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<a class="close" data-dismiss="modal" aria-hidden="true">&times;</a>
					<h4 class="modal-title" id="registerLabel">用户注册</h4>
				</div>
				<div class="modal-body">
					<form id="reg_fm">
						<table align="center">
							<tr>
								<td>
									<label for="uname">用户名：</label>
								</td>
								<td style="width: 85%;">
									<input id="uname" name="username" type="text" class="input-block-level" placeholder="赶紧抢注个响亮的用户名">
								</td>
							</tr>
							<tr>
								<td>
									<label for="nick">昵&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
								</td>
								<td>
									<input id="nick" name="nickName" type="text" class="input-block-level" placeholder="来个霸气侧漏的昵称">
								</td>
							</tr>
							<tr>
								<td>
									<label for="pwd">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
								</td>
								<td>
									<input id="pwd" name="password" type="password" class="input-block-level" placeholder="千万要记住密码哦">
								</td>
							</tr>
							<tr>
								<td colspan="2" style="color: red;height: 20px;" id="reg_error"></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<a class="btn btn-large btn-default" data-dismiss="modal">关闭</a>
					<a class="btn btn-large btn-primary" onclick="register()">注册</a>
				</div>
			</div>
		</div>
</body>
</html>