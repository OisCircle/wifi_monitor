<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//
List<Info>infos=(List<Info>)request.getAttribute("infos");
List<Seeker> seekers =(List<Seeker>)request.getAttribute("seekers");
//每个seeker对应的信息，下标与 seekers 一一对应
List<List<Info>> listInfos=(List<List<Info>>)request.getAttribute("listInfos");
//每个info应该处在的坐标
List<Map<String,Double>>coordinates=(List<Map<String,Double>>)request.getAttribute("coordinates");

int seeker_id=(int)request.getAttribute("seeker_id");
//svg config
//相对坐标中心点
double x0=(double)350;
double y0=(double)400;
int r=350;
int pr=2;

%>
<!DOCTYPE HTML>
<html>
	<script type="text/javascript">
		function showInfo(mac,rssi,time){
			document.getElementById("mac").textContent=mac;
			document.getElementById("rssi").textContent=rssi;
			document.getElementById("time").textContent=time;
		}
		function searchMac(mac){
			window.location="/path"+"?mac="+mac+"&minute=9999999";
		}
		function highLightRow(row){
			alert("into highLightRow()");
		}
	</script>
	<head>
	<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<title>main page</title>
		<style type="text/css">
			table tbody {
				display: block;
				height: 195px;
				overflow-y: scroll;
			}
			table thead, tbody tr {
				display: table;
				width: 100%;
				table-layout: fixed;
			}
			table thead {
				width: calc(100% - 1em)
			}
			table thead th {
				background: #ccc;
			}
			#circle{
				width:800px;
				height:800px;
				float:left;
			}
			#info{
				width:400px;
				height:800px;
				float:left;
			}
			#box{
			    width:250px;
			    height:200px;
			    border:2px solid #6C6D69;
			    border-radius:4px; 
			}
			 #selecttra{
		        position:absolute;
		        left:23%;
		        top:86px;
		        z-index:2000;
		        display:none;
		        width:23%;
		        height:200px;
		        text-align: center;
		        opacity: 0.6;
		        background:white;
		        border-radius:5px;    
		    }
		    #selectlink{
		        position:absolute;
		        left:46%;
		        top:86px;
		        z-index:2000;
		        display:none;
		        width:23%;
		        height:200px;
		        text-align: center;
		        opacity: 0.6;
		        background:white;
		        border-radius:5px;    
		    }
		    #selecttime{
		        position:absolute;
		        left:69%;
		        top:86px;
		        z-index:2000;
		        display:none;
		        width:23%;
		        height:200px;
		        text-align: center;
		        opacity: 0.6;
		        background:white;
		        border-radius:5px;     
		    }
		    #other{
		    	margin-top: 30px;
		    	width:23%;
		    	height:40px;
		    	padding-top:15px;
		    	text-align: center;
		    	border:0px;
		    	float: left; 
		    }
		    #now{
		    	margin-top: 30px;
		    	width:23%;
		    	height:40px;
		    	padding-top:15px; 
		    	text-align: center;
		    	background-image:url(shade.png);
		    	background-repeat :no-repeat ;
		    	background-color : transparent;  
		    	float:left;
		    }
		    span{
		       cursor:pointer;
		    }
		    a{
			  text-decoration:none;
			}
		</style>
		<script type="text/javascript">
			function playtra(){
		        var a = document.getElementById("selecttra");
		        if(a.style.display=="block") a.style.display = "none";
		        else a.style.display = "block";
		    }
		    function playlink(){
		        var a = document.getElementById("selectlink");
		        if(a.style.display=="block") a.style.display = "none";
		        else a.style.display = "block";
		    }
		    function playtime(){
		        var a = document.getElementById("selecttime");
		        if(a.style.display=="block") a.style.display = "none";
		        else a.style.display = "block";
		    }
		    
		    function selected(a){
		        //下拉选项显示后，给”item“添加点击事件：点击隐藏下拉列表
		        var b = document.getElementById("menu");
		        b.style.display = "none";
		        //讲选中项的值放到“sel“里显示
		        var txt = a.innerText;
		        document.getElementById("sel").innerText = txt;
		    }
		    function pathfly(mac){
		         window.location="/path"+"?mac="+mac+"&minute=9999999";
		    }
		    function linkpathfly(mac){
		         window.location="/linkpath"+"?mac="+mac+"&minute=9999999";
		    }
		    function timefly(time){
		         window.location="/index?minute="+time;
		    }
	</script>
	</head>
	<body>
	<div id="tittlebox">
  <div id="now" class="panel panel-success"><a href="index?minute=6000" target="right"><font color="gray" size="5" >人群观测</font></a></div>
  <div id="other" class="panel panel-info" onclick="playtra()"><font color="blue" size="5" >轨迹跟踪</font></div>
  <div id="selecttra"><%int m=0;
  for(int i=0;i<seekers.size();i++){ 
       if(m>=9) break;
          for(int j=0;j<listInfos.get(i).size();j++){
               m++;
               if(m>=9) break;%>
           <span value="<%=listInfos.get(i).get(j).getMac() %>" onclick="pathfly(this.value)"><%=listInfos.get(i).get(j).getMac() %></span><br>
    <% } }%></div>
  <div id="other" class="panel panel-info" onclick="playlink()"><font color="blue" size="5" >折线路径</font></div>
  <div id="selectlink"><%int c=0;
  for(int i=0;i<seekers.size();i++){ 
       if(c>=9) break;
          for(int j=0;j<listInfos.get(i).size();j++){
               c++;
               if(c>=9) break;%>
           <span value="<%=listInfos.get(i).get(j).getMac() %>" onclick="linkpathfly(this.value)"><%=listInfos.get(i).get(j).getMac() %></span><br>
    <% } }%></div>
  <div id="other" class="panel panel-info" onclick="playtime()"><font color="blue" size="5" >时间选取</font></div>
  <div id="selecttime">
          <span  onclick="timefly(60);" >1小时内</span><br>
          <span  onclick="timefly(120);" >2小时内</span><br>
          <span  onclick="timefly(240);" >4小时内</span><br>
          <span  onclick="timefly(9999999);" >所有</span><br>
  </div></div>
	<div>
		<div id="circle">
		<svg width=800 height=800 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<!-- 初始化背景圆 -->
			<%for(int i=90;i>=0;i-=10,r-=39){%>
				<%Double stroke_width=(double)0.5;if(r%2==1) stroke_width=(double)0; %>
				<circle cx=<%=x0%> cy=<%=y0%> r=<%=r%> stroke="black" stroke-width="<%=stroke_width %>" fill="<%= "#D8FF"+String.valueOf(i) %>" />
				<%if(r%2==0){ %>
					<text x=<%=x0+r %> y=<%=y0 %> fill="red"><%=String.valueOf((int)(((double)r)/((double)350/(double)130))*-1) %></text>
				
				<%} %>
			<%} %>
			<%for(int i=0;i<coordinates.size();++i){ 
				//每个time进行时间判断，分配颜色
				Date now =new Date();
				String fillColor;
				//秒数
				long timeGap=(now.getTime()-infos.get(i).getTime().getTime())/1000;
				if(timeGap<=3600)
					fillColor="red";
				else if(timeGap<=7200)
					fillColor="orange";
				else if(timeGap<=10800)
					fillColor="yellow";
				else
					fillColor="black";
			%>
				<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				  <rect 
					onmouseover="showInfo('<%=infos.get(i).getMac() %>',<%=infos.get(i).getRssi() %>,'<%=infos.get(i).getTime().toLocaleString() %>')"
				  onclick="searchMac('<%=infos.get(i).getMac() %>')"
				  id=<%="rect"+i %> x=<%=x0+(Double)coordinates.get(i).get("x") %> y=<%=y0+(Double)coordinates.get(i).get("y") %> width="10" height="10" style="fill:<%=fillColor %>;stroke:pink;stroke-width:0;opacity:0.5" />
				</svg>
			<%} %>
			<circle cx=<%=x0%> cy=<%=y0%> r=<%=pr%> stroke="#8A2BE2" stroke-width="0" fill="#8A2BE2" />
		</svg>
		</div>
		
		<div id="info">
			<table id="macTable" width="100%" border="1">
			<thead>
				<tr>
					<th>Seeker ID:<%= seeker_id%></th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<infos.size();++i) {%>
					<tr>
						<td id=<%= "mac"+i %> align="center" onclick="searchMac('<%=infos.get(i).getMac() %>')"><%=infos.get(i).getMac()%></td>
					</tr>
				<%}%>
			</tbody>
			</table>
			<br><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			 <rect  width="10" height="10" style="fill:red;stroke:pink;stroke-width:0;opacity:0.5" /></svg>1个小时内
			</h4><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:orange;stroke:pink;stroke-width:0;opacity:0.5" /></svg>1-2个小时内
			</h4><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:yellow;stroke:pink;stroke-width:0;opacity:0.5" /></svg>2-4个小时内
			</h4><h4>
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:black;stroke:pink;stroke-width:0;opacity:0.5" /></svg>4小时外
			</h4>
			
			<form action="/path" method="get">
				<h3>
				针对MAC搜索:&nbsp&nbsp<input type="text" name="mac"/>
				<input type="submit" value="搜索">
				</h3>
			</form>
			<div id="box">
				<h2 id="mac" style="margin-left:20px"></h2>
				<h2 id="rssi" style="margin-left:20px"></h2>
				<h2 id="time" style="margin-left:20px"></h2>
			</div>
		  </div>
		</div>
</body>

</html>