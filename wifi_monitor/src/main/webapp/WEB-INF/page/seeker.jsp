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
   <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function search(mac,rssi,time){
		  document.getElementById("mac").textContent=mac;
		  document.getElementById("rssi").textContent=rssi;
		  document.getElementById("time").textContent=time;
		}
		function searchMac(macId,mac,rssi,time){
		  var rect="rect"+macId;
		  document.getElementById(rect.toString()).style.fill="#F70512";
		  document.getElementById("mac").textContent=mac;
		  document.getElementById("rssi").textContent=rssi;
		  document.getElementById("time").textContent=time;
		}
		function searchOut(macId,time){
		  var rect="rect"+macId;
		  if(time<=3600)
					document.getElementById(rect.toString()).style.fill="#B7CEE5";
				else if(time<=7200)
					document.getElementById(rect.toString()).style.fill="#C1B7E8";
				else if(time<=10800)
					document.getElementById(rect.toString()).style.fill="#71D39D";
				else
					document.getElementById(rect.toString()).style.fill="black";
		  document.getElementById("mac").textContent="";
		  document.getElementById("rssi").textContent="";
		  document.getElementById("time").textContent="";
		}
		function highLightRow(row){
			alert("into highLightRow()");
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
				cursor:pointer;
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
				margin-top:20px;
				float:left;
			}
			#box{
			    position:absolute;
			    left:600px;
			    top:680px;
			    width:250px;
			    height:200px;
			    border:2px solid #6C6D69;
			    border-radius:4px; 
			    float:left;
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
		    #cricletittle{
		        position:absolute;
		        top:90px;
		        left:10px;
		        float:left;
		    }
		    span{
		       cursor:pointer;
		    }
		    a{
			  text-decoration:none;
			  out-line: none;
			  color: #*****;
			}
			a:hover{
			  text-decoration:none;
			}
			#tittlebox{
			   width:100%;
			   height:87px;
			   background-color:#F8F8F8;
		       cursor:pointer;
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
		    function pathfly(mac){
	           var params = {};
			   params.mac = mac;
		     $.ajax({
			   			type:"post",
			   			url:"/pathCount",
			   			data:params,
			   			success:function(data){
			   			    var longth=data;
			   			    if(longth==0){
			   			        alert("该MAC无路径！");
			   			    }else{
			   			        window.location="/path"+"?mac="+mac; 
			   			    }         
			   			},
			   			error:function(){
			   				alert("error...");
			   			}
			   		});
		    }
		    function path(){
	           var params = {};
	           var mac = document.getElementById("searchmac").value;
			   params.mac = mac;
		     $.ajax({
			   			type:"post",
			   			url:"/pathCount",
			   			data:params,
			   			success:function(data){
			   			    var longth=data;
			   			    if(longth==0){
			   			        alert("该MAC无路径！");
			   			    }else{
			   			        window.location="/path"+"?mac="+mac; 
			   			    }         
			   			},
			   			error:function(){
			   				alert("error...");
			   			}
			   		});
		    }
		    function linkpathfly(mac){
		                var params = {};
				        params.mac = mac; 
		                $.ajax({
					   			type:"post",
					   			url:"/pathCount",
					   			data:params,
					   			success:function(data){
					   			    var longth=data;
					   			    if(longth==0){
					   			        alert("该MAC无路径！");
					   			    }else{
					   			        window.location="/linkPath?mac="+mac;
					   			    }         
					   			},
					   			error:function(){
					   				alert("error...");
					   			}
					   		});
		    }
		    function timefly(time) {
                var params = {};
                params.minute = time;
                $.ajax({
                    url: "/setMinute",
                    type: "Post",
                    data: params,
                    success: function (resp) {
                        location.reload();
                    },
                    error: function (jqXHR, textstatus) {
                        alert(textstatus);
                    }
                });
            }
            function therssi(id,rssi){
                var params = {};
                params.id = id;
                params.rssi = rssi;
                $.ajax({
                    url:"/seeker_count",
                    type:"Post",
                    data:params,
                    success:function(data){
                        var rssilength=data;
                        if(rssilength==0){
                            alert("该强度无信号！");
                        }else{
                            window.location="/seeker?id="+id+"&rssi="+rssi;
                        }
                    },
                    error:function(jqXHR,textstatus){
                        alert(textstatus);
                    }
                });
            }
	</script>
	</head>
	<body>
	<div id="tittlebox">
  <div id="now" ><a href="index?minute=6000" target="right"><font color="#23527C" size="5" >人群观测</font></a></div>
  <div id="other"  onclick="playtra()"><font color="gray" size="5" >轨迹跟踪</font></div>
  <div id="selecttra"><%int m=0;
  for(int i=0;i<seekers.size();i++){ 
       if(m>=9) break;
          for(int j=0;j<listInfos.get(i).size();j++){
               m++;
               if(m>=9) break;%>
           <span id="<%=listInfos.get(i).get(j).getMac() %>" onclick="pathfly(this.id)"><%=listInfos.get(i).get(j).getMac() %></span><br>
    <% } }%></div>
  <div id="other"  onclick="playlink()"><font color="gray" size="5" >折线路径</font></div>
  <div id="selectlink"><%int c=0;
  for(int i=0;i<seekers.size();i++){ 
       if(c>=9) break;
          for(int j=0;j<listInfos.get(i).size();j++){
               c++;
               if(c>=9) break;%>
           <span id="<%=listInfos.get(i).get(j).getMac() %>" onclick="linkpathfly(this.id)"><%=listInfos.get(i).get(j).getMac() %></span><br>
    <% } }%></div>
  <div id="other" onclick="playtime()"><font color="gray" size="5" >时间选取</font></div>
  <div id="selecttime">
          <span  onclick="timefly(5)" >最近五分钟</span><br>
          <span  onclick="timefly(60)" >最近一小时</span><br>
          <span  onclick="timefly(1440)" >最近一天</span><br>
          <span  onclick="timefly(4320)" >最近三天</span><br>
          <span  onclick="timefly(525600)" >所有</span><br>
  </div></div>
	  <div id="cricletittle">
	      <h4>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			 <rect  width="10" height="10" style="fill:#B7CEE5;stroke:pink;stroke-width:0;opacity:0.5" /></svg>1个小时内&nbsp;&nbsp;&nbsp;&nbsp;	
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:#C1B7E8;stroke:pink;stroke-width:0;opacity:0.5" /></svg>1-2个小时内&nbsp;&nbsp;&nbsp;&nbsp;
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:#71D39D;stroke:pink;stroke-width:0;opacity:0.5" /></svg>2-4个小时内&nbsp;&nbsp;&nbsp;&nbsp;
			<svg width=10 height=10 xmlns="http://www.w3.org/2000/svg" version="1.1">
			<rect  width="10" height="10" style="fill:black;stroke:pink;stroke-width:0;opacity:0.5" /></svg>4小时外&nbsp;&nbsp;&nbsp;&nbsp;
		
	  <div  class="dropdown">
			<button type="button" class="btn dropdown-toggle" id="dropdownMenu1" 
					data-toggle="dropdown">
				       信号强度
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				<li role="presentation">
					<a role="menuitem" tabindex="-1" onclick="therssi('<%=seeker_id%>',-14)">14</a>
				</li>
				<li role="presentation">
					<a role="menuitem" tabindex="-1" onclick="therssi('<%=seeker_id%>',-43)">43</a>
				</li>
                <li role="presentation">
                    <a role="menuitem" tabindex="-1" onclick="therssi('<%=seeker_id%>',-72)">72</a>
				</li>
				<li role="presentation">
					<a role="menuitem" tabindex="-1" onclick="therssi('<%=seeker_id%>',-101)">101</a>
				</li>
				<li role="presentation">
					<a role="menuitem" tabindex="-1" onclick="therssi('<%=seeker_id%>',-130)">130</a>
				</li>
			</ul>
		</div>
		</h4>
	  </div>
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
					fillColor="#B7CEE5";
				else if(timeGap<=7200)
					fillColor="#C1B7E8";
				else if(timeGap<=10800)
					fillColor="#71D39D";
				else
					fillColor="black";
			%>
				<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				  <rect onclick="pathfly('<%=infos.get(i).getMac() %>')" onmouseover="search(<%=infos.get(i).getId() %>,'<%=infos.get(i).getMac() %>',<%=infos.get(i).getRssi() %>,'<%=infos.get(i).getTime().toLocaleString() %>')"
					    id="rect<%=infos.get(i).getId()%>" x=<%=x0+(Double)coordinates.get(i).get("x") %> y=<%=y0+(Double)coordinates.get(i).get("y") %> width="10" height="10" style="fill:<%=fillColor %>;stroke:pink;stroke-width:0;opacity:0.5" />
		       </svg>
			<%} %>
			<circle cx=<%=x0%> cy=<%=y0%> r=<%=pr%> stroke="#8A2BE2" stroke-width="0" fill="#8A2BE2" />
		</svg>
		<script type="text/javascript">
		</script>
		</div>
		<div id="box">
				<h3 id="mac" style="margin-left:20px"></h3>
				<h3 id="rssi" style="margin-left:20px"></h3>
				<h3 id="time" style="margin-left:20px"></h3>
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
					   <%  Date now =new Date();
					   long TimeGap=(now.getTime()-infos.get(i).getTime().getTime())/1000; %>
						<td id=<%= "mac"+i %> align="center" onmouseover="searchMac(<%=infos.get(i).getId() %>,'<%=infos.get(i).getMac() %>',<%=infos.get(i).getRssi() %>,'<%=infos.get(i).getTime().toLocaleString() %>')" 
						 onclick="pathfly('<%=infos.get(i).getMac() %>')"
						onmouseout="searchOut('<%=infos.get(i).getId() %>','<%=TimeGap%>')"
						><%=infos.get(i).getMac()%></td>
					</tr>
				<%}%>
			</tbody>
			</table>
			
				<h4>
				针对MAC搜索:&nbsp&nbsp<input id="searchmac" type="text"  value="<%= infos.get(0).getMac() %>"/>
				<input type="button" onclick="path();" value="搜索轨迹">
               </h4>
           </div>
		</div>
</body>

</html>