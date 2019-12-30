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
					shareListDiv.append("<div style=\"height:190px;margin-top:10px;background-color: #fff;\">"
								+"<div style=\"height:40px;line-height:40px;font-size:20px;font-weight:bold;margin-left:20px;\">"+shareList[i].shopName+"</div>"
								+"<img class=\"shopLogo_img\" src=\""+shareList[i].shopLogo+"\" style=\"width:100px;height:100px;margin-top:10px;margin-left:10px;\"/>"
								+"<span style=\"font-size:20px;margin-top:10px;margin-left:10px;position: absolute;\">卡名："+shareList[i].vipName+"</span>"
								+"<span style=\"font-size:18px;margin-top:40px;margin-left:10px;position: absolute;\">金额："+shareList[i].shareMoney+"</span>"
								+"<span style=\"font-size:18px;margin-top:70px;margin-left:10px;position: absolute;\">预估消费日期："+shareList[i].ygxfDate+"</span>"
								+"<div style=\"width:80px;height:30px;line-height:30px;float:right;margin-top:107px;margin-right:20px;text-align:center;color:#fff;background-color:#03A6FF;font-size:12px;\" onclick=\"goSRDetail('"+shareList[i].uuid+"')\">查看详情</div>"
								//+"<div><img src=\""+shareList[i].qrcodeUrl+"\" style=\"width: 100px;height: 100px;\"/></div>"
							+"</div>");
				}
			}
			else{
				shareListDiv.append("<div>"+result.info+"</div>");
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
					leaseListDiv.append("<div style=\"height:190px;margin-top:10px;background-color: #fff;\">"
								+"<div style=\"height:40px;line-height:40px;font-size:20px;font-weight:bold;margin-left:20px;\">"+leaseList[i].shopName+"</div>"
								+"<img class=\"shopLogo_img\" src=\""+leaseList[i].shopLogo+"\" style=\"width:100px;height:100px;margin-top:10px;margin-left:10px;\"/>"
								+"<span style=\"font-size:20px;margin-top:10px;margin-left:10px;position: absolute;\">卡名："+leaseList[i].vipName+"</span>"
								+"<span style=\"font-size:18px;margin-top:40px;margin-left:10px;position: absolute;\">金额："+leaseList[i].shareMoney+"</span>"
								+"<div style=\"width:80px;height:30px;line-height:30px;float:right;margin-top:107px;margin-right:20px;text-align:center;color:#fff;background-color:#03A6FF;font-size:12px;\" onclick=\"goLRDetail('"+leaseList[i].id+"')\">查看详情</div>"
							+"</div>");
				}
			}
			else{
				leaseListDiv.append("<div>"+result.info+"</div>");
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
<body style="margin: 0px;background-color: #F6F6F6;">
	<div style="width: 100%;height:40px;line-height:40px;text-align:center;background-color: #fff;">会员共享单</div>
	<div id="shareList_div">
	</div>
	<div style="width: 100%;height:40px;line-height:40px;text-align:center;margin-top:10px;background-color: #fff;">会员租赁单</div>
	<div id="leaseList_div">
	</div>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>