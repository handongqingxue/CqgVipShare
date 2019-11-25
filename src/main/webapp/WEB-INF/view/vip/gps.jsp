<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<title>Insert title here</title>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
<script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
<!-- 这里要配置参数key,将其值设置为高德官网开发者获取的key -->
<script src="http://webapi.amap.com/maps?v=1.3&key=9b2c5c13a6501227c97613b559324a12"></script> 
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<style type="text/css">
   #container{
      margin-left:500px;
      margin-top:50px;
      width:800px;
      height:500px;
   }
</style>
</head>
<body>
<div><h2>欢迎进入高德地图</h2></div>
<div id="container"></div>
 
<script>
    //创建地图,设定地图的中心点和级别
    var map = new AMap.Map('container', {
        resizeEnable: true,
        zoom:11,
        center: [120.2, 30.3]
 
    });
 
   /*  AMap.plugin(['AMap.ToolBar','AMap.Scale'],function(){
        //TODO  创建控件并添加
        alert("dddd");
    }) */
    //信息窗体的创建与设定
    var infowindow = new AMap.InfoWindow({
        content: '<h3>高德地图</h1><div>高德是中国领先的数字地图内容、导航和位置服务解决方案提供商。</div>',
        offset: new AMap.Pixel(0, -30),
        size:new AMap.Size(230,0)
   });
   //点标记的创建与添加
    var marker = new AMap.Marker({
        position: [120.2, 30.3],
        map:map
    });
   
    map.plugin('AMap.Geolocation', function() {
        var geolocation = new AMap.Geolocation({
            // 是否使用高精度定位，默认：true
            enableHighAccuracy: true,
            // 设置定位超时时间，默认：无穷大
            timeout: 10000,
            // 定位按钮的停靠位置的偏移量，默认：Pixel(10, 20)
            buttonOffset: new AMap.Pixel(10, 20),
            //  定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
            zoomToAccuracy: true,     
            //  定位按钮的排放位置,  RB表示右下
            buttonPosition: 'RB'
         })
        // 获取当前位置信息
        geolocation.getCurrentPosition();
        // 监听获取位置信息成功的回调函数
        AMap.event.addListener(geolocation, 'complete', onComplete);
        // 监听获取位置信息错误的回调函数
        AMap.event.addListener(geolocation, 'error', onError);
    
        function onComplete (data) {
        	console.log(data);
            // data是具体的定位信息
            addComp = data.addressComponent;
            // 获取信息中的省市区并放入到输入框中
            alert(addComp.province+"-"+addComp.city+"-"+addComp.district).trigger("change");
            alert(addComp.adcode);
            let fsenderMsg = {
                'fsenderAddress':$("#fsenderAddress").val(),
                'fsenderCountyCode':$("#fsenderCountyCode").val()
            }
            window.sessionStorage.setItem('fsendMsg', JSON.stringify(fsenderMsg));
        }
        
        function onError (error) {
            // 定位出错
            console.log(error)
        }
    })
 
</script>
</body>
</html>