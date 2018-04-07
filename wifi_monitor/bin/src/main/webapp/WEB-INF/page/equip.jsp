<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>equip</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css"> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
    var nowrows=0;
    var rowslength;
	function sendAjax(row){
	   		var jsonequip=[];
	   		$.ajax({
	   			type:"post",
	   			url:"/seekerSelectAll",
	   			data:{},
	   			success:function(data){
	 				jsonequip=data;
	 				rowslength=jsonequip.length;
	 				var root = document.getElementById("tbody");
	 				var nowRows = root.getElementsByTagName('tr');
	 				for(var i=row;i<=row+10&&i<jsonequip.length;i++){
                    var nowCells = nowRows[i].getElementsByTagName('td');
                    nowCells[0].innerHTML=i+1;
                    nowCells[1].innerHTML=jsonequip[i].id;
                    nowCells[2].innerHTML=jsonequip[i].location;
                    var oSpan=document.createElement("span");
                    var Text=document.createTextNode("编辑");
                    oSpan.setAttribute("class","glyphicon glyphicon-tasks");
                    oSpan.setAttribute("style","font-size: 23px;");
                    nowCells[3].appendChild(oSpan);
                    nowCells[3].appendChild(Text);
                    var oCheckbox=document.createElement("input");
                    var myText=document.createTextNode("禁用");
                    oCheckbox.setAttribute("type","checkbox");
                    oCheckbox.setAttribute("value",jsonequip[i].id);
                    if(jsonequip[i].isForbidden==1) oCheckbox.setAttribute("checked","ture");
                    oCheckbox.setAttribute("onclick","boxcheck(this.value,this.checked)");
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
	             sendAjax(nowrows);
	        }    
	   }
	   function nextpage(){
	        if((rowslength-nowrows)<=10) alert("已是尾页！");
	        else {nowrows+=10;
	             sendAjax(nowrows);
	        }    
	   }
	   function boxcheck(value,checked){
	       alert("ok!");
	       alert(value);
	       alert(checked);
	   }
	   sendAjax(0);
</script>
  </head>
  
  <body>
    <table class="table table-bordered">
	<caption>设备管理</caption>
   <thead>
      <tr class="active">
         <th>序号</th>
         <th>设备ID</th>
         <th>设备别名</th>
         <th>设备编辑</th>
         <th>是否禁用</th>
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
</table>
    <input style="margin-left:23%;" type="button" onclick="lastpage();"value="上一页"></input>
    <input style="margin-left:50%;" type="button" onclick="nextpage();"value="下一页"></input>
  </body>
</html>
