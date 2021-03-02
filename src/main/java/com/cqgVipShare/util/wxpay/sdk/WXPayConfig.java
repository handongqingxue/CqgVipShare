package com.cqgVipShare.util.wxpay.sdk;

import java.io.InputStream;

public abstract class WXPayConfig {

	public static String wxAppId="wxf600e162d89732da";
	
	public static String wxappStrect="79ch3122dsss71gbds5debe8d5c79e";
	
	public static String wxApiKey="GTusD1WphSK1zMjDFjRM4a3notET41hJ";
	
	//public static String notifyUrl =com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/wxPayNotifySevlet";
	//public static String notifyUrl =com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/kaiTongByWX";
	public static String notifyUrl="http://www.mcardgx.com:8080/CqgVipShare/vip/addRecord";

    /**
     * ��ȡ App ID
     *
     * @return App ID
     */
    abstract String getAppID();


    /**
     * ��ȡ Mch ID
     *
     * @return Mch ID
     */
    abstract String getMchID();


    /**
     * ��ȡ API ��Կ
     *
     * @return API��Կ
     */
    abstract String getKey();


    /**
     * ��ȡ�̻�֤������
     *
     * @return �̻�֤������
     */
    abstract InputStream getCertStream();

    /**
     * HTTP(S) ���ӳ�ʱʱ�䣬��λ����
     *
     * @return
     */
    public int getHttpConnectTimeoutMs() {
        return 6*1000;
    }

    /**
     * HTTP(S) �����ݳ�ʱʱ�䣬��λ����
     *
     * @return
     */
    public int getHttpReadTimeoutMs() {
        return 8*1000;
    }

    /**
     * ��ȡWXPayDomain, ���ڶ����������Զ��л�
     * @return
     */
    abstract IWXPayDomain getWXPayDomain();

    /**
     * �Ƿ��Զ��ϱ���
     * ��Ҫ�ر��Զ��ϱ���������ʵ�ָú������� false ���ɡ�
     *
     * @return
     */
    public boolean shouldAutoReport() {
        return true;
    }

    /**
     * ���н����ϱ����̵߳�����
     *
     * @return
     */
    public int getReportWorkerNum() {
        return 6;
    }


    /**
     * �����ϱ�������Ϣ����������������߳�ȥ�����ϱ�
     * ���Լ��㣺����һ����Ϣ200B��10000��Ϣռ�ÿռ� 2000 KB��ԼΪ2MB�����Խ���
     *
     * @return
     */
    public int getReportQueueMaxSize() {
        return 10000;
    }

    /**
     * �����ϱ���һ������ϱ��������
     *
     * @return
     */
    public int getReportBatchSize() {
        return 10;
    }

}