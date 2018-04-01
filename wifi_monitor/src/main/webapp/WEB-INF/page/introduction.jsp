<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>System introduction</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   <style type="text/css">
   #box{
       margin:auto;
       width:98%;
       height:93%;
       margin-top:2%;
       border:2px solid gray;
       border-radius: 4px;
   }
   </style>
  </head>
  
  <body>
  <div id="box">
     <br>
     <font color="gray"size="7">
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;随着计算机网络技术的发展，WIFI 技术的使用逐渐普及，如何通过WIFI探针技术进行数据采集及信息预警是目前研究的热点问题。本项目自主研发设计一套低成本的WIFI探针设备，通过分布式采集WIFI 网络中终端主动发送探针的数据包的MAC 地址信息和RSSI 信息，通过大数据处理平台对数据进行汇总分析，可以统计平时每个终端采集器附近手机终端数量的均值，同时可以统计多个终端采集器所代表的某个区域的手机终端数量的均值达到对大人流的预警。此外，通过百度地图的导入可以在地图上标注该手机经常的活动轨迹和指定终端的行为轨迹分析，实现大人流预警及人员轨迹跟踪，为城市公共安全管理供强有力的信息化支撑和保障。
     </font>
   </div>
  </body>
</html>
