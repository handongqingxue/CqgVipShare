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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/leaseVipList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	$.post("selectLeaseVipList",
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
						if(openId!=leaseVip.openId)
							appendStr+="<div class=\"shareBut_div\" onclick=\"goLease('"+leaseVip.id+"')\">点击租赁</div>";
						appendStr+="<div class=\"line_div\"></div>";
						appendStr+="</div>";
					lvListDiv.append(appendStr);
				}
			}
		}
	,"json");
});

function goLease(id){
	location.href=path+"vip/toLease?id="+id+"&openId="+openId;
}
</script>
<title>租实物卡</title>
</head>
<body>
<div class="lvList_div" id="lvList_div">
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>