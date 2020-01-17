package com.cqgVipShare.entity;

public class Message {

	public static final int QX_VIP=1;
	private Integer id;
	private String srUuid;
	private String content;
	private String fxzOpenId;
	private Integer type;
	private String createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSrUuid() {
		return srUuid;
	}
	public void setSrUuid(String srUuid) {
		this.srUuid = srUuid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFxzOpenId() {
		return fxzOpenId;
	}
	public void setFxzOpenId(String fxzOpenId) {
		this.fxzOpenId = fxzOpenId;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
