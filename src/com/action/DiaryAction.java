package com.action;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model.Diary;
import com.model.User;
import com.util.HibernateUtil;
import com.util.Util;

public class DiaryAction extends BaseAction<Diary> {

	@Override
	public Diary getModel() {
		// TODO Auto-generated method stub
		return this.model = new Diary();
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String list() {
		Map<String, Object> params = new HashMap<String, Object>();

		// 用户只能获取自己的博客列表
		params.put("user", getUser().getId());

		String hql = "from Diary where user.id = :user";

		if (model.getTitle() != null && !"".equals(model.getTitle().trim())) {
			params.put("title", "%" + model.getTitle() + "%");
			hql += " and title like :title";
		}

		List<Diary> list = diaryDao.find(hql, params, getPage(), 10);
		String pageCode = this.genPagation(diaryDao.total("select count(*) " + hql, params), getPage(), 10);

		request.setAttribute("pageCode", pageCode);
		request.setAttribute("diaryList", list);
		request.setAttribute("mainPage", "diary/diaryList.jsp");

		HibernateUtil.closeSession();

		return "main";
	}

	/**
	 * 计算分页
	 * 
	 * @param total
	 * @param page
	 * @param pageSize
	 * @return
	 */
	private String genPagation(long total, int page, int pageSize) {
		long totalPage = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;
		StringBuilder pageCode = new StringBuilder();
		if (page <= 1) {
			pageCode.append("<li class='disabled'><a>首页</a></li>");
			pageCode.append("<li class='disabled'><a>上一页</a></li>");
		} else {
			pageCode.append("<li><a href='Diary!list.do?page=1'>首页</a></li>");
			pageCode.append("<li><a href='Diary!list.do?page=" + (page - 1) + "'>上一页</a></li>");
		}
		for (int i = page - 2; i <= page + 2; i++) {
			if (i < 1 || i > totalPage) {
				continue;
			}
			if (i == page) {
				pageCode.append("<li class='active'><a>" + i + "</a></li>");
			} else {
				pageCode.append("<li><a href='Diary!list.do?page=" + i + "'>" + i + "</a></li>");
			}
		}
		if (page >= totalPage) {
			pageCode.append("<li class='disabled'><a>下一页</a></li>");
			pageCode.append("<li class='disabled'><a>尾页</a></li>");
		} else {
			pageCode.append("<li><a href='Diary!list.do?page=" + (page + 1) + "'>下一页</a></li>");
			pageCode.append("<li><a href='Diary!list.do?page=" + totalPage + "'>尾页</a></li>");
		}

		return pageCode.toString();
	}

	public String show() {
		request.setAttribute("diary", diaryDao.query(Diary.class, model.getId()));
		request.setAttribute("mainPage", "diary/diaryShow.jsp");
		HibernateUtil.closeSession();

		return "main";
	}

	/**
	 * 保存博客
	 * 
	 * @return
	 */
	public String save() {

		if (model.getId() != null) {
			Util.copyproperties(model, diaryDao.query(Diary.class, model.getId()));
		} else {
			model.setReleaseDate(new Timestamp(System.currentTimeMillis()));
			// 保存博客时设置博客作者
			model.setUser(userDao.query(User.class, getUser().getId()));
			diaryDao.save(model);
		}

		HibernateUtil.closeSession();

		request.setAttribute("mainPage", "diary/diaryList.jsp");

		return "showAll";
	}

	/**
	 * @return
	 */
	public String preSave() {

		if (model.getId() != null) {
			request.setAttribute("diary", diaryDao.query(Diary.class, model.getId()));
			HibernateUtil.closeSession();
		}
		request.setAttribute("mainPage", "diary/diarySave.jsp");

		return "main";
	}

	/**
	 * 删除一条博客
	 * 
	 * @return
	 */
	public String del() {
		diaryDao.delete(diaryDao.query(Diary.class, model.getId()));
		HibernateUtil.closeSession();
		return "main";
	}
}
