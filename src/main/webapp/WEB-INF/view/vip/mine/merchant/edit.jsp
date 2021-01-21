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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/edit.css"/>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
//var appid = "wxf600e162d89732da";
//var appSecret = "097ee3404400bdf4b75ac8cfb0cc1c26";
var appid = '<%=appId%>';
var appSecret = '<%=appSecret%>';
$(function(){
	//getSignture();
});

function getSignture(){
	//1.获取微信JSSDK签名
	$.post("../JSSDK/getSignture.action",{
		appid: appid,
		appSecret: appSecret,
		url:location.href.split('#')[0]
		//url:"http://www.mcardgx.com/CqgVipShare/vip/toScan?openId="+openId+"&from=singlemessage"
	},function(data){
		//alert(data.timestamp);
		//alert(data.nonceStr);
		//alert(data.signature);
		console.log(data);
		$("#timestamp").val(data.timestamp);
		$("#nonceStr").val(data.nonceStr);
		$("#signature").val(data.signature);
		config();
	},"json");

	/*
	//jsapi_ticket=kgt8ON7yVITDhtdwci0qeen6kZojAUOjVNkgXblzBjgKaU-LZunPgbFCh8gM-cjvtkVSA-HSiEuKkFOpqh_-Tg
	$("#timestamp").val("1577428856");
	$("#nonceStr").val("e3314941-0e45-4e55-ba5f-68e43d0963b0");
	$("#signature").val("413c88995d9a049e195f5d52c4c6758f0d51c738");
	config();
	$("#scanQRCode").css("display","block");
	*/
}

function config(){
	var timestamp = $("#timestamp").val();//时间戳
	var nonceStr = $("#nonceStr").val();//随机串
	var signature = $("#signature").val();//签名
	
	wx.config({
		debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId: appid, // 必填，公众号的唯一标识
		timestamp: timestamp, // 必填，生成签名的时间戳
		nonceStr: nonceStr, // 必填，生成签名的随机串
		signature: signature,// 必填，签名，见附录1
		jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
}

function checkInfo(){
	if(checkShopName()){
		if(checkShopAddress()){
			editMerchant();
		}
	}
}

function editMerchant(){
	/*
	var openId=$("#openId").val();
	var shopName=$("#shopName").val();
	var shopAddress=$("#shopAddress").val();
	*/
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:"editMerchant",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/goPage?page=mineInfo&openId="+'${param.openId }';
			}
			else{
				alert(data.msg);
			}
		}
	});
}

function uploadLogo(){
	document.getElementById("logo_inp").click();
}

function uploadYYZZ(){
	document.getElementById("yyzz_inp").click();
}

function showLogo(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#logo_img");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
}

function showYYZZ(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#yyzz_img");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
}

//微信接口获取当前用户经纬度
var latitude, longitude;
wx.ready(function () {
    // 获取用户位置
    wx.getLocation({
    	type: 'wgs84',
        success: function (res) {
            console.log('res', res)
             latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
             longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
             $("#latitude").val(latitude);
             $("#longitude").val(longitude);
             
             var speed = res.speed; // 速度，以米/每秒计
             var accuracy = res.accuracy; // 位置精度
             /*
             //调用百度接口  根据经纬度信息获取地址
             $.ajax({
                 url: "https://api.map.baidu.com/geocoder/v2/?ak=2GhAjyOSR2zqbv2o4MaMIEHY3ieP1ixC&callback=renderReverse&location=" + latitude + "," + longitude + "&output=json&pois=1",
                 type: "get",
                 dataType: "jsonp",
                 jsonp: "callback",
                 success: function (data) {
                     var province = data.result.addressComponent.province;
                     var cityname = (data.result.addressComponent.city);
                     var district = data.result.addressComponent.district;
                     var street = data.result.addressComponent.street;
                     var street_number = data.result.addressComponent.street_number;
                     var address = data.result.formatted_address;
                     $('[name="address"]').val(province + cityname);
                 }
             });
             */

        },
        fail: function (res) {
            //alert("获取位置失败");
        }
    });
 });

function goBack(){
	location.href=path+"vip/goPage?page=mineInfo&openId="+openId;
}
</script>
<title>完善商家信息</title>
</head>
<body>
<div class="top_div">
	<span>完善商家信息</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
<input type="hidden" id="openId" name="openId" value="${param.openId }"/>
<input type="hidden" id="timestamp" />
<input type="hidden" id="nonceStr" />
<input type="hidden" id="signature" />
<input type="hidden" id="latitude" name="latitude" />
<input type="hidden" id="longitude" name="longitude" />
<div class="main_div">
	<div class="userName_div">
		<span class="userName_span">${requestScope.merchant.userName }</span>
	</div>
	<div class="shopName_div">
		<input type="text" class="shopName_inp" id="shopName" name="shopName" placeholder="请输入商家名称" value="${requestScope.merchant.shopName }"/>
	</div>
	<div class="shopAddress_div">
		<input type="text" class="shopAddress_inp" id="shopAddress" name="shopAddress" placeholder="请输入商家地址" value="${requestScope.merchant.shopAddress }"/>
	</div>
	<div class="logo_div">
		<div class="upLoBut_div" onclick="uploadLogo()">选择商家logo</div>
		<input type="file" id="logo_inp" name="logo_inp" style="display: none;" onchange="showLogo(this)"/>
		<img class="logo_img" id="logo_img" alt="" src="${requestScope.merchant.logo }"/>
	</div>
	<div class="trade_div">
		<span class="trade_span">${requestScope.merchant.tradeName }</span>
	</div>
	<div class="yyzz_div">
		<div class="upYyzzBut_div" onclick="uploadYYZZ()">选择营业执照</div>
		<input type="file" id="yyzz_inp" name="yyzz_inp" style="display: none;" onchange="showYYZZ(this)"/>
		<img class="yyzz_img" id="yyzz_img" alt="" src="${requestScope.merchant.yyzzImgUrl }"/>
	</div>
	<div class="submitBut_div" onclick="checkInfo()">
		立即提交
	</div>
</div>
</form>
</body>
</html>