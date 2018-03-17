<%@ page  language="java"  import="java.util.*"  pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
    <meta charset="UTF-8">
    <title>首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <style type="text/css">
   *{/*清空网页默认设置*/
		margin:0;
		padding:0;
	}
	body{
		background-color:#F8F8F8; 
	}
 	ul li{
	list-style-type:none;
	line-height: 60px; 
	}
	a{
	  text-decoration:none;
	}
 </style>
  <body>
    <ul style="margin-top:30px;margin-left:30px">
       	<li><div id=""><span class="glyphicon glyphicon-list-alt" style="font-size: 23px;"></span><font color="#777474"  size="5">系统用户介绍</font></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-user" style="font-size: 23px;"></span><font color="#777474" size="5">用户管理</font></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-object-align-bottom" style="font-size: 23px;"><font color="#777474" size="5">用户组管理</font></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-tag" style="font-size: 23px;"><font color="#777474" size="5">组与权限管理</font></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-globe" style="font-size: 23px;"><font color="#777474" size="5">地图管理</font></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-record" style="font-size: 23px;"><font color="#777474" size="5">地图区域管理</font></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-pushpin" style="font-size: 23px;"><font color="#777474" size="5">观测点管理</font></div></li>
      	<li><div id=""><a href="index" target="right"><span class="glyphicon glyphicon-stats" style="font-size: 23px;"><font color="#777474" size="5">百度地图数据展示</font></a></div></li>
      	<li><div id=""><span class="glyphicon glyphicon-stats" style="font-size: 23px;"><font color="#777474" size="5">Echart地图实时展示</font></div></li>
      </ul>
  </body>
</html>
