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
function editMerchant(){
	/*
	var unionId=$("#unionId").val();
	var shopName=$("#shopName").val();
	var shopAddress=$("#shopAddress").val();
	*/
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:"editMerchant",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=path+"vip/toMine?unionId="+'${param.unionId }';
			}
			else{
				alert(data.msg);
			}
		}
	});
}
</script>
<title>完善商家信息</title>
</head>
<body>
<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
<input type="hidden" id="unionId" name="unionId" value="${param.unionId }"/>
<div>
商家名称：<input type="text" id="shopName" name="shopName" value="${requestScope.user.shopName }"/>
</div>
<div>
商家地址：<input type="text" id="shopAddress" name="shopAddress" value="${requestScope.user.shopAddress }"/>
</div>
<input type="button" value="提交" onclick="editMerchant()"/>
</form>
</body>
</html>