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
    var nowpage=1; 
    var rowslength;
    var thispage;
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
	 				thispage=Math.ceil(rowslength/10);
	 				var root = document.getElementById("tbody");
	 				var nowRows = root.getElementsByTagName('tr');
	 				for(var m=0;m<10;m++){
	                    var clearCells = nowRows[m].getElementsByTagName('td');
		                clearCells[0].innerHTML="";
		                clearCells[1].innerHTML="";
		                clearCells[2].innerHTML="";
		                clearCells[3].innerHTML="";
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
	                    oinput.setAttribute("data-toggle","modal");
	                    oinput.setAttribute("style","margin-left:5px;");
	                    oinput.setAttribute("data-target","#UpdateModal");
	                    oinput.setAttribute("onclick","openPop(this.id)");
	                    nowCells[3].innerHTML="";
	                    oinput.appendChild(Text);
	                    nowCells[3].appendChild(oinput);   
	                    if(id==jsonmap[i].id){
		                    var Checkbox=document.createElement("button");
		                    var CheckText=document.createTextNode("已选");
		                    Checkbox.setAttribute("type","button");
		                    Checkbox.setAttribute("class","btn btn-danger");
		                    Checkbox.setAttribute("style","margin-left:10px;");
		                    Checkbox.setAttribute("name","mapcheck");
		                    Checkbox.setAttribute("data-toggle","button");
		                    Checkbox.appendChild(CheckText);
	                        nowCells[3].appendChild(Checkbox);
	                    }else{
		                    var Checkbox=document.createElement("button");
		                    var CheckText=document.createTextNode("选用");
		                    Checkbox.setAttribute("type","button");
		                    Checkbox.setAttribute("class","btn btn-success");
		                    Checkbox.setAttribute("style","margin-left:10px;");
		                    Checkbox.setAttribute("name","mapcheck");
		                    Checkbox.setAttribute("value",jsonmap[i].id);
		                    Checkbox.setAttribute("data-toggle","button");
		                    Checkbox.setAttribute("onclick","boxcheck(this.value)");
		                    Checkbox.appendChild(CheckText);
	                        nowCells[3].appendChild(Checkbox);
	                    }
	            		var delect=document.createElement("button");
	            		var delectedText=document.createTextNode("删除");
	            		delect.setAttribute("type","button");
	            		delect.setAttribute("class","btn btn-warning");
	            		delect.setAttribute("style","margin-left:10px;");
	                    delect.setAttribute("value",jsonmap[i].id);
	                    delect.setAttribute("onclick","delect(this.value)");
	                    delect.appendChild(delectedText);
	                    nowCells[3].appendChild(delect);
	                    
	                } 
	                page();           
	   			},
	   			error:function(){
	   				alert("error...");
	   			}
	   		});
	   		
	   };
	   function lastpage(){
	        if(nowrows==0) alert("已是顶页！");
	        else {nowrows-=10;
	              nowpage-=1;
	             sendmap(nowrows);
	        }    
	   }
	   function nextpage(){
	        if((rowslength-nowrows)<=10) alert("已是尾页！");
	        else {nowrows+=10;
	              nowpage+=1;
	             sendmap(nowrows);
	        }    
	   }
	   function openPop(id){
	          document.getElementById("mapId").value=jsonmap[id].id;
		 	  document.getElementById("mapName").value=jsonmap[id].name;
		 	  document.getElementById("description").value=jsonmap[id].description;
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
     #pagebox{
    	 position:relative;
         width:100%; 
         height:50px;
         margin-top:100px;  
    }
	#pages{
		position:absolute;
		left:42%; 
		top:10px;
		width:200px;
		height:40px; 
		border:0px;
		text-align:center;  
	}
	#airdis{
	    width:200px;
	    heigth:50px;
	    text-align:center;
	}
	#airDis{
	    width:200px;
	    heigth:50px;
	    text-align:center;
	}
    a{
		text-decoration:none;
		out-line: none;
		cursor:pointer;
	}
    a:hover{
		text-decoration:none;
	}
</style>
  </head>
  <body>
     <table class="table table-bordered" style="margin-left:30px;">
	<caption><font size="5" weight="bold">地图管理</font><a  data-toggle="modal" data-target="#AddModal" style="margin-left:1300px;"><font size="5" weight="bold">增加地图</font></a></caption>
   <thead>
      <tr class="active">
         <th>地图序号</th>
         <th>地图名称</th>
         <th>地图说明</th>
         <th>地图操作</th>
      </tr>
   </thead>
   <tbody id="tbody">
        <tr>
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
        </tr>
        <tr>
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
        </tr>
        <tr>
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
        </tr>
        <tr>
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
        </tr>
        <tr>
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
        </tr>
   </tbody>
   <div class="modal fade" id="UpdateModal"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					 <font style="font-weight: bold;">修改地图信息</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3">ps:选择的图片最好为1600*750的格式</font>
				</h4>
			</div>
			<div class="modal-body">
				<form enctype="multipart/form-data" method="post" onsubmit="return airdisplay()" action="/zoneUpdate" class="form-horizontal" role="form">
				<div class="form-group">
				<label class="col-sm-3 control-label">选择图片：</label>
				<div class="col-sm-9">
					<input class="form-control" type="file" name="file" />
				</div>
			</div>
		    <div class="form-group">
				<label class="col-sm-3 control-label">地图名称：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" id="mapName" name="name" type="text">
					<input type="hidden" name="id" id="mapId"> 
					<input  name="x" type="hidden" value="0">
			        <input  name="y" type="hidden" value="0">
				</div>
			</div>	
			<div class="form-group">
				    <label for="name">地图说明：</label>
                    <textarea id="description" name="description"class="form-control" rows="3"></textarea>
			  </div>
			</div>
			<div class="modal-footer">
			    <div id="airdis">
			         <h4 id="airplay" style="color:red;"></h4>
			    </div>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="submit" class="btn btn-primary">
				     提交更改	
				</button>
			</div>
		</div><!-- /.modal-content -->
		</form>
		</div><!-- /.modal -->
	</div>
   <div class="modal fade" id="AddModal"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					 <font style="font-weight: bold;">增加地图信息</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3">ps:选择的图片最好为1600*750的格式</font>
				</h4>
			</div>
			<div class="modal-body">
			  <form enctype="multipart/form-data" method="post" onsubmit="return airDisplay()" action="/zoneAdd" class="form-horizontal" role="form">
				<div class="form-group">
				<label class="col-sm-3 control-label">选择图片：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" id="file"  type="file" name="file" />
				</div>
			</div>
		    <div class="form-group">
				<label class="col-sm-3 control-label">地图名称：<font color="red">*</font></label>
				<div class="col-sm-9" >
					<input class="form-control" id="mapname" name="name" type="text">
					<input  name="x" type="hidden" value="0">
			        <input  name="y" type="hidden" value="0">
				</div>
			</div>
			<div class="form-group">
				    <label for="name">地图说明：</label>
				    <textarea name="description" class="form-control" rows="3"></textarea>
			  </div>
			</div>
			<div class="modal-footer">
			   <div id="airDis">
			         <h4 id="airPlay" style="color:red;"></h4>
			    </div>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="submit" class="btn btn-primary">
				     提交更改	
				</button>
			</div>
		</div><!-- /.modal-content -->
		</form>
		</div><!-- /.modal -->
	</div>
</table>
   <div id="pagebox">
			   <a class="btn btn-lg btn-primary" role="button" style="margin-left:33%;"onclick="lastpage();" >上一页</a>
			   <div id="pages"><font id="page" size="5" style="margin-top:20px; " color="blue"></font></div>
		       <a class="btn btn-lg btn-primary" role="button" style="margin-left:20%;"onclick="nextpage();">下一页</a>
    </div> 
  </body>
  <script type="text/javascript">
	function page(){
	    var page = document.getElementById("page");
	    page.innerHTML="";
	    var Text=document.createTextNode("第"+window.nowpage+"页/共"+window.thispage+"页");
	    page.appendChild(Text);
    }
    function airdisplay(){
        var airplay=document.getElementById("airplay");
        for(var i=0;i<window.jsonmap.length;i++){
	          if(window.jsonmap[i].id==document.getElementById("mapId").value) continue;
	          else if(document.getElementById("mapName").value==jsonmap[i].name){
	                airplay.innerHTML="地图名称重复！";
	                return false;
	             } 
	    }
        var name=document.getElementById("mapName");
        if(name.value == ''){
			airplay.innerHTML="地图名称不能为空！";
			return false;
		}
		var mapx=document.getElementById("map_X");
        if(mapx.value == ''){
			airplay.innerHTML="经度不能为空！";
			return false;
		}
		var mapy=document.getElementById("map_Y");
        if(mapy.value == ''){
			airplay.innerHTML="纬度不能为空！";
			return false;
		}
		return true;
    }
    function airDisplay(){
        var airplay=document.getElementById("airPlay");
         for(var i=0;i<window.jsonmap.length;i++){
	          if(document.getElementById("mapname").value==jsonmap[i].name){
	                airplay.innerHTML="地图名称重复！";
	                return false;
	             } 
	    }
        var file=document.getElementById("file");
        if(file.value == ''){
			airplay.innerHTML="图片不能为空！";
			return false;
		}
        var name=document.getElementById("mapname");
        if(name.value == ''){
			airplay.innerHTML="地图名称不能为空！";
			return false;
		}
		var mapx=document.getElementById("map_x");
        if(mapx.value == ''){
			airplay.innerHTML="经度不能为空！";
			return false;
		}
		var mapy=document.getElementById("map_y");
        if(mapy.value == ''){
			airplay.innerHTML="纬度不能为空！";
			return false;
		}
		return true;
    }
</script>
</html>
