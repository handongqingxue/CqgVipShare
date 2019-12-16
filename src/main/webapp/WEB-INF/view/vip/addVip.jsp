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
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var tradeId='${param.tradeId}';
var tradeName='${param.tradeName}';
var vipJOStr='${param.vipJOStr}';
$(function(){
	if(vipJOStr!=""){
		reloadVipInfo();
	}
});

function reloadVipInfo(){
	var vipJO=JSON.parse(vipJOStr);
	$("#shopId").val(vipJO.shopId);
	$("#shopName").text(vipJO.shopName);
	$("#shopAddress").text(vipJO.shopAddress);
	$("#no").val(vipJO.no);
	$("#consumeCount").val(vipJO.consumeCount);
	$("#describe").val(vipJO.describe);
	$("#shareMoney").val(vipJO.shareMoney);
	$("#phone").val(vipJO.phone);
}

function addShareVip(){
	var shopId=$("#shopId").val();
	var no=$("#no").val();
	var consumeCount=$("#consumeCount").val();
	var describe=$("#describe").val();
	var shareMoney=$("#shareMoney").val();
	var phone=$("#phone").val();
	
	$.post("addShareVip",
		{shopId:shopId,openId:openId,no:no,consumeCount:consumeCount,describe:describe,shareMoney:shareMoney,phone:phone},
		function(data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/toVipList?tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
			}
			else{
				alert(data.msg);
			}
		}
	,"json");
}

function goShopList(){
	var no=$("#no").val();
	var consumeCount=$("#consumeCount").val();
	var describe=$("#describe").val();
	var shareMoney=$("#shareMoney").val();
	var phone=$("#phone").val();
	var vipJOStr="{\"no\":\""+no+"\",\"consumeCount\":\""+consumeCount+"\",\"describe\":\""+describe+"\",\"shareMoney\":\""+shareMoney+"\",\"phone\":\""+phone+"\"}";
	location.href=path+"vip/toShopList?vipJOStr="+encodeURI(vipJOStr)+"&tradeId="+tradeId+"&tradeName="+encodeURI(tradeName)+"&openId="+openId;
}
</script>
<title>发布</title>
</head>
<body style="margin: 0px;">
<table>
	<tr>
		<td>实体店名</td>
		<td>
			<input type="hidden" id="shopId"/>
			<div>
				<span id="shopName"></span>
			</div>
			<div>
				<span id="shopAddress"></span>
			</div>
			<input type="button" value="选择门店" onclick="goShopList()"/>
		</td>
	</tr>
	<tr>
		<td>卡号</td>
		<td>
			<input type="text" id="no"/>
		</td>
	</tr>
	<tr>
		<td>剩余消费次数</td>
		<td>
			<input type="text" id="consumeCount"/>
		</td>
	</tr>
	<tr>
		<td>会员服务描述</td>
		<td>
			<input type="text" id="describe"/>
		</td>
	</tr>
	<tr>
		<td>单次金额</td>
		<td>
			<input type="text" id="shareMoney"/>
		</td>
	</tr>
	<tr>
		<td>卡主手机号</td>
		<td>
			<input type="text" id="phone"/>
		</td>
	</tr>
</table>
<input type="button" value="提交" onclick="addShareVip()"/>
</body>
</html>