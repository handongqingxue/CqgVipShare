<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
<%@include file="../../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>resource/css/background/merchant/info/info.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<!-- 将百度地图API引入，设置好自己的key -->
<!-- 参考链接:https://www.jb51.net/article/159821.htm -->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=7a6QKaIilZftIMmKGAFLG7QT1GLfIncg"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var vipPath=path+"vip/";
var merPath=path+"background/merchant/";
$(function(){
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#sjxx_div").css("width",setFitWidthInParent("body")+"px");
	initYYRDiv();
	initStartTimeCBB();
	initEndTimeCBB();
	initBMap();
});

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

function confirmLocation(){
	var address=$("#map_bg_div #shopAddress").val();
	if (confirm("确定要地址是" + address + "?")) {
        $("#map_bg_div").css("display","none");
        var longitude=$("#map_bg_div #longitude").val();
        var latitude=$("#map_bg_div #latitude").val();
        $("#editMerchant_div #longitude_span").text(longitude);
        $("#editMerchant_div #latitude_span").text(latitude);
        
        $("#editMerchant_div #longitude_inp").val(longitude);
        $("#editMerchant_div #latitude_inp").val(latitude);
        $("#editMerchant_div #shopAddress").val(address);
    }
}

function initStartTimeCBB(){
	var startTime='${sessionScope.merchant.startTime}';
	var stArr=startTime.split(":");
	
	var sthData=[];
	sthData.push({"value":"","text":"时"});
	for(var i=0;i<24;i++){
		sthData.push({"value":i+"","text":i+""});
	}
	sthCBB=$("#sth_cbb").combobox({
		width:50,
		valueField:"value",
		textField:"text",
		data:sthData
	});
	var sth=stArr[0];
	sthCBB.combobox("setValue",sth);

	var stmData=[];
	stmData.push({"value":"","text":"分"});
	for(var i=0;i<60;i++){
		stmData.push({"value":(i<10?"0"+i:i)+"","text":(i<10?"0"+i:i)+""});
	}
	stmCBB=$("#stm_cbb").combobox({
		width:50,
		valueField:"value",
		textField:"text",
		data:stmData
	});
	var stm=stArr[1];
	stmCBB.combobox("setValue",stm);
}

function initEndTimeCBB(){
	var endTime='${sessionScope.merchant.endTime}';
	var etArr=endTime.split(":");
	
	var ethData=[];
	ethData.push({"value":"","text":"时"});
	for(var i=0;i<24;i++){
		ethData.push({"value":i+"","text":i+""});
	}
	ethCBB=$("#eth_cbb").combobox({
		width:50,
		valueField:"value",
		textField:"text",
		data:ethData
	});
	var eth=etArr[0];
	ethCBB.combobox("setValue",eth);

	var etmData=[];
	etmData.push({"value":"","text":"分"});
	for(var i=0;i<60;i++){
		etmData.push({"value":(i<10?"0"+i:i)+"","text":(i<10?"0"+i:i)+""});
	}
	etmCBB=$("#etm_cbb").combobox({
		width:50,
		valueField:"value",
		textField:"text",
		data:etmData
	});
	var etm=etArr[1];
	etmCBB.combobox("setValue",etm);
}

function initYYRDiv(){
	var sjxxYyrDiv=$("#sjxx_div #yyr_div");
	var sjxxMarginTop=0;
	var sjxxMarginLeft=0;
	var emYyrListDiv=$("#editMerchant_div #yyr_div #list_div");
	var emMarginTop=0;
	var emMarginLeft=0;
	var weekday='${sessionScope.merchant.weekday}';
	var weekdayArr=weekday.split(",");
	for(var i=1;i<=7;i++){
		var itemTxt="星期";
		switch (i) {
		case 1:
			itemTxt+="一";
			break;
		case 2:
			itemTxt+="二";
			
			sjxxMarginTop=-30;
			sjxxMarginLeft+=70;
			
			emMarginTop=-30;
			emMarginLeft+=70;
			break;
		case 3:
			itemTxt+="三";
			
			sjxxMarginTop=-30;
			sjxxMarginLeft+=70;
			
			emMarginTop=-30;
			emMarginLeft+=70;
			break;
		case 4:
			itemTxt+="四";
			
			sjxxMarginTop=-30;
			sjxxMarginLeft+=70;
			
			emMarginTop=-30;
			emMarginLeft+=70;
			break;
		case 5:
			itemTxt+="五";
			
			sjxxMarginTop=-30;
			sjxxMarginLeft+=70;
			
			emMarginTop=10;
			emMarginLeft=0;
			break;
		case 6:
			itemTxt+="六";
			
			sjxxMarginTop=-30;
			sjxxMarginLeft+=70;
			
			emMarginTop=-30;
			emMarginLeft+=70;
			break;
		case 7:
			itemTxt+="日";
			
			sjxxMarginTop=-30;
			sjxxMarginLeft+=70;
			
			emMarginTop=-30;
			emMarginLeft+=70;
			break;
		}
		sjxxYyrDiv.append("<div class=\"item_div "+(weekdayArr[i-1]==0?"xiuxi":"yingye")+"_div\" style=\"margin-top:"+sjxxMarginTop+"px;margin-left:"+sjxxMarginLeft+"px;\">"+itemTxt+"</div>");
		emYyrListDiv.append("<div class=\"item_div "+(weekdayArr[i-1]==0?"xiuxi":"yingye")+"_div\" style=\"margin-top:"+emMarginTop+"px;margin-left:"+emMarginLeft+"px;\" onclick=\"changeYYR(this)\">"+itemTxt+"</div>");
	}
}

function changeYYR(o){
	if($(o).attr("class").indexOf("yingye")!=-1){
		$(o).attr("class","item_div xiuxi_div");
	}
	else{
		$(o).attr("class","item_div yingye_div");
	}
}

function checkEditPwd(){
	if(checkPassword()){
		if(checkNewPwd()){
			if(checkNewPwd2()){
				var password = $("#newPwd").val();
				$.post(merPath+"updatePwdById",
					{password:MD5(password).toUpperCase()},
					function(result){
						var json=JSON.parse(result);
						if(json.status==1){
							$.messager.defaults.ok = "是";
						    $.messager.defaults.cancel = "否";
						    $.messager.defaults.width = 350;//更改消息框宽度
						    $.messager.confirm(
						    	"提示",
						    	"修改密码成功，重新登录生效！是否重新登录？"
						        ,function(r){    
						            if (r){    
						            	location.href=path+"background/exit";
						            }
						        }); 
						}
						else{
							$.messager.alert("提示","修改密码失败","warning");
						}
					}
				);
			}
		}
	}
}

function checkEditMerchant(){
	if(checkShopName()){
		if(checkShopAddress()){
			if(checkContactTel()){
				if(checkStartTime()){
					if(checkEndTime()){
						editMerchant();
					}
				}
			}
		}
	}
}

function editMerchant(){
	var weekday="";
	$("#editMerchant_div #yyr_div #list_div div[class^='item_div']").each(function(){
		if($(this).attr("class").indexOf("yingye")!=-1){
			weekday+=",1";
		}
		else{
			weekday+=",0";
		}
	});
	$("#editMerchant_div #weekday").val(weekday.substring(1));
	
	var sth=sthCBB.combobox("getValue");
	var stm=stmCBB.combobox("getValue");
	$("#editMerchant_div #startTime").val(sth+":"+stm);

	var eth=ethCBB.combobox("getValue");
	var etm=etmCBB.combobox("getValue");
	$("#editMerchant_div #endTime").val(eth+":"+etm);
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:vipPath+"editMerchant",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"background/exit";
			}
			else{
				alert(data.msg);
			}
		}
	});
}

//验证原密码
function checkPassword(){
	var flag=false;
	var userName='${sessionScope.merchant.userName}';
	var password = $("#password").val();
	if(password==null||password==""){
  		alert("原密码不能为空");
  		flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(merPath+"checkPassword",
			{password:MD5(password).toUpperCase(),userName:userName},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					alert(data.message);
					flag=false;
				}
			}
		,"json");
	}
	return flag;
}

//验证新密码
function checkNewPwd(){
	var password = $("#password").val();
	var newPwd = $("#newPwd").val();
	if(newPwd==null||newPwd==""){
	  	alert("新密码不能为空");
	  	return false;
	}
	if(newPwd==password){
		alert("新密码不能和原密码一致！");
  		return false;
	}
	else
		return true;
}

//验证确认密码
function checkNewPwd2(){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	if(newPwd2==null||newPwd2==""){
	  	alert("确认密码不能为空");
	  	return false;
	}
	else if(newPwd!=newPwd2){
		alert("两次密码不一致！");
  		return false;
	}
	else
		return true;
}

function focusShopName(){
	var shopName = $("#shopName").val();
	if(shopName=="公司名称不能为空"){
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

//验证商家地址
function checkShopAddress(){
	var shopAddress = $("#editMerchant_div #shopAddress").val();
	if(shopAddress==null||shopAddress==""||shopAddress=="商家地址不能为空"){
		$("#shopAddress").css("color","#E15748");
    	$("#shopAddress").val("商家地址不能为空");
    	return false;
	}
	else
		return true;
}

function focusContactTel(){
	var contactTel = $("#contactTel").val();
	if(contactTel=="联系电话不能为空"){
		$("#contactTel").val("");
		$("#contactTel").css("color", "#555555");
	}
}

//验证联系电话
function checkContactTel(){
	var contactTel = $("#contactTel").val();
	if(contactTel==null||contactTel==""||contactTel=="联系电话不能为空"){
		$("#contactTel").css("color","#E15748");
    	$("#contactTel").val("联系电话不能为空");
    	return false;
	}
	else
		return true;
}

function checkStartTime(){
	var sth=sthCBB.combobox("getValue");
	var stm=stmCBB.combobox("getValue");
	if(sth==null||sth==""||stm==null||stm==""){
		alert("请选择开始营业时间");
    	return false;
	}
	else
		return true;
}

function checkEndTime(){
	var eth=ethCBB.combobox("getValue");
	var etm=etmCBB.combobox("getValue");
	if(eth==null||eth==""||etm==null||etm==""){
		alert("请选择结束营业时间");
    	return false;
	}
	else
		return true;
}

function openEditPwdDialog(flag){
	$("#editPwdBg_div").css("display",flag==1?"block":"none");
}

function openEditMerchantDialog(flag){
	$("#editMerchantBg_div").css("display",flag==1?"block":"none");
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

function openBwxQrcodeBgDiv(flag){
	$("#bwxQrcodeBg_div").css("display",flag==1?"block":"none");
}

function openRbwxQrcodeBgDiv(flag){
	$("#rbwxQrcodeBg_div").css("display",flag==1?"block":"none");
}
	
function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
}
</script>
</head>
<body>
<div class="editPwdBg_div" id="editPwdBg_div">
	<div class="editPwd_div">
		<div>
			<span class="close_span" onclick="openEditPwdDialog(0)">×</span>
		</div>
		<h4 class="title">修改密码</h4>
		<div class="ymm_div">
			<input type="password" id="password" placeholder="原密码"/>
		</div>
		<div class="xmm_div">
			<input type="password" id="newPwd" placeholder="新密码"/>
		</div>
		<div class="qrmm_div">
			<input type="password" id="newPwd2" placeholder="确认密码"/>
		</div>
		<div class="confirm_div" onclick="checkEditPwd()">确定</div>
		<div class="warn_div">注意：密码修改后需要重新登录系统</div>
	</div>
</div>

<div class="bwxQrcodeBg_div" id="bwxQrcodeBg_div">
	<div class="bwxQrcode_div">
		<div>
			<span class="close_span" onclick="openBwxQrcodeBgDiv(0)">×</span>
		</div>
		<h3 class="title_h3">成为扫码商家</h3>
		<div class="title_div">扫描下方二维码，绑定微信后，商家可启用微信给分享者扫码消费</div>
		<div class="qrcode_div">
			<img class="qrcode_img" alt="" src="${sessionScope.merchant.bwxQrcode }">
		</div>
		<span class="yhzs_span" onclick="openBwxQrcodeBgDiv(0)">以后再说</span>
	</div>	
</div>

<div class="rbwxQrcodeBg_div" id="rbwxQrcodeBg_div">
	<div class="rbwxQrcode_div">
		<div>
			<span class="close_span" onclick="openRbwxQrcodeBgDiv(0)">×</span>
		</div>
		<h3 class="title_h3">解除微信绑定</h3>
		<div class="title_div">扫描下方二维码，解除微信绑定。解除后，将无法使用微信扫码</div>
		<div class="qrcode_div">
			<img class="qrcode_img" alt="" src="${sessionScope.merchant.rbwxQrcode }">
		</div>
		<span class="yhzs_span" onclick="openRbwxQrcodeBgDiv(0)">以后再说</span>
	</div>	
</div>

<div class="map_bg_div" id="map_bg_div">
	<div class="window_div">
		<div>
			<span class="close_span" onclick="showMapDiv()">×</span>
		</div>
		<div class="info_div">
			<span class="key_span">经度</span>
			<input class="longitude_inp" type="text" id="longitude"/>
			<span class="key_span">纬度</span>
			<input class="latitude_inp" type="text" id="latitude"/>
			<span class="key_span">地址</span>
			<input class="shopAdd_inp" type='text' id='shopAddress' />
			<div class="confirm_but_div" onclick="confirmLocation()">确定</div>
		</div>
		<div class="map_div" id="map_div"></div>
	</div>
</div>

<div class="editMerchantBg_div" id="editMerchantBg_div">
	<div class="editMerchant_div" id="editMerchant_div">
		<div>
			<span class="close_span" onclick="openEditMerchantDialog(0)">×</span>
		</div>
		<h4 class="title">商家信息</h4>
		<form id="form1" name="form1" method="post" enctype="multipart/form-data">
		<input type="hidden" id="id" name="id" value="${sessionScope.merchant.id }">
		<div class="gsmc_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称</span>
			<input type="text" id="shopName" name="shopName" value="${sessionScope.merchant.shopName }" onfocus="focusShopName()" onblur="checkShopName()"/>
		</div>
		<div class="gsdz_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址</span>
			<input type="text" id="shopAddress" name="shopAddress" value="${sessionScope.merchant.shopAddress }" readonly="readonly" onclick="showMapDiv()"/>
		</div>
		<div class="gswz_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;位&nbsp;&nbsp;置</span>
			<div class="value_div">
				<input type="hidden" id="longitude_inp" name="longitude"/>
				<input type="hidden" id="latitude_inp" name="latitude"/>
				经度：<span id="longitude_span">${sessionScope.merchant.longitude }</span>
				&nbsp;&nbsp;
				纬度：<span id="latitude_span">${sessionScope.merchant.latitude }</span>
			</div>
		</div>
		<div class="lxdh_div">
			<span>联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话</span>
			<input type="text" id="contactTel" name="contactTel" value="${sessionScope.merchant.contactTel }" onfocus="focusContactTel()" onblur="checkContactTel()"/>
		</div>
		<div class="logo_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;logo</span>
			<div class="img_div">
				<div class="upLoBut_div" onclick="uploadLogo()">选择商家logo</div>
				<input type="file" id="logo_inp" name="logo_inp" style="display: none;" onchange="showLogo(this)"/>
				<img class="logo_img" id="logo_img" alt="" src="${sessionScope.merchant.logo }">
			</div>
		</div>
		<div class="yyzz_div">
			<span>营&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;执&nbsp;&nbsp;照</span>
			<div class="img_div">
				<div class="upYyzzBut_div" onclick="uploadYYZZ()">选择营业执照</div>
				<input type="file" id="yyzz_inp" name="yyzz_inp" style="display: none;" onchange="showYYZZ(this)"/>
				<img class="yyzz_img" id="yyzz_img" alt="" src="${sessionScope.merchant.yyzzImgUrl }"/>
			</div>
		</div>
		<div class="yyr_div" id="yyr_div">
			<input type="hidden" id="weekday" name="weekday" value="${sessionScope.merchant.weekday }"/>
			<span>营&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
			<div class="list_div" id="list_div">
			</div>
		</div>
		<div class="yysj_div">
			<input type="hidden" id="startTime" name="startTime" value="${sessionScope.merchant.startTime }"/>
			<input type="hidden" id="endTime" name="endTime" value="${sessionScope.merchant.endTime }"/>
			<span>营&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;间</span>
			<div class="time_div">
				<input type="text" id="sth_cbb"/>
				:
				<input type="text" id="stm_cbb"/>
				-
				<input type="text" id="eth_cbb"/>
				:
				<input type="text" id="etm_cbb"/>
			</div>
		</div>
		</form>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditMerchantDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditMerchant()">提交</button>
		</div>
	</div>
</div>

<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="zhxx_div" id="zhxx_div">
		<div class="title_div">账户信息</div>
		<div class="attr_div">
			<span class="sjzh_key_span">用户账号：</span>
			<span class="sjzh_val_span">${sessionScope.merchant.userName }</span>
			<span class="mm_key_span">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
			<span class="mm_ysz_span">已设置</span>
			<span class="xgmm_span" onclick="openEditPwdDialog(1)">修改密码</span>
		</div>
		<div class="attr_div">
			<span class="bdwx_span">绑定微信：</span>
			<c:choose>
			<c:when test="${sessionScope.merchant.openId eq null||sessionScope.merchant.openId eq '' }">
				<span class="wbd_span" onclick="openBwxQrcodeBgDiv(1)">未绑定</span>
			</c:when>
			<c:otherwise>
				<span class="jcbd_span" onclick="openRbwxQrcodeBgDiv(1)">解除绑定</span>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="sjxx_div" id="sjxx_div">
		<div class="title_div">商家信息</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称：</span>
			<span class="value_span">${sessionScope.merchant.shopName }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址：</span>
			<span class="value_span">${sessionScope.merchant.shopAddress }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;位&nbsp;&nbsp;置：</span>
			<span class="value_span">经度：${sessionScope.merchant.longitude }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;纬度：${sessionScope.merchant.latitude }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话：</span>
			<span class="value_span">${sessionScope.merchant.contactTel }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;logo：</span>
			<img alt="" src="${sessionScope.merchant.logo }">
		</div>
		<div class="attr_div">
			<span class="key_span">营&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;执&nbsp;&nbsp;照：</span>
			<img alt="" src="${sessionScope.merchant.yyzzImgUrl }">
		</div>
		<div class="attr_div">
			<span class="key_span">营&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日：</span>
			<div class="yyr_div" id="yyr_div">
				<!-- 
				<div class="item_div yingye_div">星期一</div>
				<div class="item_div yingye_div" style="margin-top:-30px;margin-left:70px;">星期二</div>
				<div class="item_div yingye_div" style="margin-top:-30px;margin-left:140px;">星期三</div>
				<div class="item_div xiuxi_div" style="margin-top:-30px;margin-left:210px;">星期四</div>
				 -->
			</div>
			<div class="yyztsm_div">
				<div class="sign_div yingye_div"></div>
				<div class="text_div">营业</div>
				<div class="sign_div xiuxi_div"></div>
				<div class="text_div xiuxi_text_div">休息</div>
			</div>
		</div>
		<div class="attr_div">
			<span class="key_span">营&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;间：</span>
			<span class="value_span">${sessionScope.merchant.startTime }-${sessionScope.merchant.endTime }</span>
		</div>
		<div class="attr_div">
			<span class="em_but_span" onclick="openEditMerchantDialog(1)">修改商家信息</span>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>