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
.layui-nav .level-ul{
	height: 800px;
	margin-right: 10px;
	overflow-y:scroll;
}
.layui-nav .first-level-div{
	width: 92%; 
	margin: 20px auto 0; 
	border: #CAD9EA solid 1px;
	background-color: #F5FAFE;
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
.line_div{
	width:100%;
	height: 1px;
	background-color: #CAD9EA;
}
.cvs_img{
	width: 36px;
	height: 36px;
}
</style>
</head>
<body>
	<div class="layui-header ">
		<div class="layui-logo">
			<img class="cvs_img" alt="" src="<%=basePath%>resource/image/cqgVipShare.png"/>
			<a>会员尊享平台系统</a>
		</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="javascript:;"> 
				<img src="${sessionScope.merchant.logo }" class="layui-nav-img">
					${sessionScope.merchant.userName }
				</a>
			</li>
			<li class="layui-nav-item"><a href="<%=basePath%>background/exit">退出</a>
			</li>
		</ul>
	</div>

	<div class="layui-side ">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree layui-inline level-ul" lay-filter="demo">
				<div class="first-level-div">
					<li class="layui-nav-item first-level">
						<a>
							商家管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchant/info/info">
							&nbsp;&nbsp;&nbsp;商家信息
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchant/message/list">
							&nbsp;&nbsp;&nbsp;消息中心
						</a>
					</li>
					<shiro:hasRole  name="admin">
	  				<!--  有权限   -->
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchant/check/list">
							&nbsp;&nbsp;&nbsp;商家审核
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchant/all/list">
							&nbsp;&nbsp;&nbsp;综合查询
						</a>
					</li>
					</shiro:hasRole>
				</div>
				<div class="first-level-div">
					<li class="layui-nav-item first-level">
						<a>
							资金管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/capital/flowRec/list">
							&nbsp;&nbsp;&nbsp;资金流水记录
						</a>
					</li>
				</div>
				<shiro:hasRole  name="admin">
				<div class="first-level-div">
					<li class="layui-nav-item first-level">
						<a>
							行业管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/trade/cc/list">
							&nbsp;&nbsp;&nbsp;行业抽成
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/trade/trade/list">
							&nbsp;&nbsp;&nbsp;行业查询
						</a>
					</li>
				</div>
				</shiro:hasRole>
				<div class="first-level-div">
					<li class="layui-nav-item first-level">
						<a>
							会员管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchantCard/merCardType/list">
							&nbsp;&nbsp;&nbsp;卡类型查询
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchantCard/merCard/list">
							&nbsp;&nbsp;&nbsp;会员卡查询
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>background/merchantCard/hanRec/list">
							&nbsp;&nbsp;&nbsp;办卡记录
						</a>
					</li>
				</div>
			</ul>
		</div>
	</div>
</body>
</html>