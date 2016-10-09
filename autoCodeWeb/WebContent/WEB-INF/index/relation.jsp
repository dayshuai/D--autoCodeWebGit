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
		var columnsZh="序号,项目名称,主关系表,主关系字段,关系,关系表,关系字段,显示字段类型,关系显示字段,级联删除";
		var columnsEn="relationId,projectId,projectName,tableId,tableName,columnId,columnName,relation,relationTableId,relationTableName,relationColumnId,relationColumnName,relationColumnType,relationShowColumnId,relationShowColumnName,cascadeDelete";	//对应的对象属性
		var columnsDb="relationId,projectId,projectName,tableId,tableName,columnId,columnName,relation,relationTableId,relationTableName,relationColumnId,relationColumnName,relationColumnType,relationShowColumnId,relationShowColumnName,cascadeDelete";	//对应的数据库字段
		var isConvert=true;
		var convertColumn="cascadeDelete,relationColumnType";
		var convertValue="YES:<font color='blue'>是</font>,String:String,NO:否";
		var isHidden=true;
		var hiddenValues="projectId,tableId,columnId,relationTableId,relationColumnId,relationShowColumnId";
		var useDefault=true;	//使用公共的方法
		$(function() { 
			requestUrl={
				'append':'relation/insertRelation.html',
				'update':'relation/updateRelation.html',
				'deleteUrl':'relation/deleteRelation.html',
				'deletes':'relation/deleteRelations.html',
				'query':'relation/queryRelationList.html'
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
						changeSearchTableSelect();
						changeProjectSelect();
						changeTableSelect("all");
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
			//初始化查询下拉框
			$("#searchProjectId").select2();
			$("#searchTableId").select2();
			$("#searchRelation").select2();

			//绑定改变查询项目时 同步 tbale
			$("#searchProjectId").on("change",function(){
				changeSearchTableSelect();
			});
			//绑定改变表单项目时 同步 tbale
			$("#projectId").on("change",function(){
				changeProjectSelect();
			});

			$("#tableId").on("change",function(){
				changeTableSelect("main");
			});
			
			$("#relationTableId").on("change",function(){
				changeTableSelect("relation");
			});

			$("#columnId").on("change",function(){
				changeColumnSelect();
			});

			$("#relationColumnId").on("change",function(){
				changeColumnSelect();
			});
		});

		//查询tbale
		function changeSearchTableSelect(){
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
			$("#relationTableId").html("");
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
							$("#relationTableId").append(data.dataList[i]);
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
		}
		
		//改变columnType
		function changeTableSelect(chanageFlag){
			//等于all 更新所有
			if(chanageFlag=="all"){
				$("#columnId").html("");
				$("#relationColumnId").html("");
				$("#relationShowColumnId").html("");
			}else if(chanageFlag=="main"){
				$("#columnId").html("");
			}else{
				$("#relationColumnId").html("");
				$("#relationShowColumnId").html("");
			}
			if(chanageFlag=="all"||chanageFlag=="main"){
				$.ajax({
					url : 'column/columnSelectByTableId.html',	//找关系
					data:{
						'tableId':$("#tableId").val(),
						"a":Math.random()
					},
					cache : false,
					async : false,
					dataType : "json",
					success : function(data) {
						if(data.result){
							$("#columnId").append("<option value=''>不显示</option>");
							for ( var i = 0; i < data.dataList.length; i++) {
								$("#columnId").append(data.dataList[i]);
							}
						}else{
							showMessage(data.result,data.message);
						}
					}
				});
			}
			if(chanageFlag=="all"||chanageFlag=="relation"){
				//抓取关系表字段信息
				$.ajax({
					url : 'column/columnSelectByTableId.html',	//找关系
					data:{
						'tableId':$("#relationTableId").val(),
						"a":Math.random()
					},
					cache : false,
					async : false,
					dataType : "json",
					success : function(data) {
						if(data.result){
							$("#relationShowColumnId").append("<option value=''>不显示</option>");
							for ( var i = 0; i < data.dataList.length; i++) {
								$("#relationColumnId").append(data.dataList[i]);
								if (i!=0) {
									$("#relationShowColumnId").append(data.dataList[i]);
								}
							}
						}else{
							showMessage(data.result,data.message);
						}
					}
				});
			}
		}

		//自动找字段之间的关系
		function changeColumnSelect(){
			if($("#columnId").val()==""||$("#relationColumnId").val()==""){
				return;
			}
			$.ajax({
				url : 'relation/autoColumnRelation.html',
				data:{
					'columnId':$("#columnId").val(),
					'relationColumnId':$("#relationColumnId").val(),
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						$("#relation").val(data.data.relation);
						$("#cascadeDelete").val(data.data.cascadeDelete);
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
			changeColumnSelect();
		}

		function edit(){
			$('#objectForm')[0].reset();
			operatorState="edit";
			var flag=0;
			var selectCoun=0;
			var checks=$("input[name='idbox']");
			for(var i=0;i< checks.length; i++){
				if(checks[i].checked==true){
					selectCoun++;
					flag=i;
					if(selectCoun>1){
						bootbox.alert("只能选择一条记录修改！");
						return;
					}
				}
			}
			if(selectCoun==0){
				bootbox.alert("请选中需要修改的记录！");
				return;
			}else{
				var json=dataList[flag];
				$("#tableId").val(json["tableId"]);
				changeProjectSelect();//刷新
				$("#tableId").val(json["tableId"]);
				$("#relationTableId").val(json["relationTableId"]);
				changeTableSelect("main");
				changeTableSelect("relation");
				var json=dataList[flag];
				for ( var j = 0; j < columnsEn.length; j++) {
					$("#"+columnsEn[j]).val(json[columnsEn[j]]);
				}
				$("#appendModal").modal();
			}
		}
		
		//自动找关系
		function autoRelation(){
			var projectId=$("#searchProjectId").val();
			if(projectId==""){
				bootbox.alert("请选择需要找关系的项目");
				return;
			}
			bootbox.confirm("你选择了"+$("#searchProjectId").find("option:selected").text()+"项目,确认自动找关系？", function(result) {
				if (result) {
					$.ajax({
						url : 'relation/autoRelation.html',
						data:{
							'projectId':projectId,
							"a":Math.random()
						},
						cache : false,
						async : false,
						dataType : "json",
						success : function(data) {
							if(data.result){
								showMessage(data.result,data.data);
								JumpPage(pageIndex);
							}else{
								showMessage(data.result,decodeURI(data.message));
							}
						}
					});
				}
			});
		}
		
		function validation(){
			var mainTable=$("#tableId").val();
			var relationTable=$("#relationTableId").val();
			if(mainTable==""||relationTable==""){
				bootbox.alert("请选择关系表,如果没有表请现在Bean管理中添加");
				return;
			}
			var mainColumn=$("#columnId").val();
			var relationColumn=$("#relationColumnId").val();
			var relationShowColumn=$("#relationShowColumnId").val();
			if(mainColumn==""||relationColumn==""){
				bootbox.alert("请填写完整后提交!");
				return;
			}
			if($("#relation").val()!="OneToMany"){
				if(relationShowColumn==""){
					bootbox.alert("请填写完整后提交!");
					return;
				}
			}
			if(relationColumn==relationShowColumn){
				bootbox.alert("关系显示字段和关系字段不能相同!");
				return;
			}
			if($("#relation").val()==""){
				bootbox.alert("请选择关系!");
				return;
			}
			if($("#relation").val()=="ManyToOne"){
				$("#cascadeDelete").val("NO")
			}
			var mainType=$("#columnId").find("option:selected").text().split(":")[1];
			var relationType=$("#relationColumnId").find("option:selected").text().split(":")[1];
			if (mainType!=mainType) {
				bootbox.confirm("主关系字段和引用关系字段类型不一致,是否添加？", function(result) {
					if (result) {
						var showType=$("#relationShowColumnId").find("option:selected").text().split(":")[1];
						if(showType!="String"){
							bootbox.confirm("显示字段不是String类型,是否添加？", function(result) {
								if (result) {
									submitForm();
								}
							});
						}else{
							submitForm();						
						}
					}
				});
			}else{
				var showType=$("#relationShowColumnId").find("option:selected").text().split(":")[1];
				if(showType!="String"){
					bootbox.confirm("显示字段不是String类型,是否添加？", function(result) {
						if (result) {
							submitForm();
						}
					});
				}else{
					submitForm();						
				}
			}
		}
	</script>
<body>
	<jsp:include  page="menu.jsp"/>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-4">
						<button class="btn btn-success" id="append"><i class="glyphicon glyphicon-file"></i>添 加 </button>
						<button class="btn btn-info" id="edit"><i class="glyphicon glyphicon-edit"></i>修 改 </button>
						<button class="btn btn-danger" id="removes"><i class="glyphicon glyphicon-trash"></i>删 除 </button>
						<button class="btn btn-success" onclick="autoRelation()"><i class="glyphicon glyphicon-refresh"></i>自动找关系</button>
					</div>
				  	<div class="col-xs-7">
					 	 <form id="searchForm" onsubmit="return false">
							<div class="col-xs-4">
								<div class="input-group">
									<select id="searchProjectId" name="projectId" style="width:160px;">
									</select>
								 </div>
							</div>
							<div class="col-xs-4">
								<div class="input-group">
									<select id="searchTableId" name="tableId" style="width:160px;">
										<option value="">--请选择--</option>
									</select>
								 </div>
							</div>
							<div class="col-xs-4">
								 <div class="input-group">
								 	<select id="searchRelation" name="relation" style="width:160px;">
										<option value="">--请选择--</option>
										<option value="OneToOne">一对一</option>
										<option value="OneToMany">一对多</option>
										<option value="ManyToOne">对多一</option>
									</select>
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
							关系信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input id="relationId" name="relationId" type="hidden">
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
											主关系表：
										</label>
										<div class="col-xs-8">
											<select id="tableId" name="tableId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											主关系字段：
										</label>
										<div class="col-xs-8">
											<select id="columnId" name="columnId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											关系：
										</label>
										<div class="col-xs-8">
											<select id="relation" name="relation" class="form-control">
												<option value="">-- 请选择 --</option>
												<option value="OneToMany">一对多</option>
												<option value="ManyToOne">对多一</option>
												<option value="OneToOne">一对一</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											关系表：
										</label>
										<div class="col-xs-8">
											<select id="relationTableId" name="relationTableId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											关系字段：
										</label>
										<div class="col-xs-8">
											<select id="relationColumnId" name="relationColumnId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											关系显示字段：
										</label>
										<div class="col-xs-8">
											<select id="relationShowColumnId" name="relationShowColumnId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											级联删除：
										</label>
										<div class="col-xs-8">
											<select id="cascadeDelete" name="cascadeDelete" class="form-control">
												<option value="NO">否</option>
												<option value="YES">是</option>
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
							<button type="button" class="btn btn-primary" onclick="validation()">
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