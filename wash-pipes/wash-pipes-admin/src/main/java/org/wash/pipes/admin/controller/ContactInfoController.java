package org.wash.pipes.admin.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.ContactInfoService;
import org.wash.pipes.core.service.MemberService;
import org.wash.pipes.core.service.ProjectGroupService;

import au.com.bytecode.opencsv.CSVWriter;

@Controller
public class ContactInfoController {

	@Autowired
	ContactInfoService contactInfoService;
	@Autowired
	MemberService memberService;
	@Autowired
	ProjectGroupService projectGroupService;
	
	@RequestMapping(value = "/contactInfoList")
	public String contactInfoList(ModelMap modelMap, HttpSession session, 
			@ModelAttribute("projectGroup") ProjectGroup projectGroup, 
			HttpServletRequest request)
			throws Exception {
		
		boolean isFromDeleteContactInfo = request.getAttribute("projectGroupFromDeleteContactInfo")!=null;
		if(projectGroup.getId()!=null || isFromDeleteContactInfo) {
			Member member = (Member)session.getAttribute("loginMember");
			if(member==null) {
				return "/sessionExpire";
			}
			if(isFromDeleteContactInfo) {
				projectGroup = (ProjectGroup)request.getAttribute("projectGroupFromDeleteContactInfo");
				modelMap.addAttribute("projectGroup", projectGroup);
			}
			member = memberService.getMember(member.getId());
			JsonConfig config = new JsonConfig();
			config.setExcludes(new String[]{"member","projectGroup"});
			List<ContactInfo> contactInfoList = 
					contactInfoService.getContactInfoForProjectGroup(member, projectGroup);

			JSONArray contactInfoJsonArray = 
				JSONArray.fromObject(contactInfoList,config);
			modelMap.addAttribute("localData", contactInfoJsonArray.toString().replace("oid", "id"));
			session.setAttribute("contactInfoList", contactInfoList);
		}else {
			modelMap.addAttribute("localData", JSONArray.fromObject(new ArrayList()));
		}
		
		return "/contactInfoList";
	}
	
	@RequestMapping(value = "/contactInfoDelete") 
	public String contactInfoDelete(@RequestParam String deleteContactInfoOid, 
			HttpSession session, HttpServletRequest request) {
		Member member = (Member)session.getAttribute("loginMember");
		if(member==null) {
			return "/sessionExpire";
		}
		ContactInfo contactInfo = contactInfoService.getContactInfo(deleteContactInfoOid);
		ProjectGroup projectGroup = contactInfo.getProjectGroup();
		contactInfoService.deleteContactInfo(contactInfo);
		
		request.setAttribute("projectGroupFromDeleteContactInfo", projectGroup);
		
		return "forward:/contactInfoList.html";
	}
	
	@RequestMapping(value = "/contactInfoSelect") 
	public String contactInfoSelect(ModelMap modelMap) {
		modelMap.put("projectGroup", new ProjectGroup());
		
		return "/contactInfoSelect";
	}
	
	@RequestMapping(value = "/downloadCsv") 
	public void downloadCsv(HttpSession session, ModelMap modelMap,
			HttpServletResponse response) {
		
		String csvFileName = "data.csv";
	
		response.setContentType("text/csv");
		String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"",
                csvFileName);
        response.setHeader(headerKey, headerValue);
		
		List<ContactInfo> contactInfoList = 
				(List<ContactInfo>)session.getAttribute("contactInfoList");

		String[] column = new String[]{"姓名", "Mail", "建立時間"};
		
		try {
			OutputStream resOs= response.getOutputStream();  
			OutputStream buffOs= new BufferedOutputStream(resOs);   
			OutputStreamWriter outputwriter = new OutputStreamWriter(buffOs,"BIG5");
			CSVWriter writer = new CSVWriter(outputwriter);
			writer.writeNext(column);
			for(ContactInfo c:contactInfoList) {
				String[] contactStrArray = new String[3];
				contactStrArray[0] = c.getName();
				contactStrArray[1] = c.getEmail();
				contactStrArray[2] = c.getCreateTime();
				writer.writeNext(contactStrArray);
			}
			writer.flush();
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@ModelAttribute("projectGroupList")
	public List<ProjectGroup> getProjectGroupList() {
		List<ProjectGroup> projectGroupList = 
				projectGroupService.projectGroupList();
		
		return projectGroupList;
	}
}
