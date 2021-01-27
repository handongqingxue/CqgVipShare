package com.cqgVipShare.entity;

public class HandleRecord {

	private String uuid;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public Integer getMcId() {
		return mcId;
	}
	public void setMcId(Integer mcId) {
		this.mcId = mcId;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public Float getMoney() {
		return money;
	}
	public void setMoney(Float money) {
		this.money = money;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWxNo() {
		return wxNo;
	}
	public void setWxNo(String wxNo) {
		this.wxNo = wxNo;
	}
	public String getQrcodeUrl() {
		return qrcodeUrl;
	}
	public void setQrcodeUrl(String qrcodeUrl) {
		this.qrcodeUrl = qrcodeUrl;
	}
	public Boolean getReceive() {
		return receive;
	}
	public void setReceive(Boolean receive) {
		this.receive = receive;
	}
	private Integer mcId;
	private String openId;
	private Float money;
	private String realName;
	private String phone;
	private String qq;
	private String wxNo;
	private String qrcodeUrl;
	private Boolean receive;
}
