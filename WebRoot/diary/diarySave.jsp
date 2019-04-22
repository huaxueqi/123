<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(function() {
		onSubmit = function() {
			var title = $("#title"), content = $("#content"), error = $("#error");

			if (!$.trim(title.val())) {
				error.html("标题不能为空！");
				return false;
			}

			if (!$.trim(password.val())) {
				error.html("内容不能为空！");
				return false;
			}

			return true;
		}
	});
</script>
<div class="data_list">
	<div class="data_list_title">${empty diary ? '<img src="images/diary_add_icon.png" />写博客':'<img src="images/diary_type_edit_icon.png" />修改博客' }
	</div>
	<form action="Diary!save.do" method="post" onsubmit="return onSubmit()">
		<div>
			<div class="diary_title">
				<input type="text" id="title" name="title" value="${diary.title }" class="input-xlarge"
					style="margin-top:5px;height:30px;" placeholder="博客标题..." />
			</div>
			<div>
				<textarea class="ckeditor" id="content" name="content">${diary.content }</textarea>
			</div>
			<div>
				<input type="hidden" id="diaryId" name="id" value="${diary.id }" />
				<br>
				<input type="submit" class="btn btn-primary" value="保存" />
				<button class="btn btn-primary" type="button" onclick="javascript:history.back()">返回</button>
				<font id="error" color="red">${error }</font>
			</div>
		</div>
	</form>
</div>