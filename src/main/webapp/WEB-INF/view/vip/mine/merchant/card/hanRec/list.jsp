<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>办卡记录</title>
<%@include file="../../../../../background/js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/card/hanRec/list.css"/>
<script type="text/javascript">
var path='<%=basePath%>';
var vipPath=path+"vip/";
var openId='${param.openId}';
var shopId='${sessionScope.merchant.id}';
$(function(){
	initTypeCBB();
	initReceiveCBB();
	initCTSDTB();
	initCTEDTB();
	setTimeout("initHanRecList()",1000);//这里要延时加载，等上面的下拉框数据加载完才能根据条件加载
});

function initTypeCBB(){
	$.post(vipPath+"selectMerCardType",
		{shopId:shopId},
		function(result){
			var data=[];
			data.push({value:"",text:"请选择"});
			if(result.message=="ok"){
				var mctList=result.data;
				for(var i=0;i<mctList.length;i++){
					var mct=mctList[i];
					data.push({value:mct.type,text:mct.name});
				}
			}
			typeCBB=$("#type_cbb").combobox({
				width:180,
				valueField:"value",
				textField:"text",
				//multiple:true,
				data:data
			});
		}
	,"json");
}

function initReceiveCBB(){
	receiveCBB=$("#receive_cbb").combobox({
		width:180,
		valueField:"value",
		textField:"text",
		//multiple:true,
		data:[{value:"",text:"请选择"},{value:"0",text:"未领取"},{value:"1",text:"已领取"}]
	});
}

function initCTSDTB(){
	ctsDTB=$("#cts_dtb").datetimebox({
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
	ctsDTB.datetimebox("setValue",year+"-"+month+"-"+date1+" "+hour+":"+minute+":"+second);
}

function initCTEDTB(){
	cteDTB=$("#cte_dtb").datetimebox({
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
	cteDTB.datetimebox("setValue",year+"-"+month+"-"+date1+" "+hour+":"+minute+":"+second);
}

function initHanRecList(){
	var mcName=$("#mcName").val();
	var mcType=typeCBB.combobox("getValue");
	var receive=receiveCBB.combobox("getValue");
	var startTime=ctsDTB.datetimebox("getValue");
	var endTime=cteDTB.datetimebox("getValue");
	$.post(vipPath+"selectHanRecList",
		{mcName:mcName,mcType:mcType,receive:receive,startTime:startTime,endTime:endTime,shopId:shopId},
		function(result){
			var frList=$("#hanRecList");
			frList.empty();
			if(result.message=="ok"){
				var list=result.data;
				for(var i=0;i<list.length;i++){
					var item=list[i];
					var appendStr="<div class=\"item_div\">";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">办卡人姓名：</div>";
								appendStr+="<div class=\"val_div\">"+item.realName+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">手机号：</div>";
								appendStr+="<div class=\"val_div\">"+item.phone+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">qq：</div>";
								appendStr+="<div class=\"val_div\">"+item.qq+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">微信：</div>";
								appendStr+="<div class=\"val_div\">"+item.wxNo+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">卡名：</div>";
								appendStr+="<div class=\"val_div\">"+item.mcName+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">类型：</div>";
								var mcType=item.mcType;
								var mtStr;
								switch (mcType) {
								case 1:
									mtStr="年卡";
									break;
								case 2:
									mtStr="季卡";
									break;
								case 3:
									mtStr="月卡";
									break;
								case 4:
									mtStr="充值卡";
									break;
								case 5:
									mtStr="次卡";
									break;
								}
								appendStr+="<div class=\"val_div\">"+mtStr+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">金额：</div>";
								appendStr+="<div class=\"val_div\">"+item.money+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">办卡时间：</div>";
								appendStr+="<div class=\"val_div\">"+item.createTime+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">状态：</div>";
								appendStr+="<div class=\"val_div\">"+(item.receive?"已":"未")+"领取"+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">操作：</div>";
								appendStr+="<div class=\"val_div\">";
									appendStr+="<div class=\"xq_but_div\" onclick=\"goDetail('"+item.uuid+"')\">详情</div>";
								appendStr+="</div>";
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

function goDetail(uuid){
	var postParams={uuid:uuid,openId:openId};
	var urlParams="&page=mineHanRecDetail";
	updatePageValue(postParams,urlParams);
}

function updatePageValue(postParams,urlParams){
	$.post("updatePageValue",
		postParams,
		function(data){
			if(data.status=="ok")
				location.href=path+"vip/goPage?openId="+openId+urlParams;
		}
	,"json");
}

function goBack(){
	location.href=path+"vip/goPage?page=mineMerCardMgr&openId="+openId;
}
</script>
</head>
<body>
<div class="top_div">
	<span>办卡记录</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="main_div" id="main_div">
	<div class="search_div">
		<div class="attr_div">
			<div class="key_div">卡名：</div>
			<div class="val_div">
				<input type="text" id="mcName" placeholder="请输入卡名" style="width: 180px;height: 22px;"/>
			</div>
		</div>
		<div class="attr_div">
			<div class="key_div">类型：</div>
			<div class="val_div">
				<input id="type_cbb"/>
			</div>
		</div>
		<div class="attr_div">
			<div class="key_div">状态：</div>
			<div class="val_div">
				<input id="receive_cbb"/>
			</div>
		</div>
		<div class="attr_div">
			<div class="key_div">办卡开始时间：</div>
			<div class="val_div">
				<input id="cts_dtb"/>
			</div>
		</div>
		<div class="attr_div">
			<div class="key_div">办卡结束时间：</div>
			<div class="val_div">
				<input id="cte_dtb"/>
			</div>
		</div>
		<div class="search_but_div" onclick="initHanRecList()">查询</div>
	</div>
	<div class="hanRecList" id="hanRecList">
	</div>
</div>
</body>
</html>