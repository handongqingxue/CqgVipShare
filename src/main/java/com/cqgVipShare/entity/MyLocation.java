package com.cqgVipShare.entity;

public class MyLocation {

	private Double latitude;//Î³¶È
	private Double longitude;//¾­¶È
	public MyLocation(Double latitude, Double longitude) {
		// TODO Auto-generated constructor stub
		this.latitude=latitude;
		this.longitude=longitude;
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
}
