package com.cqgVipShare.entity;

public class Trade {

	private Integer id;
	private String name;
	private String imgUrl;
	private String describe;
	private Float ccPercent;//抽成百分比
	private Integer sort;
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
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public Float getCcPercent() {
		return ccPercent;
	}
	public void setCcPercent(Float ccPercent) {
		this.ccPercent = ccPercent;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}
