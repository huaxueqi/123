<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function diaryDelete(id) {
		if (confirm("您确定要删除这条博客吗？")) {
			location.href = "Diary!del.do?id=" + id;
		}
	}
</script>
<div class="data_list">
	<div class="data_list_title">
		<img src="images/diary_show_icon.png" />
		博客信息
	</div>
	<div>
		<div class="diary_title">
			<h3>${diary.title }</h3>
		</div>
		<div class="diary_info">发布时间：『${diary.releaseDate }』</div>
		<div class="diary_content">${diary.content }</div>
		<div class="diary_action">
			<button class="btn btn-primary" type="button" onclick="location.href='Diary!preSave.do?id=${diary.id}'">修改博客</button>
			<button class="btn btn-primary" type="button" onclick="javascript:history.back()">返回</button>
			<button class="btn btn-danger" type="button" onclick="diaryDelete(${diary.id})">删除博客</button>
		</div>
	</div>
</div>