package com.cqgVipShare.entity;

public class Merchant {
	
	public static final Integer DAI_SHEN_HE=0;
	public static final Integer SHEN_HE_TONG_GUO=1;
	public static final Integer SHEN_HE_BU_HE_GE=2;
	
	public Merchant(String userName,String password) {
		this.userName=userName;
		this.password=password;
	}
	
	public Merchant() {
		super();
	}
	
	private Integer id;//商家id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getShopFPY() {
		return shopFPY;
	}
	public void setShopFPY(String shopFPY) {
		this.shopFPY = shopFPY;
	}
	public Integer getTradeId() {
		return tradeId;
	}
	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getYyzzImgUrl() {
		return yyzzImgUrl;
	}
	public void setYyzzImgUrl(String yyzzImgUrl) {
		this.yyzzImgUrl = yyzzImgUrl;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getSumShareCount() {
		return sumShareCount;
	}

	public void setSumShareCount(Integer sumShareCount) {
		this.sumShareCount = sumShareCount;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public Integer getShopCheck() {
		return shopCheck;
	}
	public void setShopCheck(Integer shopCheck) {
		this.shopCheck = shopCheck;
	}
	private String userName;//商家账号
	private String password;//密码
	private String shopName;//门店地址
	private String shopAddress;//门店地址
	private String shopFPY;//门店首拼音
	private Integer tradeId;//行业id
	private Double latitude;//纬度
	private Double longitude;//经度
	private String logo;//门店logo
	private String yyzzImgUrl;//营业执照图片链接
	private String createTime;//创建时间
	private Integer sumShareCount;//分享量
	private String openId;
	private Integer shopCheck;//审核状态
}
