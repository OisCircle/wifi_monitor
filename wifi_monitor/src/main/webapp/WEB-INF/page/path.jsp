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
		function pass(X){
		         initMap(X);
		}
		function route(mac){
		      var params = {};
			   params.mac = mac;
		     $.ajax({
			   			type:"post",
			   			url:"/path_count",
			   			data:params,
			   			success:function(data){
			   			    var longth=data;
			   			    if(longth==0){
			   			        alert("该MAC无路径！");
			   			    }else{
			   			        window.location="/linkPath?mac="+mac;
			   			    }         
			   			},
			   			error:function(){
			   				alert("error...");
			   			}
			   		});
		}
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
    #dituContent{
       width:1330px;
        height:860px;
        margin-top:10px;
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
		    	float:left;
		    }
		    span{
		       cursor:pointer;
		    }
		    a{
			  text-decoration:none;
			} 
			a:hover{
			  text-decoration:none;
			}
			#box{
			   width:100%;
			   height:87px;
			   background-color:#F8F8F8;
		       cursor:pointer;
		    }
		    #body{
		       margin-top:15px;
		       width:272px;
		       height:400px;
		       text-align: center;
		       overflow-y:scroll;
		    }
   </style>
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
		    function pathfly(mac){
           var params = {};
		   params.mac = mac;
		     $.ajax({
			   			type:"post",
			   			url:"/pathCount",
			   			data:params,
			   			success:function(data){
			   			    var longth=data;
			   			    if(longth==0){
			   			        alert("该MAC无路径！");
			   			    }else{
			   			        window.location="/path"+"?mac="+mac; 
			   			    }         
			   			},
			   			error:function(){
			   				alert("error...");
			   			}
			   		});
		    }
		    function linkpathfly(mac){
		                var params = {};
				        params.mac = mac; 
		                $.ajax({
					   			type:"post",
					   			url:"/pathCount",
					   			data:params,
					   			success:function(data){
					   			    var longth=data;
					   			    if(longth==0){
					   			        alert("该MAC无路径！");
					   			    }else{
					   			        window.location="/linkpath"+"?mac="+mac;
					   			    }         
					   			},
					   			error:function(){
					   				alert("error...");
					   			}
					   		});
		    }
		    function timefly(time){
		           var params = {};
				   params.minute = time;
			       $.ajax({
			            url:"/setMinute",
			            type:"Post",
			            data:params,
			            success:function(resp){
			                alert("success");
			                location.reload();
				            },
			            error:function(jqXHR,textstatus){
			                alert(textstatus);
			            }
			        });
		    }
	</script>
    <title>path</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    
  </head>
  
  <body>
		<div id="box">
		  <div id="other" ><a href="index?minute=6000" target="right"><font color="gray" size="5" >人群观测</font></a></div>
		  <div id="now" onclick="playtra()"><font color="#23527C" size="5" >轨迹跟踪</font></div>
		  <div id="selecttra"><%int m=0;
		  for(int i=0;i<seekers.size();i++){ 
		       if(m>=9) break;
		          for(int j=0;j<listInfos.get(i).size();j++){
		               m++;
		               if(m>=9) break;%>
		           <span id="<%=listInfos.get(i).get(j).getMac() %>" onclick="pathfly(this.id)"><%=listInfos.get(i).get(j).getMac() %></span><br>
		    <% } }%></div>
		  <div id="other" onclick="playlink()"><font color="gray" size="5" >折线路径</font></div>
		  <div id="selectlink"><%int c=0;
		  for(int i=0;i<seekers.size();i++){ 
		       if(c>=9) break;
		          for(int j=0;j<listInfos.get(i).size();j++){
		               c++;
		               if(c>=9) break;%>
		           <span id="<%=listInfos.get(i).get(j).getMac() %>" onclick="linkpathfly(this.id)"><%=listInfos.get(i).get(j).getMac() %></span><br>
		    <% } }%></div>
		  <div id="other" onclick="playtime()"><font color="gray" size="5" >时间选取</font></div>
		  <div id="selecttime">
		          <span  onclick="timefly(5)" >最近五分钟</span><br>
          <span  onclick="timefly(60)" >最近一小时</span><br>
          <span  onclick="timefly(1440)" >最近一天</span><br>
          <span  onclick="timefly(4320)" >最近三天</span><br>
          <span  onclick="timefly(525600)" >所有</span><br>
		  </div></div>
  <div style="width:1330px;height:775px;border:0px solid gray;" id="dituContent"></div>

  <div style="float:left;margin-top:10px;">
       <div id="list">
            <div id="title">
                 <h2><%= paths.get(0).getMac()%></h2>
            </div>
           <div id="body">
				<%for(int n=0;n<paths.size();n++){ %>
	                    <span id="<%=n%>" style="cursor:pointer;" onclick="pass(this.id)"><%=paths.get(n).getStart_time().getYear()+1900%>.<%=paths.get(n).getStart_time().getMonth()%>.<%=paths.get(n).getStart_time().getDay()%>.[<%=paths.get(n).getStart_time().getHours()%>:<%=paths.get(n).getStart_time().getMinutes()%>]--<%=paths.get(n).getEnd_time().getYear()+1900%>.<%=paths.get(n).getEnd_time().getMonth()%>.<%=paths.get(n).getEnd_time().getDay()%>.[<%=paths.get(n).getEnd_time().getHours()%>:<%=paths.get(n).getEnd_time().getMinutes()%>]</span>
	                <br>
	             <%}%>
             </div>
		</div>	
		<button type="button" class="btn btn-primary" style="position:absolute; top:750px;left:1419px;" value="<%= paths.get(0).getMac() %>" onclick="route(this.value)">折线路径</button>
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
