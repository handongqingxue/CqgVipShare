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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/merchant/message.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath%>';
var openId='${param.openId}';
$(function(){
	selectList(1);	
});

function selectList(flag){
	$.post("selectMerchantMessageList",
		{flag:flag,openId:openId},
		function(result){
			var ztItemDiv=$(".zt_div .item_div");
			ztItemDiv.removeClass("select");
			ztItemDiv.removeClass("unSelect");
			ztItemDiv.each(function(i){
				if(i==flag-1){
					ztItemDiv.eq(i).addClass("select");
				}
				else{
					ztItemDiv.eq(i).addClass("unSelect");
				}
			});
			
			var listDiv=$("#list_div");
			listDiv.empty();
			if(result.message=="ok"){
				var mmList=result.data;
				for(var i=0;i<mmList.length;i++){
					var mm=mmList[i];
					listDiv.append("<div class=\"item_div\">"
								+"<span class=\"title_span\" onclick=\"goDetail('"+mm.isRead+"','"+mm.id+"')\">"+mm.title+"</span>"
								+"<input class=\"delBut_inp\" id=\"delBut_inp"+mm.id+"\" type=\"checkbox\" value=\"删除\"/>"
								+"<span class=\"createTime_span\">"+mm.createTime+"</span>"
								+"<div class=\"line_div\"></div>"
							+"</div>");
				}
			}
			else{
				listDiv.append("<div class=\"noData_div\">暂无信息</div>");
			}
		}
	,"json");
}

function goDetail(isRead,id){
	var postParams={isRead:isRead,id:id,openId:openId};
	var urlParams="&page=merMsgDetail";
	updatePageValue(postParams,urlParams);
}

function selectAllDelInp(){
	var checked=$("#allDel_inp").prop("checked");
	$("#list_div input[id^='delBut_inp']").prop("checked",checked);
}

function delAllSelected(){
	var ids="";
	$("#list_div input[id^='delBut_inp']").each(function(){
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
	$.post("deleteMerchantMessageByIds",
		{ids:ids},
		function(data){
			if(data.status==1){
				alert(data.msg);
				location.href=location.href;
			}
			else{
				alert(data.msg);
			}
		}
	,"json");
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
	location.href=path+"vip/goPage?page=mineMerchantInfo&openId="+openId;
}
</script>
<title>消息中心</title>
</head>
<body>
<div class="top_div">
	<span>消息中心</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<input class="allDel_inp" id="allDel_inp" type="checkbox" value="删除" onclick="selectAllDelInp()" />
	<span class="allDel_span" onclick="delAllSelected()">删除</span>
</div>
<div class="zt_div">
	<div class="item_div wd_div" onclick="selectList(1);">未读</div>
	<div class="item_div yd_div" onclick="selectList(2);">已读</div>
	<div class="item_div qb_div" onclick="selectList(3);">全部</div>
</div>
<div class="list_div" id="list_div">
</div>
</body>
</html>