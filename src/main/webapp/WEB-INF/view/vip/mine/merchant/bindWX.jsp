<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>绑定辰麒账号</title>
<style type="text/css">
.sqzh_div{
	font-size: 16px;text-align: center;margin: 100px auto 0;
}
.bdzh_div{
	font-size: 16px;text-align: center;margin: 10px auto 0;
}
.ljsqbd_a{
	text-decoration: none;
}
.ljsqbd_div{
	width: 200px;height:30px;line-height:30px;margin: 50px auto 0;color:#fff;text-align:center;background-color: #00A3FF;border-radius:4px;
}
.cancelBut_div{
	width: 200px;height:30px;line-height:30px;margin:20px auto 0;text-align:center;border:#999 solid 1px;border-radius:4px;
}
</style>
</head>
<body>
<div class="sqzh_div">授权微信号</div>
<div class="bdzh_div">绑定你的商户号</div>
<a class="ljsqbd_a" href="bindMerWX?merchantId=${param.merchantId}">
	<div class="ljsqbd_div">立即授权绑定</div>
</a>
<div class="cancelBut_div" onclick="WeixinJSBridge.call('closeWindow')">取消</div>
</body>
</html>