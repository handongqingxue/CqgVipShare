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
	public Integer getShopId() {
		return shopId;
	}
	public void setShopId(Integer shopId) {
		this.shopId = shopId;
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
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	private String name;//卡名
	private Integer type;//类型：1.金额卡 2.次卡
	private Integer shopId;//实体店id
	private Integer consumeCount;//消费次数
	private Float money;//分享金额
	private String describe;//服务内容描述
	private String createTime;//创建时间
	private Boolean enable;//是否下架（0已下架 1未下架）
}
