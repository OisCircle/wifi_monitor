<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.Info" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Info> infos=(List<Info>)request.getAttribute("infos");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'seeker.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  	infos:
  	<br>
  	<%for(int i=0;i<infos.size();++i) {%>
    <%= infos.get(i).toString() %>
    <br>
    <%} %>
    This is my JSP page. <br>
  </body>
</html>
