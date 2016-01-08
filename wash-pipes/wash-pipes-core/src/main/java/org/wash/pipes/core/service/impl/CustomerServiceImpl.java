package org.wash.pipes.core.service.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.Customer;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.CustomerService;

@Service("customerService")
@Transactional
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired 
	GenericDAO<Customer> genericDAO;

	public void insertCustomer(Customer customer) {
		genericDAO.save(customer);
	}
	
	public void updateCustomer(Customer customer) {
		genericDAO.update(customer);
	}

	public Customer getCustomer(String id) {
		Customer customer = genericDAO.get(Customer.class, id);
		return customer;
	}

	public List<Customer> getCustomerList(Member member, ProjectGroup projectGroup) {
		Session session = genericDAO.getSession();
		Criteria cr = session.createCriteria(Customer.class);
		cr.add(Restrictions.eq("projectGroup", projectGroup));
		if(member.getAuth().equals("1"))
			cr.add(Restrictions.eq("member", member));
		List<Customer> resultList = cr.list();
		
		return resultList;
	}

}
