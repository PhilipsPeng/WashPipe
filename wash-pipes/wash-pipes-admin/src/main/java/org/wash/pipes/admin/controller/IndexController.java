package org.wash.pipes.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.ProjectGroupService;

@Controller
public class IndexController {
	
	@Autowired
	ProjectGroupService projectGroupService;
	
	@RequestMapping(value = "/index")
	public String index(ModelMap map) {
		map.put("member", new Member());

		return "login";
	}
	

	@RequestMapping(value = "/main")
	public String main(HttpServletRequest request) {

		return "/main";
	}
	
	@RequestMapping(value = "/top")
	public String top(HttpServletRequest request) {

		return "/top";
	}

	@RequestMapping(value = "/menu")
	public String menu(HttpServletRequest request, ModelMap modelMap) {
		
		return "/menu";
	}

	@RequestMapping(value = "/template")
	public String template(HttpServletRequest request) {

		return "/template";
	}
	
	@RequestMapping(value = "/publicLink")
	public String publicLink(ModelMap modelMap) {
		List<ProjectGroup> projectGroupList = projectGroupService.projectGroupList();
		modelMap.addAttribute("projectGroupList", projectGroupList);
		
		return "/publicLink";
	}

}
