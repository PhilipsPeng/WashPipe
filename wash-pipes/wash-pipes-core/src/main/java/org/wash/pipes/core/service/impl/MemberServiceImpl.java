package org.wash.pipes.core.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.dao.GenericDAO;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.Member.Authority;
import org.wash.pipes.core.model.MemberId;
import org.wash.pipes.core.service.MemberService;
import org.wash.pipes.core.util.DateUtil;

@Service("memberService")
@Transactional
public class MemberServiceImpl implements MemberService {
	
	@Autowired 
	GenericDAO<Member> genericDAO;
	
	public Member getMember(String id) {
//		Session session = genericDAO.getSession();
		Member member = (Member)genericDAO.get(Member.class, id);
		
		return member;
//		Criteria cr = session.createCriteria(Member.class);
//		cr.add(Restrictions.eq("memberId", memberId));
//		List<Member> resultList = cr.list();
//		if(resultList.size()>0)
//			return resultList.get(0);
//		
//		return null;
	}
	
	public String memberList() {
		Session session = genericDAO.getSession();
		Criteria cr = session.createCriteria(Member.class);
		cr.add(Restrictions.ne("id", "admin"));
		List<Member> rsList = cr.list();
		JsonConfig config = new JsonConfig();
		config.setExcludes(new String[]{"memberId","contactInfos"});
		JSONArray memberJsonArray = JSONArray.fromObject(rsList, config);
		
		return memberJsonArray.toString();
	}
	
	public int queryMemberCount(String id) {
		Criteria cr = 
				genericDAO.getSession().createCriteria(Member.class);
		cr.add(Restrictions.eq("id", id));
		List<MemberId> rsList = cr.list();
		
		return rsList.size();
	}

	public int queryLoginIdCount(String loginId) {
		Criteria cr = 
				genericDAO.getSession().createCriteria(Member.class);
		cr.add(Restrictions.eq("loginId", loginId));
		List<MemberId> rsList = cr.list();
		
		return rsList.size();	
	}
	
	public Member getMemberForLogin(String loginId) {
		Session session = genericDAO.getSession();
		Criteria cr = session.createCriteria(Member.class);
		cr.add(Restrictions.eq("loginId", loginId));
		List<Member> resultList = cr.list();
		if(resultList.size()>0)
			return resultList.get(0);
		
		return null;
	}
	
	public void deleteMember(String memberId) {
		Member member = genericDAO.get(Member.class, memberId);
		genericDAO.delete(member);
	}

	public void save(Member member) {
		genericDAO.save(member);
	}

	public void register(Member member) {
		member.setAuth(Authority.NORMAL.getValue());
		member.setCreateTime(DateUtil.currentTime());
		genericDAO.save(member);
	}

	public void persist(Member member) {
		genericDAO.persist(member);
	}

	public void update(Member member) {
		genericDAO.update(member);
	}

	public boolean login(Member loginMember, Member member) {
		if(member == null) {
			return false;
		}
		if(member.getPassword().equals(loginMember.getPassword())) {
			return true;
		}
		
		return false;
	}

}
