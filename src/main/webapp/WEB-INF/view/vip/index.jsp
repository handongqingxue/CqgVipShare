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
<script type="text/javascript">
    var deviveWidth = document.documentElement.clientWidth;
    document.documentElement.style.fontSize = deviveWidth / 7.5 + 'px';
</script>
<title>Insert title here</title>
<style>
        .slider{
          overflow: hidden;
          flex:1;
        }
        .slider-list{
          transition:all .6s;
		  height: 170px;
		  font-size:12px;
        }
		.slider-list table{
			width:95%;
			text-align:center;
		}
		.slider-list table tr{
			height:80px;
		}
		.slider-list table td{
			width:20%;
		}
		.slider-list table img{
			width:30px;
			height:30px;
			margin-left: -15px;
			position: absolute;
		}
		.slider-list table div{
			margin-top:35px;
			text-align:center;
		}
        .slider-list .item{
          height: 170px;
          text-align: center;
          flex:none;
          width: 375px;
        } 
        .slider-list .item1{
		  /*
          background-color: red;
		  */
        }
        .slider-list .item2{
          background-color: yellow;
		  margin-top:-170px;
		  margin-left:375px;
        }
        .slider-list .item3{
          background-color: green;
		  margin-top:-170px;
		  margin-left:750px;
        }
        .slider-list .item4{
          background-color: blue;
		  margin-top:-170px;
		  margin-left:1125px;
        }
		.bottom_div{
			width:95%;
			height:60px;
			font-size:15px;
			background-color:#F6F6F6;
			bottom:0px;
			position:fixed;
		}
		.bottom_div .item{
			width:24%;
			height:60px;
			line-height:60px;
			text-align:center;
		}
		.bottom_div .img_div{
			width:30px;
			height:30px;
			margin-top: 5px;
		}
		.bottom_div .text_div{
			margin-top:-19px;
			text-align:center;
		}
		.bottom_div .index_div{
			color:#0091FE;
		}
		.bottom_div .swk_div{
			margin-top:-60px;
			margin-left:24%;
			color:#808080;
		}
		.bottom_div .fxk_div{
			margin-top:-60px;
			margin-left:48%;
			color:#808080;
		}
		.bottom_div .wd_div{
			margin-top:-60px;
			margin-left:72%;
			color:#808080;
		}
    </style>
</head>
<body>
<div style="width:100%;height:40px;background-color:#1B82D1;">
	<span style="font-size:15px;color:#fff;margin-top: 10px;margin-left: 10px;position: absolute;">青岛</span>
	<div style="width:200px;height:30px;margin-top: 5px;margin-left: 60px;background-color:#fff;position: absolute;">
		<img src="<%=basePath %>resource/image/001.png" style="width:30px;height:30px;"/>
		<input type="text" style="width:140px;height:25px;position: absolute;"/>
	</div>
</div>
<div class="slider" id="slider">
  <div class="slider-list flex" id="slider-list">
    <div class="item item1">
		<table>
			<tr>
				<td>
					<img src="<%=basePath %>resource/image/trade/xiche.png"/>
					<div>洗车</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/jianshen.png"/>
					<div>健身</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/xiyu.png"/>
					<div>洗浴</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/meirongmeifa.png"/>
					<div>美容美发</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/zuliao.png"/>
					<div>足疗</div>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%=basePath %>resource/image/trade/baojianyangsheng.png"/>
					<div>保健养生</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/ktv.png"/>
					<div>KTV</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/sheying.png"/>
					<div>摄影</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/jingqu.png"/>
					<div>景区</div>
				</td>
				<td>
					<img src="<%=basePath %>resource/image/trade/dianying.png"/>
					<div>电影</div>
				</td>
			</tr>
		</table>
	</div>
    <div class="item item2">滑块2</div>
    <div class="item item3">滑块3</div>
    <div class="item item4">滑块4</div>
  </div>
</div>
<div style="width:310px;margin:0 auto;margin-top:10px;">
	<div style="font-size:20px;width:150px;height:80px;background-color:yellow;">签到领积分</div>
	<div style="font-size:20px;width:150px;height:80px;margin-top:-80px;margin-left:160px;background-color:yellow;">商家免费体验卡</div>
</div>
<div style="font-size:18px;">
最新共享信息发布
</div>
<div>
	<div style="width:100%;height:120px;background-color:yellow;">
		<img src="https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=98681d43845494ee8722081f15ce87c3/29381f30e924b899c2b7e5c466061d950b7bf647.jpg" style="width:80px;height:80px;margin-top:10px;margin-left:10px;"/>
		<span style="font-size:18px;margin-top:10px;margin-left:10px;position: absolute;">岳家庄</span>
		<span style="font-size:15px;margin-top:40px;margin-left:10px;position: absolute;">80次年卡/剩余次数56</span>
		<span style="font-size:12px;margin-top:70px;margin-left:10px;position: absolute;">价格￥10元/次</span>
		<span style="font-size:12px;margin-top:90px;margin-left:10px;color:#DE792B;background-color:#FEF4EB;position: absolute;">aaaaaaaaaaa</span>
		<div style="width:60px;height:20px;line-height:20px;margin-top:-60px;margin-left:280px;text-align:center;color:#fff;background-color:#03A6FF;font-size:12px;">点击分享</div>
	</div>
</div>
<div class="bottom_div">
	<div class="item index_div">
		<img class="img_div" src="<%=basePath %>resource/image/002.png"/>
		<div class="text_div">首页</div>
	</div>
	<div class="item swk_div">
		<img class="img_div" src="<%=basePath %>resource/image/005.png"/>
		<div class="text_div">租实物卡</div>
	</div>
	<div class="item fxk_div">
		<img class="img_div" src="<%=basePath %>resource/image/007.png"/>
		<div class="text_div">分享单</div>
	</div>
	<div class="item wd_div">
		<img class="img_div" src="<%=basePath %>resource/image/009.png"/>
		<div class="text_div">我的</div>
	</div>
</div>
<script type="text/javascript" charset="utf-8" src="./js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="./js/fastclick.js"></script>
<script type="text/javascript" charset="utf-8" src="./js/global.js"></script>
<script type="text/javascript">
document.getElementById('slider').addEventListener('touchstart',touchstart, false);
document.getElementById('slider').addEventListener('touchmove',touchmove, false);
document.getElementById('slider').addEventListener('touchend',touchend, false);
 
var width = document.documentElement.clientWidth;
var startX =0;
var index = 0;
var translateX = 0;
var startTime;
var startTranslate;
var isSlide = false;
var sliderNumber = 4;//滑块是数量，控制溢出不能滑动
 
function touchstart(e){
  startX = e.touches[0].clientX;
  startTime = new Date().getTime();
  startTranslate = translateX;
  isSlide = true;
}
 
function touchmove(e){
  if (!isSlide) return
  var currentX = e.touches[0].clientX
  //2端溢出不能滑动
  if (startTranslate == 0 && currentX > startX) return;
  if (Math.abs(startTranslate) == width * (sliderNumber - 1) && currentX < startX) return;
 
  // 向右滑动时， 没数据无法滑动
  if (currentX < startX) {
 
  }
 
  distance = currentX - startX;
  translateX = currentX - startX + startTranslate;
 
  document.getElementById("slider-list").style.transform = "translateX("+translateX+"px)"
}
function touchend(){
   if (!isSlide) return
 
  var duration = +new Date() - startTime
  var newTranslateX
  if (translateX > startTranslate) {
    // 向左划
    if (distance > width / 3 || (distance > 40 && duration < 600)) {
      newTranslateX = startTranslate + width;
    } else {
      newTranslateX = startTranslate
    }
  } else {
    // 向右划
    if (Math.abs(distance) > width / 3 || (Math.abs(distance) > 40 && duration < 600)) {
      newTranslateX = startTranslate - width;
    } else {
      newTranslateX = startTranslate
    }
  }
 
  translateX = newTranslateX;
  isSlide = false;
  distance = 0;
  index = Math.abs(newTranslateX / width)
  console.log(index);
 
  document.getElementById("slider-list").style.transform = "translateX("+translateX+"px)"
}
</script>
</body>
</html>