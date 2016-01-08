package org.wash.pipes.core.dao.impl;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.wash.pipes.core.dao.GenericDAO;

@Repository("genericDAO")
public class GenericDAOImpl<T> implements GenericDAO<T> {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	
	public T get(Class class_, String id) {
		return (T)hibernateTemplate.get(class_, id);
	}

	public void update(T entity) {
		hibernateTemplate.update(entity);
	}

	public void save(T entity) {
		hibernateTemplate.save(entity);
	}

	public void persist(T entity) {
		hibernateTemplate.persist(entity);
	}

	public void merge(T entity) {
		hibernateTemplate.merge(entity);
	}

	public Session getSession() {
		return hibernateTemplate.getSessionFactory().getCurrentSession();
	}

	public void saveOrUpdate(T entity) {
		hibernateTemplate.saveOrUpdate(entity);
	}

	public void delete(T entity) {
		hibernateTemplate.delete(entity);
		
	}
	
}
