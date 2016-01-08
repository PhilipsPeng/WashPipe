package org.wash.pipes.core.service;

import org.wash.pipes.core.model.MailConfig;

public interface MailConfigService {
	
	void insertMailConfig(final MailConfig mailConfig);
	void updateMailConfig(final MailConfig mailConfig);
	void mergeMailConfig(final MailConfig mailConfig);
	MailConfig getMailConfig(String oid);
}
