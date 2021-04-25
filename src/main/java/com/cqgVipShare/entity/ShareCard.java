package com.cqgVipShare.entity;

public class ShareCard {

	public static final Integer NIAN_KA=1;
	public static final Integer JI_KA=2;
	public static final Integer YUE_KA=3;
	public static final Integer CHONG_ZHI_KA=4;
	public static final Integer CI_KA=5;
	
	private Integer id;//����
	private String no;//����
	private String name;//����
	private Integer type;//���ͣ�1.�꿨��2.������3.�¿���4.��ֵ����5.�ο�
	private Integer shopId;//ʵ���id
	private String shopName;//ʵ�����
	private String shopLogo;//ʵ���Logo
	private String shopAddress;//ʵ����ַ
	private Float shopDistance;//��ʵ������
	private String openId;//����openId
	private String phone;//�ֻ���
	private Integer consumeCount;//ʣ�����Ѵ���
	private Float yj;//ԭ��
	private Float hyj;//��Ա��
	private Float zdfxje;//��ͷ����
	private Float shareMoney;//������
	private Integer sfbfb;//�ϸ��ٷֱ�
	private Integer shopFC;//�̼ҷֳ�:�ϸ����Ľ����ָ��̼ҵĽ��ٷֱȣ�ʣ�µ��ϸ����Ľ��ָ�������
	private Integer discount;//�ۿ�
	private Float minDeposit;//���Ѻ��
	private Integer weightValue;//Ȩ��ֵ����ҳ�������ֵ�����У�
	private String describe;//������������
	private String createTime;//����ʱ��
	private String startTime;
	private String endTime;
	private Boolean used;//�Ƿ��ù���0 δ�ù� 1 �ù��ˣ�
	private Boolean enable;//�Ƿ���ã�0  ������ 1���ã�
	private Integer yxzCount;//����������
	private Integer yxfCount;//����������
	private Integer qxsqCount;//ȡ����������
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
	public Float getShopDistance() {
		return shopDistance;
	}
	public void setShopDistance(Float shopDistance) {
		this.shopDistance = shopDistance;
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
	public Float getYj() {
		return yj;
	}
	public void setYj(Float yj) {
		this.yj = yj;
	}
	public Float getHyj() {
		return hyj;
	}
	public void setHyj(Float hyj) {
		this.hyj = hyj;
	}
	public Float getZdfxje() {
		return zdfxje;
	}
	public void setZdfxje(Float zdfxje) {
		this.zdfxje = zdfxje;
	}
	public Float getShareMoney() {
		return shareMoney;
	}
	public void setShareMoney(Float shareMoney) {
		this.shareMoney = shareMoney;
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
	public Float getMinDeposit() {
		return minDeposit;
	}
	public void setMinDeposit(Float minDeposit) {
		this.minDeposit = minDeposit;
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
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
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
