package com.cqgVipShare.util.wxpay.sdk;

import java.io.InputStream;

public class HLWXPayConfig extends WXPayConfig {

	private String appID="wxf600e162d89732da";
	private String mchID="1546451251";
	private String key="GTusD1WphSK1zMjDFjRM4a3notET41hJ";

	@Override
	public String getAppID() {
		// TODO Auto-generated method stub
		return appID;
	}

	@Override
	public String getMchID() {
		// TODO Auto-generated method stub
		return mchID;
	}

	@Override
	public String getKey() {
		// TODO Auto-generated method stub
		return key;
	}

	@Override
	InputStream getCertStream() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	IWXPayDomain getWXPayDomain() {
		// TODO Auto-generated method stub
		return null;
	}

}
