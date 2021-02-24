package com.cqgVipShare.entity;

public class HandleRecord {
	
	public static final int ALL_TAB=1;
	public static final int DLQ_TAB=2;
	public static final int YLQ_TAB=3;

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
	public String getMcName() {
		return mcName;
	}
	public void setMcName(String mcName) {
		this.mcName = mcName;
	}
	public Integer getMcType() {
		return mcType;
	}
	public void setMcType(Integer mcType) {
		this.mcType = mcType;
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
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
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
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getShopAddress() {
		return shopAddress;
	}
	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}
	public String getShopLogo() {
		return shopLogo;
	}
	public void setShopLogo(String shopLogo) {
		this.shopLogo = shopLogo;
	}
	private Integer mcId;
	private String mcName;
	private Integer mcType;
	private String openId;
	private Float money;
	private String realName;
	private String phone;
	private String qq;
	private String wxNo;
	private String createTime;
	private String qrcodeUrl;
	private Boolean receive;
	private String shopName;
	private String shopAddress;
	private String shopLogo;
}
