<%@ page language="java" import="java.util.*,com.qcq.wifi_monitor.entity.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

List<Info>infos=(List<Info>)request.getAttribute("infos");
List<Map<String,Double>>coordinates=(List<Map<String,Double>>)request.getAttribute("coordinates");
//svg config
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
			window.location="/ssm_test/search"+"?mac="+mac
		
		
		
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
		</style>
	</head>
	<body>
		<h2 align="center">Latest Signals</h2>
		<table width="100%" border="1">
			<thead>
				<tr>
					<th>MAC</th>
					<th>RSSI</th>
					<th>TIME</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=0;i<infos.size();++i) {%>
					<tr>
						<td id=<%= "mac"+i %>><%= infos.get(i).getMac()%></td>
						<td id=<%= "rssi"+i %>><%= infos.get(i).getRssi()%></td>
						<td id=<%= "time"+i %>><%= infos.get(i).getTime().toLocaleString()%></td>
					</tr>
				<%}%>
			</tbody>
		</table>
		<br>
		<form action="/ssm_test/search">
			<h3>mac:&nbsp&nbsp<input type="text" name="mac">&nbsp&nbsp<input type="submit" value="search"></h3>
		</form>
		<div id="circle">
		<svg width=800 height=800 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<%for(int i=90;i>=0;i-=10,r-=39){ %>
				<%Double stroke_width=(double)0.5;if(r%2==1) stroke_width=(double)0; %>
				<circle cx=<%=x0%> cy=<%=y0%> r=<%=r%> stroke="black" stroke-width="<%=stroke_width %>" fill="<%= "#D8FF"+String.valueOf(i) %>" />
				<%if(r%2==0){ %>
					<text x=<%=x0+r %> y=<%=y0 %> fill="red"><%=String.valueOf((int)(((double)r)/((double)350/(double)130))*-1) %></text>
				
				<%} %>
			<%} %>
			<%for(int i=0;i<coordinates.size();++i){ %>
				<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				  <rect onmouseover="showInfo('<%=infos.get(i).getMac() %>',<%=infos.get(i).getRssi() %>,'<%=infos.get(i).getTime().toLocaleString() %>')"
				  onclick="searchMac('<%=infos.get(i).getMac() %>')"
				  id=<%="rect"+i %> x=<%=x0+(Double)coordinates.get(i).get("x") %> y=<%=y0+(Double)coordinates.get(i).get("y") %> width="10" height="10" style="fill:blue;stroke:pink;stroke-width:0;opacity:0.5" />
				</svg>
			<%} %>
			<circle cx=<%=x0%> cy=<%=y0%> r=<%=pr%> stroke="#8A2BE2" stroke-width="0" fill="#8A2BE2" />
		</svg>
		</div>
		
		<div id="info">
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<h2 id="mac"></h2>
			<h2 id="rssi"></h2>
			<h2 id="time"></h2>
		</div>
</body>

</html>