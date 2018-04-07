<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>map</title>
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
<script type="text/javascript">
  var nowrows=0;
    var rowslength;
	function sendmap(row){
	   		var jsonmap=[];
	   		$.ajax({
	   			type:"post",
	   			url:"/zoneSelectAll",
	   			data:{},
	   			success:function(data){
	 				jsonmap=data;
	 				rowslength=jsonmap.length;
	 				var root = document.getElementById("tbody");
	 				var nowRows = root.getElementsByTagName('tr');
	 				for(var i=row;i<=row+10&&i<jsonmap.length;i++){
                    var nowCells = nowRows[i].getElementsByTagName('td');
                    nowCells[0].innerHTML=jsonmap[i].id;
                    nowCells[1].innerHTML=jsonmap[i].name;
                    nowCells[2].innerHTML=jsonmap[i].description;
                    var oSpan=document.createElement("span");
                    var Text=document.createTextNode("编辑");
                    oSpan.setAttribute("class","glyphicon glyphicon-tasks");
                    oSpan.setAttribute("style","font-size: 23px;");
                    nowCells[3].appendChild(oSpan);
                    nowCells[3].appendChild(Text);
                    var oCheckbox=document.createElement("input");
                    var myText=document.createTextNode("选用");
                    if(<%= session.getAttribute("selectedId") %>==jsonmap[i].id)
                    oCheckbox.setAttribute("checked","ture");
                    oCheckbox.setAttribute("type","radio");
                    oCheckbox.setAttribute("name","mapcheck");
                    oCheckbox.setAttribute("id",jsonmap[i].id);
                    oCheckbox.setAttribute("onclick","boxcheck(this.id,this.checked)");
                    nowCells[4].appendChild(oCheckbox);
                    nowCells[4].appendChild(myText);
                    }
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
	   		
	   };
	   function lastpage(){
	        if(nowrows==0) alert("已是顶页！");
	        else {nowrows-=10;
	             sendmap(nowrows);
	        }    
	   }
	   function nextpage(){
	        if((rowslength-nowrows)<=10) alert("已是尾页！");
	        else {nowrows+=10;
	             sendmap(nowrows);
	        }    
	   }
	   function boxcheck(id,checked){
	       var params = {};
		   params.selectedId = id;
	       $.ajax({
	            url:"/sessionAttributeSetting",
	            type:"Post",
	            data:params,
	            success:function(resp){
	                alert("success");
	                alert(resp);
	            },
	            error:function(jqXHR,textstatus){
	                alert(textstatus);
	            }
	        });
	   }
	   sendmap(0);
</script>
  </head>
  <body>
  	<%= session.getAttribute("selectedId") %>
     <table class="table table-bordered">
	<caption>地图管理</caption>
   <thead>
      <tr class="active">
         <th>地图序号</th>
         <th>地图名称</th>
         <th>地图说明</th>
         <th>地图编辑</th>
         <th>地图选取</th>
      </tr>
   </thead>
   <tbody id="tbody">
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
   </tbody>
   <div id="edit">
   </div>
</table>
    <input style="margin-left:23%;" type="button" onclick="lastpage();"value="上一页"></input>
    <input style="margin-left:22%;" type="button" onclick="nextpage();"value="下一页"></input>
    <input style="margin-left:10%;" type="button" onclick=""value="增加"></input>
    <input style="margin-left:5%;" type="button" onclick=""value="删除"></input>
  </body>
</html>
