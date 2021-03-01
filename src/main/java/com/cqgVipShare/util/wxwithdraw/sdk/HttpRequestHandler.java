package com.cqgVipShare.util.wxwithdraw.sdk;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.SocketTimeoutException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;

import javax.net.ssl.SSLContext;

import org.apache.commons.cli.oss.KeyStores;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

//import wechatpay.utils.entity.TransfersDto;


public class HttpRequestHandler
{

    // ���ӳ�ʱʱ�䣬Ĭ��10��
    private int socketTimeout = 10000;

    // ���䳬ʱʱ�䣬Ĭ��30��
    private int connectTimeout = 30000;

    // ������������
    private static RequestConfig requestConfig;

    // HTTP������
    private static CloseableHttpClient httpClient;

    /**
     * ����֤��
     * 
     * @param path
     * @throws IOException
     * @throws KeyStoreException
     * @throws UnrecoverableKeyException
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     */
    private static void initCert(String path, HLWXWithDrawConfig config)
        throws IOException, KeyStoreException, UnrecoverableKeyException,
        NoSuchAlgorithmException, KeyManagementException
    {
        // ƴ��֤���·��
        KeyStore keyStore = KeyStores.getInstance("PKCS12", path, config.map());

        // ���ر��ص�֤�����https���ܴ���
        FileInputStream instream = new FileInputStream(new File(path));
        try
        {
            keyStore.load(instream, config.getMchID().toCharArray()); // ����֤�����룬Ĭ��Ϊ�̻�ID
        }
        catch (CertificateException e)
        {
            e.printStackTrace();
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        finally
        {
            instream.close();
        }

        // Trust own CA and all self-signed certs
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore,
        		config.getMchID().toCharArray()).build();
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext,
            new String[] {"TLSv1"}, null,
            SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);

        httpClient = HttpClients.custom().setSSLSocketFactory(sslsf).build();

        // ����Ĭ�ϳ�ʱ���Ƴ�ʼ��requestConfig
        requestConfig = RequestConfig.custom().setSocketTimeout(10000).setConnectTimeout(30000).build();

    }

    /**
     * ͨ��Https��API post xml����
     * 
     * @param url
     *            API��ַ
     * @param xmlObj
     *            Ҫ�ύ��XML���ݶ���
     * @param path
     *            ��ǰĿ¼�����ڼ���֤��
     * @return
     * @throws IOException
     * @throws KeyStoreException
     * @throws UnrecoverableKeyException
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     */
    public static String httpsRequest(String url, String xmlObj, HLWXWithDrawConfig config, String path)
        throws IOException, KeyStoreException, UnrecoverableKeyException,
        NoSuchAlgorithmException, KeyManagementException
    {
        // ����֤��
        initCert(path, config);

        String result = null;

        HttpPost httpPost = new HttpPost(url);

        // ��ָ��ʹ��UTF-8���룬����API������XML�����Ĳ��ܱ��ɹ�ʶ��
        StringEntity postEntity = new StringEntity(xmlObj, "UTF-8");
        httpPost.addHeader("Content-Type", "text/xml");
        httpPost.setEntity(postEntity);

        // ����������������
        httpPost.setConfig(requestConfig);

        try
        {
            HttpResponse response = httpClient.execute(httpPost);

            HttpEntity entity = response.getEntity();

            result = EntityUtils.toString(entity, "UTF-8");

        }
        catch (ConnectionPoolTimeoutException e)
        {

        }
        catch (ConnectTimeoutException e)
        {

        }
        catch (SocketTimeoutException e)
        {

        }
        catch (Exception e)
        {

        }
        finally
        {
            httpPost.abort();
        }

        return result;
    }
}
