<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>mapPop</title>
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

  </head>
  
  <body>
     <h4>修改地图信息</h4>
     <form class="form-horizontal" role="form">
	    <div class="form-group">
			<label class="col-sm-2 control-label">地图名称：</label>
			<div class="col-sm-10">
				<input class="form-control" id="mapName" type="text">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">探针：</label>
			<div class="col-sm-10">
				<input class="form-control" id="mapName" type="text">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">：</label>
			<div class="col-sm-10">
				<input class="form-control" id="mapName" type="text">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">：</label>
			<div class="col-sm-10">
				<input class="form-control" id="mapName" type="text">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">：</label>
			<div class="col-sm-10">
				<input class="form-control" id="mapName" type="text">
			</div>
		</div>
		<div class="form-group">
			    <label for="name">地图说明：</label>
			    <textarea id="description"class="form-control" rows="3"></textarea>
		  </div>
		  <input class="btn btn-default" type="button" value="确认">
          <input class="btn btn-default" type="button" value="取消">
	</form>
	
  </body>
</html>
