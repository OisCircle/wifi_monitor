<%@ page  language="java"  import="java.util.*"  pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">

    <head>
        <meta charset="utf-8">
     
        <link href="css/bootstrap.min.css" rel="stylesheet">
		<link rel='stylesheet' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
		<link rel='stylesheet' href='css/style.css'>
		<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
		<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>   
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
            <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
            <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
        *{/*清空网页默认设置*/
            margin:0;
            padding:0;
       }
        #sidebar-wrapper{
            width: 100%;
            height:100%;
            background-color:#5D5A5A;
        }
        .nav{
            font-size:23px;
            border-left:4px solid #4B528B;  
        }
        #menubox{
            display:none; 
        }
        a{
            color: white;
        }
        a:focus {  
          outline:none;  
          -moz-outline:none;  
        } 
        .dropdown-menu{
            width:100%;
            height:200px; 
        }
        .secondnav{
            border-left:0px solid white; 
            background-color:#A5A0A0; 
        }
        </style>
        <script type="text/javascript">
            function openmenu(){
                var a=document.getElementById("menubox");
                if(a.style.display=="block") a.style.display="none";
                else {a.style.display="block"}
            }
            function closemenu(){
                document.getElementById("menubox").style.display="none";
            }
        </script>
    </head>

    <body >
     <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
      <ul  class="nav sidebar-nav">
          <li >
              <a class="my" style="text-decoration:none;" href="introduction" target="right"><i onclick="closemenu()"><span class="glyphicon glyphicon-list-alt" style="font-size: 23px;"></span> 系统介绍</i></a>
          </li>
          <li>
            <a class="my">
                <i onclick="openmenu()"><span class="glyphicon glyphicon-cog" style="font-size: 23px;"></span>系统管理 </i>
            </a>
            <div id="menubox">
                <ul class="nav secondnav">
                  <li><a class="my" style="text-decoration:none;" href="map" target="right"><i>&nbsp;&nbsp;<span class="glyphicon glyphicon-globe" style="font-size: 23px;"></span>地图管理</i></a></li>
                  <li><a class="my" style="text-decoration:none;" href="equip" target="right"><i>&nbsp;&nbsp;<span class="glyphicon glyphicon-asterisk" style="font-size: 23px;"></span>设备管理</i></a></li>
                </ul>
            <div>
          </li>
          <li>
              <a class="my" style="text-decoration:none;" href="index" target="right"><i onclick="closemenu()"><span class="glyphicon glyphicon-stats" style="font-size: 23px;"></span> 百度地图数据展示 </i></a>
          </li>
          <li>
              <a class="my" style="text-decoration:none;" href="indoor" target="right"><i onclick="closemenu()"><span class="glyphicon glyphicon-stats" style="font-size: 23px;"></span> 室内地图实时展示 </i></a>
          </li>
      </ul>
</nav>
</body>
</html>