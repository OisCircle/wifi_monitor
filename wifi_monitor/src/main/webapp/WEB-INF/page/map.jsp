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
	      var id;
          $.ajax({
	   			type:"post",
	   			url:"/getSelectedId",
	   			data:{},
	   			success:function(data){
	 				id=data;  
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
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
		                clearCells[5].innerHTML="";
		            }
	 				for(var i=row;i<row+10&&i<jsonmap.length;i++){
	                    var nowCells = nowRows[i-row].getElementsByTagName('td');
	                    nowCells[0].innerHTML=i+1;
	                    nowCells[1].innerHTML=jsonmap[i].name;
	                    nowCells[2].innerHTML=jsonmap[i].description;
	                    var oinput=document.createElement("button");
	                    var Text=document.createTextNode("编辑");
	                    oinput.setAttribute("id",i);
	                    oinput.setAttribute("type","button");
	                    oinput.setAttribute("class","btn btn-info");
	                    oinput.setAttribute("data-toggle","button");
	                    oinput.setAttribute("onclick","openPop(this.id)");
	                    nowCells[3].innerHTML="";
	                    oinput.appendChild(Text);
	                    nowCells[3].appendChild(oinput);   
	                    if(id==jsonmap[i].id){
		                    var Checkbox=document.createElement("button");
		                    var CheckText=document.createTextNode("已选");
		                    Checkbox.setAttribute("type","button");
		                    Checkbox.setAttribute("class","btn btn-danger");
		                    Checkbox.setAttribute("name","mapcheck");
		                    Checkbox.setAttribute("data-toggle","button");
		                    nowCells[4].innerHTML="";
		                    Checkbox.appendChild(CheckText);
	                        nowCells[4].appendChild(Checkbox);
	                    }else{
		                    var Checkbox=document.createElement("button");
		                    var CheckText=document.createTextNode("选用");
		                    Checkbox.setAttribute("type","button");
		                    Checkbox.setAttribute("class","btn btn-success");
		                    Checkbox.setAttribute("name","mapcheck");
		                    Checkbox.setAttribute("value",jsonmap[i].id);
		                    Checkbox.setAttribute("data-toggle","button");
		                    Checkbox.setAttribute("onclick","boxcheck(this.value)");
		                    nowCells[4].innerHTML="";
		                    Checkbox.appendChild(CheckText);
	                        nowCells[4].appendChild(Checkbox);
	                    }
	            		var delect=document.createElement("button");
	            		var delectedText=document.createTextNode("删除");
	            		delect.setAttribute("type","button");
	            		delect.setAttribute("class","btn btn-warning");
	                    delect.setAttribute("value",jsonmap[i].id);
	                    delect.setAttribute("onclick","delect(this.value)");
	                    nowCells[5].innerHTML="";
	                    delect.appendChild(delectedText);
	                    nowCells[5].appendChild(delect);
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
			                sendmap(nowrows);
			                document.getElementById("Pop").style.display="none";
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
	       if(confirm("是否确认删除?")){
		       var params = {};
			   params.id = id;
		       $.ajax({
		            url:"/zoneDelete",
		            type:"Post",
		            data:params,
		            success:function(resp){
		                sendmap(nowrows);
		            },
		            error:function(jqXHR,textstatus){
		                alert(textstatus);
		            }
		        });
	      }  
	   }
	   function boxcheck(id){
	       var params = {};
		   params.selectedId = id;
	       $.ajax({
	            url:"/setSelectedId",
	            type:"Post",
	            data:params,
	            success:function(resp){
	                sendmap(nowrows);
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
	<caption>地图管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ps:选择的图片最好为1600*750的格式</caption>
   <thead>
      <tr class="active">
         <th>地图序号</th>
         <th>地图名称</th>
         <th>地图说明</th>
         <th>地图编辑</th>
         <th>地图选取</th>
         <th>删除</th>
      </tr>
   </thead>
   <tbody id="tbody">
        <tr>
            <td></td>
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
            <td></td>
        </tr>
        <tr>
            <td></td>
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
            <td></td>
        </tr>
        <tr>
            <td></td>
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
            <td></td>
        </tr>
        <tr>
            <td></td>
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
            <td></td>
        </tr>
        <tr>
            <td></td>
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
            <td></td>
        </tr>
   </tbody>
   <div id="Pop">
	   <h4>&nbsp;&nbsp;&nbsp;修改地图信息</h4>
	     <form class="form-horizontal" role="form">
		    <div class="form-group">
				<label class="col-sm-2 control-label">地图名称：</label>
					<input class="form-control" id="mapName" type="text">
					<input type="hidden" id="mapId"> 
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
	     <form enctype="multipart/form-data" method="post"
		action="/zoneAdd" class="form-horizontal" role="form">
		    <div class="form-group">
				<label class="col-sm-2 control-label">选择图片：</label>
				<div class="col-sm-10">
					<input class="form-control" type="file" name="file" />
				</div>
			</div>
		    <div class="form-group">
				<label class="col-sm-2 control-label">地图名称：</label>
				<div class="col-sm-10">
					<input class="form-control" name="name" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">经度_x：</label>
				<div class="col-sm-10">
					<input class="form-control" name="x" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">纬度_y：</label>
				<div class="col-sm-10">
					<input class="form-control" name="y" type="text">
				</div>
			</div>	
			<div class="form-group">
				    <label for="name">地图说明：</label>
				    <textarea name="description"class="form-control" rows="3"></textarea>
			  </div>
			  <input style="margin-left:30%;" class="btn btn-default" type="submit" value="确认">
	          <input style="margin-left:18%;" class="btn btn-default" onclick="noneAddPop();"type="button" value="取消">
		</form>
   </div>
</table>
    <a class="btn btn-lg btn-primary" style="margin-left:23%;"onclick="lastpage();" role="button">上一页</a>
    <a class="btn btn-lg btn-primary" style="margin-left:22%;"onclick="nextpage();" role="button">下一页</a>
    <a class="btn btn-lg btn-primary" style="margin-left:10%;"onclick="openAddPop();" role="button">增加</a>
  </body>
</html>
