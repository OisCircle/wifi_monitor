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
    #selecttra{
        position:absolute;
        left:23%;
        top:86px;
        z-index:2000;
        display:none;
        width:23%;
        height:200px;
        opacity: 0.6;
        background:white;
        border-radius:5px;    
    }
    #selectlink{
        position:absolute;
        left:46%;
        top:86px;
        z-index:2000;
        display:none;
        width:23%;
        height:200px;
        opacity: 0.6;
        background:white;
        border-radius:5px;    
    }
    #selecttime{
        position:absolute;
        left:69%;
        top:86px;
        z-index:2000;
        display:none;
        width:23%;
        height:200px;
        opacity: 0.6;
        background:white;
        border-radius:5px;     
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
	<script type="text/javascript">
	function playtra(){
        var a = document.getElementById("selecttra");
        if(a.style.display=="block") a.style.display = "none";
        else a.style.display = "block";
    }
    function playlink(){
        var a = document.getElementById("selectlink");
        if(a.style.display=="block") a.style.display = "none";
        else a.style.display = "block";
    }
    function playtime(){
        var a = document.getElementById("selecttime");
        if(a.style.display=="block") a.style.display = "none";
        else a.style.display = "block";
    }
    
    function selected(a){
        //下拉选项显示后，给”item“添加点击事件：点击隐藏下拉列表
        var b = document.getElementById("menu");
        b.style.display = "none";
        //讲选中项的值放到“sel“里显示
        var txt = a.innerText;
        document.getElementById("sel").innerText = txt;
    }
	</script>
  </head>
  
  <body>
  <div id="box">
  <div id="now"><a href="index?minute=6000" target="right"><font color="gray" size="5" >人群观测</font></a></div>
  <div id="other" onclick="playtra()"><font color="blue" size="5" >轨迹跟踪</font></div>
  <div id="selecttra"></div>
  <div id="other" onclick="playlink()"><font color="blue" size="5" >折线路径</font></div>
  <div id="selectlink"></div>
  <div id="other" onclick="playtime()"><font color="blue" size="5" >时间选取</font></div>
  <div id="selecttime"></div></div>
  <div style="width:1608px;height:775px;border:gray solid 0px;" id="dituContent"></div> 
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
        var point = new BMap.Point(113.545741,22.371249);//定义一个中心点坐标
        mp.centerAndZoom(point,17);//设定地图的中心点和坐标并将地图显示在地图容器中
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
        var opts = {
	      width : 80,     // 信息窗口宽度
	      height: 30,     // 信息窗口高度
	      title : " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   当前：   " , // 信息窗口标题     
	    }
	    var infoWindow = new BMap.InfoWindow("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=listInfos.get(i).size()%>个信号", opts);  // 创建信息窗口对象 
	    setmouse(start,infoWindow);
        mp.addOverlay(start);
        var circle = new BMap.Circle(point,250,{strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});
        mp.addOverlay(circle);
        <%for(int j=0;j<listInfos.get(i).size();j++){%>
          var angle=Math.random()*360;
          var myCompOverlay = new ComplexCustomOverlay(new BMap.Point(<%=X%>-0.000017*<%=listInfos.get(i).get(j).getRssi()%>*Math.cos(angle),<%=Y%>-0.000017*<%=listInfos.get(i).get(j).getRssi()%>*Math.sin(angle)));
          mp.addOverlay(myCompOverlay);
        <%}%>
        start.addEventListener("click", function(){
              window.location("/seeker?id="+<%= seekers.get(i).getId()%>+"&minute=60&rssi=-130");
        })
	    window.map = mp;
	   <%}%>
	    function setmouse(marck,infoWindow){
	      marck.addEventListener("mouseover", function(e){          
	          openInfo(infoWindow,e)
	      });
	    }
	    function openInfo(content,e){
		var p = e.target;
		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
		mp.openInfoWindow(content,point); //开启信息窗口
		window.map=mp;
	   }
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
