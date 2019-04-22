package com.model;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Diary entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_diary", catalog = "db_blog")
public class Diary implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private String title;
	private Timestamp releaseDate;
	private String content;

	// Constructors

	/** default constructor */
	public Diary() {
	}

	/** minimal constructor */
	public Diary(User user, String title, String content) {
		this.user = user;
		this.title = title;
		this.content = content;
	}

	/** full constructor */
	public Diary(User user, String title, Timestamp releaseDate, String content) {
		this.user = user;
		this.title = title;
		this.releaseDate = releaseDate;
		this.content = content;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId", nullable = false)
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "title", nullable = false, length = 60)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "releaseDate", length = 19)
	public Timestamp getReleaseDate() {
		return this.releaseDate;
	}

	public void setReleaseDate(Timestamp releaseDate) {
		this.releaseDate = releaseDate;
	}

	@Column(name = "content", nullable = false, length = 65535)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}