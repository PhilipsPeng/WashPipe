package org.wash.pipes.core.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.ProjectPageOne;
import org.wash.pipes.core.service.ProjectPageOneService;

@Service("projectPageOneService")
@Transactional
public class ProjectPageOneServiceImpl implements ProjectPageOneService {
	
	@Autowired 
	GenericDAO<ProjectPageOne> genericDAO;

	public ProjectPageOne getProjectPageOne(String id) {
		ProjectPageOne projectPageOne= 
				genericDAO.get(ProjectPageOne.class, id);
		
		return projectPageOne;
	}

	public void updateProjectPageOne(ProjectPageOne projectPageOne) {
		System.out.println(projectPageOne.getId());
		genericDAO.saveOrUpdate(projectPageOne);
	}

	public void mergeProjectPageOne(ProjectPageOne projectPageOne) {
		genericDAO.merge(projectPageOne);
	}

	public void persistProjectPageOne(ProjectPageOne projectPageOne) {
		genericDAO.persist(projectPageOne);
	}

}
