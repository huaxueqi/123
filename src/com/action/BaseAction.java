package com.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.dao.BaseDao;
import com.dao.impl.BaseDaoImpl;
import com.model.Diary;
import com.model.User;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public abstract class BaseAction<T> extends ActionSupport implements ModelDriven<T>, ServletRequestAware, ServletResponseAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected T model;

	protected int page = 1;

	private Object root;

	protected HttpServletRequest request;

	protected HttpServletResponse response;

	protected BaseDao<User> userDao = new BaseDaoImpl<User>();

	protected BaseDao<Diary> diaryDao = new BaseDaoImpl<Diary>();

	private Map<String, Object> temp = new HashMap<String, Object>();

	public BaseAction() {
		temp.put("success", true);
		this.root = temp;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public Object getRoot() {
		return root;
	}

	public void setRoot(Object root) {
		this.root = root;
	}

	public T getModel() {
		return model;
	}

	public void setModel(T model) {
		this.model = model;
	}

	public void put(String key, Object value) {
		this.temp.put(key, value);
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request = request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = response;
	}

	/**
	 * 抛出一个自定义异常消息
	 * 
	 * @param message
	 */
	protected void throwE(String message) {
		throw new RuntimeException(message);
	}

	/**
	 * 存入session
	 * 
	 * @param user
	 */
	protected void setSession(String key, Object value) {
		request.getSession().setAttribute(key, value);
	}

	/**
	 * 获取session
	 * 
	 * @return
	 */
	protected User getUser() {
		return (User) request.getSession().getAttribute("user");
	}

}
