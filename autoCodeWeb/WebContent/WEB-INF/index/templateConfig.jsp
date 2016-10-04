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
		var columnsZh="序号,模板名称,配置类型,配置名称,配置值,是否指定路径,保存路径,生成文件";
		var columnsEn="templateConfigId,templateId,templateName,configType,configName,configValue,isAssignPath,savePath,produceName";	//对应的对象属性
		var columnsDb="templateConfigId,templateId,templateName,configType,configName,configValue,isAssignPath,savePath,produceName";	//对应的数据库字段
		var isConvert=true;
		var convertColumn="configType,isAssignPath";
		var convertValue="STATIC:静态生成,DYNAMIC:动态生成,COPY:直接拷贝,YES:<font color='blue'>是</font>,NO:否";
		var isHidden=true;
		var hiddenValues="templateId";
		var useDefault=true;	//使用公共的方法
		$(function() { 
			requestUrl={
				'append':'templateConfig/insertTemplateConfig.html',
				'update':'templateConfig/updateTemplateConfig.html',
				'updateTemplateConfig':'templateConfig/updateTemplateConfig.html',
				'delete':'templateConfig/deleteTemplateConfig.html',
				'deletes':'templateConfig/deleteTemplateConfigs.html',
				'query':'templateConfig/queryTemplateConfigList.html'
			}
			$.ajax({
				url : 'template/templateSelect.html',
				data:{
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						for ( var i = 0; i < data.dataList.length; i++) {
							$("#searchTemplateId").append(data.dataList[i]);
							$("#templateId").append(data.dataList[i]);
						}
						changeTemplateSelect();
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
				}
			});
			//初始化下拉框
			$("#searchTemplateId").select2();
			
			$("#templateId").on("change",function(){
				changeTemplateSelect();
			});
			
			$("#configName").on("change",function(){
				$("#configValue").val($("#configName").val()+".ftl");
				var text=$("#configName").find("option:selected").text().split(":")[1];
				$("#produceName").val("[replace]"+$("#configName").val()+"."+text);
			});
			
			$("#configType").on("change",function(){
				if($("#configType").val()=="COPY"){
					$("#configName").html("");
					$("#configName").append("<option value='Copy'>Copy:zip</option>");
					$("#isAssignPath").val("YES");
					$("#configValue").val($("#configName").val()+".zip");
					$("#savePath").val("WebRoot\\")
					$("#produceName").val("");
				}else{
					changeTemplateSelect();
				}
			});

			$("#editTemplate").on("click",function(){
				updateTemplate();
			});
		});

		function updateTemplate(){
			var flag=0;
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
						var templateConfigId=json["templateConfigId"];
						getTemplateContent(templateConfigId);
					}
				});
			}else{
				var json=dataList[flag];
				var templateConfigId=json["templateConfigId"];
				getTemplateContent(templateConfigId);
			}
		}

		function getTemplateContent(templateConfigId){
			$.ajax({
				url : 'templateConfig/queryTemplateContent.html',
				data:{
					'templateConfigId':templateConfigId,
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						$("#templateContent").val(data.data);
						$("#updateTemplateModal").modal();
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
			$("#configValue").val($("#configName").val()+".ftl");
			$("#produceName").val("[replace]"+$("#configName").val()+".java");
			
		}

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
				bootbox.confirm("删除会导致关联文件无法生成,是否确认？", function(result) {
					if (result) {
						$.ajax({
							url : 'templateConfig/deleteTemplateConfigs.html',
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
		
		function changeTemplateSelect(){
			$("#configName").html("");
			$.ajax({
				url : 'packageConfig/packageConfigSelect.html?templateId='+$("#templateId").val(),
				data:{
					"a":Math.random()
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						for ( var i = 0; i < data.dataList.length; i++) {
							$("#configName").append(data.dataList[i]);
						}
					}else{
						showMessage(data.result,decodeURI(data.message));
					}
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
					<div class="col-xs-4">
						<button class="btn btn-success" id="append"><i class="glyphicon glyphicon-file"></i>添 加 </button>
						<button class="btn btn-info" id="edit"><i class="glyphicon glyphicon-edit"></i>修 改 </button>
						<button class="btn btn-danger" id="removes"><i class="glyphicon glyphicon-trash"></i>删 除 </button>
						<button class="btn btn-primary" id="editTemplate"><i class="glyphicon glyphicon-edit"></i>编辑模板内容</button>
					</div>
				  	<div class="col-xs-6">
					 	 <form id="searchForm" onsubmit="return false">
							<div class="col-xs-5">
								<select id="searchTemplateId" name="templateId" style="width:200px">
								</select>
							</div>
							<div class="col-xs-7">
								 <div class="input-group">
									<span class="input-group-addon">关键字</span>
									<input type="text" id="searchValue" name="searchValue" class="form-control">
								 </div>
							</div>
						</form>
					</div>
					<div class="col-xs-2">
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
							模板配置信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input type="hidden" name="templateConfigId" id="templateConfigId">
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											模板名称：
										</label>
										<div class="col-xs-8">
											<select id="templateId" name="templateId" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-12 control-label">
											<h5><font color="blue">1. 动态生成会创建多个文件。</font></h5> 
											<h5><font color="blue">2. 静态生成只创建一个文件。</font></h5> 
											<h5><font color="blue">3. 直接拷贝没制定路径,默认WebRoot下。</font></h5> 
										</label>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											配置类型：
										</label>
										<div class="col-xs-8">
											<select id="configType" name="configType" class="form-control">
												<option value="DYNAMIC">动态生成</option>
												<option value="STATIC">静态生成</option>
												<option value="COPY">直接拷贝</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											配置名称：
										</label>
										<div class="col-xs-8">
											<select id="configName" name="configName" class="form-control">
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											配置Value：
										</label>
										<div class="col-xs-8">
											<input id="configValue" name="configValue" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											是否指定路径：
										</label>
										<div class="col-xs-8">
											<select id="isAssignPath" name="isAssignPath" class="form-control">
												<option value="YES">是</option>
												<option value="NO">否</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											保存路劲：
										</label>
										<div class="col-xs-8">
											<input id="savePath" name="savePath" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											生成文件：
										</label>
										<div class="col-xs-8">
											<input id="produceName" name="produceName" class="form-control" type="text">
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
		<div class="modal fade" id="updateTemplateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog" style="width:805px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							模板内容信息
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="templateForm" method="post" onsubmit="return false;">
									<textarea id="templateContent" name="templateContent" rows="20" cols="108">
									</textarea>
								</form>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
								关闭
							</button>
							<button type="button" class="btn btn-primary" id="submitTemplateForm">
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