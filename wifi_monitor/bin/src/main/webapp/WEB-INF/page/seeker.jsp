<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.Info" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//
List<Info>infos=(List<Info>)request.getAttribute("infos");
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
			window.location="/path"+"?mac="+mac
		}
		function highLightRow(row){
			alert("into highLightRow()");
			
			
			
		}
		function latestHour(){
			var id=<%= seeker_id%>
			var hour=document.getElementById("hourSelect").value;
			window.location="/latestMinute?id="+id+"&minute="+hour*60
		}
		function latestMinute(){
			var id=<%= seeker_id%>
			var minute=document.getElementById("minuteSelect").value;
  			window.location="/latestMinute?id="+id+"&minute="+minute
		}
	</script>
	<head>
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
		</style>
	</head>
	<body>
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
			<h3>细化搜索探针嗅探到的信号</h3>
			<h4>
			&nbsp&nbsp&nbsp&nbsp针对小时段搜索
			<select id="hourSelect">
				<option value="1">1小时</option>
				<option value="2">2小时</option>
				<option value="3">3小时</option>
				<option value="5">5小时</option>
				<option value="12">12小时</option>
				<option value="24">24小时</option>
			</select>
			<button onclick="latestHour()">搜索</button>
			</h4>
			<h4>
			&nbsp&nbsp&nbsp&nbsp针对分钟段搜索
			<select id="minuteSelect">
				<option value="1">1分钟</option>
				<option value="2">2分钟</option>
				<option value="5">5分钟</option>
				<option value="10">10分钟</option>
				<option value="15">15分钟</option>
				<option value="30">30分钟</option>
				<option value="45">45分钟</option>
			</select>
			<button onclick="latestMinute()">搜索</button>
			</h4>
			<div id="box">
				<h2 id="mac" style="margin-left:20px"></h2>
				<h2 id="rssi" style="margin-left:20px"></h2>
				<h2 id="time" style="margin-left:20px"></h2>
			</div>
		</div>
</body>

</html>