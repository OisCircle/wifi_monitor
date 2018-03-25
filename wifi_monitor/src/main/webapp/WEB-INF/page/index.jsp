<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Seeker> seekers =(List<Seeker>)request.getAttribute("seekers");
//每个seeker对应的信息，下标与 seekers 一一对应
List<List<Info>> listInfos=(List<List<Info>>)request.getAttribute("listInfos");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <base href="<%=basePath%>">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=4IU3oIAMpZhfWZsMu7xzqBBAf6vMHcoa"></script>
    <style type="text/css">
    html,body{
    	margin:0;
    	padding:0;
    }
    .iw_poi_title {
    	color:#CC5522;
    	font-size:14px;
    	font-weight:bold;
    	overflow:hidden;
    	padding-right:13px;
    	white-space:nowrap;
    }
    .iw_poi_content {
    	font:12px arial,sans-serif;
    	overflow:visible;
    	padding-top:4px;
    	white-space:-moz-pre-wrap;
    	word-wrap:break-word;
    }
    #box{
    	margin-left:30px;
    }
    #dituContent{
    	float: left;
    }
    #other{
    	margin-top: 30px;
    	width:23%;
    	height:40px;
    	padding-top:15px;
    	text-align: center;
    	border:0px;
    	float: left; 
    }
    #now{
    	margin-top: 30px;
    	width:23%;
    	height:40px;
    	padding-top:15px; 
    	text-align: center;
    	background-image:url(shade.png);
    	background-repeat :no-repeat ;
    	background-color : transparent;  
    	float:left;
    }
    a{
	  text-decoration:none;
	}
</style>
    
    <title>index</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <div id="box">
  <div id="other"><font color="blue" size="5" >视频</font></div>
  <div id="now"><a href="index" target="right"><font color="gray" size="5" >WIFI</font></a></div>
  <div id="other"><font color="blue" size="5" >融合</font></div>
  <div id="other"><font color="blue" size="5" >地图列表</font></div>
  <div style="width:1570px;height:700px;border:gray solid 0px;" id="dituContent"></div>
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
        var mp = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(113.543811,22.372213 );//定义一个中心点坐标
        mp.centerAndZoom(point,16);//设定地图的中心点和坐标并将地图显示在地图容器中
        mp.enableScrollWheelZoom();
        function ComplexCustomOverlay(point){
	      this._point = point;
	      
	    }
	　　 // 继承API的BMap.Overlay  
	    ComplexCustomOverlay.prototype = new BMap.Overlay();
	    //初始化自定义覆盖物
	    // 实现初始化方法  
	    ComplexCustomOverlay.prototype.initialize = function(map){
	      // 保存map对象实例 
	      this._map = map;
	      // 创建div元素，作为自定义覆盖物的容器  
	      var div = this._div = document.createElement("div");
	      div.style.position = "absolute";
	      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);//聚合功能?
	      // 可以根据参数设置元素外观
	      div.style.height = "8px";
	      div.style.width="8px";
	
	      var arrow = this._arrow = document.createElement("img");
	      arrow.src = "http://www.yantiansf.cn/mapImage/1.gif";
	      arrow.style.width = "8px";
	      arrow.style.height = "8px";
	      arrow.style.top = "5px";
	      arrow.style.left = "10px";
	      div.appendChild(arrow);
	     
	　    // 将div添加到覆盖物容器中  
	      mp.getPanes().labelPane.appendChild(div);//getPanes(),返回值:MapPane,返回地图覆盖物容器列表  labelPane呢???
	      // 需要将div元素作为方法的返回值，当调用该覆盖物的show、  
	      // hide方法，或者对覆盖物进行移除时，API都将操作此元素。
	      return div;
	      
	    }
	    
	    //绘制覆盖物
	    // 实现绘制方法
	    ComplexCustomOverlay.prototype.draw = function(){
	      var map = this._map;
	      var pixel = map.pointToOverlayPixel(this._point);
	      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
	      this._div.style.top  = pixel.y - 30 + "px";
	    }
	   
	        
	   
	    //自定义覆盖物添加事件方法
	    ComplexCustomOverlay.prototype.addEventListener = function(event,fun){
	        this._div['on'+event] = fun;
	    }
        <%for(int i=0;i<seekers.size();++i) {%>
        <% double X = seekers.get(i).getX(); %>
        <% double Y = seekers.get(i).getY(); %>
        <% int ID = seekers.get(i).getId(); %>
        var point=new BMap.Point(<%=X%>,<%=Y%>)
        var start = new BMap.Marker(point);
        mp.addOverlay(start);
        var circle = new BMap.Circle(point,250,{strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});
        mp.addOverlay(circle);
        <%for(int j=0;j<listInfos.get(i).size();j++){%>
          var angle=Math.random()*360;
          var myCompOverlay = new ComplexCustomOverlay(new BMap.Point(<%=X%>-0.000017*<%=listInfos.get(i).get(j).getRssi()%>*Math.cos(angle),<%=Y%>-0.000017*<%=listInfos.get(i).get(j).getRssi()%>*Math.sin(angle)));
	      mp.addOverlay(myCompOverlay);
        <%}%>
        start.addEventListener("click", function(){
              window.location.href("http://localhost:8060/seeker?id="+<%= seekers.get(i).getId()%>);
        })
        window.map = mp;//将map变量存储在全局
         <%} %>
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
