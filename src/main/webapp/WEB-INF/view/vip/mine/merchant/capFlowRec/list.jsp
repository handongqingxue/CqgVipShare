<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资金流水记录</title>
<%@include file="../../../../background/js.jsp"%>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/capFlowRec/list.css"/>
<script type="text/javascript">
var path='<%=basePath%>';
var vipPath=path+"vip/";
var openId='${param.openId}';
var shopId='${sessionScope.merchant.id}';
$(function(){
	initStartTimeDTB();
	initEndTimeDTB();
	initFlowRecList();
});

function initStartTimeDTB(){
	stdtb=$("#startTime_dtb").datetimebox({
		width:180,
		required:false
	});
	var date=new Date();
	var year=date.getFullYear();
	var month=date.getMonth();
	var date1=date.getDate();
	var hour=date.getHours();
	var minute=date.getMinutes();
	var second=date.getSeconds();
	stdtb.datetimebox("setValue",year+"-"+month+"-"+date1+" "+hour+":"+minute+":"+second);
}

function initEndTimeDTB(){
	etdtb=$("#endTime_dtb").datetimebox({
		width:180,
		required:false
	});
	var date=new Date();
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var date1=date.getDate();
	var hour=date.getHours();
	var minute=date.getMinutes();
	var second=date.getSeconds();
	etdtb.datetimebox("setValue",year+"-"+month+"-"+date1+" "+hour+":"+minute+":"+second);
}

function initFlowRecList(){
	var startTime=stdtb.datetimebox("getValue");
	var endTime=etdtb.datetimebox("getValue");
	$.post(vipPath+"selectFlowRecList",
		{shopId:shopId,startTime:startTime,endTime:endTime},
		function(result){
			var frList=$("#flowRecList");
			frList.empty();
			if(result.message=="ok"){
				var list=result.data;
				for(var i=0;i<list.length;i++){
					var item=list[i];
					var appendStr="<div class=\"item_div\">";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">卡号：</div>";
								appendStr+="<div class=\"val_div\">"+item.no+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">卡主昵称：</div>";
								appendStr+="<div class=\"val_div\">"+item.kzNickName+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">分享者昵称：</div>";
								appendStr+="<div class=\"val_div\">"+item.fxzNickName+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">金额：</div>";
								appendStr+="<div class=\"val_div\">"+item.shareMoney+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">分享者手机号：</div>";
								appendStr+="<div class=\"val_div\">"+item.phone+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">门店名称：</div>";
								appendStr+="<div class=\"val_div\">"+item.shopName+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">门店地址：</div>";
								appendStr+="<div class=\"val_div\">"+item.shopAddress+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">预估消费日期：</div>";
								appendStr+="<div class=\"val_div\">"+item.ygxfDate+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">创建时间：</div>";
								appendStr+="<div class=\"val_div\">"+item.createTime+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">状态：</div>";
								appendStr+="<div class=\"val_div\">"+(item.state==1?"已":"未")+"消费</div>";
							appendStr+="</div>";
						appendStr+="</div>";
					frList.append(appendStr);
				}
			}
			else{
				frList.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerchantCenter&openId="+openId;
}
</script>
</head>
<body>
<div class="top_div">
	<span>资金流水记录</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div">
	<div class="search_div">
		<div class="attr_div">
			<div class="key_div">创建开始时间：</div>
			<div class="val_div"><input id="startTime_dtb"/></div>
		</div>
		<div class="attr_div">
			<div class="key_div">创建结束时间：</div>
			<div class="val_div"><input id="endTime_dtb"/></div>
		</div>
		<div class="search_but_div" onclick="initFlowRecList()">查询</div>
	</div>
	<div class="flowRecList" id="flowRecList">
	</div>
</div>
</body>
</html>