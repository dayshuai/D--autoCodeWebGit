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
	var tableId=null;
	var produceFlag=false;
	var successFlag=false;	//标记项目是否已经生成完成
	var produceCount=0;
	var openFile=false;
	var projectName=null;
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
					changeProjectSelect();
					changeTableSelect();
				} else {
					showMessage(data.result, decodeURI(data.message));
				}
			}
		});
		//初始化下拉框
		$("#projectId").select2();
		//绑定项目改变事件
		$("#projectId").on("change", function(e) {
			if($("#projectId").val()!=""){
				changeProjectSelect();
				changeTableSelect();
			}
		});
		
		//绑定打开文件夹
		$("#openFile").on("click", function(e) {
			$.ajax({
				url : 'produce/openFile.html?fileName=tableProduce',
				cache : false,
				dataType : "json",
				success : function(data) {
					if(!data.result){
						showMessage(true,data.message);
					}
				}
			});
		});
	});

	function changeProjectSelect(){
		$("#templateId").html("");
		if($('#projectId').val()==""){
			return;
		}
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

	function changeTableSelect(){
		$("#tableId").html("");
		if($('#projectId').val()==""){
			return;
		}
		$.ajax({
			url : 'table/tableSelect.html?projectId='+$('#projectId').val(),
			data:{
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
					$("#tableId").select2();
				}else{
					showMessage(data.result,decodeURI(data.message));
				}
			}
		});
	}

	//开始生成单个表
	function tableProduce() {
		if(produceFlag==true){
			showMessage(false,  "正在生成中,请稍后生成...");
			return;
		}
		projectId=$('#projectId').val();
		templateId=$("#templateId").val();
		tableId=$("#tableId").val();
		if(projectId==null){
			showMessage(false,  "请先选择项目后在生成...");
			return;
		}
		if(templateId==null){
			showMessage(false,  "请先选择模板后在生成...");
			return;
		}
		if(tableId==null){
			showMessage(false,  "请先选择表后在生成...");
			return;
		}
		bootbox.confirm("是否生成"+$("#projectId").find("option:selected").text()+"项目？", function(result) {
			if (result) {
				$.ajax({
					url : 'produce/startTableProduce.html?projectId='+projectId+"&templateId="+templateId+"&tableId="+$("#tableId").val(),
					cache : false,
					dataType : "json",
					success : function(data) {
						if(data.result){
							projectName=data.data;
							showMessage(true, "正在生成项目,请等待...");
							window.setInterval("readProjectProduceState()",500);
							produceFlag=true;
							if(data.openFile){
								$("#openFile").show();
							}
						}else{
							bootbox.alert(data.message);
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
				url : 'produce/readTableProduceState.html?projectName='+projectName,
				cache : false,
				dataType : "json",
				success : function(data) {
					if(data.result){
						$("#writeName").html("写入信息:写入文件名"+data.fileName+",写入类型"+data.fileType+",第"+data.writeCount+"文件.");
						$("#progress").css("width",data.progress);
						if(data.fileState=="false"){
							bootbox.alert("生成文件中断");
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
</script>
	<body>
		<jsp:include page="menu.jsp" />
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-5">
								<select id="projectId" name="projectId" style="width: 160px;">
								</select>
								<select id="templateId" name="templateId" style="width: 160px;">
								</select>
								<select id="tableId" name="tableId" style="width: 160px;">
								</select>
							</div>
							<div class="col-xs-7">
								<button type="button" class="btn btn-primary" onclick="tableProduce();">
									<i class="glyphicon glyphicon-cog"></i>开始生成
								</button>
								<button id="openFile" type="button" class="btn btn-success" style="display:none">
									<i class="glyphicon glyphicon-ok"></i>打开文件夹
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
			<h3 id="writeName" style="margin-top:300px;">
			</h3>
			<div id="progress_load" title='生成进度'>
				<div id="progress"></div>
				<center>
					<div id="progress_info">
						准备就绪
					</div>
				</center>
			</div>
			<h4 style="margin-top:10px;">
				提示:单表生成只能生成动态模板部分.
			</h4>
		</div>
	</body>
</html>