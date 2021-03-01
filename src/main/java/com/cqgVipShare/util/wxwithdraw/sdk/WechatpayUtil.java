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
    
    public static String createLinkString(HLWXWithDrawConfig config)
    {
    	//微信签名规则 https://pay.weixin.qq.com/wiki/doc/api/tools/mch_pay.php?chapter=4_3
        Map<String, Object> paramMap = new HashMap<String, Object>();
        
        config.setNonceStr(WechatpayUtil.getNonce_str());
        // 订单号默认用商户号+时间戳+4位随机数+可以根据自己的规则进行调整
        config.setPartnerTradeNo(config.getMchID()
                                  + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())
                                  + (int)((Math.random() * 9 + 1) * 1000));
        
        paramMap.put("mch_appid", config.getMchAppID());
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
            {// 拼接时，不包括最后一个&字符
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
