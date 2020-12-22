package com.cqgVipShare.entity;

public class ShareVip {

	private Integer id;//主键
	private String no;//卡号
	private String name;//卡名
	private Integer shopId;//实体店id
	private String shopName;//实体店名
	private String shopLogo;//实体店Logo
	private String shopAddress;//实体店地址
	private String openId;//卡主openId
	private String phone;//手机号
	private Integer consumeCount;//剩余消费次数
	private Float shareMoney;//分享金额
	private Integer weightValue;//权重值（首页根据这个值来排行）
	private String describe;//服务内容描述
	private String createTime;//创建时间
	private Boolean used;//是否可用（0 可用 1 不可用）
	private Boolean enable;//是否下架（0已下架 1未下架）
	private Integer yxzCount;//已下载人数
	private Integer yxfCount;//已消费人数
	private Integer qxsqCount;//取消申请人数
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getShopId() {
		return shopId;
	}
	public void setShopId(Integer shopId) {
		this.shopId = shopId;
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
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Integer getConsumeCount() {
		return consumeCount;
	}
	public void setConsumeCount(Integer consumeCount) {
		this.consumeCount = consumeCount;
	}
	public Float getShareMoney() {
		return shareMoney;
	}
	public void setShareMoney(Float shareMoney) {
		this.shareMoney = shareMoney;
	}
	public Integer getWeightValue() {
		return weightValue;
	}
	public void setWeightValue(Integer weightValue) {
		this.weightValue = weightValue;
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
	public Boolean getUsed() {
		return used;
	}
	public void setUsed(Boolean used) {
		this.used = used;
	}
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	public Integer getYxzCount() {
		return yxzCount;
	}
	public void setYxzCount(Integer yxzCount) {
		this.yxzCount = yxzCount;
	}
	public Integer getYxfCount() {
		return yxfCount;
	}
	public void setYxfCount(Integer yxfCount) {
		this.yxfCount = yxfCount;
	}
	public Integer getQxsqCount() {
		return qxsqCount;
	}
	public void setQxsqCount(Integer qxsqCount) {
		this.qxsqCount = qxsqCount;
	}
	
}
