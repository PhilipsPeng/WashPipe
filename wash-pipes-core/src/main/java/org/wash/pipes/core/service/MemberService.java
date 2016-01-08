package org.wash.pipes.core.service;

import org.wash.pipes.core.model.Member;

public interface MemberService {
	
	Member getMember(String id);
	String memberList();
	Member getMemberForLogin(String loginId);
	boolean login(Member loginMember, Member member);
	void register(Member member);
	void persist(Member member);
	void save(Member member);
	void update(Member member);
	void deleteMember(String memberId);
	int queryMemberCount(String id);
	int queryLoginIdCount(String loginId);
}
