<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.editCompanyBg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	/*
	display: none;
	*/
	z-index: 1001;
}
.editCompany_div{
	width:500px;height:640px;margin:100px auto;background: #f8f8f8;border-radius: 6px;
}
.editCompany_div .title{
	font-size: 22px;color: #4CAF50;text-align: center;padding-top: 20px;
}
.editCompany_div .gsmc_div,.editCompany_div .gsdz_div,.editCompany_div .lxdh_div{
	width:310px;margin: auto;padding-top: 20px;
}
.editCompany_div .logo_div{
	width:310px;height:230px;line-height:230px;margin: auto;padding-top: 20px;
}
.editCompany_div .dhjpgz_span{
	margin-top: 36px;position: absolute;
}
.editCompany_div input{
	width: 200px;height:30px;margin-left: 20px;border: 1px solid #DDE0E2;
}
.editCompany_div textarea{
	width: 200px;height:100px;margin-left: 108px;border: 1px solid #DDE0E2;
}
.editCompany_div .img_div{
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
.editCompany_div img{
	width: 180px;
	height:180px;
	margin-top: 10px;
}
.editCompany_div .but_div{
	width:168px;margin: auto;padding-top: 20px;
}
.editCompany_div .but{
	width: 76px;padding: 5px 10px;font-size: 14px;border: 1px solid #d9d9d9;border-radius: 4px;cursor: pointer;
}
.editCompany_div .cancel_but{
	color: #323232;background: #FFF;
}
.editCompany_div .submit_but{
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
<div class="editCompanyBg_div" id="editCompanyBg_div">
	<div class="editCompany_div">
		<h4 class="title">商家信息</h4>
		<div class="gsmc_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称</span>
			<input type="text" id="companyName" value="${requestScope.accountMsg.companyName }" onfocus="focusCompanyName()" onblur="checkCompanyName()"/>
		</div>
		<div class="gsdz_div">
			<span>商&nbsp;&nbsp;家&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址</span>
			<input type="text" id="companyAddress" value="${requestScope.accountMsg.companyAddress }" onfocus="focusCompanyAddress()" onblur="checkCompanyAddress()"/>
		</div>
		<div class="lxdh_div">
			<span>联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话</span>
			<input type="text" id="phone" value="${requestScope.accountMsg.phone }" onfocus="focusPhone()" onblur="checkPhone()"/>
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
				<div class="upYyzzBut_div" onclick="uploadYYZZ()">选择商家logo</div>
				<input type="file" id="yyzz_inp" name="yyzz_inp" style="display: none;" onchange="showYYZZ(this)"/>
				<img class="yyzz_img" id="yyzz_img" alt="" src="${requestScope.merchant.logo }"/>
			</div>
		</div>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditCompanyDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditCompany()">提交</button>
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