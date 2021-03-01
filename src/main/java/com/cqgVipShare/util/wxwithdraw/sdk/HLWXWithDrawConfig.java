package com.cqgVipShare.util.wxwithdraw.sdk;

import java.beans.Transient;
import java.util.HashMap;
import java.util.Map;

public class HLWXWithDrawConfig extends WxWithDrawConfig {

	private String appID="wxf600e162d89732da";
	private String mchID="1546451251";
    // �̻�����, ��'XXX�����'
    private String mchName;
    public String getMchName() {
		return mchName;
	}

	public void setMchName(String mchName) {
		this.mchName = mchName;
	}

	// �̻�appid�£�ĳ�û���openid
    private String openId;
    public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	// ��ҵ�������λΪԪ
    private int amount;
    public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	// �̻������ţ��豣��Ψһ��(ֻ������ĸ�������֣����ܰ����������ַ�)
    private String partnerTradeNo;
	public String getPartnerTradeNo() {
		return partnerTradeNo;
	}

	public void setPartnerTradeNo(String partnerTradeNo) {
		this.partnerTradeNo = partnerTradeNo;
	}

    private String certPath = "E:/apiclient_cert.p12";// ΢���̻�֤��·��, ����ʵ�������д
    private String transfersUrl = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
    // NO_CHECK����У����ʵ���� FORCE_CHECK��ǿУ����ʵ����
    private String checkName = "NO_CHECK";
    // ������IP��ַ+��IP�ɴ��û��˻��߷���˵�IP��
    private String spbillCreateIp = "127.0.0.1";
    public String getSpbillCreateIp() {
		return spbillCreateIp;
	}

	public void setSpbillCreateIp(String spbillCreateIp) {
		this.spbillCreateIp = spbillCreateIp;
	}

	// ��ҵ���ע
    private String desc;
    public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	// ����ַ�����������32λ
    private String nonceStr;
    public String getNonceStr() {
		return nonceStr;
	}

	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}

	private String appkey="GTusD1WphSK1zMjDFjRM4a3notET41hJ";

	/**
     * ��ȡ API ��Կ
     *
     * @return API��Կ
     */
	public String getAppkey() {
		return appkey;
	}

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
	public String getCertPath() {
		// TODO Auto-generated method stub
		return certPath;
	}

	@Override
	public String getTransfersUrl() {
		// TODO Auto-generated method stub
		return transfersUrl;
	}

	@Override
	public String getCheckName() {
		// TODO Auto-generated method stub
		return checkName;
	}
    
    @Transient
    public Map<String, String> map()
    {
        Map<String, String> map = new HashMap<String, String>();
        map.put("mch_appid", this.appID);
        map.put("mchid", this.mchID);
        map.put("mch_name", this.mchName);
        map.put("openid", this.openId);
        map.put("amount", String.valueOf(this.amount));
        map.put("desc", this.desc);
        map.put("appkey", this.appkey);
        map.put("nonce_str", this.nonceStr);
        map.put("partner_trade_no", this.partnerTradeNo);
        map.put("spbill_create_ip", this.spbillCreateIp);
        return map;
    }

    @Override
    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("[mch_appid]" + this.appID);
        sb.append(",[mchid]" + this.mchID);
        sb.append(",[openid]" + this.openId);
        sb.append(",[amount]" + this.amount);
        sb.append(",[desc]" + this.desc);
        sb.append(",[partner_trade_no]" + this.partnerTradeNo);
        sb.append(",[nonce_str]" + this.nonceStr);
        sb.append(",[spbill_create_ip]" + this.spbillCreateIp);
        sb.append(",[check_name]" + this.checkName);
        return sb.toString();
    }

}
