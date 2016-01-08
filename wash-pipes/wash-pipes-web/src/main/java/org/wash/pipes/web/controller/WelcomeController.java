package org.wash.pipes.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.MemberIdService;
import org.wash.pipes.core.service.ProjectGroupService;

@Controller
public class WelcomeController {
	
	@Autowired 
	ProjectGroupService projectGroupService;
	@Autowired
	MemberIdService memberIdService; 
	
	@RequestMapping("/welcome")
	public String welcome(HttpServletRequest req, ModelMap map, Model model,
			@RequestParam( value = "id", required = false ) String id,
			@RequestParam( value = "projectGroup", required = false ) String projectGroup) {
		System.out.println("id="+id);
		System.out.println("projectGroup="+projectGroup);
		if(StringUtils.isEmpty(projectGroup)) {
			projectGroup = "default";
		}
		
		ProjectGroup prjGroup = 
				projectGroupService.getProjectGroup(projectGroup);
		if(prjGroup==null) {
			projectGroup = "default";
			prjGroup = 
					projectGroupService.getProjectGroup(projectGroup);
		}
		
		String title = prjGroup.getProjectPageOne().getTitle();
		String youtubeLinkOne = prjGroup.getProjectPageOne().getYoutubeLinkOne();
		String youtubeLinkTwo = prjGroup.getProjectPageOne().getYoutubeLinkTwo();
		String submitText = prjGroup.getProjectPageOne().getSubmitText();
		String underText = prjGroup.getProjectPageOne().getUnderText();
		
		map.put("contactInfo", new ContactInfo());
		model.addAttribute("projectGroup", projectGroup);
		model.addAttribute("id", id);
		model.addAttribute("title", title);
		model.addAttribute("youtubeLinkOne", youtubeLinkOne);
		model.addAttribute("youtubeLinkTwo", youtubeLinkTwo);
		model.addAttribute("submitText", submitText);
		model.addAttribute("underText", underText);

		return "welcome";
	}
	
	@RequestMapping(value = "/memberIdQuery") 
	public @ResponseBody String memberIdQuery(@RequestParam String inputMemberId) {
		return String.valueOf(memberIdService.queryMemberIdCount(inputMemberId));
	}

}
