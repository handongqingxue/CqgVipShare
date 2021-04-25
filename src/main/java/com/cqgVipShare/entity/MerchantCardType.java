package com.cqgVipShare.entity;

public class MerchantCardType {

	public static final Integer NIAN_KA=1;
	public static final Integer JI_KA=2;
	public static final Integer YUE_KA=3;
	public static final Integer CHONG_ZHI_KA=4;
	public static final Integer CI_KA=5;

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
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
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
	private String types;
	private Integer shopId;//实体店id
	private String name;
}
