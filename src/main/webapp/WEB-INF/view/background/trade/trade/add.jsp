<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>行业添加</title>
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
.upLoBut_div{
	width: 120px;
	height: 30px;
	line-height:30px;
	text-align:center;
	color:#fff;
	background-color: #1777FF;
	border-radius:5px;
}
.imgUrl_img{
	width: 180px;
	height:180px;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var tradePath='<%=basePath%>'+"background/trade/";
var dialogTop=10;
var dialogLeft=20;
var ndNum=0;
$(function(){
	initNewDialog();

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ndpw=$("body").find(".panel.window").eq(ndNum);
	var ndws=$("body").find(".window-shadow").eq(ndNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ndpw);
	ccDiv.append(ndws);
}

function initNewDialog(){
	dialogTop+=20;
	$("#new_div").dialog({
		title:"行业信息",
		width:setFitWidthInParent("body","new_div"),
		height:400,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkInfo();
           }}
        ]
	});

	$("#new_div table").css("width",(setFitWidthInParent("body","new_div_table"))+"px");
	$("#new_div table").css("magin","-100px");
	$("#new_div table td").css("padding-left","50px");
	$("#new_div table td").css("padding-right","20px");
	$("#new_div table td").css("font-size","15px");
	$("#new_div table tr").each(function(i){
		$(this).css("height",(i==1?250:45)+"px");
	});

	$(".panel.window").eq(ndNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ndNum).css("color","#000");
	$(".panel.window .panel-title").eq(ndNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ndNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ndNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ndNum).css("border-color","#ddd");

	$("#new_div #ok_but").css("left","45%");
	$("#new_div #ok_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function checkInfo(){
	if(checkName()){
		addTrade();
	}
}

function addTrade(){
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:tradePath+"addTrade",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=tradePath+"trade/list";
			}
			else{
				alert(data.msg);
			}
		}
	});
}

function focusName(){
	var name = $("#name").val();
	if(name=="名称不能为空"){
		$("#name").val("");
		$("#name").css("color", "#555555");
	}
}

//验证名称
function checkName(){
	var name = $("#name").val();
	if(name==null||name==""||name=="名称不能为空"){
		$("#name").css("color","#E15748");
    	$("#name").val("名称不能为空");
    	return false;
	}
	else
		return true;
}

function uploadImgUrl(){
	document.getElementById("imgUrl_file").click();
}

function showImgUrl(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#imgUrl_img");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "new_div":
		space=340;
		break;
	case "new_div_table":
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
		<div class="page_location_div">行业添加</div>
		
		<div id="new_div">
		<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<table>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					名称
				</td>
				<td style="width:30%;">
					<input type="text" id="name" name="name" placeholder="请输入名称" style="width: 180px;height:30px;" onfocus="focusName()" onblur="checkName()"/>
				</td>
				<td align="right" style="width:15%;">
					排序
				</td>
				<td style="width:30%;">
					<input type="number" id="sort" name="sort" placeholder="请输入排序" style="width: 180px;height:30px;"/>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:15%;">
					logo
				</td>
				<td style="width:30%;">
					<div class="upLoBut_div" onclick="uploadImgUrl()">选择行业logo</div>
					<input type="file" id="imgUrl_file" name="imgUrl_file" style="display: none;" onchange="showImgUrl(this)"/>
					<img class="imgUrl_img" id="imgUrl_img" alt="" src=""/>
				</td>
				<td align="right" style="width:15%;">
					描述
				</td>
				<td style="width:30%;">
					<textarea name="describe" rows="3" cols="15" placeholder="请输入备注"></textarea>
				</td>
			  </tr>
			</table>
		</form>
		</div>
		<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>