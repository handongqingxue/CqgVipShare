package com.cqgVipShare.entity;

public class ShareHistoryRecord {
	
	private String uuid;
	private Integer vipId;
	private String kzOpenId;
	private String fxzOpenId;
	private Float shareMoney;
	private String phone;
	private String ygxfDate;
	private String fxzNickName;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
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
	public String getFxzOpenId() {
		return fxzOpenId;
	}
	public void setFxzOpenId(String fxzOpenId) {
		this.fxzOpenId = fxzOpenId;
	}
	public Float getShareMoney() {
		return shareMoney;
	}
	public void setShareMoney(Float shareMoney) {
		this.shareMoney = shareMoney;
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
	public String getFxzNickName() {
		return fxzNickName;
	}
	public void setFxzNickName(String fxzNickName) {
		this.fxzNickName = fxzNickName;
	}
}