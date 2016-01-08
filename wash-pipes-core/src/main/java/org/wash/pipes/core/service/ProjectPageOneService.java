package org.wash.pipes.core.service;

import org.wash.pipes.core.model.ProjectPageOne;

public interface ProjectPageOneService {
	
	ProjectPageOne getProjectPageOne(String id);
	void updateProjectPageOne(final ProjectPageOne projectPageOne);
	void mergeProjectPageOne(final ProjectPageOne projectPageOne);
	void persistProjectPageOne(final ProjectPageOne projectPageOne);
}
