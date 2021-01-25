package com.cqgVipShare.entity;

public class NotifyUrlParam {

	public static final int WXPAY=0;
	public static final int ALIPAY=1;
	private String outTradeNo;
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getSrUuid() {
		return srUuid;
	}
	public void setSrUuid(String srUuid) {
		this.srUuid = srUuid;
	}
	public String getHrUuid() {
		return hrUuid;
	}
	public void setHrUuid(String hrUuid) {
		this.hrUuid = hrUuid;
	}
	public Integer getScId() {
		return scId;
	}
	public void setScId(Integer scId) {
		this.scId = scId;
	}
	public Integer getMcId() {
		return mcId;
	}
	public void setMcId(Integer mcId) {
		this.mcId = mcId;
	}
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
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
	public Float getMoney() {
		return money;
	}
	public void setMoney(Float money) {
		this.money = money;
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
	public String getYglkDate() {
		return yglkDate;
	}
	public void setYglkDate(String yglkDate) {
		this.yglkDate = yglkDate;
	}
	private String srUuid;
	private String hrUuid;
	private Integer scId;
	private Integer mcId;
	private Integer payType;
	private String openId;
	private String kzOpenId;
	private String fxzOpenId;
	private Float money;
	private Float shareMoney;
	private String phone;
	private String ygxfDate;
	private String yglkDate;
}
