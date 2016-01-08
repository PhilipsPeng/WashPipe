package org.wash.pipes.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "contact_info")
public class ContactInfo {

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid.hex")
	private String oid;
	private String name;
	private String email;
	@Column(name="create_time")
	private String createTime;
	@Column(name="send_mail_time")
	private String sendMailTime;
	@Enumerated(EnumType.STRING)
	@Column(name="send_mail_process")
	private SEND_MAIL_PROCESS sendMailProcess;
	@Enumerated(EnumType.STRING)
	@Column(name="send_mail_status")
	private SEND_MAIL_STATUS sendMailStatus;
	@ManyToOne
	@JoinColumn(name = "member_id", 
	                insertable = true, updatable = false, 
	                nullable = false)
	private Member member;
	@ManyToOne
	@JoinColumn(name = "project_group_id")
	private ProjectGroup projectGroup;

	public String getOid() {
		return oid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getSendMailTime() {
		return sendMailTime;
	}

	public void setSendMailTime(String sendMailTime) {
		this.sendMailTime = sendMailTime;
	}

	public SEND_MAIL_PROCESS getSendMailProcess() {
		return sendMailProcess;
	}

	public void setSendMailProcess(SEND_MAIL_PROCESS sendMailProcess) {
		this.sendMailProcess = sendMailProcess;
	}

	public SEND_MAIL_STATUS getSendMailStatus() {
		return sendMailStatus;
	}

	public void setSendMailStatus(SEND_MAIL_STATUS sendMailStatus) {
		this.sendMailStatus = sendMailStatus;
	}
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public ProjectGroup getProjectGroup() {
		return projectGroup;
	}

	public void setProjectGroup(ProjectGroup projectGroup) {
		this.projectGroup = projectGroup;
	}

	public enum SEND_MAIL_STATUS {
		MAIL_CONFIG_EMPTY,FAIL,SUCCESS,FINISH;
	}
	
	public enum SEND_MAIL_PROCESS {
		FIRST(1),SECOND(2),THIRD(3),FOURTH(4),FIFTH(5),END(999);
		
		Integer mailNum = null;
		
		private SEND_MAIL_PROCESS(Integer mailNum) {
			this.mailNum = mailNum;
		}
		
		public Integer getMailNum() {
			return mailNum;
		}
	}
}
