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
<link rel="stylesheet" href="<%=basePath %>resource/css/vip/handle/merCardList.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var openId='${param.openId}';
var shopId='${param.shopId}';
$(function(){
	initList();
});

function initList(){
	$.post("selectMerchantCardList",
		{shopId:shopId},
		function(result){
			var mcListDiv=$("#mcList_div");
			mcListDiv.empty();
			if(result.message=="ok"){
				var mcList=result.data;
				for(var i=0;i<mcList.length;i++){
					var merchantCard=mcList[i];
					var appendStr="<div class=\"item\"";
						if(openId!=merchantCard.openId)
							appendStr+=" onclick=\"goMcDetail('"+merchantCard.id+"')\"";
						appendStr+=">";
						appendStr+="<img class=\"shopLogo_img\" src=\""+merchantCard.shopLogo+"\"/>";
						appendStr+="<span class=\"shopName_span\">"+merchantCard.shopName+"</span>";
						appendStr+="<span class=\"consumeCount_span\">"+merchantCard.name+"/使用次数"+merchantCard.consumeCount+"</span>";
						appendStr+="<span class=\"shareMoney_span\">价格￥"+merchantCard.money;
						if(merchantCard.type==1)
							appendStr+="元";
						else if(merchantCard.type==2)
							appendStr+="元/次";
						if(merchantCard.discount!=null)
							appendStr+="&nbsp;&nbsp;折扣:"+merchantCard.discount;
						appendStr+="</span>";
						appendStr+="<span class=\"describe_span\">"+merchantCard.describe+"</span>";
						appendStr+="<div class=\"line_div\"></div>";
						appendStr+="</div>";
					mcListDiv.append(appendStr);
				}
			}
			else{
				mcListDiv.append("<div style=\"font-size: 15px;text-align:center;\">暂无会员信息</div>");
			}
		}
	,"json");
}

function goMcDetail(id){
	location.href=path+"vip/goPage?page=handleMcd&id="+id+"&openId="+openId;
}

function goBack(){
	location.href=path+"vip/goPage?page=shopList&openId="+openId;
}
</script>
<title>店铺会员卡</title>
</head>
<body>
<div class="top_div">
	<span>会员办理</span>
</div>
<div class="back_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
</div>
<div class="mcList_div" id="mcList_div">
</div>
</body>
</html>