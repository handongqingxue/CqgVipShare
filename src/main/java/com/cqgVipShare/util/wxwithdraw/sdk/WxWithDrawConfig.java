package com.cqgVipShare.util.wxwithdraw.sdk;

public abstract class WxWithDrawConfig {

	/**
     * 获取 App ID
     *
     * @return MchApp ID
     */
    abstract String getMchAppID();


    /**
     * 获取 Mch ID
     *
     * @return Mch ID
     */
    abstract String getMchID();


    /**
     * 获取微信商户证书路径
     * @return CertPath
     */
    abstract String getCertPath();
    
    abstract String getTransfersUrl();
    
    abstract String getCheckName();
}
