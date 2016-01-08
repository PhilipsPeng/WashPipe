package org.wash.pipes.core.service.impl;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.MailConfig;
import org.wash.pipes.core.service.MailConfigService;

@Service("mailConfigService")
public class MailConfigServiceImpl implements MailConfigService {
	
	@Autowired
	GenericDAO<MailConfig> genericDAO;
	
	public void insertMailConfig(MailConfig mailConfig) {
		genericDAO.save(mailConfig);
	}

	public void updateMailConfig(MailConfig mailConfig) {
		genericDAO.update(mailConfig);
	}

	public void mergeMailConfig(MailConfig mailConfig) {
		genericDAO.merge(mailConfig);
	}

	public MailConfig getMailConfig(String oid) {
		Session session = genericDAO.getSession();
		MailConfig mailConfig = (MailConfig)session.get(MailConfig.class, oid);
		
		return mailConfig;
	}

}
