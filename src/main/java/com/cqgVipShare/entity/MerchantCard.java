package com.cqgVipShare.entity;

public class MerchantCard {

	private Integer id;//主键
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
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
	public Integer getConsumeCount() {
		return consumeCount;
	}
	public void setConsumeCount(Integer consumeCount) {
		this.consumeCount = consumeCount;
	}
	public Float getMoney() {
		return money;
	}
	public void setMoney(Float money) {
		this.money = money;
	}
	public Integer getSfbfb() {
		return sfbfb;
	}
	public void setSfbfb(Integer sfbfb) {
		this.sfbfb = sfbfb;
	}
	public Integer getShopFC() {
		return shopFC;
	}
	public void setShopFC(Integer shopFC) {
		this.shopFC = shopFC;
	}
	public Integer getDiscount() {
		return discount;
	}
	public void setDiscount(Integer discount) {
		this.discount = discount;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getGmxz() {
		return gmxz;
	}
	public void setGmxz(String gmxz) {
		this.gmxz = gmxz;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	private String name;//卡名
	private Integer type;//类型
	private String typeName;
	private Integer shopId;//实体店id
	private String shopName;//实体店名
	private String shopLogo;//实体店Logo
	private String shopAddress;//实体店地址
	private Integer consumeCount;//消费次数
	private Float money;//分享金额
	private Integer sfbfb;//上浮百分比
	private Integer shopFC;//商家分成:上浮出的金额里分给商家的金额百分比（剩下的上浮出的金额分给卡主）
	private Integer discount;//折扣
	private String describe;//服务内容描述
	private String gmxz;//购买须知
	private String createTime;//创建时间
	private Boolean enable;//是否下架（0已下架 1未下架）
}
