<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,com.qcq.wifi_monitor.entity.*" language="java" %>
<%
    List<Seeker> seekers =(List<Seeker>)request.getAttribute("seekers");
//每个seeker对应的信息，下标与 seekers 一一对应
List<List<Info>> listInfos=(List<List<Info>>)request.getAttribute("listInfos");
%>
<html>
<head>
    <title>indoor_linkpath</title>
<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	html,body{
    	margin:0;
    	padding:0;
    }
    #Echart{
        width:1600px;
        height:750px;
        margin-top:19px;
        margin-left:4px;
        backgroung-color:glay;
        background-size:1600px 750px;
        background-repeat:no-repeat;
        float:left;
    }
     #mapinfo{
         position:absolute;
         left:1450px;
         top:45px;
         width:150px;
         height:40px;
         text-align:center;
    }
    #mapinfos{
        position:absolute;
        left:85%;
        top:96px;
        width:13%;
        height:150px;
        opacity:0.6;
        border-radius:5px;
        background-color:black;
        display:none;
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
	</style>

  <script type="text/javascript">
    function linkpathfly(mac){
           var params = {};
		   params.mac = mac;
                $.ajax({
			   			type:"post",
			   			url:"/indoor_linkPath_count",
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
	                location.reload();
		            },
	            error:function(jqXHR,textstatus){
	                alert(textstatus);
	            }
	        });
    }
	</script>
  </head>
  <body>
	  <div id="box">
	    <nav class="navbar navbar-default" role="navigation">
		    <div class="container-fluid">
		    <div>
		        <ul class="nav navbar-nav">
		            <li><a href="index?minute=6000">人群观测</a></li>
		            <li class="dropdown">
		                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		                                                               折线路径
		                    <b class="caret"></b>
		                </a>
		                <ul class="dropdown-menu">
		                    <%int now=0;
	                          for(int i=0;i<seekers.size();i++){ 
	                             if(now>=9) break;
	                             for(int j=0;j<listInfos.get(i).size();j++){
	                                 now++;
	                                if(now>=9) break;%>
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
		    <div id="mapinfo" onclick="mapInfomation();">
		        <i class="glyphicon glyphicon-globe" style="font-size:20px;color:#5BC0DE;"></i><font size="5" color="#5BC0DE">地图信息</font>
		    </div>
		    <div id="mapinfos">
		        <h4 id="infomapname" style="margin-left:20%;color:white;"></h4>
		        <h4 id="infomacnumber" style="margin-left:20%;color:white;"></h4>
		        <h4 id="infomapx" style="margin-left:20%;color:white;"></h4>
		        <h4 id="infomapy" style="margin-left:20%;color:white;"></h4>
		    </div>
	  </div>
   <div id="Echart" >
  	<canvas id="Canvas" width="1600" height="750">
	</canvas>
	</div>
  </body>
  <script type="text/javascript">
           var seeker=[];
           var paths=[];
  function drawArrow(ctx, fromX, fromY, toX, toY,theta,headlen,width,color) { 
    theta = typeof(theta) != 'undefined' ? theta : 30; 
    headlen = typeof(theta) != 'undefined' ? headlen : 10; 
    width = typeof(width) != 'undefined' ? width : 1; 
    color = typeof(color) != 'color' ? color : '#000'; 
    // 计算各角度和对应的P2,P3坐标 
    var angle = Math.atan2(fromY - toY, fromX - toX) * 180 / Math.PI, 
    angle1 = (angle + theta) * Math.PI / 180, 
    angle2 = (angle - theta) * Math.PI / 180, 
    topX = headlen * Math.cos(angle1), 
    topY = headlen * Math.sin(angle1), 
    botX = headlen * Math.cos(angle2), 
    botY = headlen * Math.sin(angle2); 
    ctx.save(); ctx.beginPath(); 
    var arrowX = fromX - topX, 
    arrowY = fromY - topY; 
    ctx.moveTo(arrowX, arrowY); 
    ctx.moveTo(fromX, fromY); 
    ctx.lineTo(toX, toY); 
    arrowX = toX + topX; 
    arrowY = toY + topY; 
    ctx.moveTo(arrowX, arrowY); 
    ctx.lineTo(toX, toY); 
    arrowX = toX + botX; 
    arrowY = toY + botY; 
    ctx.lineTo(arrowX, arrowY); 
    ctx.strokeStyle = color; 
    ctx.lineWidth = width; 
    ctx.stroke(); 
    ctx.restore(); 
}
function mapInfomation(){
        var infomation=document.getElementById("mapinfos");
        if(infomation.style.display=="block") infomation.style.display="none";
        else infomation.style.display="block";
}
  function map(){
  
           $.ajax({
	   			type:"post",
	   			url:"/getSelectedId",
	   			data:{},
	   			async:false,
	   			success:function(data){
	 				id=data;  
	 				if(id==null){
	 				    alert("未选择地图！")
	 				}
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
	   		$.ajax({
	   			type:"post",
	   			url:"/getSeekersByZoneId",
	   			data:{},
	   			async:false,
	   			success:function(data){
	 				seeker=data;  
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
	   		$.ajax({
	   			type:"post",
	   			url:"/indoor_linkPath_Paths",
	   			data:{},
	   			async:false,
	   			success:function(data){
	 				paths=data;  
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
	   		 $.ajax({
	   			type:"post",
	   			url:"/zoneSelectAll",
	   			data:{},
	   			async:false,
	   			success:function(data){
	   			    var jsonmap=[];
	 				jsonmap=data;
	 				for(var i=0;i<jsonmap.length;i++){
	 				     if(jsonmap[i].id==id){
	 				         var mappath="url(path/"+jsonmap[i].name.toString()+".jpg)";
	 				         document.getElementById("infomapname").innerHTML="地图名称:"+jsonmap[i].name;
	 				         document.getElementById("infomacnumber").innerHTML="探针数量:"+getJsonLength(infos);
	 				         document.getElementById("infomapx").innerHTML="经度:"+jsonmap[i].x;
	 				         document.getElementById("infomapy").innerHTML="纬度:"+jsonmap[i].y;
	 				     }
	 				}
	 				var Echart=document.getElementById("Echart");
			 	    Echart.style.backgroundImage=mappath;	
			 	    var c=document.getElementById("Canvas");
                    var cxt=c.getContext("2d");	
                    for(var i=0;i<paths.length;i++){
                        var from_x=0,from_y=0;
                        var to_x=0,to_y=0;
                        for(var m=0;m<seeker.length;m++){
                              if(seeker[m].id==paths[i].seekerIdFrom){
			                     from_x=seeker[m].indoor_x;
			                     from_y=seeker[m].indoor_y;
			                  }
			                  if(seeker[m].id==paths[i].seekerIdTo){
			                     to_x=seeker[m].indoor_x;
			                     to_y=seeker[m].indoor_y;
			                  }
			            }
			            drawArrow(cxt, from_x, from_y, to_x,to_y,30,30,10,'#0078D7');
			            cxt.stroke();
			        }
			      	   			 						 	
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
    
    }
    map();
    
  </script> 
</html>
