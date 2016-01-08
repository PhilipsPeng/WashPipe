package org.wash.pipes.core.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.MemberId;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.model.ProjectPageOne;
import org.wash.pipes.core.service.ProjectGroupService;
import org.wash.pipes.core.util.DateUtil;

@Service("projectGroupService")
@Transactional
public class ProjectGroupServiceImpl implements ProjectGroupService {
	
	@Autowired 
	GenericDAO<ProjectGroup> genericDAO;
	
	public String projectGroupListJson() {
		Criteria cr = 
				genericDAO.getSession().createCriteria(ProjectGroup.class);
		cr.addOrder(Order.desc("createTime"));
		List<ProjectGroup> rsList = cr.list();
		JsonConfig config = new JsonConfig();
		config.setExcludes(new String[]{"mailConfigList","projectPageOne"});
		JSONArray projectGroupJsonArray = JSONArray.fromObject(rsList, config);
		
		return projectGroupJsonArray.toString();
	}

	public ProjectGroup getProjectGroup(String id) {
		ProjectGroup projectGroup = genericDAO.get(ProjectGroup.class, id);
		return projectGroup;
	}

	public List<ProjectGroup> projectGroupList() {
		Criteria cr = 
				genericDAO.getSession().createCriteria(ProjectGroup.class);
		cr.addOrder(Order.desc("createTime"));
		List<ProjectGroup> rsList = cr.list();
		
		return rsList;
	}

	public void persistProjectGroup(ProjectGroup projectGroup) {
		genericDAO.persist(projectGroup);
	}

	public void saveProjectGroup(ProjectGroup projectGroup) {
		ProjectPageOne projectPageOne = new ProjectPageOne();
		projectPageOne.setId(projectGroup.getId());
		projectGroup.setProjectPageOne(projectPageOne);
		projectGroup.setCreateTime(DateUtil.currentTime());
		genericDAO.save(projectGroup);
	}

	public void saveOrUpdateProjectGroup(ProjectGroup projectGroup) {
		// TODO Auto-generated method stub
		
	}

	public void updateProjectGroup(ProjectGroup projectGroup) {
		genericDAO.update(projectGroup);
	}

	public void mergeProjectGroup(ProjectGroup projectGroup) {
		genericDAO.merge(projectGroup);
	}

	public void deleteProjectGroup(String id) {
		ProjectGroup projcetGroup = 
				genericDAO.get(ProjectGroup.class, id);
		genericDAO.delete(projcetGroup);
	}

	public int queryProjectGroupCount(String id) {
		Criteria cr = 
				genericDAO.getSession().createCriteria(ProjectGroup.class);
		cr.add(Restrictions.eq("id", id));
		List<MemberId> rsList = cr.list();
		System.out.println("===================="+rsList.size());
		
		return rsList.size();
	}

}
