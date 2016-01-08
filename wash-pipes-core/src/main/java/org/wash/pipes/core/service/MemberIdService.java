package org.wash.pipes.core.service;

import org.wash.pipes.core.model.MemberId;

public interface MemberIdService {
	
	String memberIdList();
	void insertMemberId(final MemberId memberId);
	void updateMemberId(final MemberId memberId);
	void deleteMemberId(String memberId);
	int queryMemberIdCount(String memberId);
}
