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
    #other{
    	margin-top: 30px;
    	width:33%;
    	height:40px;
    	padding-top:15px;
    	text-align: center;
    	border:0px;
    	float: left; 
    }
    #now{
    	margin-top: 30px;
    	width:33%;
    	height:40px;
    	padding-top:15px; 
    	text-align: center;
    	background-image:url(shade.png);
    	background-repeat :no-repeat ;
    	background-color : transparent;  
    	float:left;
    }
	#selectlink{
        position:absolute;
        left:33%;
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
        left:66%;
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
    #EchartMap{
        width:1600px;
        height:750px;
        margin-top:19px;
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
	</style>

  <script type="text/javascript">
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
	  <div id="now"><a href="index?minute=6000" target="right"><font color="#23527C" size="5" >人群观测</font></a></div>
	  <div id="other" onclick="playlink()"><font color="gray" size="5" >折线路径</font></div>
	  <div id="selectlink"><%int now=0;
	  for(int i=0;i<seekers.size();i++){ 
	       if(now>=9) break;
	          for(int j=0;j<listInfos.get(i).size();j++){
	               now++;
	               if(now>=9) break;%>
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
	 				     if(jsonmap[i].id==id){var mappath="url(path/"+jsonmap[i].name.toString()+".jpg)";}
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