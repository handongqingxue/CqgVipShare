package com.cqgVipShare.entity;

public class ShareVip {

	private Integer id;//����
	private String no;//����
	private String name;//����
	private Integer shopId;//ʵ���id
	private String shopName;//ʵ�����
	private String shopLogo;//ʵ���Logo
	private String shopAddress;//ʵ����ַ
	private String openId;//����openId
	private String phone;//�ֻ���
	private Integer consumeCount;//ʣ�����Ѵ���
	private Float shareMoney;//������
	private Integer weightValue;//Ȩ��ֵ����ҳ�������ֵ�����У�
	private String describe;//������������
	private String createTime;//����ʱ��
	private Boolean used;//�Ƿ����
	private Boolean enable;//�Ƿ��¼ܣ�0���¼� 1δ�¼ܣ�
	private Integer wxfCount;//δ��������
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
	public Integer getWxfCount() {
		return wxfCount;
	}
	public void setWxfCount(Integer wxfCount) {
		this.wxfCount = wxfCount;
	}
	
}
