package org.wash.pipes.core.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "project_page_one")
public class ProjectPageOne implements Serializable{

	private static final long serialVersionUID = 8000255794981115387L;
	
	@Id
	private String id;
	private String title;
	@Column(name="youtube_link_one")
	private String youtubeLinkOne;
	@Column(name="youtube_link_two")
	private String youtubeLinkTwo;
	@Column(name="submit_text")
	private String submitText;
	@Column(name="under_text")
	private String underText;
	@OneToOne
	@PrimaryKeyJoinColumn
	private ProjectGroup projectGroup;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getYoutubeLinkOne() {
		return youtubeLinkOne;
	}

	public void setYoutubeLinkOne(String youtubeLinkOne) {
		this.youtubeLinkOne = youtubeLinkOne;
	}

	public String getYoutubeLinkTwo() {
		return youtubeLinkTwo;
	}

	public void setYoutubeLinkTwo(String youtubeLinkTwo) {
		this.youtubeLinkTwo = youtubeLinkTwo;
	}

	public ProjectGroup getProjectGroup() {
		return projectGroup;
	}

	public void setProjectGroup(ProjectGroup projectGroup) {
		this.projectGroup = projectGroup;
	}

	public String getSubmitText() {
		return submitText;
	}

	public void setSubmitText(String submitText) {
		this.submitText = submitText;
	}

	public String getUnderText() {
		return underText;
	}

	public void setUnderText(String underText) {
		this.underText = underText;
	}

	@Override
	public int hashCode() {
		return this.id.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this==obj) return true;
		if(!(obj instanceof ProjectPageOne)) return false;
		ProjectPageOne projecPageOne = (ProjectPageOne)obj;
		return this.id.equals(projecPageOne.getId());
	}

}
