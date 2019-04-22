$(function() {
	var list = $('#diary_list');

	$.post("Diary!list.do", function(rs) {
		rs.forEach(function(data) {
			list.append("<li>『" + data.releaseDate + "』<a href='Diary_show.do?id=" + data.id + "'>" + data.title
					+ "</a></li>");
		});
	});
})