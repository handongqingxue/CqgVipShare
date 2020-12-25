package com.cqgVipShare.entity;

public class CapitalFlowRecord {

	public static final int ALL_TAB=1;
	public static final int DXF_TAB=2;
	public static final int YXF_TAB=3;
	public static final int YQX_TAB=5;
	
	public static final int DXF_STATE=0;
	public static final int YXF_STATE=1;
	public static final int YPL_STATE=2;
	public static final int DQX_STATE=3;
	public static final int YQX_STATE=4;
	public static final int YSC_STATE=5;
	private Integer id;
	private String srUuid;
	private Integer vipId;
	private String vipName;
	private String no;
	private String kzOpenId;
	private String kzNickName;
	private String fxzOpenId;
	private String fxzNickName;
	private Float shareMoney;
	private String createTime;
	private String shopName;
	private String shopLogo;//实体店Logo
	private String shopAddress;
	private String phone;
	private String ygxfDate;
	//private Integer state;//0待消费 1已消费 2待取消 3已取消 4已删除
	private Integer state;//0待消费 1已消费 2 已评价 3待取消 4已取消 5已删除
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
	public Integer getVipId() {
		return vipId;
	}
	public void setVipId(Integer vipId) {
		this.vipId = vipId;
	}
	public String getVipName() {
		return vipName;
	}
	public void setVipName(String vipName) {
		this.vipName = vipName;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getKzOpenId() {
		return kzOpenId;
	}
	public void setKzOpenId(String kzOpenId) {
		this.kzOpenId = kzOpenId;
	}
	public String getKzNickName() {
		return kzNickName;
	}
	public void setKzNickName(String kzNickName) {
		this.kzNickName = kzNickName;
	}
	public String getFxzOpenId() {
		return fxzOpenId;
	}
	public void setFxzOpenId(String fxzOpenId) {
		this.fxzOpenId = fxzOpenId;
	}
	public String getFxzNickName() {
		return fxzNickName;
	}
	public void setFxzNickName(String fxzNickName) {
		this.fxzNickName = fxzNickName;
	}
	public Float getShareMoney() {
		return shareMoney;
	}
	public void setShareMoney(Float shareMoney) {
		this.shareMoney = shareMoney;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getShopLogo() {
		return shopLogo;
	}
	public void setShopLogo(String shopLogo) {
		this.shopLogo = shopLogo;
	}
	public String getShopAddress() {
		return shopAddress;
	}
	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
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
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
}
