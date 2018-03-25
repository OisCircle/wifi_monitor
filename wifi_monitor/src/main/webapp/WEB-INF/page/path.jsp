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
		function pass(X){
		         initMap(X);
		}
		function route(mac){
				window.location="/linkPath?mac="+mac;
		}
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
    a{
      text-decoration:none;
    }
    #box{
        width:1330px;
        height:860px;
    	float:left;
    }
    #dituContent{
    	float: left;
    }	 
    #list{
        margin-left:2px;
        width:272px;
        height:470px;
        border:1px solid gray;
        border-radius:3px; 
        float:left;
    }
    #title{
       margin:0;
       width:272px;
       height:30px;
       text-align: center;
       background-color:#CDCDCD;
    }  
    #body{
       margin-top:5px;
       width:272px;
       height:400px;
       text-align: center;
       overflow-y:scroll;
    }
</style>
    <title>path</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    
  </head>
  
  <body>
  <div id="box">
  <div style="width:1330px;height:860px;border:0px solid gray;" id="dituContent"></div>
  </div>
  <div style="float:left">
       <div id="list">
            <div id="title">
                 <h2><%= paths.get(0).getMac()%></h2>
            </div>
           <div id="body">
				<%for(int n=0;n<paths.size();n++){ %>
	                <a title="<%=paths.get(n).getEnd_time().getYear()+1900%>年<%=paths.get(n).getEnd_time().getMonth()%>月<%=paths.get(n).getEnd_time().getDay()%>日<%=paths.get(n).getEnd_time().getHours()%>时<%=paths.get(n).getEnd_time().getMinutes()%>分<%=paths.get(n).getEnd_time().getSeconds()%>秒"><span id="<%=n%>" style="cursor:pointer;" onclick="pass(this.id)"><%=paths.get(n).getStart_time().getYear()+1900%>年<%=paths.get(n).getStart_time().getMonth()%>月<%=paths.get(n).getStart_time().getDay()%>日<%=paths.get(n).getStart_time().getHours()%>时<%=paths.get(n).getStart_time().getMinutes()%>分<%=paths.get(n).getStart_time().getSeconds()%>秒</span></a>
	                <br>
	             <%}%>
             </div>
		</div>	
		<input type="button"value="折线路径" style="position:absolute; top:750px;left:1419px;width:100px;height:30px;border:1px solid gray;border-radius: 3px;backgrou-color:#A7C0E0;" onclick="route('<%= paths.get(0).getMac() %>')" > 
  </div>
  </body>
  <script type="text/javascript">
    //创建和初始化地图函数：
   function initMap(X){
        createMap(X);//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    }
    
    //创建地图函数：
    function createMap(X){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(113.543811,22.372213 );//定义一个中心点坐标
        map.centerAndZoom(point,16);//设定地图的中心点和坐标并将地图显示在地图容器中
        var walking = new BMap.WalkingRoute(map, { 
            renderOptions: { 
                map: map, 
                autoViewport: true 
            }
        });
         var start_x=new Array;
	     var start_y=new Array;
	     var end_x=new Array;
	     var end_y=new Array;
        <%for(int i=0;i<paths.size();i++){%>
	        start_x.push(<%=  paths.get(i).getStart_x() %>);
	        start_y.push(<%= paths.get(i).getStart_y() %>);
	        end_x.push(<%= paths.get(i).getEnd_x() %>);
	        end_y.push(<%= paths.get(i).getEnd_y() %>);
        <%}%>
        var start = new BMap.Marker(new BMap.Point(start_x[X],start_y[X]));
        var end = new BMap.Marker(new BMap.Point(end_x[X],end_y[X]));
        walking.search(start, end);
        window.map = map;//将map变量存储在全局
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
    
    initMap(0);//创建和初始化地图
</script>
</html>
