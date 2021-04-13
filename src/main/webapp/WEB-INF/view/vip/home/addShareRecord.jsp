<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>分享会员</title>
<%@include file="../../background/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/home/addShareRecord.css"/>
<!--引用微信JS库-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var id='${requestScope.pageValue.id}';
var kzOpenId='${requestScope.pageValue.kzOpenId}';
var fxzOpenId='${requestScope.pageValue.fxzOpenId}';
var from='${requestScope.pageValue.from}';
var scType='${requestScope.pageValue.scType}';
var scId='${requestScope.pageValue.scId}';
var shopId='${requestScope.pageValue.shopId}';
var shareMoney='${requestScope.pageValue.shareMoney}';
var discount='${requestScope.pageValue.discount}';
var minDeposit='${requestScope.pageValue.minDeposit }';
var action="share";
$(function(){
	initYgxfDB();
	initDepositType();
});

function initYgxfDB(){
	ygxfDB=$("#ygxfDate").datebox({
		height:30,
		editable:false
	});
	$(".combo.datebox").eq(0).css("margin-top","12px");
}

function initDepositType(){
	var depSel=$("#deposit");
	depSel.empty();
	depSel.append("<option value=\"\">请选择押金</option>");
	for(var i=1;i<=10;i++){
		if(i*100<minDeposit)
			continue;
		depSel.append("<option value=\""+i*100+"\">"+i*100+"元</option>");
	}
}

function pay(){
	var phone=$("#phone").val();
	var ygxfDate=ygxfDB.datebox("getValue");
	var deposit=$("#deposit").val();
	/*
	var deposit,shareMoney1;
	if(scType=="5")
		shareMoney1=shareMoney;
	else{
		deposit=shareMoney;
	}
	*/
	$.post("wxPay",
		{kzOpenId:kzOpenId,fxzOpenId:fxzOpenId,phone:phone,ygxfDate:ygxfDate,scId:scId,shareMoney:shareMoney,deposit:deposit,discount:discount,scType:scType,shopId:shopId,action:action},
		function(payMap){
			//alert(JSON.stringify(payMap));
			WeixinJSBridge.invoke('getBrandWCPayRequest',{  
			    "appId" : payMap.appId,
			  	"timeStamp":payMap.timeStamp,  
			     "nonceStr" : payMap.nonceStr,
			     "package" : payMap["package"],  
			     "signType" : "MD5",
			     "paySign" : payMap.paySign
			},function(res){  
				//alert(JSON.stringify(res));
			     if(res.err_msg == "get_brand_wcpay_request:ok"){ 
			     	//pophint("付款成功！",null,null,"javascript:window.history.back();return false;");
			     	location.href="goPaySuccess?srUuid="+payMap.uuid+"&action="+action;
			     }else{  
			     	//pophint("付款失败");
			     	//此处，若用户取消付款（也就是退出公众号或者关闭那个输入密码的窗口），你可以执行一些自己的操作
			     }  
		    }); 
		}
	,"json");
}

function checkInfo(){
	if(checkPhone()){
		if(checkDeposit()){
			if(checkYgxfDate()){
				pay();
			}
		}
	}
}

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="手机号不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证手机号
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="手机号不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("手机号不能为空");
    	return false;
	}
	else
		return true;
}

//验证押金
function checkDeposit(){
	if(scType==5)//次卡不需要验证押金
		return true;
	var deposit = $("#deposit").val();
	if(deposit==null||deposit==""){
		alert("请选择押金");
  		return false;
	}
	else
		return true;
}

//验证预估消费日期
function checkYgxfDate(){
	var ygxfDate=ygxfDB.datebox("getValue");
	if(ygxfDate==null||ygxfDate==""){
    	alert("请选择预估消费日期");
    	return false;
	}
	else
		return true;
}

function updatePageValue(postParams,urlParams){
	$.post("updatePageValue",
		postParams,
		function(data){
			if(data.status=="ok")
				location.href=path+"vip/goPage?openId="+fxzOpenId+urlParams;
		}
	,"json");
}

function goBack(){
	var postParams,urlParams;
	postParams={id:id,from:from,openId:fxzOpenId};
	urlParams="&page=shareTreaty";
	updatePageValue(postParams,urlParams);
	//location.href=path+"vip/goPage?page=homeShare&id="+id+"&openId="+fxzOpenId+"&from="+from;
}
</script>
</head>
<body>
<div class="top_div">
	<span>分享会员</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="addSR_div">
	<div class="phone_div">
		<div class="tit_div">手机号</div>
		<div class="phone_inp_div">
			<input type="text" class="phone_inp" id="phone" placeholder="请输入手机号" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
	</div>
	<c:if test="${requestScope.pageValue.scType ne 5}">
	<div class="minDeposit_div">
		<div class="tit_div">最低押金</div>
		<div class="md_val_div">
			${requestScope.pageValue.minDeposit }
		</div>
	</div>
	<div class="deposit_div">
		<div class="tit_div">押金</div>
		<div class="deposit_sel_div">
			<select class="deposit_sel" id="deposit">
			</select>
		</div>
	</div>
	</c:if>
	<div class="ygxfDate_div">
		<div class="tit_div">预估消费日期</div>
		<div class="ygxfd_inp_div">
			<input type="text" class="ygxfDate_inp" id="ygxfDate"/>
		</div>
	</div>
</div>
<div class="pay_div" onclick="checkInfo()">
	<c:choose>
		<c:when test="${param.scType eq '5'}">支付</c:when>
		<c:otherwise>提交</c:otherwise>
	</c:choose>
</div>
<div>
	<img id="qrcodeUrl" alt="" />
</div>
</body>
</html>