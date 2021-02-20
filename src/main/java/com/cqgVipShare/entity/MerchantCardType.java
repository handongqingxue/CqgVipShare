package com.cqgVipShare.entity;

public class MerchantCardType {

	private Integer id;//主键
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	private Integer type;//类型：1.年卡、2.季卡、3.月卡、4.充值卡、5.次卡
	private Integer shopId;//实体店id
	private String name;
}
