package com.cqgVipShare.entity;

public class MerchantCardType {

	private Integer id;//����
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
	private Integer type;//���ͣ�1.�꿨��2.������3.�¿���4.��ֵ����5.�ο�
	private Integer shopId;//ʵ���id
	private String name;
}
