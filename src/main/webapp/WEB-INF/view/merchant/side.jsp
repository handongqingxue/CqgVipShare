<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>边框导航栏</title>
<script type="text/javascript">

</script>
<style type="text/css">
.side {
	position: fixed;
	top: 50px;
	bottom: 0;
	height: 100%;
	justify-content: center;
	display: flex;
}

.head {
	align-items: center;
	position: relative;
	height: 50px;
	background-color: #20A0FF !important;
}

.headTitle, .headTitle>h1 {
	padding-left: 15px;
	margin: 0px auto;
}
.layui-nav .layui-nav-item a{
	color:#000;
}
.layui-nav .layui-nav-item .pointer-img{
	margin-top: 18px;
	margin-left: 18px;
	position: absolute;
}
.layui-nav .first-level{
    font-size: 15px;
	font-weight: bold;
	background-color: #E7F4FD;
}
.layui-nav,.layui-side{
	background-color: #FAFDFE;
}
.layui-side{
	border-right:#86B9D6 solid 1px;
}
.layui-layout-admin .layui-header{
	background-color:  #E7F4FD;
}

</style>
</head>
<body>
	<div class="layui-header ">
		<div class="layui-logo">
			<img alt="" src="<%=basePath%>resource/image/qrcode.png"/>
			<a>会员尊享平台系统</a>
		</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="javascript:;"> <img
					src="http://t.cn/RCzsdCq" class="layui-nav-img">
					${sessionScope.merchant.userName }
			</a></li>
			<li class="layui-nav-item"><a href="<%=basePath%>merchant/exit">退出</a>
			</li>
		</ul>
	</div>

	<div class="layui-side ">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree layui-inline" lay-filter="demo"
				style="margin-right: 10px;height: 800px;overflow-y:scroll;">
				<div style="width: 92%; margin: 0 auto; margin-top: 20px;border: #CAD9EA solid 1px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<a>
							系统管理
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>merchant/toShopCheckList">
							&nbsp;&nbsp;&nbsp;商家审核
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>merchant/toCapFlowRecList">
							&nbsp;&nbsp;&nbsp;资金流水记录
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>merchant/toTradeCCList">
							&nbsp;&nbsp;&nbsp;行业抽成
						</a>
					</li>
					<shiro:hasRole  name="admin">
	  				<!--  有权限   -->
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>merchant/goAccountList">
							&nbsp;&nbsp;&nbsp;商户查询
						</a>
					</li>
					</shiro:hasRole>
				</div>
			</ul>
		</div>
	</div>
</body>
</html>