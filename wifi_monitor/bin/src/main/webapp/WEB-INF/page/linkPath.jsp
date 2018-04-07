<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.Path" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

List<Path> paths=(List<Path>)request.getAttribute("paths");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript">
</script>
  <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=4IU3oIAMpZhfWZsMu7xzqBBAf6vMHcoa"></script>
    <style type="text/css">
    html,body{
    	margin:0;
    	padding:0;
    }
    #box{
        width:1370px;
        height:860px;
    	float:left;
    }
    #dituContent{
    	float: left;
    }	 
</style>
    <title>linkPath</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    
  </head>
  
  <body>
  <div id="box">
  <div style="width:1370px;height:860px;border:0px solid gray;" id="dituContent"></div>
  </div>
  <div style="margin-top:30px;margin-left:10px;float:left;">
  <br><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			 <rect  width="10" height="10" style="fill:red;stroke:pink;stroke-width:0;opacity:0.5" /></svg>1个小时内
			</h4><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:orange;stroke:pink;stroke-width:0;opacity:0.5" /></svg>1-2个小时内
			</h4><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:yellow;stroke:pink;stroke-width:0;opacity:0.5" /></svg>2-4个小时内
			</h4><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:black;stroke:pink;stroke-width:0;opacity:0.5" /></svg>4小时外
			</h4>
  </div>
  </body>
  <script type="text/javascript">
    //创建和初始化地图函数：
   function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    }
    
    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(113.543811,22.372213 );//定义一个中心点坐标
        map.centerAndZoom(point,16);//设定地图的中心点和坐标并将地图显示在地图容器中
        <%for(int i=0;i<paths.size();i++){
	            Date now =new Date();
				String fillColor;
				//秒数
				long timeGap=(now.getTime()-paths.get(i).getEnd_time().getTime())/1000;
				if(timeGap<=3600)
					fillColor="red";
				else if(timeGap<=7200)
					fillColor="orange";
				else if(timeGap<=10800)
					fillColor="yellow";
				else
					fillColor="black";%>
			    var polyline = new BMap.Polyline([
		        new BMap.Point(<%=  paths.get(i).getStart_x() %>,<%= paths.get(i).getStart_y() %>),
		        new BMap.Point(<%= paths.get(i).getEnd_x() %>,<%= paths.get(i).getEnd_y() %>)
		        ], {strokeColor:"<%=fillColor%>", strokeWeight:2, strokeOpacity:0.7}); 
		        var start = new BMap.Marker(new BMap.Point(<%=  paths.get(i).getStart_x() %>,<%= paths.get(i).getStart_y() %>));
		        var end = new BMap.Marker(new BMap.Point(<%= paths.get(i).getEnd_x() %>,<%= paths.get(i).getEnd_y() %>));
		        map.addOverlay(start);
		        map.addOverlay(end);
		        map.addOverlay(polyline);
		        window.map = map;//将map变量存储在全局
		    <%}%>
        
    }
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
    var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_ZOOM});
    map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
    var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
    map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
    var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
    map.addControl(ctrl_sca);
    }
    
    initMap();//创建和初始化地图
</script>
</html>
