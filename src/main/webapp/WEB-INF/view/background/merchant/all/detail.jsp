<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家详情</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	width: 100%;
	height: 90vh;
	margin-left:205px;
	overflow-y: scroll;
	position: absolute;
}
.page_location_div{
	height: 50px;
	line-height: 50px;
	margin-left: 20px;
	font-size: 18px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var merchantPath='<%=basePath%>'+"background/merchant/";
var dialogTop=10;
var dialogLeft=20;
var ddNum=0;
$(function(){
	initDetailDialog();

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ddpw=$("body").find(".panel.window").eq(ddNum);
	var ddws=$("body").find(".window-shadow").eq(ddNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ddpw);
	ccDiv.append(ddws);
}

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"商家详情",
		width:setFitWidthInParent("body","detail_div"),
		height:500,
		top:dialogTop,
		left:dialogLeft
	});

	$("#detail_div table").css("width",(setFitWidthInParent("body","detail_div_table"))+"px");
	$("#detail_div table").css("magin","-100px");
	$("#detail_div table td").css("padding-left","50px");
	$("#detail_div table td").css("padding-right","20px");
	$("#detail_div table td").css("font-size","15px");
	$("#detail_div table tr").each(function(i){
		$(this).css("height",(i==2?250:45)+"px");
	});

	$(".panel.window").eq(ddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ddNum).css("color","#000");
	$(".panel.window .panel-title").eq(ddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ddNum).css("border-color","#ddd");

	$("#detail_div #ok_but").css("left","30%");
	$("#detail_div #ok_but").css("position","absolute");
	$("#detail_div #cancel_but").css("left","45%");
	$("#detail_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	
	initWeekday();
}

function initWeekday(){
	var weekday='${requestScope.merchant.weekday}';
	var weekdayArr=weekday.split(",");
	var weekdayTxt="";
	for(var i=1;i<=7;i++){//遍历一周内的每一天
		if(weekdayArr[i-1]==0){
			if(i>=2&i<=6){
				if(weekdayArr[i-2]==1){
					weekdayTxt+="、";
				}
			}
			else
				continue;
		}
		else{
			if(i>=2&i<=6){
				if(weekdayArr[i-2]==0&weekdayArr[i]==1){
					weekdayTxt+="周";
					switch (i) {
					case 2:
						weekdayTxt+="二至";
						break;
					case 3:
						weekdayTxt+="三至";
						break;
					case 4:
						weekdayTxt+="四至";
						break;
					case 5:
						weekdayTxt+="五至";
						break;
					case 6:
						weekdayTxt+="六至";
						break;
					}
				}
				else if(weekdayArr[i-2]==1&weekdayArr[i]==1){
					if(weekdayTxt.substring(weekdayTxt.length-1).indexOf("至")!=-1){
						continue;
					}
					else{
						weekdayTxt+="至";
					}
				}
				else if(weekdayArr[i-2]==1&weekdayArr[i]==0||weekdayArr[i-2]==0&weekdayArr[i]==0){
					weekdayTxt+="周";
					switch (i) {
					case 2:
						weekdayTxt+="二";
						break;
					case 3:
						weekdayTxt+="三";
						break;
					case 4:
						weekdayTxt+="四";
						break;
					case 5:
						weekdayTxt+="五";
						break;
					case 6:
						weekdayTxt+="六";
						break;
					}
				}
			}
			else if(i==1){
				if(weekdayArr[i]==1&weekdayArr[i+1]==0){
					weekdayTxt+="周一、";
				}
				else{
					weekdayTxt+="周一";
				}
			}
			else if(i==7){
				weekdayTxt+="周日";
			}
		}
	}
	$("#detail_div #weekday_span").text(weekdayTxt);
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "detail_div":
		space=340;
		break;
	case "detail_div_table":
	case "panel_window":
		space=355;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">	
	<%@include file="../../side.jsp"%>
	<div class="center_con_div" id="center_con_div">
		<div class="page_location_div">商家详情</div>
		
		<div id="detail_div">
			<table>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					商家名称
				</td>
				<td style="width:30%;">
					<span>${requestScope.merchant.shopName }</span>
				</td>
				<td align="right" style="width:15%;">
					商家地址
				</td>
				<td style="width:30%;">
					<span>${requestScope.merchant.shopAddress }</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					用户名
				</td>
				<td style="width:30%;">
					<span>${requestScope.merchant.userName }</span>
				</td>
				<td align="right" style="width:15%;">
					行业
				</td>
				<td style="width:30%;">
					<span>${requestScope.merchant.tradeName }</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					商家logo
				</td>
				<td style="width:30%;">
					<img style="width: 200px;height:200px;" src="${requestScope.merchant.logo }"/>
				</td>
				<td align="right" style="width:15%;">
					营业执照
				</td>
				<td style="width:30%;">
					<img style="width: 200px;height:200px;" src="${requestScope.merchant.yyzzImgUrl }"/>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					创建时间
				</td>
				<td style="width:30%;">
					<span>${requestScope.merchant.createTime }</span>
				</td>
				<td align="right" style="width:15%;">
					状态
				</td>
				<td style="width:30%;">
					<span>
						<c:if test="${requestScope.merchant.shopCheck eq 0 }">待审核</c:if>
						<c:if test="${requestScope.merchant.shopCheck eq 2 }">未通过</c:if>
					</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					营业日
				</td>
				<td style="width:30%;">
					<span id="weekday_span"></span>
				</td>
				<td align="right" style="width:15%;">
					营业时间
				</td>
				<td style="width:30%;">
					<span>
						${requestScope.merchant.startTime }-${requestScope.merchant.endTime }
					</span>
				</td>
			  </tr>
			</table>
		</div>
		<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>