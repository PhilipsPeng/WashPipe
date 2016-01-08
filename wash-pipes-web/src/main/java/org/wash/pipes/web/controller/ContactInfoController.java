package org.wash.pipes.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_PROCESS;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_STATUS;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.ContactInfoService;
import org.wash.pipes.core.service.EmailNotificationService;
import org.wash.pipes.core.service.MemberService;
import org.wash.pipes.core.service.ProjectGroupService;
import org.wash.pipes.core.util.DateUtil;

@Controller
public class ContactInfoController {

	@Autowired
	ContactInfoService contactInfoService;
	@Autowired
	ProjectGroupService projectGroupService;
	@Autowired
	MemberService memberService;
	@Autowired
	EmailNotificationService emailNotificationService;

	@RequestMapping(value = "/insertContactInfo")
	public String insertContactInfo(
			@ModelAttribute("contactInfo") ContactInfo contactInfo,
			BindingResult result, 
			@RequestParam( value = "id", required = false ) String id,
			@RequestParam( value = "projectGroupId", required = false ) String projectGroupId) throws Exception {

		System.out.println("id="+id);
		if(StringUtils.isEmpty(id))
			id = "admin";
		Member member = memberService.getMember(id);
		if(member==null)
			throw new Exception("會員ID不存在");
		ProjectGroup projectGroup = projectGroupService.getProjectGroup(projectGroupId);
		System.out.println(member.getName());
		contactInfo.setMember(member);
		contactInfo.setCreateTime(DateUtil.currentTime());
//		contactInfo.setSendMailStatus(SEND_MAIL_STATUS.INITIAL);
		contactInfo.setSendMailProcess(SEND_MAIL_PROCESS.FIRST);
		contactInfo.setProjectGroup(projectGroup);
		contactInfoService.insertContactInfo(contactInfo);
//		if(!mailConfigList.isEmpty()) {
			boolean isSendSuccess = 
				emailNotificationService.sendContactNotification(
						contactInfo, projectGroup, member, false);
			if(isSendSuccess) {
//				if(projectGroup.getMailNum()==SEND_MAIL_STATUS.FIRST.getMailNum()) {
//					contactInfo.setSendMailStatus(SEND_MAIL_STATUS.FINISH);
//				}else {
//					contactInfo.setSendMailStatus(SEND_MAIL_STATUS.FIRST);
//				}
				contactInfo.setSendMailStatus(SEND_MAIL_STATUS.SUCCESS);
				
			}else {
				contactInfo.setSendMailStatus(SEND_MAIL_STATUS.FAIL);
			}
			contactInfo.setSendMailTime(DateUtil.currentTime());
//		}else {
//			contactInfo.setSendMailStatus(SEND_MAIL_STATUS.MAIL_CONFIG_EMPTY);
//		}
		
		contactInfoService.updateContactInfo(contactInfo);

		return "contactInfoSuccess";
	}

	@ExceptionHandler(Exception.class)
	public ModelAndView handleAllException(Exception ex) {

		ModelAndView model = new ModelAndView("error");
		return model;

	}

}
