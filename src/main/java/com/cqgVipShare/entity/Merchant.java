package com.cqgVipShare.entity;

public class Merchant {
	
	public static final int DAI_SHEN_HE=0;
	public static final int SHEN_HE_TONG_GUO=1;
	public static final int SHEN_HE_BU_HE_GE=2;
	
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
	public String getTradeName() {
		return tradeName;
	}

	public void setTradeName(String tradeName) {
		this.tradeName = tradeName;
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
	public String getXcImgUrl() {
		return xcImgUrl;
	}
	public void setXcImgUrl(String xcImgUrl) {
		this.xcImgUrl = xcImgUrl;
	}
	public String getYyzzImgUrl() {
		return yyzzImgUrl;
	}
	public void setYyzzImgUrl(String yyzzImgUrl) {
		this.yyzzImgUrl = yyzzImgUrl;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getVisitCount() {
		return visitCount;
	}
	public void setVisitCount(Integer visitCount) {
		this.visitCount = visitCount;
	}
	public Integer getSumShareCount() {
		return sumShareCount;
	}
	public void setSumShareCount(Integer sumShareCount) {
		this.sumShareCount = sumShareCount;
	}
	public Integer getHandleCount() {
		return handleCount;
	}

	public void setHandleCount(Integer handleCount) {
		this.handleCount = handleCount;
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
	private String tradeName;//行业名称
	private Double latitude;//纬度
	private Double longitude;//经度
	private String logo;//门店logo
	private String xcImgUrl;//宣传图图片链接
	private String yyzzImgUrl;//营业执照图片链接
	private String describe;//门店简介
	private String createTime;//创建时间
	private Integer visitCount;//访问量
	private Integer sumShareCount;//分享量
	private Integer handleCount;//办卡量
	private String openId;
	private Integer shopCheck;//审核状态
}
