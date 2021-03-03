package com.cqgVipShare.entity;

public class MyLocation {

	private Double latitude;//γ��
	private Double longitude;//����
	private String province;//ʡ��
	private String city;
	private String district;//����
	private String street;
	private String streetNumber;
	private String formattedAddress;//��ַ
	
	public MyLocation() {
		
	}
	public MyLocation(Double latitude, Double longitude, String province, String city, 
			String district, String street, String streetNumber, String formattedAddress) {
		// TODO Auto-generated constructor stub
		this.latitude=latitude;
		this.longitude=longitude;
		this.province=province;
		this.city=city;
		this.district=district;
		this.street=street;
		this.streetNumber=streetNumber;
		this.formattedAddress=formattedAddress;
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
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getStreetNumber() {
		return streetNumber;
	}
	public void setStreetNumber(String streetNumber) {
		this.streetNumber = streetNumber;
	}
	public String getFormattedAddress() {
		return formattedAddress;
	}
	public void setFormattedAddress(String formattedAddress) {
		this.formattedAddress = formattedAddress;
	}
}
