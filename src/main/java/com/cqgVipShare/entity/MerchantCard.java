package com.cqgVipShare.entity;

public class MerchantCard {

	private Integer id;//����
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
	private String name;//����
	private Integer type;//����
	private String typeName;
	private Integer shopId;//ʵ���id
	private String shopName;//ʵ�����
	private String shopLogo;//ʵ���Logo
	private String shopAddress;//ʵ����ַ
	private Integer consumeCount;//���Ѵ���
	private Float money;//������
	private Integer sfbfb;//�ϸ��ٷֱ�
	private Integer shopFC;//�̼ҷֳ�:�ϸ����Ľ����ָ��̼ҵĽ��ٷֱȣ�ʣ�µ��ϸ����Ľ��ָ�������
	private Integer discount;//�ۿ�
	private String describe;//������������
	private String gmxz;//������֪
	private String createTime;//����ʱ��
	private Boolean enable;//�Ƿ��¼ܣ�0���¼� 1δ�¼ܣ�
}
