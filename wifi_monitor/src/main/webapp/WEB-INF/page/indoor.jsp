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
    <base href="<%=basePath%>">
    
    <title>EchartMap</title>
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
    #EchartMap{
        width:1600px;
        height:750px;
        margin-top:9px;
        margin-left:4px;
        backgroung-color:glay;
        background-size:1600px 750px;
        background-repeat:no-repeat;
        float:left;
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
    #nowTimeShow{
		       position:absolute;
		       z-index:1000;
		       left:50px;
		       top:100px;
		       width:100px;
		       height:40px;
		       background-color:gray;
		       border-radius:5px;
		       text-align:center;
		       opacity:0.8;
    }
    .nav{
    	font-size:25px; 
		margin-top:36px;
		margin-left:0;
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
			   			        window.location="/indoor_linkPath?mac="+macs;
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
       <div id="nowTimeShow">
	      <h4 id="nowtime" style="margin-top:10%;color:white;"></h4>
	  </div>
	  <script type="text/javascript">
	      function time(){
		       $.ajax({
		            url:"/getMinute",
		            type:"Post",
		            async:false,
		            data:{},
		            success:function(data){
		                    var nowTime=data;
		                    var now=document.getElementById("nowtime");
		                    if(nowTime==5){
		                          now.innerHTML="最近五分钟";          
		                    }else if(nowTime==60){
		                          now.innerHTML="最近一小时";
		                    }else if(nowTime==1440){
		                          now.innerHTML="最近一天";
		                    }else if(nowTime==4320){
		                          now.innerHTML="最近三天";
		                    }else if(nowTime==525600){
		                          now.innerHTML="所有";
		                    }
			            },
		            error:function(jqXHR,textstatus){
		                alert(textstatus);
		            }
		        });
	    }
	    time();
	  </script>
   <div id="EchartMap" >
  	<canvas id="myCanvas" width="1600" height="750">
	</canvas>
	</div>
  </body>
  <script type="text/javascript">
          var id;
          var seekers=[];
          var infos={};
          var Echart=document.getElementById("EchartMap");
          var jsonlength;
function Cricre(x,y,mac){
        y+=75;
        var cricre=document.createElement("div");
        cricre.setAttribute("id", mac);
	    cricre.setAttribute("style","position:absolute;left:"+x+"px;top:"+y+"px;width:6px;height:6px;border-radius:3px;background-color:red") ;
	    cricre.setAttribute("onclick", "getpath(this.id)");
	    Echart.appendChild(cricre);
    }
function mapInfomation(){
        var infomation=document.getElementById("mapinfos");
        if(infomation.style.display=="block") infomation.style.display="none";
        else infomation.style.display="block";
}
function getpath(macs){
		      var params={};
		      params.mac=macs;
		      $.ajax({
			   			type:"post",
			   			url:"/indoor_linkPath_count",
			   			data:params,
			   			success:function(data){
			 				var maccount=data;  
			 				if(maccount==0){
			 				   alert("该mac无路径！")
			 				}else{
			 				   window.location="/indoor_linkPath?mac="+macs;
			 				}
			   			},
			   			error:function(){
			   				alert("error...");
			   			}
			   		});
}
function getJsonLength(jsonData){  
	    var jsonLength = 0;  
	    for(var item in jsonData){    
	        jsonLength++;    
	    }  	  
	    return jsonLength;  
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
	   			url:"/indoor_seekers",
	   			data:{},
	   			async:false,
	   			success:function(data){
	 				seekers=data;  
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
	   	$.ajax({
	   			type:"post",
	   			url:"/indoor_listInfos",
	   			data:{},
	   			async:false,
	   			dataType:'json',
	   			success:function(data){
	   			    infos=data;  
	   			    jsonlength=getJsonLength(infos);
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
	 				Echart.style.backgroundImage=mappath;	
	 				var c=document.getElementById("myCanvas");
					var cxt=c.getContext("2d");
					for(var m=0;m<seekers.length;m++){
						cxt.lineWidth=3;
						cxt.strokeStyle="red";
					    cxt.arc(seekers[m].indoor_x,seekers[m].indoor_y,80,0,7,false);
					    cxt.stroke();
					    cxt.closePath();
					    cxt.fillStyle="#FF0000";
                        if(getJsonLength(infos)>=1&&infos.Obj0.length>0&&seekers[m].id==infos.Obj0[0].s_id){
							   for(var n=0;n<infos.Obj0.length;n++){
							         var angle=Math.random()*360;
							         var x=seekers[m].indoor_x-0.46*infos.Obj0[n].rssi*Math.cos(angle);
							         var y=seekers[m].indoor_y-0.46*infos.Obj0[n].rssi*Math.sin(angle);
							         Cricre(x,y,infos.Obj0[n].mac);
							     }
						 }
						 if(jsonlength>=2&&infos.Obj1.length>0&&seekers[m].id==infos.Obj1[0].s_id){
						    for(var n=0;n<infos.Obj1.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj1[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj1[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj1[n].mac);
						     }
						 }
						 if(jsonlength>=3&&infos.Obj2.length>0&&seekers[m].id==infos.Obj2[0].s_id){
						    for(var n=0;n<infos.Obj2.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj2[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj2[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj2[n].mac);
						     }
						 }
						 if(jsonlength>=4&&infos.Obj3.length>0&&seekers[m].id==infos.Obj3[0].s_id){
						    for(var n=0;n<infos.Obj3.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj3[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj3[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj3[n].mac);
						     }
						 }
						 if(jsonlength>=5&&infos.Obj4.length>0&&seekers[m].id==infos.Obj4[0].s_id){
						    for(var n=0;n<infos.Obj4.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj4[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj4[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj4[n].mac);
						     }
						 }
						 if(jsonlength>=6&&infos.Obj5.length>0&&seekers[m].id==infos.Obj5[0].s_id){
						    for(var n=0;n<infos.Obj5.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj5[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj5[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj5[n].mac);
						     }
						 }
						 if(jsonlength>=7&&infos.Obj6.length>0&&seekers[m].id==infos.Obj6[0].s_id){
						    for(var n=0;n<infos.Obj6.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj6[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj6[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj6[n].mac);
						     }
						 }
						 if(jsonlength>=8&&infos.Obj7.length>0&&seekers[m].id==infos.Obj7[0].s_id){
						    for(var n=0;n<infos.Obj7.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj7[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj7[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj7[n].mac);
						     }
						 }
						 if(jsonlength>=9&&infos.Obj8.length>0&&seekers[m].id==infos.Obj8[0].s_id){
						    for(var n=0;n<infos.Obj8.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj8[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj8[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj8[n].mac);
						     }
						 }
						 if(jsonlength>=10&&infos.Obj9.length>0&&seekers[m].id==infos.Obj9[0].s_id){
						    for(var n=0;n<infos.Obj9.length;n++){
						         var angle=Math.random()*360;
						         var x=seekers[m].indoor_x-0.46*infos.Obj9[n].rssi*Math.cos(angle);
						         var y=seekers[m].indoor_y-0.46*infos.Obj9[n].rssi*Math.sin(angle);
						         Cricre(x,y,infos.Obj9[n].mac);
						     }
						 }
					   cxt.beginPath();
					}
					cxt.closePath();		
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
    
    }
    map();
  </script>
</html>