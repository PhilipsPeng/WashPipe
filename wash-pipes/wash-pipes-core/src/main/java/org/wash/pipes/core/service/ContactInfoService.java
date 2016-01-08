package org.wash.pipes.core.service;

import java.util.List;

import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_STATUS;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;

public interface ContactInfoService {
	
	void insertContactInfo(ContactInfo contactInfo);
	void updateContactInfo(ContactInfo contactInfo);
	void deleteContactInfo(ContactInfo contactInfo);
	ContactInfo getContactInfo(String oid);
	List<ContactInfo> getContactInfoForNeMailStatus(
			SEND_MAIL_STATUS ...neSendMailStatus);
	List<ContactInfo> getContactInfoForProjectGroup(Member member, ProjectGroup projectGroup);
	
}
