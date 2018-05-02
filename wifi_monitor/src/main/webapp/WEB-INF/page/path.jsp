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
		        margin-top:0px;
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
		    .nav{
		        font-size:25px; 
			    margin-top:36px;
		        margin-left:0;
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
					   			        window.location="/linkPath?mac="+mac;
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
		  <nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
    <div>
        <ul class="nav navbar-nav">
            <li><a href="index?minute=6000">人群观测</a></li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown">
                                                            轨迹跟踪
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                <%int m=0;
                  for(int i=0;i<seekers.size();i++){ 
                  if(m>=9) break;
                   for(int j=0;j<listInfos.get(i).size();j++){
                       m++;
                        if(m>=9) break;%>
                      <li> <a id="<%=listInfos.get(i).get(j).getMac() %>" onclick="pathfly(this.id)"><%=listInfos.get(i).get(j).getMac() %></a></li>
                 <% } }%>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                                               折线路径
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <%int c=0;
                      for(int i=0;i<seekers.size();i++){ 
                          if(c>=9) break;
                          for(int j=0;j<listInfos.get(i).size();j++){
                                c++;
                                if(c>=9) break;%>
                      <li><a id="<%=listInfos.get(i).get(j).getMac() %>" onclick="linkpathfly(this.id)"><%=listInfos.get(i).get(j).getMac() %></a></li>
                   <% } }%>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown">
                                                                时间选取
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a onclick="timefly(5)" >最近五分钟</a></li>
                    <li><a onclick="timefly(60)" >最近一小时</a></li>
                    <li><a onclick="timefly(1440)" >最近一天</a></li>
                    <li><a onclick="timefly(4320)" >最近三天</a></li>
                    <li><a onclick="timefly(525600)" >所有</a></li>
                </ul>
            </li>
        </ul>
    </div>
    </div>
</nav>
</div>
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
