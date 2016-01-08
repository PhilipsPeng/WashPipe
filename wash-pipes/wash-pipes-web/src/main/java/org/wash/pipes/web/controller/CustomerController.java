package org.wash.pipes.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.wash.pipes.core.model.Customer;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.service.CustomerService;
import org.wash.pipes.core.service.MemberService;
import org.wash.pipes.core.service.ProjectGroupService;

@Controller
public class CustomerController {

	@Autowired
	CustomerService customerService;
	@Autowired
	MemberService memberService;
	@Autowired
	ProjectGroupService projectGroupService;

	@RequestMapping(value = "/customerPage")
	public String customerPage(
			@RequestParam( value = "projectGroup") String projectGroupId,
			@RequestParam( value = "id") String memberId,
			HttpServletRequest request, ModelMap map) {
		Customer customer = new Customer();
//		customer.setProjectGroup(projectGroupService.getProjectGroup(projectGroup));
		customer.setHoliday("1");
//		customer.setContactInterval(CONTACT_INTERVAL.MORNING);
		customer.setContactInterval("MORNING");
		map.put("customer", customer);
		request.setAttribute("projectGroupId", projectGroupId);
		request.setAttribute("id", memberId);

		return "customerPage";
	}

	@RequestMapping(value = "/insertCustomer")
	public String insertCustomer (
			@ModelAttribute("Customer") Customer customer,
			BindingResult result,
			@RequestParam( value = "projectGroupId", required = false) String projectGroupId,
			@RequestParam( value = "id", required = false) String memberId
			) {
//		List<ObjectError> errors = result.getAllErrors();
//		for(ObjectError o:errors) {
//			System.out.println("@@@@@@"+o.getDefaultMessage());
//		}
		Member member = memberService.getMember(memberId);
		System.out.println("====xxxxxx===="+member.getName());
		customer.setMember(member);
		customer.setStatus("-1");
		customer.setProjectGroup(projectGroupService.getProjectGroup(projectGroupId));;
		customerService.insertCustomer(customer);
		
		return "customerSuccess";
	}

	@ExceptionHandler(Exception.class)
	public ModelAndView handleAllException(Exception ex) {

		ModelAndView model = new ModelAndView("error");
		return model;

	}

}
