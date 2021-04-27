package com.cqgVipShare.entity;

/*
 * δ��ս����FB2EA4B638A9C657244045E9A02E9D95
 */
public class Merchant {
	
	public static final int DAI_SHEN_HE=0;
	public static final int SHEN_HE_TONG_GUO=1;
	public static final int SHEN_HE_BU_HE_GE=2;
	
	public static final int BWX=1;
	public static final int RBWX=2;
	
	public Merchant(String userName,String password) {
		this.userName=userName;
		this.password=password;
	}
	
	public Merchant() {
		super();
	}
	
	private Integer id;//�̼�id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getShopAddress() {
		return shopAddress;
	}
	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}
	public String getShopFPY() {
		return shopFPY;
	}
	public void setShopFPY(String shopFPY) {
		this.shopFPY = shopFPY;
	}
	public Integer getTradeId() {
		return tradeId;
	}
	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}
	public String getTradeName() {
		return tradeName;
	}

	public void setTradeName(String tradeName) {
		this.tradeName = tradeName;
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
	public Float getDistance() {
		return distance;
	}

	public void setDistance(Float distance) {
		this.distance = distance;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getXcImgUrl() {
		return xcImgUrl;
	}
	public void setXcImgUrl(String xcImgUrl) {
		this.xcImgUrl = xcImgUrl;
	}
	public String getYyzzImgUrl() {
		return yyzzImgUrl;
	}
	public void setYyzzImgUrl(String yyzzImgUrl) {
		this.yyzzImgUrl = yyzzImgUrl;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
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
	public String getWeekday() {
		return weekday;
	}
	public void setWeekday(String weekday) {
		this.weekday = weekday;
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
	public Integer getVisitCount() {
		return visitCount;
	}
	public void setVisitCount(Integer visitCount) {
		this.visitCount = visitCount;
	}
	public Integer getSumShareCount() {
		return sumShareCount;
	}
	public void setSumShareCount(Integer sumShareCount) {
		this.sumShareCount = sumShareCount;
	}
	public Integer getSumHandleCount() {
		return sumHandleCount;
	}
	public void setSumHandleCount(Integer sumHandleCount) {
		this.sumHandleCount = sumHandleCount;
	}
	public Float getWithDrawMoney() {
		return withDrawMoney;
	}
	public void setWithDrawMoney(Float withDrawMoney) {
		this.withDrawMoney = withDrawMoney;
	}
	public String getBwxQrcode() {
		return bwxQrcode;
	}
	public void setBwxQrcode(String bwxQrcode) {
		this.bwxQrcode = bwxQrcode;
	}
	public String getRbwxQrcode() {
		return rbwxQrcode;
	}
	public void setRbwxQrcode(String rbwxQrcode) {
		this.rbwxQrcode = rbwxQrcode;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public Integer getShopCheck() {
		return shopCheck;
	}
	public void setShopCheck(Integer shopCheck) {
		this.shopCheck = shopCheck;
	}
	private String userName;//�̼��˺�
	private String password;//����
	private String shopName;//�ŵ��ַ
	private String shopAddress;//�ŵ��ַ
	private String shopFPY;//�ŵ���ƴ��
	private Integer tradeId;//��ҵid
	private String tradeName;//��ҵ����
	private Double latitude;//γ��
	private Double longitude;//����
	private Float distance;//��ʵ������
	private String logo;//�ŵ�logo
	private String xcImgUrl;//����ͼͼƬ����
	private String yyzzImgUrl;//Ӫҵִ��ͼƬ����
	private String contactTel;//��ϵ�绰
	private String describe;//�ŵ���
	private String createTime;//����ʱ��
	private String weekday;//һ����ÿ���Ƿ�Ӫҵ
	private String startTime;//Ӫҵ��ʼʱ��
	private String endTime;//Ӫҵ����ʱ��
	private Integer visitCount;//������
	private Integer sumShareCount;//�ۼƷ�����
	private Integer sumHandleCount;//�ۼư쿨��
	private Float withDrawMoney;
	private String bwxQrcode;
	private String rbwxQrcode;
	private String openId;
	private Integer shopCheck;//���״̬
}
