<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
	if (${empty mainPage}) {
		location.href = "Diary!list.do";
	}
</script>
<div class="data_list">
	<div class="data_list_title">
		<img src="images/list_icon.png" />
		博客列表
	</div>
	<div class="diary_datas">
		<ul id="diary_list">
			${fn:length(diaryList)==0 ? "<h4>没有数据</h4>" : "" }
			<c:forEach var="diary" items="${diaryList }">
				<li>
					『 ${diary.releaseDate } 』
					<span>
						&nbsp;
						<a href="Diary!show.do?id=${diary.id }">${diary.title }</a>
					</span>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="pagination pagination-centered">
		<ul>${pageCode }</ul>
	</div>
</div>