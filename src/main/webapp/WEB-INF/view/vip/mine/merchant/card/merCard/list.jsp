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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/card/merCard/list.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var vipPath='<%=basePath%>'+"vip/";
var shopId='${sessionScope.merchant.id}';
var openId='${param.openId}';

$(function(){
	initCardTypeSel();
	initMerCardListDiv();
});

function initCardTypeSel(){
	$.post(vipPath+"selectMerCardTypeList",
		{shopId:shopId},
		function(result){
			var cardTypeSel=$("#cardType_sel");
			cardTypeSel.append("<option value=\"\">请选择</option>");
			if(result.message=="ok"){
				var mctList=result.data;
				for(var i=0;i<mctList.length;i++){
					var mct=mctList[i];
					cardTypeSel.append("<option value=\""+mct.type+"\">"+mct.name+"</option>");
				}
			}
		}
	,"json");
}

function initMerCardListDiv(){
	var name=$("#name").val();
	var type=$("#cardType_sel").val();
	$.post(vipPath+"selectMerCardList",
		{name:name,type:type,shopId:shopId},
		function(result){
			var mcListDiv=$("#mcList_div");
			mcListDiv.empty();
			if(result.message=="ok"){
				var list=result.data;
				for(var i=0;i<list.length;i++){
					var item=list[i];
					var appendStr="<div class=\"item_div\">";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">卡名：</div>";
								appendStr+="<div class=\"val_div\">"+item.name+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">类型：</div>";
								appendStr+="<div class=\"val_div\">"+item.typeName+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">金额：</div>";
								appendStr+="<div class=\"val_div\">"+item.money+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">创建时间：</div>";
								appendStr+="<div class=\"val_div\">"+item.createTime+"</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">状态：</div>";
								appendStr+="<div class=\"val_div\">已"+(item.enable?"上":"下")+"架</div>";
							appendStr+="</div>";
							appendStr+="<div class=\"attr_div\">";
								appendStr+="<div class=\"key_div\">操作：</div>";
								appendStr+="<div class=\"val_div\">";
									appendStr+="<div class=\"option_but_div\">";
									appendStr+="<input class=\"delBut_inp\" id=\"delBut_inp"+item.id+"\" type=\"checkbox\"/>";
									if(item.enable){
										appendStr+="<div class=\"xj_but_div but_show\" onclick=\"updateEnableById('"+item.id+"',false)\">下架</div>";
									}
									else{
										appendStr+="<div class=\"sj_but_div but_show\" onclick=\"updateEnableById('"+item.id+"',true)\">上架</div>";
									}
									appendStr+="<div class=\"bj_but_div\" onclick=\"goEdit('"+item.id+"')\">编辑</div>";
									appendStr+="</div>";
								appendStr+="</div>";
							appendStr+="</div>";
						appendStr+="</div>";
					mcListDiv.append(appendStr);
				}
			}
			else{
				mcListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function selectAllDelInp(){
	var checked=$("#allDel_inp").prop("checked");
	$("#mcList_div input[id^='delBut_inp']").prop("checked",checked);
}

function delAllSelected(){
	var ids="";
	$("#mcList_div input[id^='delBut_inp']").each(function(){
		var checked=$(this).prop("checked");
		if(checked){
			var id=$(this).attr("id").substring(10);
			ids+=","+id;
		}
	});
	ids=ids.substring(1);
	if(ids==""){
		alert("请选择要删除的信息！");
		return false;
	}
	deleteByIds(ids);
}

function deleteByIds(ids){
	$.post(vipPath+"deleteMerCardByIds",
		{ids:ids},
		function(result){
			if(result.status==1){
				alert(result.msg);
				initMerCardListDiv();
			}
			else{
				alert(result.msg);
			}
		}
	,"json");
}

function updateEnableById(id,enable){
	if(confirm("确认"+(enable?"上":"下")+"架")){
		$.post(vipPath+"updateMerCardEnableById",
			{id:id,enable:enable},
			function(data){
				if(data.state=="ok"){
					alert(data.message);
					initMerCardListDiv();
				}
				else{
					alert(data.message);
				}
			}
		,"json");
	}
}

function goAdd(){
	location.href=path+"vip/goPage?page=mineMerCardAdd&openId="+openId;
}

function goEdit(id){
	var postParams={id:id,openId:openId};
	var urlParams="&page=mineMerCardEdit";
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
<title>会员卡查询</title>
</head>
<body>
<div class="top_div">
	<span>会员卡查询</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<input class="allDel_inp" id="allDel_inp" type="checkbox" value="删除" onclick="selectAllDelInp()" />
	<span class="allDel_span" id="allDel_span" onclick="delAllSelected()">删除</span>
</div>
<div class="main_div">
	<div class="search_div">
		<div class="attr_div">
			<div class="key_div">卡名：</div>
			<div class="val_div">
				<input id="name" placeholder="请输入卡名" style="width: 180px;height: 20px;"/>
			</div>
		</div>
		<div class="attr_div">
			<div class="key_div">类型：</div>
			<div class="val_div">
				<select id="cardType_sel" style="width: 186px;height: 25px;">
				</select>
			</div>
		</div>
		<div class="search_but_div" onclick="initMerCardListDiv()">查询</div>
		<div class="add_but_div" onclick="goAdd()">添加</div>
	</div>
	<div class="mcList_div" id="mcList_div">
	</div>
</div>
</body>
</html>