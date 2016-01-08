package org.wash.pipes.core.service;

import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;

public interface EmailNotificationService {
	boolean sendContactNotification(
			ContactInfo contactInfo, ProjectGroup projectGroup, Member member, boolean isFinalMail);
	boolean sendForgetPwdNotification(Member member);
}
