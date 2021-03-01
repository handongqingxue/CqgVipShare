package com.cqgVipShare.util.wxwithdraw.sdk;

import java.beans.Transient;
import java.util.HashMap;
import java.util.Map;

public class HLWXWithDrawConfig extends WxWithDrawConfig {

	private String mchAppID="wxf600e162d89732da";
	private String mchID="1546451251";
    // 商户名称, 如'XXX服务号'
    private String mchName="青岛华凌科技有限公司开发区分公司";
	private String appkey="GTusD1WphSK1zMjDFjRM4a3notET41hJ";
    private String certPath = "D:/apiclient_cert.p12";// 微信商户证书路径, 根据实际情况填写
    private String transfersUrl = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
    // NO_CHECK：不校验真实姓名 FORCE_CHECK：强校验真实姓名
    private String checkName = "NO_CHECK";
	// 商户订单号，需保持唯一性(只能是字母或者数字，不能包含有其他字符)
    private String partnerTradeNo;
    // 发起者IP地址+该IP可传用户端或者服务端的IP。
    private String spbillCreateIp = "127.0.0.1";
	// 企业付款金额，单位为元
    private int amount;
	// 随机字符串，不长于32位
    private String nonceStr;
	// 企业付款备注
    private String desc;
	// 商户appid下，某用户的openid
    private String openId;

	@Override
	public String getMchAppID() {
		// TODO Auto-generated method stub
		return mchAppID;
	}
	@Override
	public String getMchID() {
		// TODO Auto-generated method stub
		return mchID;
	}
    public String getMchName() {
		return mchName;
	}
	/**
     * 获取 API 密钥
     *
     * @return API密钥
     */
	public String getAppkey() {
		return appkey;
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
	public String getPartnerTradeNo() {
		return partnerTradeNo;
	}
	public void setPartnerTradeNo(String partnerTradeNo) {
		this.partnerTradeNo = partnerTradeNo;
	}
    public String getSpbillCreateIp() {
		return spbillCreateIp;
	}
	public void setSpbillCreateIp(String spbillCreateIp) {
		this.spbillCreateIp = spbillCreateIp;
	}
    public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
    public String getNonceStr() {
		return nonceStr;
	}
	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}
    public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
    public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	
    @Transient
    public Map<String, String> map(){
        Map<String, String> map = new HashMap<String, String>();
        map.put("mch_appid", this.mchAppID);
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
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("[mch_appid]" + this.mchAppID);
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
