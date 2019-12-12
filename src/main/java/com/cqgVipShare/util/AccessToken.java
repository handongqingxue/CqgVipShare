package com.cqgVipShare.util;
/**
 * 微信通用接口凭证
 * 
 * @author ydq
 * @date 2013.08.29
 */
public class AccessToken {
	// 获取到的凭证
	private String token;
	// 凭证有效时间，单位：�?
	private int expiresIn;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public int getExpiresIn() {
		return expiresIn;
	}

	public void setExpiresIn(int expiresIn) {
		this.expiresIn = expiresIn;
	}
}
