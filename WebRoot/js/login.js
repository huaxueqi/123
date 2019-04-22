$(function() {
	/**
	 * 回车按钮监听
	 */
	$('#user_fm').keypress(function(e) {
		if (e.keyCode == 13) {
			login();
		}
	});

	/**
	 * 用户登录
	 * 
	 * @returns
	 */
	login = function() {
		var username = $('#username'), password = $('#password'), error = $('#error');

		if (!$.trim(username.val())) return error.html('用户名不能为空');

		if (!$.trim(password.val())) return error.html('密码不能为空');

		/**
		 * 利用Ajax进行表单异步提交
		 */

		$.ajax({
			url : 'User!login.do',
			method : 'post',
			data : $('#user_fm').serializeObject(),
			success : function(r) {
				if (r.success) {
					location.href = 'main.jsp';
				} else {
					error.html(r.msg);
				}
			},
			error : function(r) {

			}
		})
	}
});