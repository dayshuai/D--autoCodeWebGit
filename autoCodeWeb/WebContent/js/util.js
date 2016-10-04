var messageCount=1;
var createMessageDivFlag=true;
var pageIndex=1;	//当前第几页
var pageSize=10;	//每页显示记录
var ids;			//用于删除ids
var pageCount=0;    //记录总条数
var dataList;	   //列表记录
var operatorState; //操作状态   append/edit
var requestUrl=null;
//显示信息
function showMessage(type,message){
	var width=$(window).width();
	width=(width-200)/2;
	var height=$(window).height();
	height=(height-200)/2;
	if(createMessageDivFlag){
		createMessageDivFlag=false;
		var messageDiv="<div id='message' class='message' style='top:"+height+"px;left:"+width+"px;'>";
		$("body").append(messageDiv);
	}
	var html="";
	var closeTime=0;
	messageCount++;
	var messageId="message"+messageCount;
	if(type=="success"||type){
		if(message==""||typeof(message)=="undefined"){
			message="操作成功!"
		}
		closeTime=1000;
	}else if(type=="danger"||type=="failed"||type==false){
		if(message==""||typeof(message)=="undefined"){
			message="操作异常!"
		}
		closeTime=2000;
	}
	html+="<div id='"+messageId+"' class='alert alert-message' role='alert'>";
	html+="<b>";
	html+="<p><center>"+message+"</center></p></b>";
	html+="</div>";
	$("#message").append(html);
	setTimeout("closeAnimate('"+messageId+"')",closeTime);
}
//关闭动画
function closeAnimate(messageId){
	$("#"+messageId).fadeTo("slow",0);
	setTimeout("closeMessage('"+messageId+"')",500);
}
//删除显示的信息
function closeMessage(messageId){
	$("#"+messageId).remove();
}

function getCreenHeight(){
	var height=$(window).height();
	return height;
}

function computeImageHeight(){
	var width=$(window).width();
}

//成功后刷新
function refreshSuccess(obj){
	$("#refresh").show();
	$("tbody").show();
	$("#refreshDiv").hide();
	$("#dataInfo").show();
	$("#pageStart").html(obj.pageStart);
	$("#pageEnd").html(obj.pageEnd);
	$("#pageCount").html(obj.pageCount);
	pageCount=obj.pageCount;
}
//重新初始化全选事件
function selectAllBindClick(){ 
	$("#selectAll").on("click",function(){
		var checks=$("tbody tr").find(":checkbox");
		for(var i=0;i< checks.length; i++){
			if($("#selectAll")[0].checked==false){
				checks[i].checked=false;
			}else{
				checks[i].checked=true;
			}
		}
	});
}
//复选按钮绑定事件
function checkboxBindClick(){
	var checkboxs=$("#idbox");
	if(checkboxs.length==0){
		return;
	}
	//绑定事件   tbody 绑定
	$("#tbody tr").on("click",function(){
		$("table tr").removeClass();
		if($(this).find(":checkbox")[0].checked){
			$(this).find(":checkbox").prop("checked", false);
		}else{
			$(this).find(":checkbox").prop("checked", true);
		}
		var flag=false;
		var checks=$("tbody tr").find(":checkbox");
		for(var i=0;i< checks.length; i++){
			if(checks[i].checked==false){
				flag=true;
				break;
			}
		}
		if(flag){
			$("#selectAll").prop("checked", false);
		}else{
			$("#selectAll").prop("checked", true);
		}
	});
}

$(function() { 
	if (typeof(useDefault)!="undefined"&&useDefault) {
		columnsZh=columnsZh.split(",");
		columnsEn=columnsEn.split(",");
		columnsDb=columnsDb.split(",");
		if(typeof(convertColumn)!="undefined"){
			convertColumn=convertColumn.split(",");
		}
		if(typeof(convertValue)!="undefined"){
			convertValue=convertValue.split(",");
		}
		if(typeof(hiddenValues)!="undefined"){
			hiddenValues=hiddenValues.split(",");
		}
		initTable();//初始化数据表格
		for ( var i = 0; i < columnsZh.length; i++) {
			var searchOption="<option value='"+columnsDb[i]+"'>"+columnsZh[i]+"搜索</option>";
			var sortOption="<option value='"+columnsDb[i]+"'>"+columnsZh[i]+"排序</option>";
			$("#searchColumn").append(searchOption);
			$("#sortColumn").append(sortOption);
		}
		//初始化下拉框
		$("#searchColumn").select2();
		$("#sortColumn").select2();
		//全选 checkbox 绑定事件
		selectAllBindClick();
		
		$("#searchBtn").on("click",function(){
			pageIndex=1;
			JumpPage(1);
		});
		
		//绑定回车查询
		$("#searchValue").on("keydown",function(e){
			if(e.keyCode==13){
				pageIndex=1;
				JumpPage(1);
			}
		});
		//选择显示页数
		$("#changeShowNum").on("change",function(){
			pageSize=$("#changeShowNum").val();
			pageIndex=1;
			JumpPage(1);
		});
		
		$("#append").on("click",function(){
			append();
		});
		
		$("#edit").on("click",function(){
			edit();
		});
		
		$("#removes").on("click",function(){
			removes();
		});
		
		$("#remove").on("click",function(){
			remove();
		});
		
		$("#submitForm").on("click",function(){
			submitForm();
		});
	}
});

//默认的添加方法
function append(){
	operatorState="append";
	$("#appendModal").modal();
	$('#objectForm')[0].reset();
}
//默认的添加方法
function edit(){
	$('#objectForm')[0].reset();
	operatorState="edit";
	var flag=true;
	var selectCoun=0;
	var checks=$("input[name='idbox']");
	for(var i=0;i< checks.length; i++){
		if(checks[i].checked==true){
			selectCoun++;
			if(flag==true){
				flag=i;
			}
		}
	}
	if(selectCoun==0){
		bootbox.alert("请选中需要修改的记录！");
		return;
	}else if(selectCoun>1){
		bootbox.confirm("你选择多条记录,默认修改第一条？", function(result) {
			if (result) {
				var json=dataList[flag];
				for ( var j = 0; j < columnsEn.length; j++) {
					$("#"+columnsEn[j]).val(json[columnsEn[j]]);
				}
				$("#appendModal").modal();
			}
		});
	}else{
		var json=dataList[flag];
		for ( var j = 0; j < columnsEn.length; j++) {
			$("#"+columnsEn[j]).val(json[columnsEn[j]]);
		}
		$("#appendModal").modal();
	}
}
//删除一个
function remove(){
	var id="";
	var countId=0;
	var checks=$("input[name='idbox']:checked");
	for(var i=0;i< checks.length; i++){
		if(checks[i].checked==true){
			id=checks[i].value;
			countId++;
		}
	}
	if (countId>1) {
		bootbox.alert("只能选择一条记录删除！");
	}else if(countId==1){
		bootbox.confirm("确认删除所选记录？", function(result) {
			if (result) {
				$.ajax({
					url : requestUrl.delete,
					data:{
						'id':id,
						"a":Math.random()
					},
					cache : false,
					async : false,
					dataType : "json",
					success : function(data) {
						if(data.result){
							showMessage(data.result,"删除成功!");
							var page;
							if((pageCount-checks.length)%pageSize==0){
								page=(pageCount-checks.length)/pageSize;
							}else{
								page=parseInt(((pageCount-checks.length)/pageSize)+1);
							}
							if(page<pageIndex){
								pageIndex=page;
							}
							JumpPage(pageIndex);
						}else{
							showMessage(data.result,decodeURI(data.message));
						}
					}
				});
			}
		});
	}else{
		bootbox.alert("请选中需要删除的记录！");
	}
}
//删除多个
function removes(){
	ids="";
	var flag=false;
	var checks=$("input[name='idbox']:checked");
	for(var i=0;i< checks.length; i++){
		if(checks[i].checked==true){
			ids+=checks[i].value+",";
			flag=true;
		}
	}
	if(flag){
		ids=ids.substring(0,ids.length-1);
		bootbox.confirm("确认删除所选中的"+checks.length+"条记录？", function(result) {
			if (result) {
				$.ajax({
					url : requestUrl.deletes,
					data:{
						'ids':ids,
						"a":Math.random()
					},
					cache : false,
					async : false,
					dataType : "json",
					success : function(data) {
						if(data.result){
							showMessage(data.result,"删除成功!");
							var page;
							if((pageCount-checks.length)%pageSize==0){
								page=(pageCount-checks.length)/pageSize;
							}else{
								page=parseInt(((pageCount-checks.length)/pageSize)+1);
							}
							if(page<pageIndex){
								pageIndex=page;
							}
							JumpPage(pageIndex);
						}else{
							showMessage(data.result,decodeURI(data.message));
						}
					}
				});
			}
		});
	}else{
		bootbox.alert("请选中需要删除的记录！");
	}
}
//默认提交
function submitForm(){
	var operatorUrl="";
	if(operatorState=="append"){
		operatorUrl=requestUrl.append;
	}else{
		operatorUrl=requestUrl.update;
	}
	$.ajax({
		url:operatorUrl,
		data:$('#objectForm').serialize(),//form 序列化
		dataType : "json",
		type:'post',
		cache : false,
		async : false,
		onsubmit: function(){
			return true;
		},
		success:function(data){
			if(data.result){
				$("#appendModal").modal("hide");
				JumpPage(pageIndex);
				showMessage(data.result,"操作成功");
			}else{
				bootbox.alert(data.message);
			}
		}
	});
}
//默认选择Page方法
function JumpPage(index){
	if(typeof(index)!="undefined"){
		pageIndex=index;
	}
	$("tbody").hide();
	$("#refreshDiv").show();
	setTimeout(function(){
		$.ajax({
			url:requestUrl.query+"?pageIndex="+pageIndex+"&pageSize="+pageSize+"&random="+Math.random(),
			data:$('#searchForm').serialize(),//form 序列化
			dataType : "json",
			type:'post',
			cache : false,
			async : false,
			success:function(data){
				if(data.result){
					refreshSuccess(data);
					buildTableInfo(data.dataList);
					//为checkbox绑定事件
					checkboxBindClick();
				}else{
					refreshFailed(data.message);
					bootbox.alert(data.message);
				}
				$("#pagination").html(data.pageHtml);
			}
		});
	},200);
}
//初始化table
function initTable(addition){
	var html="<thead id=\"thead\"><th width=\"32px\"><label><input onclick1=\"selectAll()\" id=\"selectAll\" type=\"checkbox\"><span></span></label></th>";
	for ( var i = 0; i < columnsZh.length; i++) {
		html+="<th>"+columnsZh[i]+"</th>";
	}
	if(addition!=""&&addition!=null&&typeof(addition)!="undefined"){
		html+="<th>"+addition+"</th>";
	}
	html+="</thead><tbody id='tbody'>";
	html+="</tbody>";
	$("#dataTable").html(html);
	JumpPage(1);
}
//构建table信息
function buildTableInfo(objectList){
	dataList=objectList;
	$("#selectAll")[0].checked=false;
	if(dataList.length==0){
		var html="<tr><td colspan='"+$("thead").find("th").length+"'><br/><br/><br/><br/><br/><br/><center><b> 没有查询到数据...</b></center><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></td></tr>";
		$("tbody").html(html);
	}else{
		var html="";
		for (var i = 0; i < dataList.length; i++) {
			var json=dataList[i];
			html+="<tr>";
			html+="<td><label><input id='idbox' name=\"idbox\" type=\"checkbox\" value="+json[columnsEn[0]]+"><span></span></label></td>";
			if(isConvert){ //需要转换值
				for ( var j = 0; j < columnsEn.length; j++) {
					var hiddenFlag=false;
					if(typeof(isHidden)!="undefined"&&isHidden){
						for ( var k = 0; k < hiddenValues.length; k++) {
							var column = hiddenValues[k];
							if(columnsEn[j]==column){
								hiddenFlag=true;
								break;
							}
						}
					}
					if (hiddenFlag) {
						continue;
					}
					var columnName=columnsEn[j];
					var columnValue=json[columnName];
					var convertFlag=false;
					for ( var k = 0; k < convertColumn.length; k++) {
						if (columnName==convertColumn[k]) {
							convertFlag=true;
							break;
						}
					}
					if(convertFlag){
						var value="<font color='red'>"+columnValue+"</font>";
						for ( var k = 0; k < convertValue.length; k++) {
							var temp=convertValue[k].split(":");
							if(temp[0]==columnValue){
								value=temp[1];
								break;
							}
						}
						html+="<td>"+value+"</td>";
					}else{
						html+="<td>"+columnValue+"</td>";
					}
				}
			}else{
				for ( var j = 0; j < columnsEn.length; j++) {
					var hiddenFlag=false;
					if(typeof(isHidden)!="undefined"&&isHidden){
						for ( var k = 0; k < hiddenValues.length; k++) {
							var column = hiddenValues[k];
							if(columnsEn[j]==column){
								hiddenFlag=true;
								break;
							}
						}
					}
					if (hiddenFlag) {
						continue;
					}
					html+="<td>"+json[columnsEn[j]]+"</td>";
				}
			}
			html+="</tr>";
		}
		$("#dataTable tbody").html(html);
	}
}

function refreshFailed(message){
	var html="<tr><td colspan='"+$("thead").find("th").length+"'><br/><br/><br/><br/><br/><br/><center><b><font color='red'>"+message+"...</font></b></center><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>";
	$("tbody").html(html);
	$("tbody").show();
	$("#refreshDiv").hide();
	$("#dataInfo").hide();
}
//导航js
$(function(){
    $("div.menuNav li").on("click",function(){
		//console.log($(this).position());
		var id=$(this).context.id;
		if(id=="metnav_1"){	//第一个不用显示 菜单
			$(".menulist").css("display","none");
			return;
		}
		var left=parseInt($(this).position().left)+235;
		$(".menulist").css("display","block").css("margin-left",left+"px");
	});
    
    var onnav=$(".onnav").length;
    if (onnav==0) {
    	$("#nav_1").attr("class","onnav");
	}
	var width=$(window).width();
//	if(width<1035){
//		$(".menus").css("width","1035px");
//	}else{
		$(".menus").css("width","100%");
//	}

	$('#topnav a').click(function() {	
		modelMenu($(this));
		$(".menudetail ul").css("display","none");
		var id=$(this).context.id;
		$(".menulist").css("display","none");
		$("#detail_"+id.substring(id.length-1,id.length)).css("display","");
		
	});
});
	
	function modelMenu(d) {
	    if (d instanceof jQuery) {
	        if (d.attr("id") != 'top_quick_a') {
	            $('#topnav a').removeClass("onnav");
	            d.addClass("onnav");
	            $("ul[id^='tab_']").hide();
	            var u = String(d.attr('id'));
	            u = u.split('_');
	            u = u[1];
	            $("#tab_" + u).show();
	            u = $("#tab_" + u).find('li a').eq(0);
	        }
	    } else {
	        modelMenu($('#nav_' + d));
	    }
	}
