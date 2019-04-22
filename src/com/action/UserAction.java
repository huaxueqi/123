package com.action;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;

import com.model.User;
import com.util.HibernateUtil;
import com.util.Util;

public class UserAction extends BaseAction<User> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private File image;

	private String pwd;

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	@Override
	public User getModel() {
		// TODO Auto-generated method stub
		return this.model = new User();
	}

	/**
	 * 用户登录
	 * 
	 * @return
	 */
	public String login() {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", model.getUsername());
		User user = userDao.query("from User where username = :username", params);

		HibernateUtil.closeSession();

		if (user == null) {
			request.setAttribute("error", "登录失败，用户名不存在！");
			return LOGIN;
		}

		if (!user.getPassword().equals(model.getPassword())) {
			request.setAttribute("error", "登录失败，密码错误！");
			return LOGIN;
		}

		Util.copyproperties(user, model);

		// 将用户信息存入session中
		setSession("user", model);

		request.setAttribute("mainPage", "diary/diaryList.jsp");

		return "showAll";
	}

	/**
	 * 用户注册
	 * 
	 * @return
	 */
	public String register() {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", model.getUsername());
		User user = userDao.query("from User where username = :username", params);

		if (user != null) throwE("该用户名太火了，再换一个试试吧！");

		userDao.save(model);

		HibernateUtil.closeSession();

		return SUCCESS;
	}

	/**
	 * 修改密码
	 * 
	 * @return
	 */
	public String modify() {
		
		// 将前台传过来的密码与session中比较
		if (!getUser().getPassword().equals(pwd)) throwE("修改失败，原密码错误！");

		User user = userDao.query(User.class, getUser().getId());

		// 更新密码
		user.setPassword(model.getPassword());

		HibernateUtil.closeSession();

		// 更新session信息
		setSession("user", user);

		return SUCCESS;
	}

	/**
	 * 显示个人信息
	 * 
	 * @return
	 */
	public String show() {

		request.setAttribute("mainPage", "user/user.jsp");

		return "main";
	}

	/**
	 * 保存个人信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String save() throws Exception {

		String path = request.getServletContext().getRealPath("/userImages");

		User user = userDao.query(User.class, getUser().getId());

		// 更新用户信息
		Util.copyproperties(model, user);

		// 保存上传的文件
		if (image != null) {
			String imageName = System.currentTimeMillis() + "";
			user.setImageName(imageName);
			FileUtils.copyFile(image, new File(path, imageName));
		}

		HibernateUtil.closeSession();

		// 更新session信息
		setSession("user", user);
		request.setAttribute("mainPage", "user/user.jsp");

		return "user";
	}

	/**
	 * 退出登录，清空session
	 * 
	 * @return
	 * @throws IOException
	 */
	public void logout() throws IOException {
		request.getSession().invalidate();
		response.sendRedirect("");
	}
}
