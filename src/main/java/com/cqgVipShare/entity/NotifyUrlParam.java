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
	public Integer getVipId() {
		return vipId;
	}
	public String getSrUuid() {
		return srUuid;
	}
	public void setSrUuid(String srUuid) {
		this.srUuid = srUuid;
	}
	public void setVipId(Integer vipId) {
		this.vipId = vipId;
	}
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
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
	private String srUuid;
	private Integer vipId;
	private Integer payType;
	private String kzOpenId;
	private String fxzOpenId;
	private Float shareMoney;
	private String phone;
	private String ygxfDate;
}
