package org.wash.pipes.core.service;

import java.util.List;

import org.wash.pipes.core.model.ProjectGroup;

public interface ProjectGroupService {
	
	String projectGroupListJson();
	ProjectGroup getProjectGroup(String id);
	List<ProjectGroup> projectGroupList();
	void saveProjectGroup(final ProjectGroup projectGroup);
	void saveOrUpdateProjectGroup(final ProjectGroup projectGroup);
	void updateProjectGroup(final ProjectGroup projectGroup);
	void deleteProjectGroup(String id);
	void persistProjectGroup(final ProjectGroup projectGroup);
	void mergeProjectGroup(final ProjectGroup projectGroup);
	int queryProjectGroupCount(String id);
}
