package com.cqgVipShare.util;

/*
 * 应用公钥：MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAokuXFwnI1CbA8oosZsAU7H8KHzid7m/rh+3KOfHqNabkWgCg6BPWPYO0LT2QRxUDx2c0Kz3WQcbqr7k9YVuxAaVhDsgRxSc4Qo2XqsOkaOvyA4185cPgl1TQyLMTvowyG27BsD3E3qN92rRxLM1B0DfGX62WEilxZxCrNyhp8E6mZcHImDsM5mFJGlROaBE7j5qqNM00Q/xnlI6ixF5R99lV2M1KSB6aUCELoOr6VVqimfp1xxWucvJTd9iikj3EZFSJAAgg2CkcIKijzlcKcYZPNcn3ekWKvTnKQm7X7gvSf83hWN3EYXvjqoSLv34PZowxRPAW+9yC/Tq1Dd5y0wIDAQAB
 * 支付宝公钥：MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg3R04pFb/esO+7EZ0zzSUAWmk7mm1b7R2886RSSuf+NC4ahhSYsB0bBVaGf6OjEqNhRJrBWenOyy/sXI+JYlq++HAlNrN5s4KLuVHMg8u5/3mbWFih2TY6xs1s88Mupvv8hQjJKrMRwscob26150YH95DCyYyQk3dKY3mRaebctrimcYDwkUPUNDK13oEjcWXQ64Y7Qqu4X7NxutU8uE/5DUO4i8afu4IeVLkPHA4bfb/ovvM1SW54c7RAQZhwMa+wC9SLh6+qKMHRenqQs+mOWmxJreNmxy9nkc59Uq/aeV6jY0nuG8qPnSpVe5C5L0VPXVhQCRnB0FrO+UtpdKYQIDAQAB
 */
public class AlipayConfig {

	public static String APPID="2019122160177031";
	public static String RSA_PRIVATE_KEY="MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCiS5cXCcjUJsDyiixmwBTsfwofOJ3ub+uH7co58eo1puRaAKDoE9Y9g7QtPZBHFQPHZzQrPdZBxuqvuT1hW7EBpWEOyBHFJzhCjZeqw6Ro6/IDjXzlw+CXVNDIsxO+jDIbbsGwPcTeo33atHEszUHQN8ZfrZYSKXFnEKs3KGnwTqZlwciYOwzmYUkaVE5oETuPmqo0zTRD/GeUjqLEXlH32VXYzUpIHppQIQug6vpVWqKZ+nXHFa5y8lN32KKSPcRkVIkACCDYKRwgqKPOVwpxhk81yfd6RYq9OcpCbtfuC9J/zeFY3cRhe+OqhIu/fg9mjDFE8Bb73IL9OrUN3nLTAgMBAAECggEBAI8NHcIax7/n4M5n6DcxO8AxQhS+7MYMNIj9mfB1QUHFNyX1w96MDZzvB9OQnilpZolOeHdc7AvSb24wUuAL1/thcCl9Q9yJc1eGQpcsFzC8N/fVsK89distgVJGNjMQk+IGQAc+itbLONWbkt4wlcAYSWxwLwUXLnPwB1p47tf2s5P1vGgxKANdOCj74weUJFOo1dBirlEnLG5JqT6bK+YjqwHRAZq6oD0992XNIfNVN1BO4w3EvmhnAV6MqFUGCNZN5bHrKW82G4Zh1VRfXjWnDGA4xB6uiD9EWxzdJYBU2GXrnxRIJ7QYAuj/eDXx0xTgAMNsQglGG4ZM0oB2tQECgYEA1VmbxT1Ya3QfxCl1aMMdNTief/9sJq8oIZTqzQlA5VSjWlFk5ouIPw9QHrd7mE2rI+DrcfTZO/AcROOwL6wZDYl2Ia82z9/+8lnTYoF0EMzD4kUndvI6kilo47ra5b4j/jqnwlDlojH7XyAlyXfGVAp06NXQ9C5L5Oe6eC4yf5MCgYEAwr00qZ9x978T9HesUFo/bPgmo+6qR2XPuDJCFUeovrufWEuEoXrbEda0BzFVCst/jOE3s1SOBlZ1wfmN9zZhtB1buzVEPcUNQ/KuzqJjYn4Qve+8CS4YQMdzgXkjbJwm7tbKk370Ry4YEVADH9FP5vANAw3prLW4zOX7pb97x8ECgYBBpg8ehB/fAJ59t9we3lrwc3miHTBkPuV0X+RYLw6/Amo5cm4/2pOUA9w9d2wak1uj8KPCLvthTCMGt6ERKj2TQscM2mNdV6mVXTqERx01xixIRcs8+JA5RXC3Elok83sT0WypiEcAv6x/ut6lvatTVNxggNqJKG3GA+AG9wAm7QKBgDF+BLRXYY+lcFzhTVneleAL8UYYkg4zQed+Xm0qGSjgZk76Ymrn3mVaO8bYMtTbgz86vf1FsBLMRoFV+06o84vjKj0Z/I32Vri+JM8/ViLiBz8+fnuWy3MrPZ/aObaQuRRaYoG58jtk65j6zNB5UeVPfP8Zuhm61Yy9pocpczwBAoGAS9HVqxwYc1xKsUFO2CYCUzNncIDVK3JTap6osEjhF4vGRqkwxcH3j2Z1jrb2KUf9jSgeBdd2r1T9lzX4LtcRjNL40nPCoJL6AuphJPfHSVJX51Hgx28Rd9BdyhwyPtGc4vp+yaqjDXUE+O9i2Ag3sfsd23V30DYo+VUMakXNa54=";
	public static String NOTIFY_URL="http://www.mcardgx.com:8080/CqgVipShare/vip/addShareRecord";
	public static String RETURN_URL="http://www.mcardgx.com:8080/CqgVipShare/vip/goPaySuccess";
	public static String URL="https://openapi.alipay.com/gateway.do";
	public static String CHARSET="UTF-8";
	public static String FORMAT="json";
	public static String ALIPAY_PUBLIC_KEY="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg3R04pFb/esO+7EZ0zzSUAWmk7mm1b7R2886RSSuf+NC4ahhSYsB0bBVaGf6OjEqNhRJrBWenOyy/sXI+JYlq++HAlNrN5s4KLuVHMg8u5/3mbWFih2TY6xs1s88Mupvv8hQjJKrMRwscob26150YH95DCyYyQk3dKY3mRaebctrimcYDwkUPUNDK13oEjcWXQ64Y7Qqu4X7NxutU8uE/5DUO4i8afu4IeVLkPHA4bfb/ovvM1SW54c7RAQZhwMa+wC9SLh6+qKMHRenqQs+mOWmxJreNmxy9nkc59Uq/aeV6jY0nuG8qPnSpVe5C5L0VPXVhQCRnB0FrO+UtpdKYQIDAQAB";
	public static String SIGNTYPE="RSA2";
	public static String CERT_PATH="http://127.0.0.1:8080/CqgVipShare/upload/appCertPublicKey_2016080600178660.crt";
	public static String ALIPAY_PUBLIC_CERT_PATH="http://127.0.0.1:8080/CqgVipShare/upload/alipayCertPublicKey_RSA2.crt";
	public static String ROOT_CERT_PATH="http://127.0.0.1:8080/CqgVipShare/upload/alipayRootCert.crt";
	
	/*
	public static String APPID="2019072265971163";
	public static String RSA_PRIVATE_KEY="MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC5iR4FunUOM6c2uiE6C7qBzz7RW8xQT8NLxn3B5hL6dS3Zo9y7nb02Js3PGYWZgnvZsKrtn1Y3VJNdZyKoKlktHF8N7v/qhCdYHKHnj1DE7J/3v23lD/9tUt58rC58QoMKbxQjpWB/gua75WcvGChCXKvmG1OWIIkAAi6stSxrac6hNVH2b4oLfGy4941ATR4f019m9fOs64kgzX5Mv0SbnPCemeoeSfKbYEMm6pLiVWLVGxdsE/ufCvOhGBAorVJbgXngWeNn9GLlWx8wrMZPt6lRJ9bDG1QtFpeYeq6/R7XFGphQL2rPOsipwHwXzrIYLZ9uytnb+Z698lU8IlatAgMBAAECggEAXjC9PB0/xdj1P/RYX/aKVdJXysN2wyLrO7HmMCTUZ7BLeZ0Vt23KHA6xFz2WtKsoowhsjjwA8hAOzDFKx+LP6PXpT9KQu4chzjqi+0Knt4GFaKoXaV2ox+B1MQfchZrimc5wg/Q2PCXBa4x3yNHTxnTzk9s1oRadVpLFDUrg5Rov3vOaFDjDXOpNDsVsEZPhA3oehh+MF/VuO3ypJRT2FttvD11n5S03T4ZiPt/ft70AMVzsI9x2ElWpEre5hqPX/73QABB7gaJ9uTMI7hsCx39nlpElIbVM3xSWrrVFegy17oQ9wx89Eg77aEfR/IzJ+KmSnSEoy6ZmcaNpaG9E5QKBgQD44DHQCVzNTffqNQDCAO5KeL8ffdb+8BG0RGEdfDM0ZDP3kymssAADYZH+8Tau8azRt++hr5GOBcI3P0hqK9tZE/m9fQMEk9nBicgVjq9W/oRK9n6S9Emu8F61GFWDcPZEuqOKRjbIERqaNVq4KeJEYHbg+fplQtaT5bKUDtshewKBgQC+2MFELBlhdtjk9vH+bjzCWGE/VOk7bBI44Yp7QSlP72D8l+VasCbj9pULh+qT2ieQMg0rwaj8N0CB5t0yQtwAl59gApoNrcNNzoXPWrmaHAX4lKflyJk5yjEE9Clafj66nOVIUja+S0Ny7sZnoeGy1y4BPvKWndYusU0Yp9JL9wKBgCfZzmAff6qoN3BbOFnYSE/IceIbBlggHNWetWZBQvm6qc+U0vGB5R6levk1qqnsrN2P9GERed8h8O1jxrapeyASYMUExXzwJ8gjxdQd2tm1O329ZpslXr8SYjfhQ6AecHCk6hb0E0WJ55aVwIcIveBxCdgQbxXT1AQunZ+zmUcNAoGBAI/mEbucYLrLiPkDdi344tlLGHBPTtjeQNMgxHDxDfxWq1NqGKaLoZdLitA5+FbpK+Gey62NhSQ/aOVJtMk7/nR33tTewVfFCDj3mo9hggbAUIRBWmN5IIehe9qXW0L/Y78DpCIm014ik8XqYjErr2lQtEB+PR3x/tgQGeiYSYm7AoGBAKLD58z45CKAVLIlro4ktA8zFn/xqL4mUMQKCg+dwK6D4HWo/hpGYHKyz131Qmx5HjJ05VARkxiH/nIq/gkTKyamOENYeEs+U1iQhq3CRM+fvOrWOB4fpxbE1c2baSWugWLvhO4QKtW5xxl3r55MzLupxYbB8y/IkakoiRmBbeWY";
	public static String NOTIFY_URL="";
	public static String RETURN_URL="";
	public static String URL="https://openapi.alipay.com/gateway.do";
	public static String CHARSET="UTF-8";
	public static String FORMAT="json";
	public static String ALIPAY_PUBLIC_KEY="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg3R04pFb/esO+7EZ0zzSUAWmk7mm1b7R2886RSSuf+NC4ahhSYsB0bBVaGf6OjEqNhRJrBWenOyy/sXI+JYlq++HAlNrN5s4KLuVHMg8u5/3mbWFih2TY6xs1s88Mupvv8hQjJKrMRwscob26150YH95DCyYyQk3dKY3mRaebctrimcYDwkUPUNDK13oEjcWXQ64Y7Qqu4X7NxutU8uE/5DUO4i8afu4IeVLkPHA4bfb/ovvM1SW54c7RAQZhwMa+wC9SLh6+qKMHRenqQs+mOWmxJreNmxy9nkc59Uq/aeV6jY0nuG8qPnSpVe5C5L0VPXVhQCRnB0FrO+UtpdKYQIDAQAB";
	public static String SIGNTYPE="RSA2";
	*/
}
