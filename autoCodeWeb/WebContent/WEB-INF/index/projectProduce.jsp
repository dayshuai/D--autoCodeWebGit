<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<link rel="stylesheet" href="css/select2-bootstrap.css" />
		<link rel="stylesheet" href="css/select2.css" />
		<link rel="stylesheet" href="css/jquery.validator.css" />
		<link rel="stylesheet" href="css/util.css" />
		<link rel="stylesheet" href="css/menu.css" />
		<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<script type="text/javascript" src="js/modernizr.custom.js"></script>
		<script type="text/javascript" src="js/select2.js"></script>
		<script type="text/javascript" src="js/select2_locale_zh-CN.js"></script>
		<script type="text/javascript" src="js/jquery.validator.js"></script>
		<script type="text/javascript" src="js/jquery.validator.zh_CN.js"></script>
		<script type="text/javascript" src="js/bootbox.js"></script>
		<script type="text/javascript" src="js/util.js"></script>
	</head>
	<script>
	var projectId=null;
	var templateId=null;
	var produceFlag=false;
	var successFlag=false;	//标记项目是否已经生成完成
	var produceCount=0;
	var openFile=false;
	var projectName=null;
	var isHidden=false;
	var hiddenValues="";
	var useDefault=false;	//不使用公共的方法
	$(function() {
		$.ajax( {
			url : 'project/projectSelect.html',
			data : {
				"a" : Math.random()
			},
			cache : false,
			async : false,
			dataType : "json",
			success : function(data) {
				if (data.result) {
					for ( var i = 0; i < data.dataList.length; i++) {
						$("#projectId").append(data.dataList[i]);
					}
					changeTemplateSelect();
				} else {
					showMessage(data.result, decodeURI(data.message));
				}
			}
		});
		//初始化下拉框
		$("#projectId").select2();
		//为checkbox 绑定事件
		//绑定回车查询
		$("#searchBtn").on("click", function(e) {
			$.ajax({
				url : 'produce/queryProjectInfo.html?projectId='+$('#projectId').val()+"&templateId="+$("#templateId").val(),
				cache : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						initTable(data.data);
						$("#projectUrl").html("生成路径:"+data.data.projectUrl);
						produceCount=data.data.produceCount;
						projectId=$('#projectId').val();
						templateId=$("#templateId").val();
						openFile=true;
					}else{
						showMessage(false, data.message);
					}
				}
			});
		});
		//绑定项目改变事件
		$("#projectId").on("change", function(e) {
			if($("#projectId").val()!=""){
				changeTemplateSelect();
			}
		});
		//绑定打开文件夹
		$("#openFile").on("click", function(e) {
			$.ajax({
				url : 'produce/openFile.html?fileName=projectProduce',
				cache : false,
				dataType : "json",
				success : function(data) {
					if(!data.result){
						showMessage(true,data.message);
					}
				}
			});
		});
		
		//下载文件
		$("#downloadFile").on("click", function(e) {
			if(successFlag==false){
				showMessage(false,"项目没有生成完整不能下载");
				return;
			}
			showMessage(true,"正在打包下载,请等待...");
			var form = $("<form>");   //定义一个form表单
            form.attr('style', 'display:none');   //在form表单中添加查询参数
            form.attr('target', '');
            form.attr('method', 'post');
            form.attr('action', 'produce/downloadProject.html?projectId='+$('#projectId').val());
            $('body').append(form);  //将表单放置在web中 
            form.submit();
		});
	});

	function changeTemplateSelect(){
		$("#templateId").html("");
		$.ajax({
			url : 'template/templateSelectByProjectId.html?projectId='+$('#projectId').val(),
			data:{
				"a":Math.random()
			},
			cache : false,
			async : false,
			dataType : "json",
			success : function(data) {
				if(data.result){
					for ( var i = 0; i < data.dataList.length; i++) {
						$("#templateId").append(data.dataList[i]);
					}
					$("#templateId").select2();
				}else{
					showMessage(data.result,decodeURI(data.message));
				}
			}
		});
	}

	//获取SM table信息
	function initTable(data){
		var columnsZh=data.columnsZh.split(",");
		var columnsValue=data.columnsValue.split(",");
		var html="<thead id=\"thead\">";
		var info="";
		for ( var i = 0; i < columnsZh.length; i++) {
			html+="<th>"+columnsZh[i]+"</th>";
		}
		html+="</thead><tbody id='tbody'>";
		html+="<tr>";
		for ( var j = 0; j < columnsValue.length; j++) {
			html+="<td>"+columnsValue[j]+"</td>";
		}
		html+="</tr>";
		html+="</tbody>";
		$("#dataTable").html(html);
	}

	//开始生成项目
	function projectProduce() {
		if(projectId==null){
			showMessage(false,  "请先获取信息后在生成...");
			return;
		}
		if(produceCount==0){
			showMessage(false,  "该项目没有可生成的文件!");
			return;
		}
		if($("#projectId").val()!=projectId){
			showMessage(false,  "项目已经改变,请重新获取项目信息");
			return;
		}
		if($("#templateId").val()!=templateId){
			showMessage(false,  "模板已经改变,请重新获取项目信息");
			return;
		}
		bootbox.confirm("是否生成"+$("#projectId").find("option:selected").text()+"项目？", function(result) {
			if (result) {
				$("#projectUrl").show();
				if(openFile){
					$("#openFile").show();
					$("#downloadFile").show();
				}
				$.ajax({
					url : 'produce/startProjectProduce.html?projectId='+projectId+"&templateId="+templateId+"&isOpenFile="+openFile,
					cache : false,
					dataType : "json",
					success : function(data) {
						if(data.result){
							projectName=data.data;
							showMessage(true, "正在生成项目,请等待...");
							window.setInterval("readProjectProduceState()",500);
							produceFlag=true;
						}else{
							showMessage(false, data.message);
						}
					}
				});
			}
		});
	}
	
	function readProjectProduceState(){
		if(projectName==null){
			return;
		}
		if(!produceFlag){
			return;
		}
		$.ajax({
				url : 'produce/readProjectProduceState.html?projectName='+projectName,
				cache : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						$("#writeName").html("写入信息:写入文件名"+data.fileName+",写入类型"+data.fileType+",第"+data.writeCount+"文件.");
						$("#progress").css("width",data.progress);
						if(data.fileState=="false"){
							showMessage(false,"生成文件异常,请检查模板");
							produceFlag=false;
							successFlag=true;
							$("#progress_info").html("写入失败:<font color='#FFFF00'>"+data.reason+"</font><span style='wtidth:30px'></span> "+data.writeCount+"/"+data.produceCount);
							return;
						}
						if(data.produceCount==data.writeCount){
							produceFlag=false;
							successFlag=true;
							showMessage(true, "项目生成完成");
							$("#progress_info").html("写入进度:<font color='#FFFF00'>"+data.progress+"</font><span style='wtidth:30px'></span> 写入完成  "+data.writeCount+"/"+data.produceCount);
							return;
						}
						$("#progress_info").html("写入进度:<font color='#FFFF00'>"+data.progress+"</font><span style='wtidth:30px'></span> "+data.writeCount+"/"+data.produceCount);
					}
				}
		});
	}

	//处理项目中的Error
	function disposeError(){
		bootbox.confirm("处理Error:0是项目表和字段信息在转换中出现的错误是否处理？", function(result) {
			if (result) {
				$.ajax({
					url : 'project/disposeError.html',
					data:{
						'projectId':$('#projectId').val(),
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

	function produceSql(){
		if($('#projectId').val()==null){
			showMessage(false,"请选择需要生成Sql的项目");
		}
		var chuangkou=window.open('produce/produceSql.html?projectId='+$('#projectId').val(),'生成Sql文件','height=360px,width=480px,top=120px;,left=450px,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
	}
</script>
	<body>
		<jsp:include page="menu.jsp" />
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2">
								<select id="projectId" name="projectId" style="width: 160px;">
								</select>
							</div>
							<div class="col-xs-2">
								<select id="templateId" name="templateId" style="width: 160px;">
								</select>
							</div>
							<div class="col-xs-8">
								<button type="button" id="searchBtn" class="btn btn-primary">
									<i class="glyphicon glyphicon-search"></i>查询项目信息
								</button>
								<button class="btn btn-danger" onclick="disposeError()">
									<i class="glyphicon glyphicon-refresh"></i>处理Error:0
								</button>
								<a href="download/sshBase.html" target="_blank" class="btn btn-info">
									<i class="glyphicon glyphicon-download"></i>下载SSH基础文件
								</a>
								<a href="download/smBase.html" target="_blank" class="btn btn-info">
									<i class="glyphicon glyphicon-download"></i>下载SM基础文件
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-list"></i>生成项目信息
						</h3>
					</div>
					<table class="table table-bordered table-condensed table-striped" id="dataTable">
						<thead>
							<th>Bean数量</th>
							<th>Controller数量</th>
							<th>Service数量</th>
							<th>ServiceImpl数量</th>
							<th>Mapper数量</th>
							<th>MapperImpl数量</th>
							<th>Page数量</th>
							<th>其它文件数量</th>
							<th>合计数量</th>
						</thead>
						<tbody>
							<tr>
								<td colspan="9">
								<div class="loading">
									<center><font color="blue">请获取需要生成的项目信息</font></center>	
								</div>
								</td>
							</tr>
						</tbody>
					</table>
					<h3>
						生成前请检查文件数量是否正确,特别注意其它文件数量。
					</h3>
					<br>
					<h3 id="projectUrl" style="display: none">
					</h3>
					<div style="float:right;margin-right:30px">
						<button type="button" class="btn btn-primary gray" onclick="projectProduce();">
							<i class="glyphicon glyphicon-cog"></i>一键生成
						</button>
						<button type="button" class="btn btn-primary gray" onclick="produceSql()">
							<i class="glyphicon glyphicon-cog "></i>生成SQL
						</button>
						<button id="openFile" type="button" class="btn btn-info gray" style="display:none">
							<i class="glyphicon glyphicon-ok"></i>打开文件夹
						</button>
						<button id="downloadFile" type="button" class="btn btn-success gray" style="display:none">
							<i class="glyphicon glyphicon-ok"></i>打包下载
						</button>
					</div>
				</div>
			</div>
			<h3 id="writeName">
			</h3>
			<div id="progress_load" title='生成进度'>
				<div id="progress"></div>
				<center>
					<div id="progress_info">
						准备就绪
					</div>
				</center>
			</div>
		</div>
	</body>
</html>