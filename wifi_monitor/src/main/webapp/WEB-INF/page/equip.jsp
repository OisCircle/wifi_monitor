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
    var nowpage=1; 
    var rowslength;
     var thispage;
    var jsonequip=[];
	function sendAjax(row){
	   		$.ajax({
	   			type:"post",
	   			url:"/seekerSelectAll",
	   			data:{},
	   			success:function(data){
	 				jsonequip=data;
	 				rowslength=jsonequip.length;
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
	 				for(var i=row;i<row+10&&i<jsonequip.length;i++){
	                    var nowCells = nowRows[i-row].getElementsByTagName('td');
	                    nowCells[0].innerHTML=i+1;
	                    nowCells[1].innerHTML=jsonequip[i].id;
	                    nowCells[2].innerHTML=jsonequip[i].location;
	                    var oinput=document.createElement("button");
	                    var Text=document.createTextNode("编辑");
	                    oinput.setAttribute("id",i);
	                    oinput.setAttribute("type","button");
	                    oinput.setAttribute("class","btn btn-info");
	                    oinput.setAttribute("data-toggle","modal");
	                    oinput.setAttribute("style","margin-left:5px;");
	                    oinput.setAttribute("data-target","#UpdateequipModal");
	                    oinput.setAttribute("onclick","openPop(this.id)");
	                    nowCells[3].innerHTML="";
	                    oinput.appendChild(Text);
	                    nowCells[3].appendChild(oinput);
	                    if(jsonequip[i].isForbidden==1){
		                    var Checkbox=document.createElement("button");
		                    var CheckText=document.createTextNode("已选用");
		                    Checkbox.setAttribute("type","button");
		                    Checkbox.setAttribute("value",jsonequip[i].id);
		                    Checkbox.setAttribute("class","btn btn-danger");
		                    Checkbox.setAttribute("style","margin-left:10px;");
		                    Checkbox.setAttribute("name","mapcheck");
		                    Checkbox.setAttribute("data-toggle","button");
		                    Checkbox.setAttribute("onclick","boxcheck(this.value,0)");
		                    Checkbox.appendChild(CheckText);
	                        nowCells[3].appendChild(Checkbox);
	                    }else{
	                        var Checkbox=document.createElement("button");
		                    var CheckText=document.createTextNode("已禁用");
		                    Checkbox.setAttribute("type","button");
		                    Checkbox.setAttribute("value",jsonequip[i].id);
		                    Checkbox.setAttribute("class","btn btn-success");
		                    Checkbox.setAttribute("style","margin-left:10px;");
		                    Checkbox.setAttribute("name","mapcheck");
		                    Checkbox.setAttribute("data-toggle","button");
		                    Checkbox.setAttribute("onclick","boxcheck(this.value,1)");
		                    Checkbox.appendChild(CheckText);
	                        nowCells[3].appendChild(Checkbox);
	                    }
	                    var delect=document.createElement("button");
	            		var delectedText=document.createTextNode("删除");
	            		delect.setAttribute("type","button");
	            		delect.setAttribute("class","btn btn-warning");
	            		delect.setAttribute("style","margin-left:10px;");
	                    delect.setAttribute("value",jsonequip[i].id);
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
	   function buildingSelect(){
	         $.ajax({
	   			type:"post",
	   			url:"/zoneSelectAll",
	   			data:{},
	   			success:function(data){
	   			    var jsonmap=[];
	 				jsonmap=data;
	 				var select = document.getElementById("mapselect");
	 				var Addselect = document.getElementById("Addmapselect");
	 				for(var i=0;i<jsonmap.length;i++){
                       select.add(new Option(jsonmap[i].name,jsonmap[i].id));
	                   Addselect.add(new Option(jsonmap[i].name,jsonmap[i].id));
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
	   function openPop(id){
		 	  document.getElementById("equipID").value=jsonequip[id].id;
		 	  document.getElementById("equipName").value=jsonequip[id].location;
		 	  document.getElementById("equipType").value=jsonequip[id].type;
		 	  document.getElementById("wifi_X").value=jsonequip[id].x;
		 	  document.getElementById("wifi_Y").value=jsonequip[id].y;
		 	  document.getElementById("mapselect").value=jsonequip[id].zone_id;
		 	  document.getElementById("zone_X").value=jsonequip[id].indoor_x;
		 	  document.getElementById("zone_Y").value=jsonequip[id].indoor_y;
	   }
	   function changeequip(){
	          if(judgment()){
	          
	          }else{
			       var params = {};
		           params.id=document.getElementById("equipID").value;
		           params.type=document.getElementById("equipType").value;
		 	       params.x=document.getElementById("wifi_X").value;
		 	       params.y=document.getElementById("wifi_Y").value;
		 	       params.indoor_x=document.getElementById("zone_X").value;
		 	       params.indoor_y=document.getElementById("zone_Y").value;
		 	       params.location=document.getElementById("equipName").value;
		 	       params.zone_id=document.getElementById("mapselect").value;	 	       	 	       
			       $.ajax({
			            url:"/seekerUpdate",
			            type:"Post",
			            data:params,
			            success:function(resp){
			                $('#UpdateequipModal').modal('hide');        
			                sendAjax(nowrows);
			            },
			            error:function(jqXHR,textstatus){
			                alert(textstatus);
			            }
			        }); 
	          }
	   }
	   function Addequip(){
	          if(review()){
	                
	          }else{
			       var params = {};
		          params.id=document.getElementById("AddequipID").value;
		           params.type=document.getElementById("AddequipType").value;
		 	       params.x=document.getElementById("Addwifi_X").value;
		 	       params.y=document.getElementById("Addwifi_Y").value;
		 	       params.indoor_x=document.getElementById("Addzone_X").value;
		 	       params.indoor_y=document.getElementById("Addzone_Y").value;
		 	       params.location=document.getElementById("AddequipName").value;
		 	       params.isForbidden=0;
		 	       params.zone_id=document.getElementById("Addmapselect").value;
			       $.ajax({
			            url:"/seekerAdd",
			            type:"Post",
			            data:params,
			            success:function(resp){
			                 $('#AddequipModal').modal('hide');
			                 sendAjax(nowrows);
			            },
			            error:function(jqXHR,textstatus){
			                alert(textstatus);
			            }
			        }); 
	          }
	   }
	   function delect(id){
	       if(confirm("是否确认删除?")){
		       var params = {};
			   params.id = id;
		       $.ajax({
		            url:"/seekerDelete",
		            type:"Post",
		            data:params,
		            success:function(resp){
		                sendAjax(nowrows);
		            },
		            error:function(jqXHR,textstatus){
		                alert(textstatus);
		            }
		        });
	        }
	   }
	   function boxcheck(value,checked){
	       var i=0;
	       var params = {};
		   params.id = value;
		   if(checked==1)i=1;
		   params.isForbidden=i;
	       $.ajax({
	            url:"/seekerSetIsForbidden",
	            type:"Post",
	            data:params,
	            success:function(resp){
	                sendAjax(nowrows);
	            },
	            error:function(jqXHR,textstatus){
	                alert(textstatus);
	            }
	        });
	   }
	   sendAjax(0);
	   buildingSelect();
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
        width:750px;
        height:500px;
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
    #AddPop{
        position:absolute;
        margin-left:30%;
        margin-top:5%;
        z-index:10000;
        display:none;
        width:750px;
        height:500px;
        background-color:#E8F2FE;
        opacity:0.9;
        border:1px solid #9DAFC6;
        border-radius:4px;
    }
</style>
  </head>
  
  <body>
    <table class="table table-bordered" style="margin-left:30px;"> 
	<caption><font size="5" weight="bold">设备管理</font> <a  data-toggle="modal" data-target="#AddequipModal" style="margin-left:1300px;"><font size="5" weight="bold">增加设备</font></a></caption>
   <thead>
      <tr class="active">
         <th>序号</th>
         <th>设备ID</th>
         <th>设备别名</th>
         <th>设备操作</th>
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
 <!-- -->
</table>
<div>
<div class="modal fade" id="UpdateequipModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					 <font style="font-weight: bold;">修改设备信息</font></font>
				</h4>
			</div>
			<div class="modal-body">
			  <form  class="form-horizontal" role="form">
				<div class="form-group">
				<label class="col-sm-3 control-label">设备ID：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="equipID" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">设备别名：</label>
				<div class="col-sm-9">
					<input class="form-control" id="equipName" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">设备型号：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" id="equipType" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">探针经度X：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" id="wifi_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">探针纬度Y：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" id="wifi_Y" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">选择地图：<font color="red">*</font></label>
				<div class="col-sm-9">
					<select id="mapselect" class="form-control">
                   </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">相对地图的X：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="zone_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">相对地图的Y：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="zone_Y" type="text">
				</div>
			</div>
			<div class="modal-footer">
			    <div id="airdis">
			         <h4 id="airplay" style="color:red;"></h4>
			    </div>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" onclick="changeequip();" class="btn btn-primary">
				     提交更改	
				</button>
			</div>
		</div>
		</form>
		</div>
	</div>
	</div>
	<div>
<div class="modal fade" id="AddequipModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					 <font style="font-weight: bold;">增加设备信息</font></font>
				</h4>
			</div>
			<div class="modal-body">
			  <form  class="form-horizontal" role="form">
				<div class="form-group">
			      <label class="col-sm-3 control-label">设备ID：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="AddequipID" type="text">
				</div>
			   </div>
			   <div class="form-group">
				<label class="col-sm-3 control-label">设备别名：</label>
				<div class="col-sm-9">
					<input class="form-control" id="AddequipName" type="text">
				</div>
			   </div>
			   <div class="form-group">
				<label class="col-sm-3 control-label">设备型号：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" id="AddequipType" type="text">
				</div>
			   </div>
			<div class="form-group">
				<label class="col-sm-3 control-label">探针经度X：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"  id="Addwifi_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">探针纬度Y：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" id="Addwifi_Y" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">选择地图：<font color="red">*</font></label>
				<div class="col-sm-9">
					<select id="Addmapselect" class="form-control">
                   </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">相对地图的X：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="Addzone_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">相对地图的Y：<font color="red">*</font></label>
				<div class="col-sm-9">
					<input class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="Addzone_Y" type="text">
				</div>
			</div>
			</form>
			</div>
			<div class="modal-footer">
			    <div id="airDis">
			         <h4 id="airPlay" style="color:red;"></h4>
			    </div>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" onclick="Addequip();" class="btn btn-primary">
				     提交更改	
				</button>
			</div>
		</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	</div>
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
    function judgment(){
        var airplay=document.getElementById("airplay");
        for(var i=0;i<window.jsonequip.length;i++){
	          if(window.jsonequip[i].id==document.getElementById("equipID").value) continue;
	          else if(document.getElementById("equipName").value==window.jsonequip[i].name){
	                airplay.innerHTML="设备别名重复！";
	                return true;
	             } 
	    }
        var ID=document.getElementById("equipID");
        if(ID.value == ''){
			airplay.innerHTML="设备ID不能为空！";
			return true;
		}
		var Type=document.getElementById("equipType");
        if(Type.value == ''){
			airplay.innerHTML="设备型号不能为空！";
			return true;
		}
		var X=document.getElementById("wifi_X");
        if(X.value == ''){
			airplay.innerHTML="经度不能为空！";
			return true;
		}
		var Y=document.getElementById("wifi_Y");
        if(Y.value == ''){
			airplay.innerHTML="纬度不能为空！";
			return true;
		}
		var x=document.getElementById("zone_X");
        if(x.value == ''){
			airplay.innerHTML="地图经度不能为空！";
			return true;
		}
		var y=document.getElementById("zone_Y");
        if(y.value == ''){
			airplay.innerHTML="地图纬度不能为空！";
			return true;
		}
		return false;
    }
    function review(){
        var airplay=document.getElementById("airPlay");
        for(var i=0;i<window.jsonequip.length;i++){
	          if(document.getElementById("AddequipName").value==window.jsonequip[i].name){
	                airplay.innerHTML="设备别名重复！";
	                return true;
	             } 
	    }
        var ID=document.getElementById("AddequipID");
        if(ID.value == ''){
			airplay.innerHTML="设备ID不能为空！";
			return true;
		}
		var Type=document.getElementById("AddequipType");
        if(Type.value == ''){
			airplay.innerHTML="设备型号不能为空！";
			return true;
		}
		var X=document.getElementById("Addwifi_X");
        if(X.value == ''){
			airplay.innerHTML="经度不能为空！";
			return true;
		}
		var Y=document.getElementById("Addwifi_Y");
        if(Y.value == ''){
			airplay.innerHTML="纬度不能为空！";
			return true;
		}
		var x=document.getElementById("Addzone_X");
        if(x.value == ''){
			airplay.innerHTML="地图经度不能为空！";
			return true;
		}
		var y=document.getElementById("Addzone_Y");
        if(y.value == ''){
			airplay.innerHTML="地图纬度不能为空！";
			return true;
		}
    }
</script>
</html>
