<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Seeker> seekers =(List<Seeker>)request.getAttribute("seekers");
//每个seeker对应的信息，下标与 seekers 一一对应
List<List<Info>> listInfos=(List<List<Info>>)request.getAttribute("listInfos");
//每个info应该处在的坐标
List<Path> paths=(List<Path>)request.getAttribute("paths");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript">
</script>
  <base href="<%=basePath%>">
   <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
    #selecttra{
		        position:absolute;
		        left:23%;
		        top:86px;
		        z-index:2000;
		        display:none;
		        width:23%;
		        height:200px;
		        text-align: center;
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
		        text-align: center;
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
		        text-align: center;
		        opacity: 0.6;
		        background:white;
		        border-radius:5px;     
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
		    span{
		       cursor:pointer;
		    }
		    a{
			  text-decoration:none;
			}	 
</style>
    <title>linkPath</title>
    
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
		    function pathfly(mac){
		         window.location="/path"+"?mac="+mac+"&minute=9999999";
		    }
		    function linkpathfly(mac){
		         window.location="/linkpath"+"?mac="+mac+"&minute=9999999";
		    }
		    function timefly(time){
		         window.location="/index?minute="+time;
		    }
	</script>
  </head>
  
  <body>
  <div id="tittlebox">
  <div id="other" class="panel panel-info"><a href="index?minute=6000" target="right"><font color="gray" size="5" >人群观测</font></a></div>
  <div id="other" class="panel panel-info" onclick="playtra()"><font color="blue" size="5" >轨迹跟踪</font></div>
  <div id="selecttra"><%int m=0;
  for(int i=0;i<seekers.size();i++){ 
       if(m>=9) break;
          for(int j=0;j<listInfos.get(i).size();j++){
               m++;
               if(m>=9) break;%>
           <span value="<%=listInfos.get(i).get(j).getMac() %>" onclick="pathfly(this.value)"><%=listInfos.get(i).get(j).getMac() %></span><br>
    <% } }%></div>
  <div id="now" class="panel panel-success" onclick="playlink()"><font color="blue" size="5" >折线路径</font></div>
  <div id="selectlink"><%int c=0;
  for(int i=0;i<seekers.size();i++){ 
       if(c>=9) break;
          for(int j=0;j<listInfos.get(i).size();j++){
               c++;
               if(c>=9) break;%>
           <span value="<%=listInfos.get(i).get(j).getMac() %>" onclick="linkpathfly(this.value)"><%=listInfos.get(i).get(j).getMac() %></span><br>
    <% } }%></div>
  <div id="other" class="panel panel-info" onclick="playtime()"><font color="blue" size="5" >时间选取</font></div>
  <div id="selecttime">
          <span  onclick="timefly(60);" >1小时内</span><br>
          <span  onclick="timefly(120);" >2小时内</span><br>
          <span  onclick="timefly(240);" >4小时内</span><br>
          <span  onclick="timefly(9999999);" >所有</span><br>
  </div></div>
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
