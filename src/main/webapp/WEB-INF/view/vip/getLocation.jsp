<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
		+request.getServerPort()+request.getContextPath()+"/";
	String appId=request.getAttribute("appId").toString();
	String appSecret=request.getAttribute("appSecret").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
//var openId='${param.openId}';
//var appid = "wxf600e162d89732da";
//var appSecret = "097ee3404400bdf4b75ac8cfb0cc1c26";
var appid = '<%=appId%>';
var appSecret = '<%=appSecret%>';
$(function(){
	getSignture();
});

function getSignture(){
	//1.获取微信JSSDK签名
	$.post("../JSSDK/getSignture.action",{
		appid: appid,
		appSecret: appSecret,
		url:location.href.split('#')[0]
		//url:"http://www.mcardgx.com/CqgVipShare/vip/toScan?openId="+openId+"&from=singlemessage"
	},function(data){
		config(data.timestamp,data.nonceStr,data.signature);
	},"json");
}

function config(timestamp,nonceStr,signature){
	wx.config({
		debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId: appid, // 必填，公众号的唯一标识
		timestamp: timestamp, // 必填，生成签名的时间戳
		nonceStr: nonceStr, // 必填，生成签名的随机串
		signature: signature,// 必填，签名，见附录1
		jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
}

wx.ready(function () {
    // 获取用户位置
    wx.getLocation({
    	type: 'wgs84',
        success: function (res) {
            //console.log('res', res)
            //alert(JSON.stringify(res));
             var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
             var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
             
             var speed = res.speed; // 速度，以米/每秒计
             var accuracy = res.accuracy; // 位置精度
             
             getAddress(latitude,longitude);
        },
        fail: function (res) {
            alert("获取位置失败");
        }
    });
 });
 
 function getAddress(latitude,longitude){
	//调用百度接口  根据经纬度信息获取地址
     $.ajax({
         url: "https://api.map.baidu.com/geocoder/v2/?ak=2GhAjyOSR2zqbv2o4MaMIEHY3ieP1ixC&callback=renderReverse&location=" + latitude + "," + longitude + "&output=json&pois=1",
         type: "get",
         dataType: "jsonp",
         jsonp: "callback",
         success: function (data) {
             var province = data.result.addressComponent.province;//山东省
             var city_name = (data.result.addressComponent.city);//青岛市
             var district = data.result.addressComponent.district;//市北区
             var street = data.result.addressComponent.street;//江都路
             var street_number = data.result.addressComponent.street_number;//
             var address = data.result.formatted_address;//山东省青岛市市北区江都路
             //$('[name="address"]').val(province + cityname);
             saveMyLocation(latitude,longitude,province,city_name,district,street,street_number,address);
         }
     });
 }
 
 function saveMyLocation(latitude,longitude,province,city,district,street,streetNumber,formattedAddress){
     $.post("saveMyLocation",
   		 {latitude:latitude,longitude:longitude,province:province,city:city,district:district,street:street,streetNumber:streetNumber,formattedAddress:formattedAddress},
   		 function(data){
   			 if(data.status=="ok"){
   				location.href=path+'${requestScope.redirectUrl}';
   			 }
   		 }
     ,"json");
 }
</script>
<title>获取位置</title>
</head>
<body>

</body>
</html>