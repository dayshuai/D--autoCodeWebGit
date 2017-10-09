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
<body>
	<form id="objectForm" method="post" action="columnConvert/uploadFile.html?toPage=true" enctype="multipart/form-data">
		<div class="modal-header">
			<h3 class="modal-title col-xs-8">
				导入数据
			</h3>
			<div class="col-xs-4">
				<a href="download/convertExcel.html" target="_blank" class="btn btn-primary">
					Excel例子
				</a>
			</div>
			<br/><br/>
		</div>
		<div class="modal-body">
			<div class="col-xs-12">
				<div class="form-group col-xs-12">
					<label class="col-xs-4 control-label">
						Excel路径：
					</label>
					<div class="col-xs-8">
						<input id="file" name="file" class="form-control" type="file">
						<input id="mediaUrl" name="mediaUrl" class="form-control" type="hidden">
					</div>
				</div>
				<div class="form-group col-xs-12">
					<label class="col-xs-4 control-label">
						读取页数：
					</label>
					<div class="col-xs-8">
						<input id="pageIndex" name="pageIndex" class="form-control" type="text" value="0">
					</div>
				</div>
			</div>
		</div>
		<div class="col-xs-12 modal-footer">
			<button type="submit" class="btn btn-default" data-dismiss="modal">
				确定
			</button>
		</div>
	</form><br/>
	<div class="col-xs-12">
		<div class="form-group col-xs-12">
			<c:if test="${!empty result}">
		  		<c:if test="${result=='true'}">
		  			<h4>导入成功:${message}</h4>
		  		</c:if>
		  		<c:if test="${result=='false'}">
		  			<h4>导入失败:${message}</h4>
		  		</c:if>
			</c:if>
		</div>
	</div>
  </body>
</html>