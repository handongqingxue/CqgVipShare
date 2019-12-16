package com.cqgVipShare.entity;

public class ShareHistoryRecord {
	
	private Integer id;
	private Integer vipId;
	private String openId;
	private String phone;
	private String ygxfDate;
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
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getYgxfDate() {
		return ygxfDate;
	}
	public void setYgxfDate(String ygxfDate) {
		this.ygxfDate = ygxfDate;
	}
}
