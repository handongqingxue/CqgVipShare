package com.cqgVipShare.entity;

public class Vip {
	//oNFEuwzkbP4OTTjBucFgBTWE5Bqg（李天赐）
	//oNFEuw0N6YZ92BsOnp5rOxbS7MfY（樊梦华）
	//oNFEuw0f9zJ4oELAA3q7KnE43FG4（丁丽丽）
	//oNFEuw61CEPtxI-ysHrZ4YrMoiyM（王闯）
	//oNFEuwz4EtJE6F25Zmu9hFXUqfdk（经理）
	//oNFEuw89f5P17ws79nQVqRbvQ8Uo（李曼飞）
	//oNFEuw1xnvaDPY-T4Z9koGmBHgsM（孙玲潇）
	//oNFEuwwo4v0NBef3TLKkSD3rlAfI（未来战场VR竞技馆（青岛））
	//oNFEuw94ZZhwwb6qSt72ndsVON1o（burns）
	private Integer id;//用户id
	private String phone;//电话
	private String password;//密码
	private String nickName;//昵称
	private String headImgUrl;//头像
	private String signTxt;//签名
	private String createTime;//创建时间
	private Float sumShareCount;//累计分享次数
	private Float sumShareMoney;//累计分享金额
	private Float withDrawMoney;//可提现金额
	private Integer reputation;//信誉度

	private String permissionId;

	private Double latitude;//纬度
	private Double longitude;//经度
	private String alipayNo;
	private String realName;
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
	
	public String getSignTxt() {
		return signTxt;
	}

	public void setSignTxt(String signTxt) {
		this.signTxt = signTxt;
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

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

}
