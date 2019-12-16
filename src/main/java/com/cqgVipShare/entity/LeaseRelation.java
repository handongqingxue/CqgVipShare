package com.cqgVipShare.entity;

public class LeaseRelation {

	private Integer id;
	private String kzOpenId;
	private String zkOpenId;
	private String zkNickName;
	private String zkPhone;
	private String createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getKzOpenId() {
		return kzOpenId;
	}
	public void setKzOpenId(String kzOpenId) {
		this.kzOpenId = kzOpenId;
	}
	public String getZkOpenId() {
		return zkOpenId;
	}
	public void setZkOpenId(String zkOpenId) {
		this.zkOpenId = zkOpenId;
	}
	public String getZkNickName() {
		return zkNickName;
	}
	public void setZkNickName(String zkNickName) {
		this.zkNickName = zkNickName;
	}
	public String getZkPhone() {
		return zkPhone;
	}
	public void setZkPhone(String zkPhone) {
		this.zkPhone = zkPhone;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
