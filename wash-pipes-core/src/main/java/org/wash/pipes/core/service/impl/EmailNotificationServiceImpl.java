package org.wash.pipes.core.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_PROCESS;
import org.wash.pipes.core.model.MailConfig;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.EmailNotificationService;
import org.wash.pipes.core.service.ProjectGroupService;

@Service("emailNotificationService")
public class EmailNotificationServiceImpl implements EmailNotificationService {

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private ProjectGroupService projectGroupService;
	@Autowired
	private VelocityEngine velocityEngine;
	
	@Transactional
	public boolean sendContactNotification(
			final ContactInfo contactInfo, 
			final ProjectGroup projectGroup, 
			final Member member, 
			final boolean isFinalMail) {
		boolean isSendSuccess = false;
		Map<Integer,MailConfig> mailConfigMap = new HashMap<Integer,MailConfig>();
		projectGroupService.updateProjectGroup(projectGroup);
		List<MailConfig> mailConfigList = projectGroup.getMailConfigList();
		for(MailConfig mailConfig:mailConfigList) {
			mailConfigMap.put(mailConfig.getMailOrderNum(), mailConfig);
		}
		final MailConfig mailConfig;
		switch (contactInfo.getSendMailProcess()) {
		case FIRST:
			mailConfig = mailConfigMap.get(SEND_MAIL_PROCESS.FIRST.getMailNum());
			break;
		case SECOND:
			mailConfig = mailConfigMap.get(SEND_MAIL_PROCESS.SECOND.getMailNum());
			break;
		case THIRD:
			mailConfig = mailConfigMap.get(SEND_MAIL_PROCESS.THIRD.getMailNum());
			break;
		case FOURTH:
			mailConfig = mailConfigMap.get(SEND_MAIL_PROCESS.FOURTH.getMailNum());
			break;
		case FIFTH:
			mailConfig = mailConfigMap.get(SEND_MAIL_PROCESS.FIFTH.getMailNum());
			break;
		default:
			mailConfig = new MailConfig();
			break;
		}
		final String mailTemplate = "contactInfoNotification.vm";
		final String subject = mailConfig.getSubject();

		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@SuppressWarnings({ "rawtypes", "unchecked" })
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
				String name = MimeUtility.encodeText("林劉璋"); 
				message.setFrom(new InternetAddress(
						name+"<noreply@pipelin.com>"));
				message.setTo(new InternetAddress(contactInfo.getEmail()));
				message.setSubject(subject);
				message.setSentDate(new Date());
				Map model = new HashMap();
				model.put("contact", contactInfo);
				model.put("projectGroup", projectGroup);
				model.put("member", member);
				model.put("isFinalMail", isFinalMail);
				model.put("text", mailConfig.getText());

				String text = VelocityEngineUtils.mergeTemplateIntoString(
						velocityEngine, mailTemplate,
						"UTF-8", model);
				message.setText(text, true);
			}
		};
		
		try {
			mailSender.send(preparator);
			isSendSuccess = true;
		}catch(MailException e) {
			e.printStackTrace();
		}
		
		return isSendSuccess;
		
	}

	public boolean sendForgetPwdNotification(final Member member) {
		boolean isSendSuccess = false;
		
		final String mailTemplate = "forgetPasswordNotification.vm";
		final String subject = "水管達人管理新密碼";

		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@SuppressWarnings({ "rawtypes", "unchecked" })
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
				String name = MimeUtility.encodeText("林劉璋"); 
				message.setFrom(new InternetAddress(
						name+"<noreply@pipelin.com>"));
				message.setTo(new InternetAddress(member.getMail()));
				message.setSubject(subject);
				message.setSentDate(new Date());
				Map model = new HashMap();
				model.put("member", member);

				String text = VelocityEngineUtils.mergeTemplateIntoString(
						velocityEngine, mailTemplate,
						"UTF-8", model);
				message.setText(text, true);
			}
		};
		
		try {
			mailSender.send(preparator);
			isSendSuccess = true;
		}catch(MailException e) {
			e.printStackTrace();
		}
		
		return isSendSuccess;
	}

	
}
