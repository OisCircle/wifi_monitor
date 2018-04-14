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
    var jsonmap=[];
	function sendmap(row){
	   		$.ajax({
	   			type:"post",
	   			url:"/zoneSelectAll",
	   			data:{},
	   			success:function(data){
	 				jsonmap=data;
	 				rowslength=jsonmap.length;
	 				var root = document.getElementById("tbody");
	 				var nowRows = root.getElementsByTagName('tr');
	 				for(var m=0;m<10;m++){
	                    var clearCells = nowRows[m].getElementsByTagName('td');
		                clearCells[0].innerHTML="";
		                clearCells[1].innerHTML="";
		                clearCells[2].innerHTML="";
		                clearCells[3].innerHTML="";
		                clearCells[4].innerHTML="";
		            }
	 				for(var i=row;i<row+10&&i<jsonmap.length;i++){
	                    var nowCells = nowRows[i-row].getElementsByTagName('td');
	                    nowCells[0].innerHTML=i+1;
	                    nowCells[1].innerHTML=jsonmap[i].name;
	                    nowCells[2].innerHTML=jsonmap[i].description;
	                    var oSpan=document.createElement("span");
	                    var Text=document.createTextNode("编辑");
	                    oSpan.setAttribute("id",i);
	                    oSpan.setAttribute("class","glyphicon glyphicon-tasks");
	                    oSpan.setAttribute("style","font-size: 23px;");
	                    oSpan.setAttribute("onclick","openPop(this.id)");
	                    nowCells[3].innerHTML="";
	                    nowCells[3].appendChild(oSpan);
	                    nowCells[3].appendChild(Text);
	                    var oCheckbox=document.createElement("input");
	                    var myText=document.createTextNode("选用");
	                    var delectspan=document.createElement("span");
	                    var delectbox=document.createElement("div");
	                    if(<%= session.getAttribute("selectedId") %>==jsonmap[i].id)
	                    oCheckbox.setAttribute("checked","ture");
	                    oCheckbox.setAttribute("type","radio");
	                    oCheckbox.setAttribute("name","mapcheck");
	                    oCheckbox.setAttribute("value",jsonmap[i].id);
	                    oCheckbox.setAttribute("onclick","boxcheck(this.value,this.checked)");
	                    delectbox.setAttribute("id","delect"+i)
	                    delectbox.setAttribute("style", "margin-left:10px;display:none;");
	                    delectspan.setAttribute("id", jsonmap[i].id);
	                    delectspan.setAttribute("class", "glyphicon glyphicon-remove");
	                    delectspan.setAttribute("style", "color:red;")
	                    delectspan.setAttribute("onclick", "delect(this.id)");
	                    delectbox.appendChild(delectspan);
	                    nowCells[4].innerHTML="";
	                    nowCells[4].appendChild(oCheckbox);
	                    nowCells[4].appendChild(myText);
	                    nowCells[4].appendChild(delectbox);
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
	   function openDelect(){
	            for(var i=nowrows;i<=nowrows+10&&i<jsonmap.length;i++){
	                var thisid="delect"+i;  
	                if(document.getElementById(thisid.toString()).style.display=="block"){
	                      document.getElementById(thisid.toString()).style.display="none";
	                }else{
	                      document.getElementById(thisid.toString()).style.display="block"
	                }
	            }
	   }
	   function openPop(id){
	          document.getElementById("mapId").value=jsonmap[id].id;
		 	  document.getElementById("mapName").value=jsonmap[id].name;
		 	  document.getElementById("map_X").value=jsonmap[id].x;
		 	  document.getElementById("map_Y").value=jsonmap[id].y;
		 	  document.getElementById("description").value=jsonmap[id].description;
		 	  document.getElementById("Pop").style.display="block";
	   }
	   function openAddPop(){
		 	  document.getElementById("AddPop").style.display="block";
	   }
	   function judgment(){
	       for(var i=0;i<jsonmap.length;i++){
	          if(jsonmap[i].id==document.getElementById("mapId").value) continue;
	          else if(document.getElementById("mapName").value==jsonmap[i].name){
	                return 1;
	             } 
	          }
	          return 0;
	   }
	   function review(){
	       for(var i=0;i<jsonmap.length;i++){
	          if(document.getElementById("AddmapName").value==jsonmap[i].name){
	                return 1;
	            } 
	          }
	          return 0;
	   }
	   function changeMap(){
	          if(judgment()){
	               alert("名称重复，请修改！");
	          }else{
			       var params = {};
		           params.id = document.getElementById("mapId").value;
		           params.name = document.getElementById("mapName").value;
		           params.description = document.getElementById("description").value;
		           params.x = document.getElementById("map_X").value;
		           params.y = document.getElementById("map_Y").value;
			       $.ajax({
			            url:"/zoneUpdate",
			            type:"Post",
			            data:params,
			            success:function(resp){
			                alert("success");
			                alert(resp);
			                sendmap(nowrows);
			                document.getElementById("Pop").style.display="none";
			            },
			            error:function(jqXHR,textstatus){
			                alert(textstatus);
			            }
			        }); 
	          }
	   }
	   function AddMap(){
	          if(review()){
	               alert("名称重复，请修改！");
	          }else{
			       var params = {};
		           params.name = document.getElementById("AddmapName").value;
		           params.description = document.getElementById("Adddescription").value;
		           params.x = document.getElementById("Addmap_X").value;
		           params.y = document.getElementById("Addmap_Y").value;
			       $.ajax({
			            url:"/zoneAdd",
			            type:"Post",
			            data:params,
			            success:function(resp){
			                alert("success");
			                alert(resp);
			                sendmap(nowrows);
			                document.getElementById("AddPop").style.display="none";
			            },
			            error:function(jqXHR,textstatus){
			                alert(textstatus);
			            }
			        }); 
	          }
	   }
	   function nonePop(){
	          document.getElementById("Pop").style.display="none";
	   }
	   function noneAddPop(){
	          document.getElementById("AddPop").style.display="none";
	   }
	   function delect(id){
	       alert(id);
	       var params = {};
		   params.id = id;
	       $.ajax({
	            url:"/zoneDelete",
	            type:"Post",
	            data:params,
	            success:function(resp){
	                alert("success");
	                alert(resp);
	                for(var i=nowrows;i<=nowrows+10&&i<jsonmap.length;i++){
	                   var thisid="delect"+i;  
	                  document.getElementById(thisid.toString()).style.display="none";
	                 }
	                sendmap(nowrows);
	            },
	            error:function(jqXHR,textstatus){
	                alert(textstatus);
	            }
	        });
	        
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
<style type="text/css">
     html,body{
    	margin:0;
    	padding:0;
    }
    #Pop{
        position:absolute;
        margin-left:30%;
        margin-top:5%;
        z-index:10000;
        display:none;
        width:700px;
        height:400px;
        background-color:#E8F2FE;
        opacity:0.9;
        border:1px solid #9DAFC6;
        border-radius:4px;
    }
    #AddPop{
        position:absolute;
        margin-left:30%;
        margin-top:5%;
        z-index:10000;
        display:none;
        width:700px;
        height:400px;
        background-color:#E8F2FE;
        opacity:0.9;
        border:1px solid #9DAFC6;
        border-radius:4px;
    }
</style>
  </head>
  <body>
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
   <div id="Pop">
	   <h4>&nbsp;&nbsp;&nbsp;修改地图信息</h4>
	     <form class="form-horizontal" role="form">
		    <div class="form-group">
				<label class="col-sm-2 control-label">地图名称：</label>
				<div class="col-sm-10">
					<input class="form-control" id="mapName" type="text">
					<input type="hidden" id="mapId"> 
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">经度_x：</label>
				<div class="col-sm-10">
					<input class="form-control" id="map_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">纬度_y：</label>
				<div class="col-sm-10">
					<input class="form-control" id="map_Y" type="text">
				</div>
			</div>	
			<div class="form-group">
				    <label for="name">地图说明：</label>
				    <textarea id="description"class="form-control" rows="3"></textarea>
			  </div>
			  <input style="margin-left:30%;" class="btn btn-default" onclick="changeMap();" type="button" value="确认">
	          <input style="margin-left:18%;" class="btn btn-default" onclick="nonePop();"type="button" value="取消">
		</form>
   </div>
   <div id="AddPop">
	   <h4>修改地图信息</h4>
	     <form class="form-horizontal" role="form">
		    <div class="form-group">
				<label class="col-sm-2 control-label">地图名称：</label>
				<div class="col-sm-10">
					<input class="form-control" id="AddmapName" type="text">
					<input type="hidden" id="mapId"> 
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">经度_x：</label>
				<div class="col-sm-10">
					<input class="form-control" id="Addmap_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">纬度_y：</label>
				<div class="col-sm-10">
					<input class="form-control" id="Addmap_Y" type="text">
				</div>
			</div>	
			<div class="form-group">
				    <label for="name">地图说明：</label>
				    <textarea id="Adddescription"class="form-control" rows="3"></textarea>
			  </div>
			  <input style="margin-left:30%;" class="btn btn-default" onclick="AddMap();" type="button" value="确认">
	          <input style="margin-left:18%;" class="btn btn-default" onclick="noneAddPop();"type="button" value="取消">
		</form>
   </div>
</table>
    <input style="margin-left:23%;" type="button" onclick="lastpage();"value="上一页"></input>
    <input style="margin-left:22%;" type="button" onclick="nextpage();"value="下一页"></input>
    <input style="margin-left:10%;" type="button" onclick="openAddPop()"value="增加"></input>
    <input style="margin-left:5%;" type="button" onclick="openDelect();"value="删除"></input>
  </body>
</html>
