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
		<script>
			var columnsZh="序号,项目标题,项目名称,框架,请求后缀,数据库,数据库IP,端口,数据库名,用户名,密码,创建时间,验证通过";
			var columnsEn="projectId,projectTitle,projectName,projectFrame,requestPostfix,databaseType,databaseIp,databasePort,databaseName,databaseUser,databasePwd,createDate,isValidation";	//对应的对象属性
			var columnsDb="projectId,projectTitle,projectName,projectFrame,requestPostfix,databaseType,databaseIp,databasePort,databaseName,databaseUser,databasePwd,createDate,isValidation";	//对应的数据库字段
			var isConvert=true;
			var convertColumn="isDefault,isValidation,projectFrame,databaseType";
			var convertValue="YES:<font color='blue'>是</font>,NO:否,SSH:Spring Struts Hibernate,SM:Spring MyBatis,MySql:MySql,SqlServer:SqlServer,Oracle:Oracle";
			var isHidden=false;
			var hiddenValues="";
			var useDefault=true;	//使用公共的方法
			$(function() { 
				requestUrl={
					'append':'project/insertProject.html',
					'update':'project/updateProject.html',
					'deleteUrl':'project/deleteProject.html',
					'deletes':'project/deleteProjects.html',
					'query':'project/queryProjectList.html'
				}
			});
			
			function append(){
				operatorState="append";
				$("#appendModal").modal();
				$('#objectForm')[0].reset()
				$("#projectFrame").val("SM");
				$("#databaseType").val("MySql");
				$("#databaseIp").val("localhost");
				$("#databasePort").val("3306");
				$("#databaseUser").val("root");
				$("#databasePwd").val("root");
				$("#isDefault").val("YES");
			}
			
			function resetProject(){
				$('#objectForm')[0].reset();
				var flag=true;
				var selectCoun=0;
				var checks=$("input[name='idbox']");
				for(var i=0;i< checks.length; i++){
					if(checks[i].checked==true){
						selectCoun++;
						ids=checks[i].value;
						if(flag==true){
							flag=i;
						}
						if(selectCoun==2){
							break;
						}
					}
				}
				if(selectCoun==0){
					bootbox.alert("请选中需要清空的项目信息！");
				}else if(selectCoun>1){
					bootbox.alert("只能选择一个项目记录！");
				}else{
					var json=dataList[flag];
					bootbox.confirm("确认清空  "+json["projectName"]+" 项目信息?", function(result) {
						if (result) {
							$.ajax({
								url : 'project/resetProject.html',
								data:{
									'projectId':json['projectId'],
									"a":Math.random()
								},
								cache : false,
								async : false,
								dataType : "json",
								success : function(data) {
									if(data.result){
										showMessage(data.result, "操作成功!");
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
										showMessage(data.result,data.message);
									}
								}
							});
						}
					});
				}
			}		
	
			function checkDatabase(){
				var id="";
				$('#objectForm')[0].reset();
				var flag=true;
				var selectCoun=0;
				var checks=$("input[name='idbox']");
				for(var i=0;i< checks.length; i++){
					if(checks[i].checked==true){
						selectCoun++;
						id=checks[i].value;
						if(flag==true){
							flag=i;
						}
						if(selectCoun==2){
							break;
						}
					}
				}
				if(selectCoun==0){
					bootbox.alert("请选中需要验证的记录！");
				}else if(selectCoun>1){
					bootbox.alert("只能选择一条记录进行验证！");
				}else{
					if(flag!=null){
						var json=dataList[flag];
						if(json["isValidation"]=="YES"){
							bootbox.alert("当前选中的记录已经验证通过！");
							return;
						}
					}
					$.ajax({
						url : 'project/chackDatabase.html',
						data:{
							'projectId':id,
							"a":Math.random()
						},
						cache : false,
						async : false,
						dataType : "json",
						success : function(data) {
							if(data.result){
								showMessage(data.result,"验证成功!");
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
								showMessage(data.result,"验证失败,请确认数据库信息正确性!");
							}
						}
					});
				}
			}
			
			function changeDatabaseType(){
				var value=$("#databaseType option:selected").val();
				$("#databaseName").val($("#projectName").val());
				if(value=="MySql"){ //mysql
					$("#databaseIp").val("localhost");
					$("#databasePort").val("3306");
					$("#databaseUser").val("root");
					$("#databasePwd").val("root");
				}else if(value=="SqlServer"){ //sqlserver
					$("#databaseIp").val("localhost");
					$("#databasePort").val("1433");
					$("#databaseUser").val("sa");
					$("#databasePwd").val("sa");
				}else if(value=="Oracle"){	//oracle
					$("#databaseIp").val("localhost");
					$("#databasePort").val("1521");
					$("#databaseUser").val("scott");
					$("#databasePwd").val("tiger");
				}else{	//null
					$("#databaseIp").val("");
					$("#databasePort").val("");
					$("#databaseUser").val("");
					$("#databasePwd").val("");
				}
			}

			function disposeError(){
				var id="";
				var flag=true;
				var selectCoun=0;
				var checks=$("input[name='idbox']");
				for(var i=0;i< checks.length; i++){
					if(checks[i].checked==true){
						selectCoun++;
						id=checks[i].value;
						if(flag==true){
							flag=i;
						}
						if(selectCoun==2){
							break;
						}
					}
				}
				if(selectCoun==0){
					bootbox.alert("请选中需要处理Error的项目！");
				}else if(selectCoun>1){
					bootbox.alert("只能选择一个项目进行验证！");
				}else{
					bootbox.confirm("处理Error:0是项目表和字段信息在转换中出现的错误是否处理？", function(result) {
						if (result) {
							$.ajax({
								url : 'project/disposeError.html',
								data:{
									'projectId':id,
									"a":Math.random()
								},
								cache : false,
								async : false,
								dataType : "json",
								success : function(data) {
									if(data.result){
										bootbox.alert(data.data);
									}else{
										showMessage(data.result,data.message);
									}
								}
							});
						}
					});
				}
			}
		</script>
	</head>
<body>
	<jsp:include  page="menu.jsp"/>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-6">
						<button class="btn btn-info" id="append"><i class="glyphicon glyphicon-file"></i>添 加 </button>
						<button class="btn btn-info" id="edit"><i class="glyphicon glyphicon-edit"></i>修 改 </button>
						<button class="btn btn-info" id="removes"><i class="glyphicon glyphicon-trash"></i>删 除 </button>
						<button class="btn btn-info" onclick="checkDatabase()">验证数据库 </button>
					</div>
				  	<div class="col-xs-5">
					 	 <form id="searchForm" onsubmit="return false">
							<div class="col-xs-4">
								<div class="input-group">
									<select id="searchColumn" name="searchColumn" style="width:140px;">
										<option value="">默认搜索</option>
									</select>
								 </div>
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
			<div class="modal-dialog" style="width:800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							项目信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input  id="projectId" name="projectId" type="hidden" >
									<input id="createDate" name="createDate" type="hidden">
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												项目名称：
											</label>
											<div class="col-xs-8">
												<input  id="projectName" name="projectName" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												数据库：
											</label>
											<div class="col-xs-8">
												<select id="databaseType" name="databaseType" class="form-control" onchange="changeDatabaseType();">
													<option value="MySql">MySql</option>
													<option value="SqlServer">SqlServer</option>
													<option value="Oracle">Oracle</option>
												</select>
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												框架：
											</label>
											<div class="col-xs-8">
												<select id="projectFrame" name="projectFrame" class="form-control">
													<option value="SM">Spring MyBatis</option>
													<option value="SSH">Spring Struts Hibernate</option>
												</select>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												数据库IP：
											</label>
											<div class="col-xs-8">
												<input  id="databaseIp" name="databaseIp" class="form-control" type="text">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												项目标题：
											</label>
											<div class="col-xs-8">
												<input  id="projectTitle" name="projectTitle" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												端口：
											</label>
											<div class="col-xs-8">
												<input  id="databasePort" name="databasePort" class="form-control" type="text">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												数据库名：
											</label>
											<div class="col-xs-8">
												<input  id="databaseName" name="databaseName" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												用户名：
											</label>
											<div class="col-xs-8">
												<input  id="databaseUser" name="databaseUser" class="form-control" type="text">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												请求后缀：
											</label>
											<div class="col-xs-8">
												<input  id="requestPostfix" name="requestPostfix" class="form-control" type="text">
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												密码：
											</label>
											<div class="col-xs-8">
												<input  id="databasePwd" name="databasePwd" class="form-control" type="text">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												默认操作：
											</label>
											<div class="col-xs-8">
												<select id="isDefault" name="isDefault" class="form-control">
													<option value="YES">是</option>
													<option value="NO">否</option>
												</select>
											</div>
										</div>
										<div class="col-xs-6">
											<label class="col-xs-4 control-label">
												通过验证：
											</label>
											<div class="col-xs-8">
												<select id="isValidation" name="isValidation" class="form-control">
													<option value="NO">否</option>
													<option value="YES">是</option>
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