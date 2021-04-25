package com.cqgVipShare.entity;

public class ShareCard {

	public static final Integer NIAN_KA=1;
	public static final Integer JI_KA=2;
	public static final Integer YUE_KA=3;
	public static final Integer CHONG_ZHI_KA=4;
	public static final Integer CI_KA=5;
	
	private Integer id;//主键
	private String no;//卡号
	private String name;//卡名
	private Integer type;//类型：1.年卡、2.季卡、3.月卡、4.充值卡、5.次卡
	private Integer shopId;//实体店id
	private String shopName;//实体店名
	private String shopLogo;//实体店Logo
	private String shopAddress;//实体店地址
	private Float shopDistance;//到实体店距离
	private String openId;//卡主openId
	private String phone;//手机号
	private Integer consumeCount;//剩余消费次数
	private Float yj;//原价
	private Float hyj;//会员价
	private Float zdfxje;//最低分享价
	private Float shareMoney;//分享金额
	private Integer sfbfb;//上浮百分比
	private Integer shopFC;//商家分成:上浮出的金额里分给商家的金额百分比（剩下的上浮出的金额分给卡主）
	private Integer discount;//折扣
	private Float minDeposit;//最低押金
	private Integer weightValue;//权重值（首页根据这个值来排行）
	private String describe;//服务内容描述
	private String createTime;//创建时间
	private String startTime;
	private String endTime;
	private Boolean used;//是否用过（0 未用过 1 用过了）
	private Boolean enable;//是否可用（0  不可用 1可用）
	private Integer yxzCount;//已下载人数
	private Integer yxfCount;//已消费人数
	private Integer qxsqCount;//取消申请人数
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
