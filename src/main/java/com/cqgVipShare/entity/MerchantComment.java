package com.cqgVipShare.entity;

public class MerchantComment {
	private Integer id;//Ö÷¼ü
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public Integer getShopId() {
		return shopId;
	}
	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getPjzNickName() {
		return pjzNickName;
	}
	public void setPjzNickName(String pjzNickName) {
		this.pjzNickName = pjzNickName;
	}
	public String getPjzHeadImgUrl() {
		return pjzHeadImgUrl;
	}
	public void setPjzHeadImgUrl(String pjzHeadImgUrl) {
		this.pjzHeadImgUrl = pjzHeadImgUrl;
	}
	private Integer type;
	private String content;
	private String openId;
	private Integer shopId;
	private String createTime;
	private String pjzNickName;
	private String pjzHeadImgUrl;
}
