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
var openId='${param.openId}';
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
				location.href=path+"vip/toMine?openId="+'${param.openId }';
			}
			else{
				alert(data.msg);
			}
		}
	});
}

function uploadImage(){
	document.getElementById("uploadImg_inp").click();
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

function goBack(){
	location.href=path+"vip/toMine?openId="+openId;
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
</script>
<title>完善商家信息</title>
</head>
<body style="margin: 0px;">
<div style="width: 100%;height: 40px;line-height: 40px;color:#fff;background-color: #EC4149;">
	<span style="margin-left: 10px;" onclick="goBack()">&lt;返回</span>
	<span style="margin-left: 50px;">完善商家信息</span>
</div>
<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
<input type="hidden" id="openId" name="openId" value="${param.openId }"/>
<input type="hidden" id="timestamp" />
<input type="hidden" id="nonceStr" />
<input type="hidden" id="signature" />
<input type="hidden" id="latitude" />
<input type="hidden" id="longitude" />
<table style="margin-top: 10px;">
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">商家名称</td>
		<td>
			<input type="text" id="shopName" name="shopName" value="${requestScope.user.shopName }" style="width: 188px;"/>
		</td>
	</tr>
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">商家地址</td>
		<td>
			<input type="text" id="shopAddress" name="shopAddress" value="${requestScope.user.shopAddress }" style="width: 188px;"/>
		</td>
	</tr>
	<tr height="30">
		<td style="width:45%;padding-left: 10px;">商家logo</td>
		<td>
			<div id="uploadBut_div" onclick="uploadImage()" style="width: 80px;height: 30px;line-height:30px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">选择文件</div>
			<input type="file" id="uploadImg_inp" name="uploadImg_inp" style="display: none;" onchange="showLogo(this)"/>
			<img id="logo_img" alt="" src="" style="width: 150px;height:150px;margin-top: 10px;"/>
		</td>
	</tr>
</table>
<div onclick="editMerchant()" style="width:95%;height:40px;line-height:40px;margin:0 auto; margin-top: 10px;text-align:center;color:#fff;background-color: #f00;border-radius:5px;">
	提交
</div>
</form>
</body>
</html>