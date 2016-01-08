package org.wash.pipes.admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.wash.pipes.core.model.Customer;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.CustomerService;
import org.wash.pipes.core.service.MemberService;
import org.wash.pipes.core.service.ProjectGroupService;

@Controller
public class CustomerController {
	
	@Autowired
	ProjectGroupService projectGroupService;
	@Autowired
	CustomerService customerService;
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/customerList")
	public String customerList(ModelMap modelMap, HttpSession session, 
			HttpServletRequest request,
			@ModelAttribute("projectGroup") ProjectGroup projectGroup)
			throws Exception {
		Member member = (Member)session.getAttribute("loginMember");
		if(member==null) {
			return "/sessionExpire";
		}
		boolean isFromUpdateStatus = request.getAttribute("projectGroupFromUpdateStatus")!=null;
		
		if(projectGroup.getId()!=null || isFromUpdateStatus) {
			if(isFromUpdateStatus) {
				projectGroup = (ProjectGroup)request.getAttribute("projectGroupFromUpdateStatus");
				modelMap.addAttribute("projectGroup", projectGroup);
			}	
			JsonConfig config = new JsonConfig();
			config.setExcludes(new String[]{"member","projectGroup"});
			
			member = memberService.getMember(member.getId());
			
			List<Customer> customerList = 
					customerService.getCustomerList(member, projectGroup);
			
			JSONArray customerJsonArray = 
				JSONArray.fromObject(customerList, config);
			modelMap.addAttribute("localData", customerJsonArray.toString().replace("oid", "id"));
		}else {
			modelMap.addAttribute("localData", JSONArray.fromObject(new ArrayList()));
		}
		
		return "/customerList";
	}
	
	
	@RequestMapping(value = "/customerSelect") 
	public String customerSelect(ModelMap modelMap) {
		modelMap.put("projectGroup", new ProjectGroup());
		
		return "/customerSelect";
	}
	
	@RequestMapping(value = "/updateCustomerStatus")
	public String updateCustomerStatus(@RequestParam String ids,
			@RequestParam String status, ModelMap modelMap, HttpServletRequest request) {
		String[] idArray = ids.split(",");
		ProjectGroup projectGroup = null;
		for(String id:idArray) {
			Customer customer = customerService.getCustomer(id);
			customer.setStatus(status);
			projectGroup = customer.getProjectGroup();
			customerService.updateCustomer(customer);
		}
		request.setAttribute("projectGroupFromUpdateStatus", projectGroup);
		
		return "forward:/customerList.html";
	}
	
	@ModelAttribute("projectGroupList")
	public List<ProjectGroup> getProjectGroupList() {
		List<ProjectGroup> projectGroupList = 
				projectGroupService.projectGroupList();
		
		return projectGroupList;
	}
	
}
