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
$(function(){
	$.post("selectLeaseList",
		function(result){
			if(result.status=="ok"){
				var leaseListDiv=$("#leaseList_div");
				var leaseList=result.data;
				for(var i=0;i<leaseList.length;i++){
					leaseListDiv.append("<div class=\"item_div\" style=\"height:80px;margin-top:10px;background-color: #fff;\">"
								+"<div style=\"width:100%;height:40px;line-height:40px;\"><span style=\"margin-left:10px;\">租卡人："+leaseList[i].zkNickName+"</span></div>"
								+"<div style=\"width:100%;height:40px;line-height:40px;\"><span style=\"margin-left:10px;\">联系方式："+leaseList[i].zkPhone+"</span></div>"
							+"</div>");
				}
			}
		}
	,"json");
});
</script>
<title>租实物卡</title>
<style>
.space_div{
	width: 100%;
	height:60px;
}
</style>
</head>
<body style="margin: 0px;background-color: #F6F6F6;">
<div id="leaseList_div">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>