package com.cqgVipShare.util.wxwithdraw.sdk;

public abstract class WxWithDrawConfig {

	/**
     * ��ȡ App ID
     *
     * @return MchApp ID
     */
    abstract String getMchAppID();


    /**
     * ��ȡ Mch ID
     *
     * @return Mch ID
     */
    abstract String getMchID();


    /**
     * ��ȡ΢���̻�֤��·��
     * @return CertPath
     */
    abstract String getCertPath();
    
    abstract String getTransfersUrl();
    
    abstract String getCheckName();
}
