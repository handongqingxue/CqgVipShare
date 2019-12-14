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
$.post("selectShareListByOpenId",
	{openId:openId},
	function(result){
		if(result.message=="ok"){
			var shareList=result.data;
			var shareListDiv=$("#shareList_div");
			for(var i=0;i<shareList.length;i++){
				shareListDiv.append("<div>"
							+"<div>卡号："+shareList[i].vipNo+"</div>"
							+"<div>卡主手机号："+shareList[i].kzPhone+"</div>"
							+"<div>预估消费日期："+shareList[i].ygxfDate+"</div>"
							+"<div><img src=\""+shareList[i].qrcodeUrl+"\" style=\"width: 100px;height: 100px;\"/></div>"
						+"</div>");
			}
		}
		else{
			
		}
	}
,"json");
</script>
<title>分享单</title>
<style>
.space_div{
	width: 100%;
	height:60px;
}
</style>
</head>
<body style="margin: 0px;">
	<div id="shareList_div">
	</div>
	<div class="space_div"></div>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>