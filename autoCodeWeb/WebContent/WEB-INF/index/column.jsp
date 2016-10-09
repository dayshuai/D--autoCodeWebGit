﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		var columnsZh="序号,项目名称,Bean名称,字段名,转换名称,中文名称,映射类型,字段类型,显示类型,主键,修改,默认值,重复,显示,查询,导包,验证,显示顺序";
		var	columnsEn="columnId,projectId,projectName,tableId,tableName,mappingName,columnName,columnZhName,mappingType,columnType,showType,isPrimary,isUpdate,isDefault,isRepeat,isShow,isQuery,isImportPackage,isCheck,showOrder";	//对应的对象属性
		var columnsDb="columnId,projectId,projectName,tableId,tableName,mappingName,columnName,columnZhName,mappingType,columnType,showType,isPrimary,isUpdate,isDefault,isRepeat,isShow,isQuery,isImportPackage,isCheck,showOrder";	//对应的数据库字段
		var isConvert=true;
		var convertColumn="showType,isPrimary,isShow,isQuery,isCheck,isImportPackage,isUpdate,isDefault,isRepeat";
		var convertValue="YES:<font color='blue'>是</font>,NO:否,null:无,TEXT:文本,IMAGE:图片";
		var isHidden=true;
		var hiddenValues="projectId,tableId";
		var useDefault=true;	//使用公共的方法
		$(function() { 
			requestUrl={
				'append':'column/insertColumn.html',
				'update':'column/updateColumn.html',
				'deleteUrl':'column/deleteColumn.html',
				'deletes':'column/deleteColumns.html',
				'query':'column/queryColumnList.html'
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
						changeSearchProjectSelect();
						changeProjectSelect();
						changeColumnTypeSelect();
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
			
			//初始化下拉框
			$("#searchProjectId").select2();
			$("#searchTableId").select2();
			
			//绑定改变查询项目时 同步 tbale
			$("#searchProjectId").on("change",function(){
				changeSearchProjectSelect();
			});
			//绑定改变表单项目时 同步 tbale
			$("#projectId").on("change",function(){
				changeProjectSelect();
			});
		});
		//查询tbale
		function changeSearchProjectSelect(){
			$("#searchTableId").html("<option value=''>--请选择--</option>");
			$.ajax({
				url : 'table/tableSelect.html',
				data:{
					'projectId':$("#searchProjectId").val(),
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						for ( var i = 0; i < data.dataList.length; i++) {
							$("#searchTableId").append(data.dataList[i]);
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
		}
		//表单tbale
		function changeProjectSelect(){
			$("#tableId").html("");
			$.ajax({
				url : 'table/tableSelect.html',
				data:{
					'projectId':$("#projectId").val(),
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						for ( var i = 0; i < data.dataList.length; i++) {
							$("#tableId").append(data.dataList[i]);
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
		}
		
		//改变columnType
		function changeColumnTypeSelect(){
			$.ajax({
				url : 'databaseConvert/databaseConvertSelect.html',
				data:{
					'projectId':$("#projectId").val(),
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						for ( var i = 0; i < data.dataList.length; i++) {
							$("#columnType").append(data.dataList[i]);
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
		}
		
		function append(){
			operatorState="append";
			$("#appendModal").modal();
			$('#objectForm')[0].reset();
			changeProjectSelect();
		}
	</script>
<body>
	<jsp:include  page="menu.jsp"/>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-3">
						<button class="btn btn-success" id="append"><i class="glyphicon glyphicon-file"></i>添 加 </button>
						<button class="btn btn-info" id="edit"><i class="glyphicon glyphicon-edit"></i>修 改 </button>
						<button class="btn btn-danger" id="removes"><i class="glyphicon glyphicon-trash"></i>删 除 </button>
					</div>
				  	<div class="col-xs-8">
					 	 <form id="searchForm" onsubmit="return false">
							<div class="col-xs-3">
								<div class="input-group">
									<select id="searchProjectId" name="projectId" style="width:160px;">
									</select>
								 </div>
							</div>
							<div class="col-xs-3">
								<div class="input-group">
									<select id="searchTableId" name="tableId" style="width:160px;">
										<option value="">--请选择--</option>
									</select>
								 </div>
							</div>
							<div class="col-xs-6">
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
						<option value="1000">1000</option>
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
			<div class="modal-dialog" style="width:800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							字段信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input type="hidden" name="columnId" id="columnId">
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												项目名称：
											</label>
											<div class="col-xs-8">
												<select id="projectId" name="projectId" class="form-control" style="width:195px;">
												</select>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												Bean名称：
											</label>
											<div class="col-xs-8">
												<select id="tableId" name="tableId" class="form-control" style="width:195px;">
												</select>
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												中文名称：
											</label>
											<div class="col-xs-8">
												<input id="columnZhName" name="columnZhName" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否主键：
											</label>
											<div class="col-xs-8">
												<select id="isPrimary" name="isPrimary" class="form-control">
													<option value="NO">否</option>
													<option value="YES">是</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												映射名称：
											</label>
											<div class="col-xs-8">
												<input id="mappingName" name="mappingName" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												字段名：
											</label>
											<div class="col-xs-8">
												<input id="columnName" name="columnName" class="form-control" type="text">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												数据库类型：
											</label>
											<div class="col-xs-8">
												<input id="mappingType" name="mappingType" class="form-control"/>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												字段类型：
											</label>
											<div class="col-xs-8">
												<select id="columnType" name="columnType" class="form-control">
												</select>
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												显示类型：
											</label>
											<div class="col-xs-8">
												<input id="showType" name="showType" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												显示顺序：
											</label>
											<div class="col-xs-8">
												<input id="showOrder" name="showOrder" class="form-control" type="text">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否显示：
											</label>
											<div class="col-xs-8">
												<select id="isShow" name="isShow" class="form-control">
													<option value="YES">是</option>
													<option value="NO">否</option>
												</select>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否修改：
											</label>
											<div class="col-xs-8">
												<select id="isUpdate" name="isUpdate" class="form-control">
													<option value="YES">是</option>
													<option value="NO">否</option>
												</select>
											</div>
										</div>
										
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												默认值：
											</label>
											<div class="col-xs-8">
												<select id="isDefault" name="isDefault" class="form-control">
													<option value="NO">否</option>
													<option value="YES">是</option>
												</select>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否重复：
											</label>
											<div class="col-xs-8">
												<select id="isRepeat" name="isRepeat" class="form-control">
													<option value="YES">是</option>
													<option value="NO">否</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否验证：
											</label>
											<div class="col-xs-8">
												<select id="isCheck" name="isCheck" class="form-control">
													<option value="YES">是</option>
													<option value="NO">否</option>
												</select>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否查询：
											</label>
											<div class="col-xs-8">
												<select id="isQuery" name="isQuery" class="form-control">
													<option value="NO">否</option>
													<option value="YES">是</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												是否导包：
											</label>
											<div class="col-xs-8">
												<select id="isImportPackage" name="isImportPackage" class="form-control">
													<option value="YES">是</option>
													<option value="NO">否</option>
												</select>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
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
	</div>
  </body>
</html>