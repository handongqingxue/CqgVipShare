package com.cqgVipShare.entity;

public class User {
	private Integer id;//用户id
	private String phone;//电话
	private String passWord;//密码
	private String nickName;//昵称
	private String headImgUrl;//头像
	private String createTime;//创建时间
	private Float sumShareCount;
	private Float sumShareMoney;
	private Integer reputation;//信誉度

	private String permissionId;

	private Float sumCount;
	private Float sumMoney;

	private Integer tradeId;
	private String shopName;
	private String shopAddress;
	private String logo;
	private Integer userType;//1.个人 2.商家
	private String openId;

	public User(String phone,String passWord) {
		this.phone=phone;
		this.passWord=passWord;
	}
	
	public User() {
		super();
	}
	
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
	
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
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

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
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
