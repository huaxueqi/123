package com.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.dao.BaseDao;
import com.util.HibernateUtil;

@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> implements BaseDao<T> {

	@Override
	public int executeHql(String hql) {
		return HibernateUtil.getSession().createQuery(hql).executeUpdate();
	}

	@Override
	public T query(Class<T> c, Serializable id) {
		return (T) HibernateUtil.getSession().get(c, id);
	}

	@Override
	public T query(String hql) {
		Query query = HibernateUtil.getSession().createQuery(hql);
		List<T> list = query.list();
		if (list != null && list.size() > 0) { return list.get(0); }
		return null;
	}

	@Override
	public List<T> find(String hql) {

		Query query = HibernateUtil.getSessionFactory().openSession().createQuery(hql);
		return query.list();
	}

	@Override
	public T query(String hql, Map<String, Object> params) {
		Query query = HibernateUtil.getSession().createQuery(hql);

		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				query.setParameter(key, params.get(key));
			}
		}
		List<T> list = query.list();

		if (list != null && list.size() > 0) { return list.get(0); }
		return null;
	}

	@Override
	public List<T> find(String hql, Map<String, Object> params) {
		Query query = HibernateUtil.getSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				query.setParameter(key, params.get(key));
			}
		}
		return query.list();
	}

	@Override
	public List<T> find(String hql, Map<String, Object> params, int page, int rows) {
		Query query = HibernateUtil.getSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				query.setParameter(key, params.get(key));
			}
		}
		return query.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	@Override
	public Long total(String hql, Map<String, Object> params) {
		Query query = HibernateUtil.getSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				query.setParameter(key, params.get(key));
			}
		}
		return (Long) query.uniqueResult();
	}

	@Override
	public Serializable save(T object) {
		return HibernateUtil.getSession().save(object);
	}

	@Override
	public void delete(T object) {
		HibernateUtil.getSession().delete(object);
	}

}
