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
});

function initStartTimeCBB(){
	var data=[];
	data.push({"value":"","text":"请选择开始时间"});
	for(var i=0;i<24;i++){
		data.push({"value":i+"","text":i+"时"});
	}
	startTimeCBB=$("#startTime_cbb").combobox({
		width:120,
		valueField:"value",
		textField:"text",
		data:data,
		onSelect:function(){
			var startTime=$(this).combobox("getValue");
			$("#startTime").val(startTime);
		}
	});
	startTimeCBB.combobox("setValue",'${sessionScope.merchant.startTime}');
}

function initEndTimeCBB(){
	var data=[];
	data.push({"value":"","text":"请选择结束时间"});
	for(var i=0;i<24;i++){
		data.push({"value":i+"","text":i+"时"});
	}
	endTimeCBB=$("#endTime_cbb").combobox({
		width:120,
		valueField:"value",
		textField:"text",
		data:data,
		onSelect:function(){
			var endTime=$(this).combobox("getValue");
			$("#endTime").val(endTime);
		}
	});
	endTimeCBB.combobox("setValue",'${sessionScope.merchant.endTime}');
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
	var startTime=startTimeCBB.combobox("getValue");
	if(startTime==null||startTime==""){
		alert("请选择开始营业时间");
    	return false;
	}
	else
		return true;
}

function checkEndTime(){
	var endTime=endTimeCBB.combobox("getValue");
	if(endTime==null||endTime==""){
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

<div class="editMerchantBg_div" id="editMerchantBg_div">
	<div class="editMerchant_div" id="editMerchant_div">
		<h4 class="title">商家信息</h4>
		<form id="form1" name="form1" method="post" enctype="multipart/form-data">
		<input type="hidden" id="openId" name="openId" value="${sessionScope.merchant.openId }">
		<div class="gsmc_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称</span>
			<input type="text" id="shopName" name="shopName" value="${sessionScope.merchant.shopName }" onfocus="focusShopName()" onblur="checkShopName()"/>
		</div>
		<div class="gsdz_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址</span>
			<input type="text" id="shopAddress" name="shopAddress" value="${sessionScope.merchant.shopAddress }" onfocus="focusShopAddress()" onblur="checkShopAddress()"/>
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
				<img alt="" src="${sessionScope.merchant.logo }">
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
				<input type="text" id="startTime_cbb"/>
				-
				<input type="text" id="endTime_cbb"/>
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
			<span class="value_span">${sessionScope.merchant.startTime }时-${sessionScope.merchant.endTime }时</span>
		</div>
		<div class="attr_div">
			<span class="em_but_span" onclick="openEditMerchantDialog(1)">修改商家信息</span>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>