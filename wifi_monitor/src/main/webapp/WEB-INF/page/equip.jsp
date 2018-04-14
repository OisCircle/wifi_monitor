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
    var jsonequip=[];
	function sendAjax(row){
	   		$.ajax({
	   			type:"post",
	   			url:"/seekerSelectAll",
	   			data:{},
	   			success:function(data){
	 				jsonequip=data;
	 				rowslength=jsonequip.length;
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
	 				for(var i=row;i<row+10&&i<jsonequip.length;i++){
	                    var nowCells = nowRows[i-row].getElementsByTagName('td');
	                    nowCells[0].innerHTML=i+1;
	                    nowCells[1].innerHTML=jsonequip[i].id;
	                    nowCells[2].innerHTML=jsonequip[i].location;
	                    var oSpan=document.createElement("span");
	                    var Text=document.createTextNode("编辑");
	                    oSpan.setAttribute("id",i);
	                    oSpan.setAttribute("class","glyphicon glyphicon-tasks");
	                    oSpan.setAttribute("style","font-size: 23px;");
	                    oSpan.setAttribute("onclick","openPop(this.id)");
	                    nowCells[3].innerHTML='';
	                    nowCells[3].appendChild(oSpan);
	                    nowCells[3].appendChild(Text);
	                    var oCheckbox=document.createElement("input");
	                    var myText=document.createTextNode("禁用");
	                    var delectspan=document.createElement("span");
	                    var delectbox=document.createElement("div");
	                    oCheckbox.setAttribute("type","checkbox");
	                    oCheckbox.setAttribute("value",jsonequip[i].id);
	                    if(jsonequip[i].isForbidden==1) oCheckbox.setAttribute("checked","ture");
	                    oCheckbox.setAttribute("onclick","boxcheck(this.value,this.checked)");
	                    delectbox.setAttribute("id","delect"+i)
	                    delectbox.setAttribute("style", "margin-left:10px;display:none;");
	                    delectspan.setAttribute("id", jsonequip[i].id);
	                    delectspan.setAttribute("class", "glyphicon glyphicon-remove");
	                    delectspan.setAttribute("style", "color:red;")
	                    delectspan.setAttribute("onclick", "delect(this.id)");
	                    delectbox.appendChild(delectspan);
	                    nowCells[4].innerHTML='';
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
	   function openDelect(){
	            for(var i=nowrows;i<=nowrows+10&&i<jsonequip.length;i++){
	                var thisid="delect"+i;  
	                if(document.getElementById(thisid.toString()).style.display=="block"){
	                      document.getElementById(thisid.toString()).style.display="none";
	                }else{
	                      document.getElementById(thisid.toString()).style.display="block"
	                }
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
		 	  document.getElementById("Pop").style.display="block";
	   }
	   function openAddPop(){
		 	  document.getElementById("AddPop").style.display="block";
	   }
	    function judgment(){	      
	          for(var i=0;i<jsonequip.length;i++){
	          if(jsonequip[i].id==document.getElementById("equipID").value) continue;
	          else if(document.getElementById("equipName").value==jsonequip[i].name){
	                return 1;
	             } 
	          }
	          return 0;
	   }
	   function review(){
	       for(var i=0;i<jsonequip.length;i++){
	          if(document.getElementById("AddequipName").value==jsonequip[i].name){
	                return 1;
	            } 
	          }
	          return 0;
	   }
	   function changeequip(){
	          if(judgment()){
	               alert("名称重复，请修改！");
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
			                alert("success");
			                alert(resp);
			                document.getElementById("Pop").style.display="none";
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
	               alert("名称重复，请修改！");
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
			                alert("success");
			                alert(resp);
			                document.getElementById("AddPop").style.display="none";
			                 sendAjax(nowrows);
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
	            url:"/seekerDelete",
	            type:"Post",
	            data:params,
	            success:function(resp){
	                alert("success");
	                alert(resp);
	                for(var i=nowrows;i<=nowrows+10&&i<jsonequip.length;i++){
	                   var thisid="delect"+i;  
	                  document.getElementById(thisid.toString()).style.display="none";
	                 }
	                sendAjax(nowrows);
	            },
	            error:function(jqXHR,textstatus){
	                alert(textstatus);
	            }
	        });
	        
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
	                alert("success");
	                alert(resp);
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
   <div id="Pop">
	   <h4>&nbsp;&nbsp;&nbsp;修改设备信息</h4>
	     <form class="form-horizontal" role="form">
		    <div class="form-group">
				<label class="col-sm-2 control-label">设备ID：</label>
				<div class="col-sm-10">
					<input class="form-control" id="equipID" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">设备别名：</label>
				<div class="col-sm-10">
					<input class="form-control" id="equipName" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">设备型号：</label>
				<div class="col-sm-10">
					<input class="form-control" id="equipType" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">探针经度X：</label>
				<div class="col-sm-10">
					<input class="form-control" id="wifi_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">探针纬度Y：</label>
				<div class="col-sm-10">
					<input class="form-control" id="wifi_Y" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">选择地图：</label>
				<div class="col-sm-10">
					<select id="mapselect" class="form-control">
                   </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">相对地图的X：</label>
				<div class="col-sm-10">
					<input class="form-control" id="zone_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">相对地图的Y：</label>
				<div class="col-sm-10">
					<input class="form-control" id="zone_Y" type="text">
				</div>
			</div>
			  <input style="margin-left:30%;" class="btn btn-default" onclick="changeequip();" type="button" value="确认">
	          <input style="margin-left:18%;" class="btn btn-default" onclick="nonePop();"type="button" value="取消">
		</form>
   </div>
   <div id="AddPop">
	   <h4>修改设备信息</h4>
	     <form class="form-horizontal" role="form">
		    <div class="form-group">
				<label class="col-sm-2 control-label">设备ID：</label>
				<div class="col-sm-10">
					<input class="form-control" id="AddequipID" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">设备别名：</label>
				<div class="col-sm-10">
					<input class="form-control" id="AddequipName" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">设备型号：</label>
				<div class="col-sm-10">
					<input class="form-control" id="AddequipType" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">探针经度X：</label>
				<div class="col-sm-10">
					<input class="form-control" id="Addwifi_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">探针纬度Y：</label>
				<div class="col-sm-10">
					<input class="form-control" id="Addwifi_Y" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">选择地图：</label>
				<div class="col-sm-10">
					<select id="Addmapselect" class="form-control">
                   </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">相对地图的X：</label>
				<div class="col-sm-10">
					<input class="form-control" id="Addzone_X" type="text">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">相对地图的Y：</label>
				<div class="col-sm-10">
					<input class="form-control" id="Addzone_Y" type="text">
				</div>
			</div>
			  <input style="margin-left:30%;" class="btn btn-default" onclick="Addequip();" type="button" value="确认">
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
