<%@ page  language="java"  import="java.util.*"  pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
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
	<script type="text/javascript">
	function playequip(){
        var a = document.getElementById("liboxequip");
        if(a.style.display=="block") a.style.display = "none";
        else a.style.display = "block";
    }
	</script>
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
    }
    #libox{
    margin-top:50px;
    }
    
 </style>
  <body>
    <ul style="margin-left:30px">
        <li><div id="libox"><span class="glyphicon glyphicon-list-alt" style="font-size: 23px;"></span><a style="text-decoration:none;" href="introduction" target="right"><font color="#777474"  size="5">系统用户介绍</font></a></div></li>
        <li><div id="libox" onclick="playequip()"><span class="glyphicon glyphicon-cog" style="font-size: 23px;"></span><font color="#777474" size="5">系统管理</font></div></li>
        <div id="liboxequip" style="display:none;margin-left:20px;">
        	<ul>
	           <li><span class="glyphicon glyphicon-globe" style="font-size: 23px;"></span><font color="#777474" size="5">地图管理</font></li>
               <li><span class="glyphicon glyphicon-asterisk" style="font-size: 23px;"><a style="text-decoration:none;" href="equip" target="right"></span><font color="#777474" size="5">设备管理</font></a></li>
           </ul>
        </div>
        <li><div id="libox"><span class="glyphicon glyphicon-stats" style="font-size: 23px;"></span><a style="text-decoration:none;" href="index?minute=6000" target="right"><font color="#777474" size="5">百度地图数据展示</font></a></div></li>
        <li><div id="libox"><span class="glyphicon glyphicon-stats" style="font-size: 23px;"></span><font color="#777474" size="5">Echart地图实时展示</font></div></li>
      </ul>
  </body>
</html>