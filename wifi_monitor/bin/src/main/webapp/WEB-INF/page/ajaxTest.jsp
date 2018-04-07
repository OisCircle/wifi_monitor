<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ajaxTest.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
   <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript">
	function sendAjax(){
		var params = {};
		params.selectedId = 123456;
   		alert("into js method");
   		$.ajax({
   			type:"POST",
   			url:"/testAjax",
   			data:params,
   			success:function(data){
 				jsonData=data;
 				alert(jsonData.hello);
 				alert(jsonData.world);
   				document.getElementById("table").innerHTML="hello ajax!";
   			},
   			error:function(){
   				alert("error...");
   			}
   		});
   		
   };
   
   </script>
  <body>
    This is my JSP page. <br>
    session:
    <br>
    <%= session.getAttribute("username") %>
    <br>
    selectedId:
    <br>
    <%= session.getAttribute("selectedId") %>
    <br>
    <table id="table">i am a table</table>
    
    <button onclick="sendAjax()">我是按钮</button>
  </body>
</html>
