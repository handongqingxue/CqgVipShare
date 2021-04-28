<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<%@include file="../../../background/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
function unBindWX(){
	var merchantId='${param.merchantId}';
	$.post(path+"/vip/unBindMerWX",
		{id:merchantId},
		function(data){
			if(data.message=="ok"){
				openJbcgBgDiv(1);
			}
			else{
				alert(data.info);
			}
		}
	,"json");
}

function openJbcgBgDiv(flag){
	$("#jbcgBg_div").css("display",flag==1?"block":"none");
}
</script>
<style type="text/css">
body{
	padding:1px;
}
.jbcgBg_div{
	width: 100%;height:100%;background: rgba(0,0,0,0.65);position: fixed;display:none;z-index: 1001;
}
.jbcg_div{
	width:100%;height:180px;background: #f8f8f8;border-radius: 6px;padding: 1px;bottom: 0;position: fixed;
}
.jbcg_div .title_h3{
	font-size: 20px;color: #373737;font-weight:700;text-align: center;margin: 30px auto 0;
}
.jbcg_div .finishBut_div{
	width: 112px;height: 38px;line-height: 38px;margin: 30px auto 0;text-align: center;color: rgba(255,255,255,1);background-color: #00A3FF;border-radius: 3px;
}

.jcbd_div{
	font-size: 16px;text-align: center;margin: 100px auto 0;
}
.yhzh_div{
	font-size: 14px;text-align: center;margin: 30px auto 0;
}
.jcbdBut_div{
	width: 200px;height:30px;line-height:30px;margin: 50px auto 0;color:#fff;text-align:center;background-color: #f00;border-radius:4px;
}
.cannelBut_div{
	width: 200px;height:30px;line-height:30px;margin:20px auto 0;text-align:center;border:#999 solid 1px;border-radius:4px;
}
</style>
<title>解绑</title>
</head>
<body>
<div class="jbcgBg_div" id="jbcgBg_div">
	<div class="jbcg_div">
		<h3 class="title_h3">微信账号解绑成功</h3>
		<div class="finishBut_div" onclick="WeixinJSBridge.call('closeWindow')">完成</div>
	</div>
</div>

<div class="jcbd_div">解除绑定微信</div>
<div class="yhzh_div">用户账号：${requestScope.merchant.userName }</div>
<div class="jcbdBut_div" onclick="unBindWX()">解除绑定</div>
<div class="cannelBut_div" onclick="WeixinJSBridge.call('closeWindow')">取消</div>
</body>
</html>