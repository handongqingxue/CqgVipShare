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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/delLeaseList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	$.post("selectLeaseVipListByOpenId",
		{openId:openId},
		function(result){
			if(result.status=="ok"){
				var lvListDiv=$("#lvList_div");
				var lvList=result.data;
				for(var i=0;i<lvList.length;i++){
					var leaseVip=lvList[i];
					var appendStr="<div class=\"item\">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+leaseVip.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+leaseVip.shopName+"</span>";
						appendStr+="<span class=\"consumeCount_span\">"+leaseVip.name+"/剩余次数"+leaseVip.consumeCount+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+leaseVip.shareMoney+"元/次</span>";
						appendStr+="<span class=\"describe_span\">"+leaseVip.describe+"</span>";
						appendStr+="<input class=\"delBut_inp\" id=\"delBut_inp"+leaseVip.id+"\" type=\"checkbox\" value=\"删除\"/>";
						appendStr+="<div class=\"line_div\"></div>";
						appendStr+="</div>";
					lvListDiv.append(appendStr);
				}
			}
		}
	,"json");
});

function selectAllDelInp(){
	var checked=$("#allDel_inp").prop("checked");
	$("#lvList_div input[id^='delBut_inp']").prop("checked",checked);
}

function delAllSelected(){
	var ids="";
	$("#lvList_div input[id^='delBut_inp']").each(function(){
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
	$.post("deleteLeaseVipByIds",
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

function goBack(){
	location.href=path+"vip/goPage?page=mineInfo&openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<span class="delZLK_span">删除租赁卡</span>
	<input class="allDel_inp" id="allDel_inp" type="checkbox" value="删除" onclick="selectAllDelInp()" />
	<span class="allDel_span" onclick="delAllSelected()">删除</span>
</div>
<div class="lvList_div" id="lvList_div">
</div>
</body>
</html>