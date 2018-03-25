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

  </head>
   <frameset rows="100px,*"> 
    <frame src="top"  name="top" noresize="noresize"  border-bottom="0.5px"  scrolling="no" bordercolor="gray" border-style="groove"> 
    <frameset cols="16%,*">
      <frame src="left" name="left"  noresize="noresize" style="border-radius:3px" border-bottom="0.5px"  scrolling="no" bordercolor="gray" border-style="groove">
      <frame name="right" noresize="noresize"  border-bottom="0.5px"  scrolling="no" bordercolor="glay" border-style="groove">
     </frameset>
  </frameset>
</html>
