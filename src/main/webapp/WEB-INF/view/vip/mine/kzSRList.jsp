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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/mine/kzSRList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var scId='${param.scId}';
$(function(){
	$.post("selectKzSRListByScId",
		{scId:scId,openId:openId},
		function(result){
			console.log(result);
			var kzSRListDiv=$("#kzSRList_div");
			if(result.message=="ok"){
				var kzSRList=result.data;
				for(var i=0;i<kzSRList.length;i++){
					var kzSR=kzSRList[i];
					kzSRListDiv.append("<div>分享者："+kzSR.fxzNickName+"</div>"
							+"<div>联系方式："+kzSR.phone+"</div>");
				}
			}
			else{
				kzSRListDiv.append("<div style=\"text-align:center;\">暂无数据</div>");
			}
		}
	,"json");
});

function goBack(){
	location.href=path+"vip/goPage?page=mineMscl&openId="+openId;
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="top_div">
	<span>${param.scName }会员分享信息</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div id="kzSRList_div">
</div>
</body>
</html>