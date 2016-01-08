package org.wash.pipes.core.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.MemberId;
import org.wash.pipes.core.service.MemberIdService;
import org.wash.pipes.core.util.DateUtil;

@Service("memberIdService")
public class MemberIdServiceImpl implements MemberIdService {
	
	@Autowired 
	GenericDAO<MemberId> genericDAO;
	@Autowired
	GenericDAO<Member> genericDAO_;
	
	@Transactional
	public String memberIdList() {
		Criteria cr = 
				genericDAO.getSession().createCriteria(MemberId.class);
		cr.add(Restrictions.ne("id", "admin"));
		JsonConfig config = new JsonConfig();
		config.setExcludes(new String[]{"member"});
		JSONArray memberIdJsonArray = JSONArray.fromObject(cr.list(), config);
		
		return memberIdJsonArray.toString();

	}

	public void insertMemberId(MemberId memberId) {
		memberId.setCreateTime(DateUtil.currentTime());
		genericDAO.save(memberId);
	}

	public void updateMemberId(MemberId memberId) {
		// TODO Auto-generated method stub
		
	}

	public void deleteMemberId(String id) {
		MemberId memberId = genericDAO.get(MemberId.class, id);
		genericDAO.delete(memberId);
		Member member = genericDAO_.get(Member.class, id);
		genericDAO_.delete(member);
	}
	
	@Transactional
	public int queryMemberIdCount(String memberId) {
		Criteria cr = 
				genericDAO.getSession().createCriteria(MemberId.class);
		cr.add(Restrictions.eq("id", memberId));
		List<MemberId> rsList = cr.list();
		System.out.println("===================="+rsList.size());
		
		return rsList.size();
	}

}
