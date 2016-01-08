package org.wash.pipes.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "customer")
public class Customer {

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid.hex")
	private String oid;
	private String name;
	private String phone;
	private String holiday;//0:假日 1:非假日
	@Column(name = "contact_interval")
	private String contactInterval;
	@ManyToOne
	@JoinColumn(name = "project_group_id")
	private ProjectGroup projectGroup;
	@ManyToOne
	@JoinColumn(name = "member_id")
	private Member member;
	private String status;//-1:N/A 0:施工 1:收款 2:獎金發放

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHoliday() {
		return holiday;
	}

	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}

	public String getContactInterval() {
		return contactInterval;
	}

	public void setContactInterval(String contactInterval) {
		this.contactInterval = contactInterval;
	}

	public ProjectGroup getProjectGroup() {
		return projectGroup;
	}

	public void setProjectGroup(ProjectGroup projectGroup) {
		this.projectGroup = projectGroup;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getOid() {
		return oid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public enum CONTACT_INTERVAL {
		MORNING,NOON,AFTERNOON,NIGHT
	}

}
