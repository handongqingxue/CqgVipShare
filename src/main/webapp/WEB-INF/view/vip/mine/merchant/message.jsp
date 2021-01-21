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
					listDiv.append("<div class=\"item_div\" onclick=\"goDetail('"+mm.isRead+"','"+mm.id+"')\">"
							+"<div>"+mm.title+"<div>"
							+"<div>"+mm.createTime+"<div>"
							+"</div>");
				}
			}
			else{
				listDiv.append("暂无信息");
			}
		}
	,"json");
}

function goDetail(isRead,id){
	location.href=path+"vip/goPage?page=merMsgDetail&isRead="+isRead+"&id="+id+"&openId="+openId;
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
</div>
<div class="zt_div">
	<div class="item_div wd_div" onclick="selectList(1);">未读</div>
	<div class="item_div yd_div" onclick="selectList(2);">已读</div>
	<div class="item_div qb_div" onclick="selectList(3);">全部</div>
</div>
<div id="list_div">
</div>
</body>
</html>