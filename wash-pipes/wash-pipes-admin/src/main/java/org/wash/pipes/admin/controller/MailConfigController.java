package org.wash.pipes.admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.wash.pipes.core.model.MailConfig;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.MailConfigService;
import org.wash.pipes.core.service.ProjectGroupService;

@Controller
public class MailConfigController {
	
	@Autowired
	MailConfigService mailConfigService; 
	@Autowired
	ProjectGroupService projectGroupService; 
	
	@RequestMapping(value = "/mailConfigSelect") 
	public String mailConfigSelect(ModelMap modelMap) {
		modelMap.put("projectGroup", new ProjectGroup());
		
		return "/mailConfigSelect";
	}
	
	@RequestMapping(value = "/mailConfigList") 
	public String mailConfigList(
			@ModelAttribute("projectGroup") ProjectGroup projectGroup,
			ModelMap modelMap, HttpServletRequest request) {
		
		boolean isFromEditMailConfig = 
				request.getAttribute("projectGroupFromEditMailConfig")!=null;
		if((projectGroup.getId()!=null && !projectGroup.getId().equals("NONE")) 
				|| isFromEditMailConfig) {
//			if(projectGroup.getId()==null)
//				projectGroup = (ProjectGroup)request.getAttribute("projectGroup");
//	
			if(isFromEditMailConfig) {
				projectGroup = (ProjectGroup)request.getAttribute("projectGroupFromEditMailConfig");
				modelMap.addAttribute("projectGroup", projectGroup);
			}
			
			projectGroup = 
					projectGroupService.getProjectGroup(projectGroup.getId());
			
			List<MailConfig> mailConfigList = projectGroup.getMailConfigList();;
//			if(projectGroup.getMailConfigList().isEmpty() || 
//					projectGroup.getMailConfigList() == null) {
//				int mailNum = projectGroup.getMailNum();
//				mailConfigList = new ArrayList<MailConfig>();
//				for(int i=1;i<=mailNum;i++) {
//					MailConfig mailConfig = new MailConfig();
//					mailConfig.setProjectGroup(projectGroup);
//					mailConfig.setMailOrderNum(i);
//					mailConfig.setName("第"+i+"封");
////					mailConfigService.insertMailConfig(mailConfig);
//					mailConfigList.add(mailConfig);
//					projectGroup.setMailConfigList(mailConfigList);
//					projectGroupService.updateProjectGroup(projectGroup);
//				}
//			}else {
//				mailConfigList = projectGroup.getMailConfigList();
//			}
			
			JsonConfig config = new JsonConfig();
			config.setExcludes(new String[]{"projectGroup"});
			JSONArray mailConfigJsonArray = JSONArray.fromObject(mailConfigList,config);
			modelMap.addAttribute("localData", 
					mailConfigJsonArray.toString().replaceAll("oid", "id"));
			modelMap.addAttribute("projectGroupName", projectGroup.getName());
			modelMap.addAttribute("projectGroupId", projectGroup.getId());
		}else {
			modelMap.addAttribute("localData", JSONArray.fromObject(new ArrayList()));
		}

		return "/mailConfigList";
	}
	
	@RequestMapping(value = "/mailConfig") 
	public String mailConfig(@RequestParam String oid, ModelMap modelMap) {
		MailConfig mailConfig = mailConfigService.getMailConfig(oid);
		modelMap.addAttribute("mailConfig", mailConfig);
		
		return "/mailConfig";
	}
	
	@RequestMapping(value = "/mailConfigEditSubmit") 
	public String mailConfigEditSubmit(@ModelAttribute MailConfig mailConfig,
			ModelMap modelMap, HttpServletRequest request) {
		ProjectGroup projectGroup = mailConfig.getProjectGroup();
		mailConfigService.updateMailConfig(mailConfig);
//		modelMap.addAttribute("projectGroup", projectGroup);
		request.setAttribute("projectGroupFromEditMailConfig", projectGroup);
		
		return "forward:/mailConfigList.html";
	}
	
	@ModelAttribute("projectGroupList")
	public List<ProjectGroup> getProjectGroupList() {
		List<ProjectGroup> projectGroupList = 
				projectGroupService.projectGroupList();
		
		return projectGroupList;
	}
	
}
