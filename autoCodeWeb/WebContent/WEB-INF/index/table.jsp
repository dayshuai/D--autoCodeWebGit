<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE>
<html>
	<head>
		<title>AutoCode</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="AutoCode">
		<link rel="stylesheet" href="css/checkstyle.css" />
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="stylesheet" href="css/select2-bootstrap.css"/>
		<link rel="stylesheet" href="css/select2.css"/>
		<link rel="stylesheet" href="css/jquery.validator.css"/>
		<link rel="stylesheet" href="css/util.css"/>
		<link rel="stylesheet" href="css/menu.css"/>
		<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<script type="text/javascript" src="js/modernizr.custom.js" ></script>
		<script type="text/javascript" src="js/select2.js"></script>
		<script type="text/javascript" src="js/select2_locale_zh-CN.js"></script>
		<script type="text/javascript" src="js/jquery.validator.js"></script>
		<script type="text/javascript" src="js/jquery.validator.zh_CN.js"></script>
		<script type="text/javascript" src="js/bootbox.js"></script>
		<script type="text/javascript" src="js/util.js"></script>
 	</head>
	<script>
		var columnsZh="序号,项目名称,Bean名称,映射名称,拥有字段,页面标题,备注";
		var columnsEn="tableId,projectId,projectName,tableName,mappingName,countColumn,tableTitle,tableMemo";	//对应的对象属性
		var columnsDb="tableId,projectId,mappingName,tableName,tableTitle,tableMemo";	//对应的数据库字段
		var isConvert=true;
		var convertColumn="validationDelete";
		var convertValue="YES:<font color='blue'>是</font>,NO:否";
		var transmitAppendId=null;
		var isHidden=true;
		var hiddenValues="projectId";
		var useDefault=true;	//使用公共的方法
		$(function() { 
			requestUrl={
				'append':'table/insertTable.html',
				'update':'table/updateTable.html',
				'delete':'table/deleteTable.html',
				'deletes':'table/deleteTables.html',
				'query':'table/queryTableList.html'
			}
			$.ajax({
				url : 'project/projectSelect.html',
				data:{
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						for ( var i = 0; i < data.dataList.length; i++) {
							$("#searchProjectId").append(data.dataList[i]);
							$("#projectId").append(data.dataList[i]);
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
			
			$("#searchProjectId").select2();
		});

		function append(){
			operatorState="append";
			$("#appendModal").modal();
			$('#objectForm')[0].reset();
			$("#tableMemo").val("无");
			$("#tableTitle").val($("#projectId").find("option:selected").text());
		}
		
		function importFile(){
			$("#excelModal").modal();
			var chuangkou=window.open('project/uploadFile.html?toPage=false','Excel导入数据','height=360px,width=480px,top=120px;,left=450px,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no') 
		}

		function submitForm(){
			var operatorUrl="";
			if(operatorState=="append"||operatorState=="transmitAppend"){
				operatorUrl='table/insertTable.html';
			}else{
				operatorUrl='table/updateTable.html';
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
						if(operatorState=="transmitAppend"){
							$("#"+transmitAppendId).remove();
							var trs=$("#tableInfoList").find("tr");
							if(trs.length!=0){
								$("#tableListModal").modal();
							}else{
								showMessage(false,"该项目已经添加完所有的表");
							}
						}
					}else{
						bootbox.alert(data.message);
					}
				}
			});
		}
		
		//添加表单关闭事件
		function closeModal(){
			if(operatorState=="transmitAppend"){
				$("#tableListModal").modal();
			}
			$("#appendModal").modal("hide");
		}

		//添加
		function noopsycheAppend(){
			$.ajax({
				url:'table/queryProjectTableList.html',
				data:$('#searchForm').serialize(),//form 序列化
				dataType : "json",
				type:'post',
				cache : false,
				async : false,
				onsubmit: function(){
					return true;
				},
				success:function(data){
					if(data.result){
						var tableList=data.dataList;
						var tableHtml="<table class='table table-bordered table-condensed table-striped table-hover'>";
						tableHtml+="<thead><th>序号</th><th>映射名称</th><th>表名称</th><th>表标题</th><th>表字段数</th><th>操作</th><thead><tbody id='tableInfoList'>";
						for ( var i = 0; i < tableList.length; i++) {
							var json=tableList[i];
							tableHtml+="<tr id='tableName"+(i+1)+"'>";
							tableHtml+="<td>"+(i+1)+"</td>";
							tableHtml+="<td>"+json.mappingName+"</td>";
							tableHtml+="<td>"+json.tableName+"</td>";
							tableHtml+="<td>"+json.tableTitle+"</td>";
							tableHtml+="<td>"+json.countColumn+"</td>";
							tableHtml+="<td><center><button class='btn btn-success btn-xs' onclick='transmitAppend(\"tableName"+(i+1)+"\",\""+json.mappingName+"\",\""+json.tableName+"\",\""+json.tableTitle+"\",true)'>添加</button></center></td>";
							tableHtml+="</tr>";
						}
						tableHtml+="</tbody></table>";
						$("#dbTableList").html(tableHtml);
						$("#tableListModal").modal();
					}else{
						bootbox.alert(data.message);
					}
				}
			});
		}
		
		//智能传参添加
		function transmitAppend(trId,mappingName,tableName,tableTitle,bool){
			//等于真表示直接添加否则通过表单添加
			if(bool){
				$.ajax({
					url:"table/transmitAppend.html",
					data:{
						'tableName':tableName,
						'tableTitle':tableTitle,
						'mappingName':mappingName,
						'projectId':$("#searchProjectId").val(),
						'validationDelete':'NO',
						'a':Math.random()
					},
					dataType : "json",
					type:'post',
					cache : false,
					async : false,
					onsubmit: function(){
						return true;
					},
					success:function(data){
						if(data.result){
							$("#"+trId).remove();
							var trs=$("#tableInfoList").find("tr");
							if(trs.length==0){
								$("#tableListModal").modal("hide");
								showMessage(false,"该项目已经添加完所有的表");
							}
							JumpPage(pageIndex);
							showMessage(data.result,"操作成功");
						}else{
							bootbox.alert(data.message);
						}
					}
				});
			}
		}
		
		//一键添加
		function onKeyAppend(){
			$.ajax({
				url:'table/onKeyAutoAppendTable.html',
				data:{
					'projectId':$("#searchProjectId").val(),
					'a':Math.random()
				},
				dataType : "json",
				type:'post',
				cache : false,
				async : false,
				onsubmit: function(){
					return true;
				},
				success:function(data){
					if(data.result){
						JumpPage(1);
						showMessage(false,data.data);
					}else{
						bootbox.alert(data.message);
					}
				}
			});
		}

		//移除前缀
		function removePrefix(){
			var projectId=$("#searchProjectId").val();
			if(projectId==""){
				bootbox.alert("请选择移除前缀的项目");
				return;
			}
			bootbox.confirm("你选择了"+$("#searchProjectId").find("option:selected").text()+"项目,移除所有TableName前缀吗？", function(result) {
				if (result) {
					$.ajax({
						url : 'table/removePrefix.html',
						data:{
							'projectId':projectId,
							"a":Math.random()
						},
						cache : false,
						async : false,
						dataType : "json",
						success : function(data) {
							if(data.result){
								showMessage(data.result,"移除前缀完成!");
								JumpPage(pageIndex);
							}else{
								showMessage(data.result,decodeURI(data.message));
							}
						}
					});
				}
			});
		}
	</script>
<body>
	<jsp:include  page="menu.jsp"/>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-6">
						<button class="btn btn-info" id="append"><i class="glyphicon glyphicon-file"></i>手动添加 </button>
						<button class="btn btn-info" onclick="noopsycheAppend()"><i class="glyphicon glyphicon-refresh"></i>自定义数据库添加 </button>
						<button class="btn btn-info" onclick="onKeyAppend()"><i class="glyphicon glyphicon-cog"></i>全部添加</button>
						<button class="btn btn-info" id="edit"><i class="glyphicon glyphicon-edit"></i>修 改 </button>
						<button class="btn btn-info" id="removes"><i class="glyphicon glyphicon-trash"></i>删 除 </button>
						<button class="btn btn-info" onclick="removePrefix()"><i class="glyphicon glyphicon-remove"></i>移除前缀 </button>
					</div>
				  	<div class="col-xs-5">
					 	 <form id="searchForm" onsubmit="return false">
					 	 	<div class="col-xs-4">
								<select id="searchProjectId" name="projectId" style="width:160px;">
								</select>
							</div>
							<div class="col-xs-8">
								<div class="input-group">
									<span class="input-group-addon">关键字</span>
									<input type="text" id="searchValue" name="searchValue" class="form-control">
								 </div>
							</div>
						</form>
					</div>
					<div class="col-xs-1">
						<button type="button" id="searchBtn" class="btn btn-primary"><i class="glyphicon glyphicon-search"></i>查询</button>			
					</div>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<table class="table table-bordered table-condensed table-striped table-hover" id="dataTable">
			</table>
			<div id="refreshDiv" class="table-bordered">
				<div class="loading">
					<center><img src='images/loding.gif' width="19" height="19"/><b> 正在刷新,请等待...</b></center>
				</div>
			</div>
		</div>
		<div class="row pageDiv" id="pageDiv">
			<div class="col-xs-5" style="margin-top:0px;">
				<span id="dataInfo" style="float:left;display:none">
					每页显示
					<select id="changeShowNum">
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
						<option value="30">30</option>
						<option value="50">50</option>
						<option value="80">80</option>
						<option value="100">100</option>
					</select>
					条记录
					<span>
						,显示 <font color="blue" id="pageStart">1</font> 到  <font color="blue" id="pageEnd">10</font> 条记录,查询到 <font color="red" id="pageCount">0</font> 条数据
					</span>。
				</span>
			</div>
			<div class="col-xs-7" id="pagination">
				
			</div>
		</div>
		<!-- 表单 -->
		<div class="modal fade" id="appendModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog" style="width:500px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							数据库表信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input type="hidden" name="tableId" id="tableId">
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											项目名称：
										</label>
										<div class="col-xs-7">
											<select id="projectId" name="projectId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											映射名称：
										</label>
										<div class="col-xs-7">
											<input id="mappingName" name="mappingName" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											Bean名称：
										</label>
										<div class="col-xs-7">
											<input id="tableName" name="tableName" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											页面标题：
										</label>
										<div class="col-xs-7">
											<input id="tableTitle" name="tableTitle" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											验证删除：
										</label>
										<div class="col-xs-7">
											<select id="validationDelete" name="validationDelete" class="form-control">
												<option value="NO">否</option>
												<option value="YES">是</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											备注：
										</label>
										<div class="col-xs-7">
											<input id="tableMemo" name="tableMemo" class="form-control" type="text">
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" onclick="closeModal()">
								关闭
							</button>
							<button type="button" class="btn btn-primary" id="submitForm">
								保存
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="tableListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog" style="width:800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12" id="dbTableList">
								
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
								关闭
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
  </body>
</html>