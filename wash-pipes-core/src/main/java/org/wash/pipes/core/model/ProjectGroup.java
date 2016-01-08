package org.wash.pipes.core.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;


@Entity
@org.hibernate.annotations.Entity(selectBeforeUpdate=true)
@Table(name = "project_group")
public class ProjectGroup implements Serializable {
	
	private static final long serialVersionUID = -1843386631197837182L;
	
	@Id
	private String id;
	@OneToOne(cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn
	private ProjectPageOne projectPageOne;
	@OneToMany(mappedBy="projectGroup", cascade = CascadeType.ALL)
	private List<MailConfig> mailConfigList;
	private String name;
	@Column(name="mail_num")
	private Integer mailNum;//最多五封
	@Column(name="mail_job_day")
	private Integer mailJobDay;//發送mail時間間隔(單位:天)
	@Column(name="create_time")
	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getMailNum() {
		return mailNum;
	}

	public void setMailNum(Integer mailNum) {
		this.mailNum = mailNum;
	}

	public Integer getMailJobDay() {
		return mailJobDay;
	}

	public void setMailJobDay(Integer mailJobDay) {
		this.mailJobDay = mailJobDay;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public ProjectPageOne getProjectPageOne() {
		return projectPageOne;
	}

	public void setProjectPageOne(ProjectPageOne projectPageOne) {
		this.projectPageOne = projectPageOne;
	}

	public List<MailConfig> getMailConfigList() {
		return mailConfigList;
	}

	public void setMailConfigList(List<MailConfig> mailConfigList) {
		this.mailConfigList = mailConfigList;
	}
	
}
