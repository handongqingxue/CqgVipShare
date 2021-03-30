<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var vipPath=path+"vip/";
var merPath=path+"background/merchant/";
$(function(){
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#sjxx_div").css("width",setFitWidthInParent("body")+"px");
});

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
				editMerchant();
			}
		}
	}
}

function editMerchant(){
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
<style type="text/css">
.editPwdBg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	display: none;
	z-index: 1001;
}
.editPwd_div{
	width:400px;height:420px;margin:100px auto;background: #f8f8f8;border-radius: 6px;
}
.editPwd_div .close_span{
	float: right;margin-top: 20px;margin-right: 20px;font-size: 25px;cursor: pointer;
}
.editPwd_div .title{
	font-size: 22px;color: #4CAF50;text-align: center;padding-top: 50px;
}
.editPwd_div .ymm_div{
	width:240px;margin: auto;padding-top: 20px;
}
.editPwd_div .xmm_div,.editPwd_div .qrmm_div{
	width:240px;margin: auto;
}
.editPwd_div input{
	width: 216px;
    height: 46px;
    padding: 0 15px;
    font-size: 12px;
	border: 1px solid #DDE0E2;
    border-radius: 4px;
}
.editPwd_div .confirm_div{
	width:240px;height:40px;line-height:40px;margin: 30px auto;text-align:center;font-size:17px;color:#fff;background-color:#4caf50;border-radius:3px;cursor: pointer;
}
.editPwd_div .warn_div{
	width: 100%;margin-top: 20px;border-radius: 0 0 4px 4px;font-size: 12px;text-align: center;color: #9b9b9b;
}

.editMerchantBg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	display: none;
	z-index: 1001;
}
.editMerchant_div{
	width:500px;height:600px;margin:100px auto;background: #f8f8f8;border-radius: 6px;overflow-y:scroll; 
}
.editMerchant_div .title{
	font-size: 22px;color: #4CAF50;text-align: center;padding-top: 20px;
}
.editMerchant_div .gsmc_div,.editMerchant_div .gsdz_div,.editMerchant_div .lxdh_div{
	width:310px;margin: auto;padding-top: 20px;
}
.editMerchant_div .logo_div,.yyzz_div{
	width:310px;height:230px;line-height:230px;margin: auto;padding-top: 20px;
}
.editMerchant_div .dhjpgz_span{
	margin-top: 36px;position: absolute;
}
.editMerchant_div input{
	width: 200px;height:30px;margin-left: 20px;border: 1px solid #DDE0E2;
}
.editMerchant_div textarea{
	width: 200px;height:100px;margin-left: 108px;border: 1px solid #DDE0E2;
}
.editMerchant_div .img_div{
	width:180px;
	height:230px;
	margin-top:-230px;
	margin-left: 108px;
}
.upLoBut_div,.upYyzzBut_div{
	width: 120px;
	height: 30px;
	line-height:30px;
	text-align:center;
	color:#fff;
	background-color: #1777FF;
	border-radius:5px;
}
.editMerchant_div img{
	width: 180px;
	height:180px;
	margin-top: 10px;
}
.editMerchant_div .but_div{
	width:168px;margin: auto;padding-top: 20px;padding-bottom: 20px;
}
.editMerchant_div .but{
	width: 76px;padding: 5px 10px;font-size: 14px;border: 1px solid #d9d9d9;border-radius: 4px;cursor: pointer;
}
.editMerchant_div .cancel_but{
	color: #323232;background: #FFF;
}
.editMerchant_div .submit_but{
	color: #FFF;background: #4CAF52;margin-left: 12px;
}

.zhxx_div{
	height:140px;margin-top:20px;margin-left: 238px;padding-top:40px;padding-left:40px;background-color:#FAFDFE;
}
.zhxx_div .title_div,.sjxx_div .title_div{
	font-size: 20px;color: #373737;font-weight:700;
}
.zhxx_div .attr_div,.sjxx_div .attr_div{
	margin-top:40px;
}
.zhxx_div .sjzh_key_span,.sjxx_div .attr_div .key_span{
	font-size: 15px;color: #373737;font-weight: 700;
}
.zhxx_div .sjzh_val_span,.zhxx_div .mm_ysz_span,.sjxx_div .attr_div .value_span{
	font-size: 15px;
}
.zhxx_div .mm_key_span{
	font-size: 15px;color: #373737;font-weight: 700;margin-left: 100px;
}
.zhxx_div .xgmm_span{
	font-size: 15px;color: #357bb3;margin-left: 15px;cursor: pointer;
}

.sjxx_div{
	height:700px;
	margin:20px 0 40px 238px;
	padding-top:40px;
	padding-left:40px;
	background-color:#FAFDFE;
}
.sjxx_div .attr_div img{
	width: 150px;height:150px;
}
.sjxx_div .attr_div .em_but_span{
	font-size: 15px;
	color: #357bb3;
	cursor: pointer;
}
</style>
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
	<div class="editMerchant_div">
		<h4 class="title">商家信息</h4>
		<form id="form1" name="form1" method="post" enctype="multipart/form-data">
		<input type="hidden" id="openId" name="openId" value="${requestScope.merchant.openId }">
		<div class="gsmc_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称</span>
			<input type="text" id="shopName" name="shopName" value="${requestScope.merchant.shopName }" onfocus="focusShopName()" onblur="checkShopName()"/>
		</div>
		<div class="gsdz_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址</span>
			<input type="text" id="shopAddress" name="shopAddress" value="${requestScope.merchant.shopAddress }" onfocus="focusShopAddress()" onblur="checkShopAddress()"/>
		</div>
		<div class="lxdh_div">
			<span>联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话</span>
			<input type="text" id="contactTel" name="contactTel" value="${requestScope.merchant.contactTel }" onfocus="focusContactTel()" onblur="checkContactTel()"/>
		</div>
		<div class="logo_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;logo</span>
			<div class="img_div">
				<div class="upLoBut_div" onclick="uploadLogo()">选择商家logo</div>
				<input type="file" id="logo_inp" name="logo_inp" style="display: none;" onchange="showLogo(this)"/>
				<img alt="" src="${requestScope.merchant.logo }">
			</div>
		</div>
		<div class="yyzz_div">
			<span>营&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;执&nbsp;&nbsp;照</span>
			<div class="img_div">
				<div class="upYyzzBut_div" onclick="uploadYYZZ()">选择营业执照</div>
				<input type="file" id="yyzz_inp" name="yyzz_inp" style="display: none;" onchange="showYYZZ(this)"/>
				<img class="yyzz_img" id="yyzz_img" alt="" src="${requestScope.merchant.yyzzImgUrl }"/>
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
			<span class="sjzh_val_span">${requestScope.merchant.userName }</span>
			<span class="mm_key_span">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
			<span class="mm_ysz_span">已设置</span>
			<span class="xgmm_span" onclick="openEditPwdDialog(1)">修改密码</span>
		</div>
	</div>
	<div class="sjxx_div" id="sjxx_div">
		<div class="title_div">商家信息</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称：</span>
			<span class="value_span">${requestScope.merchant.shopName }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址：</span>
			<span class="value_span">${requestScope.merchant.shopAddress }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话：</span>
			<span class="value_span">${requestScope.merchant.contactTel }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;logo：</span>
			<img alt="" src="${requestScope.merchant.logo }">
		</div>
		<div class="attr_div">
			<span class="key_span">营&nbsp;&nbsp;业&nbsp;&nbsp;&nbsp;执&nbsp;&nbsp;照：</span>
			<img alt="" src="${requestScope.merchant.yyzzImgUrl }">
		</div>
		<div class="attr_div">
			<span class="em_but_span" onclick="openEditMerchantDialog(1)">修改商家信息</span>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>