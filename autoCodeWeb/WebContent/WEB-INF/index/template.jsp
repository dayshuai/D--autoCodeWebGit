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
		<script type="text/javascript" src="js/uploadify/jquery.uploadify-3.1.js"></script>
 	</head>
	<script>
		var columnsZh="序号,模板标题,模板名称,适用框架,是否可用,模板图片,备注";
		var columnsEn="templateId,templateTitle,templateName,applyFrame,isValidation,imageUrl,memo";	//对应的对象属性
		var columnsDb="templateId,templateTitle,templateName,applyFrame,isValidation,imageUrl,memo";	//对应的数据库字段
		var isConvert=true;
		var convertColumn="isValidation,applyFrame";
		var convertValue="YES:<font color='blue'>可用</font>,NO:不可用,SSH:Spring Struts Hibernate,SM:Spring MyBatis";
		var isHidden=false;
		var hiddenValues="";
		var useDefault=true;	//使用公共的方法
		$(function() { 
			requestUrl={
				'append':'template/insertTemplate.html',
				'update':'template/updateTemplate.html',
				'deleteUrl':'template/deleteTemplate.html',
				'deletes':'template/deleteTemplates.html',
				'query':'template/queryTemplateList.html'
			}
			//上传 模板图片
			$("#fileImageUrl").uploadify({
		        height: 20, 
		    	width : 80, 
		    	buttonText: '<button class="btn btn-xs btn-info">选择文件</button>',
		        swf: 'js/uploadify/uploadify.swf',
		        uploader: 'template/uploadTemplateImage.html',
		        auto: false,
		        fileObjName:'file',                 //上传文件name 
		        multi: true,                    //设置为true时可以上传多个文件  
		        fileTypeExts:'*.jpg;*.png;*.gif;',    //允许上传的文件后缀
		        progressData : 'all',           //队列中显示文件上传进度的方式：all-上传速度+百分比，percentage-百分比，speed-上传速度  
		        removeCompleted : true,             //上传成功后的文件，是否在队列中自动删除  
		        method:'post',                 //和后台交互的方式：post/get  
		        onUploadSuccess:function(file, data, response){
		        	data=eval('(' + data + ')'); 
			        if (data.result) {
			        	$("#imageUrl").val(data.data);
			        	$("#fileName").text("上传成功:"+data.data);
						return;
					}else{
						$("#imageUrl").val("");
			        	$("#fileName").text("上传失败,请重新上传");
						bootbox.alert(data.message);
						return;
					}
			    },
			    onSelect: function(file) {
		        }
		    });
		});    
		
		var countFile=0;
		var uploadCount=0;
		function upload(){
			if(uploadCount>0){
				return;
			}
			uploadCount=0;
			$('#fileUrl').uploadify('upload','*');
		}

		function cancel(){
			countFile=0;
			$('#fileUrl').uploadify('cancel', '*');
		}

		var uploadCount=0;
		function uploadImage(){
			$('#fileImageUrl').uploadify('upload','*');
		}
		
		
		function append(){
			operatorState="append";
			$("#appendModal").modal();
			$('#objectForm')[0].reset();
			$("#imageUrl").val("");
			$("#fileName").text("");
			
		}
		//导入ftl文件
		function importFtlFile(){
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
				bootbox.alert("请选中需要上传配置文件的模板！");
			}else if(selectCoun>1){
				bootbox.alert("只能选择一个模板进行上传！");
			}else{
				var success=0;
				$("#importFtlFileModal").modal();
				$('#fileUrl').uploadify({
					height: 20, 
			    	width : 80, 
			    	buttonText: '<span class="btn btn-info">选择文件</span>',
			        swf: 'js/uploadify/uploadify.swf',
			        uploader:'template/uploadTemplateFtl.html?templateId='+checks[flag].value,
			        auto: false,
			        fileObjName:'file',                 //上传文件name 
			        multi: true,                    //设置为true时可以上传多个文件  
			        fileTypeExts:'*.ftl;*.zip;',    //允许上传的文件后缀
			        progressData : 'all',           //队列中显示文件上传进度的方式：all-上传速度+百分比，percentage-百分比，speed-上传速度  
			        removeCompleted : true,             //上传成功后的文件，是否在队列中自动删除  
			        method:'post',                 //和后台交互的方式：post/get  
			        onUploadSuccess:function(file, data, response){
						uploadCount++;
						data=eval('(' + data + ')'); 
				        if (data.result) {
				        	success++;
				        	$("#uploadInfo").text("上传成功"+success+"个文件")
						}else{
							bootbox.alert(data.message);
						}
						if(uploadCount==countFile){
							countFile=0;
							uploadCount=0;
						}
				    },
				    onSelect: function(file) {
				    	countFile++;
			        }
			    });
			}
		}
		
		function submitForm(){
			var operatorUrl="";
			if(operatorState=="append"){
				operatorUrl=requestUrl.append;
			}else{
				operatorUrl=requestUrl.edit;
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
								if(columnsEn[j]=="imageUrl"){
									html+="<td><a href='javascript:void' data-url='/uploadFiles/"+json[columnsEn[j]]+"' class='imageUrl'><img src='/uploadFiles/"+json[columnsEn[j]]+"' width='60px' height:='60px;'/></a></td>";
								}else{
									html+="<td>"+columnValue+"</td>";
								}
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
				//图片大图预览
				$(".imageUrl").on("click",function(){
					var href=$(this).attr("data-url");
					$("#showImage").attr("src",href);
					$("#showImageModal").modal();
				});

				$("#showImage").on("click",function(){
					$("#showImageModal").modal("hide");
				});
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
						<button class="btn btn-success" onclick="importFtlFile()"><i class="glyphicon glyphicon glyphicon-upload"></i>导入模板文件</button>
					</div>
				  	<div class="col-xs-6">
					 	 <form id="searchForm" onsubmit="return false">
							<div class="col-xs-4">
								<div class="input-group">
									<select id="sortColumn" name="sortColumn" style="width:160px;">
										<option value="">默认排序</option>
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
		<div class="modal fade" id="importFtlFileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog" style="width:500px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							导入模板文件
						</h4>
						<span id="error" class="label label-danger" style="display:none">
						</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-6">
									<button name="fileUrl" id="fileUrl"></button>
								</div>
								<div class="col-xs-6">
									<a class="btn btn-success" id="upload" onclick="upload();" href="javascript:void();">开始上传</a>
							        <a class="btn btn-info" onclick="cancel();" href="javascript:void();">取消所有上传</a><br><br>
							        <h4 class="alert-success uploadInfo" style="height:60px;" id="uploadInfo">
							        	准备就绪
									</h4>
								</div>
							</div>
							<div class="col-xs-12">
								<br>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">
								关闭
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="showImageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
			<div class="modal-dialog" style="width:800px;height:500px;">
				<div class="modal-content">
					<div class="modal-header" style="border-bottom:0px solid #e5e5e5">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							查看大图
						</h4>
						<a href="javascript:void"><img width="100%" height="100%" id="showImage"/></a>
					</div>
				</div>
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
							模板信息管理
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<form id="objectForm" method="post" onsubmit="return false;">
									<input type="hidden" name="templateId" id="templateId">
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											模板标题：
										</label>
										<div class="col-xs-8">
											<input id="templateTitle" name="templateTitle" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											模板名称：
										</label>
										<div class="col-xs-8">
											<input id="templateName" name="templateName" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											适用框架：
										</label>
										<div class="col-xs-8">
											<select id="applyFrame" name="applyFrame" class="form-control">
												<option value="SM">Spring MyBatis</option>
												<option value="SSH">Spring Struts Hibernate</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											是否可用：
										</label>
										<div class="col-xs-8">
											<select id="isValidation" name="isValidation" class="form-control">
												<option value="YES">可用</option>
												<option value="NO">不可用</option>
											</select>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											模板图片：
										</label>
										<div class="col-xs-8">
											<div class="col-xs-6">
												<button id="fileImageUrl" name="fileImageUrl"></button>
											</div>
											<div class="col-xs-6">
												<a class="btn btn-xs btn-success" style="float:right;" id="uploadImage" onclick="uploadImage();" href="javascript:void();">开始上传</a>
											</div>
											<span id="fileName"></span>
											<div class="col-xs-12">
												<input id="imageUrl" name="imageUrl" class="form-control" type="hidden">
											</div>
										</div>
									</div>
									<div class="form-group col-xs-12">
										<label class="col-xs-4 control-label">
											备注：
										</label>
										<div class="col-xs-8">
											<input id="memo" name="memo" class="form-control" type="text">
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