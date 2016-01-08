package org.wash.pipes.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "mail_config")
public class MailConfig {
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid.hex")
	private String oid;
	@Column(name="mail_order_num")
	private Integer mailOrderNum;
	private String name;
	private String subject;
	@Lob 
	private String text;
	@ManyToOne
	@JoinColumn(name="fk_project_group_id", nullable=false)
	@ForeignKey(name="fk_project_group")
	private ProjectGroup projectGroup;
	
	public Integer getMailOrderNum() {
		return mailOrderNum;
	}

	public void setMailOrderNum(Integer mailOrderNum) {
		this.mailOrderNum = mailOrderNum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getOid() {
		return oid;
	}

	public ProjectGroup getProjectGroup() {
		return projectGroup;
	}

	public void setProjectGroup(ProjectGroup projectGroup) {
		this.projectGroup = projectGroup;
	}

	@Override
	public int hashCode() {
		return this.oid.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this==obj) return true;
		if(!(obj instanceof MailConfig)) return false;
		MailConfig mailConfig = (MailConfig)obj;
		return this.oid.equals(mailConfig.getOid());
	}

}
