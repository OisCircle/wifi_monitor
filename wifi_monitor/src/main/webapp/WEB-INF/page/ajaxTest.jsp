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
   		alert("into js method");
   		var jsonData=[];
   		$.ajax({
   			type:"post",
   			url:"/testAjax",
   			data:{},
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
    
    <table id="table">i am a table</table>
    
    <button onclick="sendAjax()">我是按钮</button>
  </body>
</html>
