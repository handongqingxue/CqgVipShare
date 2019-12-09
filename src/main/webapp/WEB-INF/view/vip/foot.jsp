<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
function goNav(flag){
	var url;
	switch (flag) {
	case 1:
		url="toIndex";
		break;
	case 2:
		
		break;
	case 3:
		
		break;
	case 4:
		url="toMine";
		break;
	}
	location.href=path+"vip/"+url;
}
</script>
<link rel="stylesheet" href="<%=basePath %>/resource/css/vip/foot.css" />
<div class="bottom_div">
	<div class="item index_div" onclick="goNav(1)">
		<img class="img_div" src="<%=basePath %>resource/image/002.png"/>
		<div class="text_div">首页</div>
	</div>
	<div class="item swk_div" onclick="goNav(2)">
		<img class="img_div" src="<%=basePath %>resource/image/005.png"/>
		<div class="text_div">租实物卡</div>
	</div>
	<div class="item fxk_div" onclick="goNav(3)">
		<img class="img_div" src="<%=basePath %>resource/image/007.png"/>
		<div class="text_div">分享单</div>
	</div>
	<div class="item wd_div" onclick="goNav(4)">
		<img class="img_div" src="<%=basePath %>resource/image/009.png"/>
		<div class="text_div">我的</div>
	</div>
</div>