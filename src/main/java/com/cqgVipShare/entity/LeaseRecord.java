package com.cqgVipShare.entity;

public class LeaseRecord {

	private Integer id;
	private Integer vipId;
	private String kzOpenId;
	private String zlzOpenId;
	private String phone;
	private String createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getVipId() {
		return vipId;
	}
	public void setVipId(Integer vipId) {
		this.vipId = vipId;
	}
	public String getKzOpenId() {
		return kzOpenId;
	}
	public void setKzOpenId(String kzOpenId) {
		this.kzOpenId = kzOpenId;
	}
	public String getZlzOpenId() {
		return zlzOpenId;
	}
	public void setZlzOpenId(String zlzOpenId) {
		this.zlzOpenId = zlzOpenId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
