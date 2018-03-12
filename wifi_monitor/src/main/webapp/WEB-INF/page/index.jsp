<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.Seeker" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Seeker> seekers =(List<Seeker>)request.getAttribute("seekers");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>index</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    seekers
    <br>
    <%for(int i=0;i<seekers.size();++i) {%>
    <%= seekers.get(i).toString() %>
    <br>
    <%} %>
  </body>
</html>
