package org.wash.pipes.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.wash.pipes.core.model.MailConfig;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.model.ProjectPageOne;
import org.wash.pipes.core.service.ProjectGroupService;
import org.wash.pipes.core.service.ProjectPageOneService;

@Controller
public class ProjectGroupController {
	
	@Autowired
	ProjectGroupService projectGroupService; 
	@Autowired
	ProjectPageOneService projectPageOneService;
	
	@RequestMapping(value = "/projectGroupList") 
	public String projectGroupList(ModelMap modelMap) {
		String projectGroupListJson = projectGroupService.projectGroupListJson();
		modelMap.addAttribute("localData", projectGroupListJson);
		
		return "/projectGroupList";
	}
	
	@RequestMapping(value = "/projectGroupInsert")
	public String projectGroupInsert(ModelMap modelMap) {
		modelMap.addAttribute("projectGroup", new ProjectGroup());

		return "/projectGroupInsert";
	}
	
	@RequestMapping(value = "/projectGroupInsertSubmit")
	public String projectGroupInsertSubmit(@ModelAttribute("projectGroup") 
					ProjectGroup projectGroup, ModelMap modelMap) {
		
		int mailNum = projectGroup.getMailNum();
		List<MailConfig> mailConfigList = new ArrayList<MailConfig>();
		for(int i=1;i<=mailNum;i++) {
			MailConfig mailConfig = new MailConfig();
			mailConfig.setProjectGroup(projectGroup);
			mailConfig.setMailOrderNum(i);
			mailConfig.setName("第"+i+"封");
			mailConfig.setSubject("第"+i+"封");
			mailConfig.setText("尚未設定內容");
//			mailConfigService.insertMailConfig(mailConfig);
			mailConfigList.add(mailConfig);
			
//			projectGroupService.updateProjectGroup(projectGroup);
		}
		projectGroup.setMailConfigList(mailConfigList);
		projectGroupService.saveProjectGroup(projectGroup);
		
		return "forward:/projectGroupList.html";
	}
	
	@RequestMapping(value = "/projectGroupUpdate")
	public String projectGroupUpdate(@RequestParam String updateProjectGroupId, 
			ModelMap modelMap) {
		ProjectGroup projectGroup = projectGroupService.getProjectGroup(updateProjectGroupId);
		modelMap.addAttribute("projectGroup", projectGroup);

		return "/projectGroupUpdate";
	}
	
	@RequestMapping(value = "/projectGroupUpdateSubmit")
	public String projectGroupUpdateSubmit(@ModelAttribute("projectGroup") 
					ProjectGroup projectGroup, ModelMap modelMap) {
		projectGroupService.mergeProjectGroup(projectGroup);
		
		return "forward:/projectGroupList.html";
	}
	
	@RequestMapping(value = "/projectPageOneUpdateSubmit")
	public String projectPageOneUpdateSubmit(
			@ModelAttribute("projectPageOne") ProjectPageOne projectPageOne, 
			ModelMap modelMap) {
		projectPageOneService.mergeProjectPageOne(projectPageOne);
		
		return "forward:/projectPageOne.html";
	}
	
	@RequestMapping(value = "/projectPageOne") 
	public String projectPageOne(@ModelAttribute("projectGroup") 
			ProjectGroup projectGroup, ModelMap modelMap) {
		
		if(projectGroup.getId()!=null && !projectGroup.getId().equals("NONE")) {
			ProjectPageOne projectPageOne = 
					projectPageOneService.getProjectPageOne(projectGroup.getId());
			if(projectPageOne==null) {
				projectPageOne = new ProjectPageOne();
				projectPageOne.setId(projectGroup.getId());
			}
			
			if(projectPageOne.getProjectGroup()==null)
				projectPageOne.setProjectGroup(projectGroupService.getProjectGroup(projectGroup.getId()));
			modelMap.addAttribute("projectGroupName",projectPageOne.getProjectGroup().getName());
			modelMap.addAttribute("projectPageOne", projectPageOne);
		}else {
			modelMap.addAttribute("projectPageOne", new ProjectPageOne());
		}
		
		return "/projectPageOne";
	}
	
	@RequestMapping(value = "/projectPageOneSelect") 
	public String projectPageOneSelect(ModelMap modelMap) {
		modelMap.put("projectGroup", new ProjectGroup());
		
		return "/projectPageOneSelect";
	}
	
	@RequestMapping(value = "/projectGroupDelete") 
	public String projectGroupDelete(@RequestParam String id) {
		projectGroupService.deleteProjectGroup(id);
		
		return "forward:/projectGroupList.html";
	}
	
	@ModelAttribute("projectGroupList")
	public List<ProjectGroup> getProjectGroupList() {
		List<ProjectGroup> projectGroupList = 
				projectGroupService.projectGroupList();
		
		return projectGroupList;
	}
	
	@RequestMapping(value = "/projectGroupQuery") 
	public @ResponseBody String projectGroupQuery(@RequestParam String inputProjectGroupId) {
		return String.valueOf(projectGroupService.queryProjectGroupCount(inputProjectGroupId));
	}
}
