package org.wash.pipes.core.service.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_STATUS;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.ContactInfoService;

@Service("contactInfoService")
@Transactional
public class ContactInfoServiceImpl implements ContactInfoService {
	
	@Autowired 
	GenericDAO<ContactInfo> genericDAO;
	
	public void insertContactInfo(ContactInfo contactInfo) {
		genericDAO.save(contactInfo);
	}

	public void updateContactInfo(ContactInfo contactInfo) {
		genericDAO.update(contactInfo);
	}
	
	public void deleteContactInfo(ContactInfo contactInfo) {
		genericDAO.delete(contactInfo);
	}

	public ContactInfo getContactInfo(String oid) {
		return genericDAO.get(ContactInfo.class, oid);
	}

	public List<ContactInfo> getContactInfoForNeMailStatus(
			SEND_MAIL_STATUS ...neSendMailStauts) {
//		Calendar cal = Calendar.getInstance();
		Session session = genericDAO.getSession();
		Criteria cr = session.createCriteria(ContactInfo.class);
		for(SEND_MAIL_STATUS stauts:neSendMailStauts) {
			cr.add(Restrictions.ne("sendMailStatus", stauts));
		}
		List<ContactInfo> resultList = cr.list();
		
		return resultList;
	}
	
	public List<ContactInfo> getContactInfoForProjectGroup(
			Member member, ProjectGroup projectGroup) {
//		Calendar cal = Calendar.getInstance();
		Session session = genericDAO.getSession();
		Criteria cr = session.createCriteria(ContactInfo.class);
		if(!member.getAuth().equals("0"))
			cr.add(Restrictions.eq("member", member));
		cr.add(Restrictions.eq("projectGroup", projectGroup));
		List<ContactInfo> resultList = cr.list();
		
		return resultList;
	}
	
	
}
