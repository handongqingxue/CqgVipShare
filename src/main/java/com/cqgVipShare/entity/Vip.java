package com.cqgVipShare.entity;

public class Vip {
	//oNFEuwzkbP4OTTjBucFgBTWE5Bqg（李天赐）
	//oNFEuw0N6YZ92BsOnp5rOxbS7MfY（樊梦华）
	//oNFEuw0f9zJ4oELAA3q7KnE43FG4（丁丽丽）
	//oNFEuw61CEPtxI-ysHrZ4YrMoiyM（王闯）
	private Integer id;//用户id
	private String phone;//电话
	private String password;//密码
	private String nickName;//昵称
	private String headImgUrl;//头像
	private String createTime;//创建时间
	private Float sumShareCount;
	private Float sumShareMoney;
	private Float withDrawMoney;//可提现金额
	private Integer visitCount;//访问量
	private Integer reputation;//信誉度

	private String permissionId;

	private Float sumCount;
	private Float sumMoney;

	private Integer tradeId;
	private String shopName;
	private String shopAddress;
	private String shopFPY;
	private Double latitude;//纬度
	private Double longitude;//经度
	private Boolean shopCheck;
	private String logo;
	private String alipayNo;
	private String realName;
	private Integer userType;//1.个人 2.商家
	private String openId;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public Float getSumShareCount() {
		return sumShareCount;
	}

	public void setSumShareCount(Float sumShareCount) {
		this.sumShareCount = sumShareCount;
	}

	public Float getSumShareMoney() {
		return sumShareMoney;
	}

	public void setSumShareMoney(Float sumShareMoney) {
		this.sumShareMoney = sumShareMoney;
	}

	public Float getWithDrawMoney() {
		return withDrawMoney;
	}

	public void setWithDrawMoney(Float withDrawMoney) {
		this.withDrawMoney = withDrawMoney;
	}

	public Integer getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(Integer visitCount) {
		this.visitCount = visitCount;
	}

	public Integer getReputation() {
		return reputation;
	}

	public void setReputation(Integer reputation) {
		this.reputation = reputation;
	}

	public String getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}
	
	public Float getSumCount() {
		return sumCount;
	}

	public void setSumCount(Float sumCount) {
		this.sumCount = sumCount;
	}

	public Float getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Float sumMoney) {
		this.sumMoney = sumMoney;
	}

	public Integer getTradeId() {
		return tradeId;
	}

	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
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

	public Boolean getShopCheck() {
		return shopCheck;
	}

	public void setShopCheck(Boolean shopCheck) {
		this.shopCheck = shopCheck;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getAlipayNo() {
		return alipayNo;
	}

	public void setAlipayNo(String alipayNo) {
		this.alipayNo = alipayNo;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

}
