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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/shareList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
$(function(){
	selectShareListByOpenId();
	selectLeaseListByOpenId();
});

function selectShareListByOpenId(){
	$.post("selectShareListByOpenId",
		{openId:openId},
		function(result){
			var shareListDiv=$("#shareList_div");
			if(result.message=="ok"){
				var shareList=result.data;
				for(var i=0;i<shareList.length;i++){
					shareListDiv.append("<div class=\"item_div\">"
								+"<div class=\"shopName_div\">"+shareList[i].shopName+"</div>"
								+"<img class=\"shopLogo_img\" src=\""+shareList[i].shopLogo+"\"/>"
								+"<span class=\"vipName_span\">卡名："+shareList[i].vipName+"</span>"
								+"<span class=\"shareMoney_span\">金额："+shareList[i].shareMoney+"</span>"
								+"<span class=\"ygxfDate_span\">预估消费日期："+shareList[i].ygxfDate+"</span>"
								+"<div class=\"goBut_div\" onclick=\"goSRDetail('"+shareList[i].uuid+"')\">查看详情</div>"
								//+"<div><img src=\""+shareList[i].qrcodeUrl+"\" style=\"width: 100px;height: 100px;\"/></div>"
							+"</div>");
				}
			}
			else{
				shareListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function selectLeaseListByOpenId(){
	$.post("selectLeaseListByOpenId",
		{openId:openId},
		function(result){
			var leaseListDiv=$("#leaseList_div");
			if(result.message=="ok"){
				var leaseList=result.data;
				for(var i=0;i<leaseList.length;i++){
					leaseListDiv.append("<div class=\"item_div\">"
								+"<div class=\"shopName_div\">"+leaseList[i].shopName+"</div>"
								+"<img class=\"shopLogo_img\" src=\""+leaseList[i].shopLogo+"\"/>"
								+"<span class=\"vipName_span\">卡名："+leaseList[i].vipName+"</span>"
								+"<span class=\"shareMoney_span\">金额："+leaseList[i].shareMoney+"</span>"
								+"<div class=\"goBut_div\" onclick=\"goLRDetail('"+leaseList[i].id+"')\">查看详情</div>"
							+"</div>");
				}
			}
			else{
				leaseListDiv.append("<div class=\"noData_div\">"+result.info+"</div>");
			}
		}
	,"json");
}

function goSRDetail(uuid){
	location.href=path+"vip/toSRDetail?uuid="+uuid+"&openId="+openId;
}

function goLRDetail(id){
	location.href=path+"vip/toLRDetail?id="+id+"&openId="+openId;
}
</script>
<title>分享单</title>
</head>
<body>
	<div class="gxdTit_div">会员共享单</div>
	<div class="shareList_div" id="shareList_div">
	</div>
	<div class="zldTit_div">会员租赁单</div>
	<div class="leaseList_div" id="leaseList_div">
	</div>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>