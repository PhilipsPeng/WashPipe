package org.wash.pipes.core.service;

import java.util.List;

import org.wash.pipes.core.model.Customer;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;

public interface CustomerService {
	void insertCustomer(Customer customer);
	void updateCustomer(Customer customer);
	Customer getCustomer(String id);
	List<Customer> getCustomerList(Member member, ProjectGroup projectGroup);
}
