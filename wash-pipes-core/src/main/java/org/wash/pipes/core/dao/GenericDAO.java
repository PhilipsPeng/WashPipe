package org.wash.pipes.core.dao;

import org.hibernate.Session;

public interface GenericDAO<T> {
	
	T get(Class class_, String id);
	void update(T entity);
	void save(T entity);
	void saveOrUpdate(T entity);
	void persist(T entity);
	void merge(T entity);
	void delete(T entity);
	Session getSession();
	
}
