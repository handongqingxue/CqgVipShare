<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新用户注册</title>
<%@include file="js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>resource/css/background/regist.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<!-- 将百度地图API引入，设置好自己的key -->
<!-- 参考链接:https://www.jb51.net/article/159821.htm -->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=7a6QKaIilZftIMmKGAFLG7QT1GLfIncg"></script>
<script type="text/javascript">
var baseUrl="${pageContext.request.contextPath}";
var vipPath=baseUrl+"/vip/";
$(function(){
	initTradeCBB();
	initBMap();
});

function initTradeCBB(){
	$.post(vipPath+"selectTrade",
		{name:name},
		function(result){
			if(result.message=="ok"){
				var tradeList=result.data;
				var tradeCBB=$("#trade_cbb");
				for(var i=0;i<tradeList.length;i++){
					var trade=tradeList[i];
					tradeCBB.append("<option value=\""+trade.id+"\">"+trade.name+"</option>");
				}
			}
		}
	,"json");
}

var map,geoc,markersArray,geolocation,point;
function initBMap(){
    map = new BMap.Map("map_div");
    geoc = new BMap.Geocoder();  //地址解析对象
    markersArray = [];
    geolocation = new BMap.Geolocation();
    point = new BMap.Point(116.331398, 39.897445);
    map.centerAndZoom(point, 12); // 中心点
    geolocation.getCurrentPosition(function (r) {
      if (this.getStatus() == BMAP_STATUS_SUCCESS) {
        var mk = new BMap.Marker(r.point);
        map.addOverlay(mk);
        map.panTo(r.point);
        map.enableScrollWheelZoom(true);
      }
      else{
        alert('failed' + this.getStatus());
      }
    }, {enableHighAccuracy: true})
    map.addEventListener("click", showInfo);
}

//点击地图时间处理
function showInfo(e) {
    $("#map_bg_div #longitude").val(e.point.lng);
    $("#map_bg_div #latitude").val(e.point.lat);
    geoc.getLocation(e.point, function (rs) {
      var addComp = rs.addressComponents;
      var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
      $("#map_bg_div #shopAddress").val(address);
      if (confirm("确定要地址是" + address + "?")) {
        $("#map_bg_div").css("display","none");
        $("#regist_div #longitude").val(e.point.lng);
        $("#regist_div #latitude").val(e.point.lat);
        $("#regist_div #shopAddress").val(address);
      }
    });
    addMarker(e.point);
}

//地图上标注
function addMarker(point) {
    var marker = new BMap.Marker(point);
    markersArray.push(marker);
    clearOverlays();
    map.addOverlay(marker);
}

//清除标识
function clearOverlays() {
    if (markersArray) {
      for (i in markersArray) {
        map.removeOverlay(markersArray[i])
      }
    }
}

function focusUserName(){
	var userName = $("#userName").val();
	if(userName=="用户名不能为空"||userName=="用户名已注册"){
		$("#userName").val("");
		$("#userName").css("color", "#555555");
	}
}

//验证用户名
function checkUserName(){
	var flag=false;
	var userName = $("#userName").val();
	if(userName==null||userName==""||userName=="用户名不能为空"){
		$("#userName").css("color","#E15748");
    	$("#userName").val("用户名不能为空");
    	flag=false;
	}
	else if(userName=="用户名已注册"){
		$("#userName").css("color","#E15748");
    	$("#userName").val("用户名已注册");
    	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(vipPath+"checkUserNameExist",
			{userName:userName},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					$("#userName").css("color","#E15748");
			    	$("#userName").val(data.message);
			    	flag=false;
				}
			}
		,"json");
	}
	return flag;
}

function checkPassword(){
	var password=$("#password").val();
	if(password==null||password==""||password=="请输入密码"){
		alert("请输入密码");
		return false;
	}
	else
		return true;
}

function checkPassword1(){
	var password=$("#password").val();
	var password1=$("#password1").val();
	if(password1==null||password1==""||password1=="请输入确认密码"){
		alert("请输入确认密码");
		return false;
	}
	if(password!=password1){
		alert("两次密码不一致");
		return false;
	}
	else
		return true;
}

function checkTradeId(){
	var tradeId = $("#trade_cbb").val();
	if(tradeId==null||tradeId==""){
    	alert("请选择所属行业");
    	return false;
	}
	else
		return true;
}

function focusShopName(){
	var shopName = $("#shopName").val();
	if(shopName=="商家名称不能为空"){
		$("#shopName").val("");
		$("#shopName").css("color", "#555555");
	}
}

//验证商家名称
function checkShopName(){
	var shopName = $("#shopName").val();
	if(shopName==null||shopName==""||shopName=="商家名称不能为空"){
		$("#shopName").css("color","#E15748");
    	$("#shopName").val("商家名称不能为空");
    	return false;
	}
	else
		return true;
}

function focusShopAddress(){
	var shopAddress = $("#shopAddress").val();
	if(shopAddress=="商家地址不能为空"){
		$("#shopAddress").val("");
		$("#shopAddress").css("color", "#555555");
	}
}

//验证商家地址
function checkShopAddress(){
	var shopAddress = $("#shopAddress").val();
	if(shopAddress==null||shopAddress==""||shopAddress=="商家地址不能为空"){
		$("#shopAddress").css("color","#E15748");
    	$("#shopAddress").val("商家地址不能为空");
    	return false;
	}
	else
		return true;
}

function checkForm(){
	if(checkUserName()){
		if(checkPassword()){
			if(checkPassword1()){
				if(checkTradeId()){
					if(checkShopName()){
						if(checkShopAddress()){
							addMerchant();
						}
					}
				}
			}
		}
	}
}

function addMerchant(){
	$("#pwd_hid").val(MD5($("#password").val()).toUpperCase());
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:vipPath+"addMerchant",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=baseUrl+"/background/login";
			}
			else{
				alert(data.msg);
			}
		}
	});
}

function reset(){
	$("#userName").val("");
	$("#password").val("");
	$("#password1").val("");
	$("#shopName").val("");
	$("#regist_div #shopAddress").val("");
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

function showMapDiv(){
	var display=$("#map_bg_div").css("display");
    if (display == 'none') {
    	$("#map_bg_div").css("display","block");
    } 
    else{
    	$("#map_bg_div").css("display","none");
    }
}
</script>
</head>
<body>
<div class="map_bg_div" id="map_bg_div">
	<div class="window_div">
		<div class="info_div">
			<span class="key_span">经度</span>
			<input class="longitude_inp" type="text" id="longitude"/>
			<span class="key_span">纬度</span>
			<input class="latitude_inp" type="text" id="latitude"/>
			<span class="key_span">地址</span>
			<input class="shopAdd_inp" type='text' id='shopAddress' readonly />
		</div>
		<div class="map_div" id="map_div"></div>
	</div>
</div>

<div class="regist_div" id="regist_div">
	<div class="title_div">商家注册</div>
	<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
	<div class="main_div">
			<div class="attr_div userName_div">
				<input type="text" class="userName_inp" id="userName" name="userName" placeholder="请输入用户名" onfocus="focusUserName();" onblur="checkUserName();"/>
			</div>
			<div class="attr_div password_div">
				<input type="password" class="password_inp" id="password" placeholder="请输入密码" onblur="checkPassword();"/>
				<input type="hidden" id="pwd_hid" name="password"/>
			</div>
			<div class="attr_div password1_div">
				<input type="password" class="password1_inp" id="password1" placeholder="请再次输入密码" onblur="checkPassword1();"/>
			</div>
			<div class="attr_div trade_div">
				<select class="trade_cbb" id="trade_cbb" name="tradeId">
					<option value="">请选择行业</option>
				</select>
			</div>
			<div class="attr_div shopName_div">
				<input type="text" class="shopName_inp" id="shopName" name="shopName" placeholder="请输入商家名称" onfocus="focusShopName();" onblur="checkShopName();"/>
			</div>
			<div class="attr_div shopAddress_div">
				<input type="hidden" id="longitude" name="longitude"/>
				<input type="hidden" id="latitude" name="latitude"/>
				<input type="text" class="shopAddress_inp" id="shopAddress" name="shopAddress" placeholder="请选择商家地址" readonly="readonly" onclick="showMapDiv()"/>
			</div>
			<div class="logo_div">
				<div class="upLoBut_div" onclick="uploadLogo()">选择商家logo</div>
				<input type="file" id="logo_inp" name="logo_inp" style="display: none;" onchange="showLogo(this)"/>
				<img class="logo_img" id="logo_img" alt="" src=""/>
			</div>
			<div class="yyzz_div">
				<div class="upYyzzBut_div" onclick="uploadYYZZ()">选择营业执照</div>
				<input type="file" id="yyzz_inp" name="yyzz_inp" style="display: none;" onchange="showYYZZ(this)"/>
				<img class="yyzz_img" id="yyzz_img" alt="" src=""/>
			</div>
			<div class="option_but_div">
				<div class="submitBut_div" onclick="checkForm();">立即提交</div>
				<div class="resetBut_div" onclick="reset();">重置</div>
			</div>
	</div>
	</form>
 	<div class="zjdl_div">已有账号？<a class="zjdl_a" href="<%=basePath%>merchant/login">直接登录</a></div>
</div>
</body>
</html>