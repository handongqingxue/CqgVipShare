package com.cqgVipShare.util.wxwithdraw.sdk;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class WechatpayUtil
{
    private static final Log LOG = LogFactory.getLog(WechatpayUtil.class);
    
    private static final String TRANS_URL = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";

    // ΢���̻�appkey
    private static String APP_KEY = "";

    // ΢���̻�֤��·��
    private static String CERT_PATH = "";
    
    /**
     * @param model
     *            微信接口请求参数DTO对象
     * @return ResultEntity 返回结构�?
     */
    /*
    public static ResultEntity doTransfers(String appkey, String certPath, TransfersDto model)
    {
        APP_KEY = appkey;
        CERT_PATH = certPath;
        try
        {
            // 1.计算参数签名
            String paramStr = WechatpayUtil.createLinkString(model);
            String mysign = paramStr + "&key=" + APP_KEY;
            String sign = DigestUtils.md5Hex(mysign).toUpperCase();

            // 2.封装请求参数
            StringBuilder reqXmlStr = new StringBuilder();
            reqXmlStr.append("<xml>");
            reqXmlStr.append("<mchid>" + model.getMchid() + "</mchid>");
            reqXmlStr.append("<mch_appid>" + model.getMch_appid() + "</mch_appid>");
            reqXmlStr.append("<nonce_str>" + model.getNonce_str() + "</nonce_str>");
            reqXmlStr.append("<check_name>" + model.getCheck_name() + "</check_name>");
            reqXmlStr.append("<openid>" + model.getOpenid() + "</openid>");
            reqXmlStr.append("<amount>" + model.getAmount() + "</amount>");
            reqXmlStr.append("<desc>" + model.getDesc() + "</desc>");
            reqXmlStr.append("<sign>" + sign + "</sign>");
            reqXmlStr.append("<partner_trade_no>" + model.getPartner_trade_no() + "</partner_trade_no>");
            reqXmlStr.append("<spbill_create_ip>" + model.getSpbill_create_ip() + "</spbill_create_ip>");
            reqXmlStr.append("</xml>");

            LOG.info("request xml = " + reqXmlStr);
            // 3.加载证书请求接口
            String result = HttpRequestHandler.httpsRequest(TRANS_URL, reqXmlStr.toString(),
                model, CERT_PATH);
            LOG.info(("response xml = " + result));
            if(result.contains("CDATA[FAIL]")){
                return new ResultEntity(false, "调用微信接口失败, 具体信息请查看访问日�?");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return new ResultEntity(false, e.getMessage());
        }
        return new ResultEntity(true);
    }
    */
    
    public static String createLinkString(HLWXWithDrawConfig config)
    {
        // 微信签名规则 https://pay.weixin.qq.com/wiki/doc/api/tools/mch_pay.php?chapter=4_3
        Map<String, Object> paramMap = new HashMap<String, Object>();
        
        // 订单号默认用商户�?+时间�?+4位随机数+可以根据自己的规则进行调�?
        //config.setAppkey(APP_KEY);
        config.setNonceStr(WechatpayUtil.getNonce_str());
        config.setPartnerTradeNo(config.getMchID()
                                  + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())
                                  + (int)((Math.random() * 9 + 1) * 1000));
        
        paramMap.put("mch_appid", config.getAppID());
        paramMap.put("mchid", config.getMchID());
        paramMap.put("openid", config.getOpenId());
        paramMap.put("amount", config.getAmount());
        paramMap.put("check_name", config.getCheckName());
        paramMap.put("desc", config.getDesc());
        paramMap.put("partner_trade_no", config.getPartnerTradeNo());
        paramMap.put("nonce_str", config.getNonceStr());
        paramMap.put("spbill_create_ip", config.getSpbillCreateIp());
        
        List<String> keys = new ArrayList(paramMap.keySet());
        Collections.sort(keys);
        String prestr = "";
        for (int i = 0; i < keys.size(); i++ )
        {
            String key = keys.get(i);
            Object value = (Object)paramMap.get(key);
            if (i == keys.size() - 1)
            {// 拼接时，不包括最后一�?&字符
                prestr = prestr + key + "=" + value;
            }
            else
            {
                prestr = prestr + key + "=" + value + "&";
            }
        }
        return prestr;
    }

    private static String getNonce_str()
    {
        String base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 15; i++ )
        {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }

}
