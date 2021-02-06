package com.cqgVipShare.entity;

public class Merchant {
	
	public static final int DAI_SHEN_HE=0;
	public static final int SHEN_HE_TONG_GUO=1;
	public static final int SHEN_HE_BU_HE_GE=2;
	
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
	public Integer getHandleCount() {
		return handleCount;
	}

	public void setHandleCount(Integer handleCount) {
		this.handleCount = handleCount;
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
	private String logo;//�ŵ�logo
	private String xcImgUrl;//����ͼͼƬ����
	private String yyzzImgUrl;//Ӫҵִ��ͼƬ����
	private String describe;//�ŵ���
	private String createTime;//����ʱ��
	private Integer visitCount;//������
	private Integer sumShareCount;//������
	private Integer handleCount;//�쿨��
	private String openId;
	private Integer shopCheck;//���״̬
}
