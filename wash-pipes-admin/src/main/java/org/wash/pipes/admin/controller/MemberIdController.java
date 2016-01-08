package org.wash.pipes.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.wash.pipes.core.model.MemberId;
import org.wash.pipes.core.service.MemberIdService;

@Controller
public class MemberIdController {
	
	@Autowired
	MemberIdService memberIdService; 
	
	@RequestMapping(value = "/memberIdList")
	public String memberIdList(ModelMap modelMap) {
		String memberIdListJson = memberIdService.memberIdList();
		modelMap.addAttribute("localData", memberIdListJson); 
		
		return "/memberIdList";
	}
	
	@RequestMapping(value = "/memberIdInsert") 
	public String memberIdInsert(ModelMap modelMap) {
		modelMap.addAttribute("memberId", new MemberId());
		
		return "/memberIdInsert";
	}
	
	@RequestMapping(value = "/memberIdInsertSubmit") 
	public String memberIdInsertSubmit(
			@ModelAttribute("memberId") MemberId memberId) {
		memberIdService.insertMemberId(memberId);
		
		return "forward:/memberIdList.html";
	}
	
	@RequestMapping(value = "/memberIdQuery") 
	public @ResponseBody String memberIdQuery(@RequestParam String inputMemberId) {
		return String.valueOf(memberIdService.queryMemberIdCount(inputMemberId));
	}

	@RequestMapping(value = "/memberIdDelete") 
	public String memberIdDelete(@RequestParam String deleteMemberId) {
		memberIdService.deleteMemberId(deleteMemberId);
		
		return "forward:/memberIdList.html";
	}

}
