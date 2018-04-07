<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页</title>
    <meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script language="javascript">
     var t = null;
    t = setTimeout(time,1000);//开始执行
    function time()
    {
        clearTimeout(t);//清除定时器
        dt = new Date();
		var y=dt.getYear()+1900;
		var mm=dt.getMonth()+1;
		var d=dt.getDate();
		var weekday=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
		var day=dt.getDay();
		       	var h=dt.getHours();
		       	var m=dt.getMinutes();
		       	var s=dt.getSeconds();
		/*var calendar=document.createElement("span");
		calendar.setAttribute("class", "glyphicon glyphicon-calendar");*/
		if(h<10){h="0"+h;}
		if(m<10){m="0"+m;}
		if(s<10){s="0"+s;}
		        /*document.getElementById("showtime").appendChild(calendar);*/
		       	document.getElementById("showtime").innerHTML = " "+y+"年"+mm+"月"+d+"日  "+weekday[day]+"  "+h+":"+m+":"+s+"";
		       	t = setTimeout(time,1000); //设定定时器，循环执行           
    }
  </script>
  </head>
  <style type="text/css">
 	*{/*清空网页默认设置*/
		margin:0;
		padding:0;
       
	}
	body{ /*整体颜色*/
		background-color:#F8F8F8;
	}
	#tittle{
	   width:700px;
	   height:70px;
	   margin-left:30px;
	   margin-top:30px;
	   float:left;
	}
 	#showtime{/*显示时间*/
 		padding-top:10px;
 		padding-left:26px;  
 		width:260px;
 		height:30px;
 		margin-top:30px;
 		margin-left:200px;  
 		background-color: black;
 		opacity: 0.6;
 		color:white;
        border-radius:20px;
        float:left;
 	}
 </style>
  <body>
  <div>
    <div id="tittle">
       <font color="#39AEFF"size="6" font-style="italic">大人流预警及人员轨迹跟踪系统</font>
      </div>
    <div id="showtime" >
       	  <span class="glyphicon glyphicon-calendar"></span>
       </div>
</div>
  </body>
</html>