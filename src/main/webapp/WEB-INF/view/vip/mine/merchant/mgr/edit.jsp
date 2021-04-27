<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/mgr/edit.css"/>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
	src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	initYYRDiv();
	initStartTimeSel();
	initEndTimeSel();
});

function initYYRDiv(){
	var yyrListDiv=$("#yyr_div #list_div");
	var marginTop=0;
	var marginLeft=0;
	var weekday='${requestScope.merchant.weekday}';
	var weekdayArr=weekday.split(",");
	for(var i=1;i<=7;i++){
		var itemTxt="星期";
		switch (i) {
		case 1:
			itemTxt+="一";
			
			marginTop=10;
			break;
		case 2:
			itemTxt+="二";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 3:
			itemTxt+="三";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 4:
			itemTxt+="四";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 5:
			itemTxt+="五";
			
			marginTop=10;
			marginLeft=0;
			break;
		case 6:
			itemTxt+="六";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		case 7:
			itemTxt+="日";
			
			marginTop=-25;
			marginLeft+=63;
			break;
		}
		yyrListDiv.append("<div class=\"item_div "+(weekdayArr[i-1]==0?"xiuxi":"yingye")+"_div\" style=\"margin-top:"+marginTop+"px;margin-left:"+marginLeft+"px;\" onclick=\"changeYYR(this)\">"+itemTxt+"</div>");
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

function initStartTimeSel(){
	var startTimeSel=$("#startTime_sel");
	startTimeSel.append("<option value=\"\">请选择开始时间</option>");
	for(var i=0;i<24;i++){
		startTimeSel.append("<option value=\""+i+"\" "+('${requestScope.merchant.startTime}'==i?"selected":"")+">"+i+"时</option>");
	}
}

function initEndTimeSel(){
	var endTimeSel=$("#endTime_sel");
	endTimeSel.append("<option value=\"\">请选择结束时间</option>");
	for(var i=0;i<24;i++){
		endTimeSel.append("<option value=\""+i+"\" "+('${requestScope.merchant.endTime}'==i?"selected":"")+">"+i+"时</option>");
	}
}

function checkInfo(){
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
	$("#main_div #yyr_div #list_div div[class^='item_div']").each(function(){
		if($(this).attr("class").indexOf("yingye")!=-1){
			weekday+=",1";
		}
		else{
			weekday+=",0";
		}
	});
	$("#main_div #weekday").val(weekday.substring(1));
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
				location.href=path+"vip/goPage?page=mineCenter&openId="+'${param.openId }';
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
	var startTime=$("#startTime_sel").val();
	if(startTime==null||startTime==""){
		alert("请选择营业开始时间");
    	return false;
	}
	else
		return true;
}

function checkEndTime(){
	var endTime=$("#endTime_sel").val();
	if(endTime==null||endTime==""){
		alert("请选择营业结束时间");
    	return false;
	}
	else
		return true;
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerInfo&openId="+openId;
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
<input type="hidden" id="id" name="id" value="${requestScope.merchant.id }"/>
<div class="main_div" id="main_div">
	<div class="attr_div">
		<div class="key_div">商家名称：</div>
		<input type="text" class="val_inp" id="shopName" name="shopName" placeholder="请输入商家名称" value="${requestScope.merchant.shopName }" onfocus="focusShopName()" onblur="checkShopName()"/>
	</div>
	<div class="attr_div">
		<div class="key_div">商家地址：</div>
		<input type="text" class="val_inp" id="shopAddress" name="shopAddress" placeholder="请输入商家地址" value="${requestScope.merchant.shopAddress }" onfocus="focusShopAddress()" onblur="checkShopAddress()"/>
	</div>
	<div class="attr_div">
		<div class="key_div">联系电话：</div>
		<input type="text" class="val_inp" id="contactTel" name="contactTel" placeholder="请输入联系电话" value="${requestScope.merchant.contactTel }" onfocus="focusContactTel()" onblur="checkContactTel()"/>
	</div>
	<div class="attr_div">
		<div class="key_div">行业：</div>
		<div class="val_div">${requestScope.merchant.tradeName }</div>
	</div>
	<div class="logo_div">
		<div class="key_div">商家logo：</div>
		<div class="logo_img_div">
			<div class="upLoBut_div" onclick="uploadLogo()">选择商家logo</div>
			<input type="file" id="logo_inp" name="logo_inp" style="display: none;" onchange="showLogo(this)"/>
			<img class="logo_img" id="logo_img" alt="" src="${requestScope.merchant.logo }"/>
		</div>
	</div>
	<div class="yyzz_div">
		<div class="key_div">营业执照：</div>
		<div class="yyzz_img_div">
			<div class="upYyzzBut_div" onclick="uploadYYZZ()">选择营业执照</div>
			<input type="file" id="yyzz_inp" name="yyzz_inp" style="display: none;" onchange="showYYZZ(this)"/>
			<img class="yyzz_img" id="yyzz_img" alt="" src="${requestScope.merchant.yyzzImgUrl }"/>
		</div>
	</div>
	<div class="yyr_div" id="yyr_div">
		<input type="hidden" id="weekday" name="weekday" value="${requestScope.merchant.weekday }"/>
		<div class="key_div">营业日：</div>
		<div class="list_div" id="list_div"></div>
	</div>
	<div class="attr_div">
		<div class="key_div">营业状态：</div>
		<div class="yyztsm_div">
			<div class="sign_div yingye_div"></div>
			<div class="text_div">营业</div>
			<div class="sign_div xiuxi_div"></div>
			<div class="text_div xiuxi_text_div">休息</div>
		</div>
	</div>
	<div class="attr_div">
		<div class="time_key_div">营业开始时间：</div>
		<div class="time_val_div">
			<select class="time_sel" id="startTime_sel" name="startTime"></select>
		</div>
	</div>
	<div class="attr_div">
		<div class="time_key_div">营业结束时间：</div>
		<div class="time_val_div">
			<select class="time_sel" id="endTime_sel" name="endTime"></select>
		</div>
	</div>
	<div class="submitBut_div" onclick="checkInfo()">
		立即提交
	</div>
</div>
</form>
</body>
</html>