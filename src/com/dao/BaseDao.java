package com.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface BaseDao<T> {

	/**
	 * 直接执行一条Hql语句
	 * 
	 * @param hql
	 * @return
	 */
	public int executeHql(String hql);

	/**
	 * 获取一个对象
	 * 
	 * @param c
	 * @param id
	 * @return
	 */
	public T query(Class<T> c, Serializable id);

	/**
	 * 直接执行一条Hql语句查询
	 * 
	 * @param hql
	 * @return
	 */
	public T query(String hql);

	/**
	 * 查询一个字段，返回一个结果集
	 * 
	 * @param hql
	 * @return
	 */
	public List<T> find(String hql);

	/**
	 * 多个字段查询，返回一条记录
	 * 
	 * @param hql
	 * @param params
	 * @return
	 */
	public T query(String hql, Map<String, Object> params);

	/**
	 * 多个字段查询，返回一条结果集
	 * 
	 * @param hql
	 * @param params
	 * @return
	 */
	public List<T> find(String hql, Map<String, Object> params);

	/**
	 * 传参数分页
	 * 
	 * @param hql
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<T> find(String hql, Map<String, Object> params, int page, int rows);

	/**
	 * 传参数查询数据总数量
	 * 
	 * @param hql
	 * @param params
	 * @return
	 */
	public Long total(String hql, Map<String, Object> params);

	/**
	 * 添加
	 * 
	 * @param object
	 * @return
	 */
	public Serializable save(T object);

	/**
	 * 删除
	 * 
	 * @param object
	 */
	public void delete(T object);


}
