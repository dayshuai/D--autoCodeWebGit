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
		var columnsZh="序号,项目名称,Bean名称,添加方法,修改方法,删除方法,查询方法,SELECT方法";
		var columnsEn="controlId,projectId,projectName,tableId,tableName,isInsertMethod,isUpdateMethod,isDeleteMethod,isQueryMethod,isSelectMethod";	//对应的对象属性
		var columnsDb="controlId,projectId,tableId,isInsertMethod,isUpdateMethod,isDeleteMethod,isQueryMethod,isSelectMethod";	//对应的数据库字段
		var isConvert=true;
		var convertColumn="isInsertMethod,isUpdateMethod,isDeleteMethod,isQueryMethod,isSelectMethod";
		var convertValue="YES:有,NO:无";
		var isHidden=true;
		var hiddenValues="projectId,tableId";
		var useDefault=true;	//使用公共的方法
		$(function() { 
			requestUrl={
				'append':'control/insertControl.html',
				'update':'control/updateControl.html',
				'deleteUrl':'control/deleteControl.html',
				'deletes':'control/deleteControls.html',
				'query':'control/queryControlList.html'
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
							changeProjectSelect();
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
			//初始化下拉框
			$("#searchProjectId").select2();

			$("#projectId").on("change",function(){
				changeProjectSelect();
			});
			
		});

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
						<button class="btn btn-info" id="append"><i class="glyphicon glyphicon-file"></i>添 加 </button>
						<button class="btn btn-info" id="edit"><i class="glyphicon glyphicon-edit"></i>修 改 </button>
						<button class="btn btn-info" id="removes"><i class="glyphicon glyphicon-trash"></i>删 除 </button>
					</div>
				  	<div class="col-xs-8">
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
							控制器信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input type="hidden" name="controlId" id="controlId">
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											项目名称：
										</label>
										<div class="col-xs-8">
											<select id="projectId" name="projectId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											表名称：
										</label>
										<div class="col-xs-8">
											<select id="tableId" name="tableId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											添加方法：
										</label>
										<div class="col-xs-8">
											<select id="isInsertMethod" name="isInsertMethod" class="form-control">
												<option value='YES'>有</option>
												<option value='NO'>无</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											修改方法：
										</label>
										<div class="col-xs-8">
											<select id="isUpdateMethod" name="isUpdateMethod" class="form-control">
												<option value='YES'>有</option>
												<option value='NO'>无</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											删除方法：
										</label>
										<div class="col-xs-8">
											<select id="isDeleteMethod" name="isDeleteMethod" class="form-control">
												<option value='YES'>有</option>
												<option value='NO'>无</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											查询方法：
										</label>
										<div class="col-xs-8">
											<select id="isQueryMethod" name="isQueryMethod" class="form-control">
												<option value='YES'>有</option>
												<option value='NO'>无</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											SELECT方法：
										</label>
										<div class="col-xs-8">
											<select id="isSelectMethod" name="isSelectMethod" class="form-control">
												<option value='YES'>有</option>
												<option value='NO'>无</option>
											</select>
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