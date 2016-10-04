<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE>
<html>
	<head>
		<title>AutoCode</title>
		<base href="<%=basePath%>"/>
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
		<style>
	    	.setp h4{
	    		margin-top:8px;
	    	}
	    </style>
	</head>
<body>
<jsp:include  page="menu.jsp"/>
<br>
<div class="col-lg-12">
    <div class="col-lg-4">
      <div class="bs-component setp">
      	<h3>导入数据库设计使用步骤</h3><br>
        <h4 class="text-muted">1、创建项目(需要验证通过)</h2>
        <h4 class="text-muted">2、项目默认包</h4>
        <h4 class="text-muted">3、Bean管理,导入数据库设计<a href="download/projectExcel.html" target="_blank">Excel</a></h4>
        <h4 class="text-muted">4、控制器管理</h4>
        <h4 class="text-muted">5、字段信息管理</h4>
        <h4 class="text-muted">6、关系管理(建立表与表的关系)</h4>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="bs-component setp">
      	<h3>导入字段转换使用步骤</h3><br>
      	<h4 class="text-muted">1、字段转换配置导入<a href="download/convertExcel.html" target="_blank">Excel</a></h4>
        <h4 class="text-muted">2、创建项目(需要验证通过)</h4>
        <h4 class="text-muted">3、项目默认包</h4>
        <h4 class="text-muted">4、Bean管理,智能添加或一键添加</h4>
        <h4 class="text-muted">5、控制器管理</h4>
        <h4 class="text-muted">6、字段信息管理</h4>
        <h4 class="text-muted">7、关系管理(建立表与表的关系)</h4>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="bs-component setp">
      	<h3>Other</h3><br>
      	<h4 class="text-muted">1、目前只支持SSH框架和SM框架</h4>
      	<h4 class="text-muted">2、不支持项目逻辑生成，仅支持增删改查。</h4>
        <h4 class="text-muted">3、可以通过添加模板,生成各种各样的项目。</h4>
        <h4 class="text-muted">4、若不能满足自己的需求,可联系开发者定制。</h4>
      </div>
    </div>
  </div>
  <div>
  	<div class="col-xs-12">
      <div class="bs-component">
        <h3>疑难解答</h3><br/>
        <h4>下拉框中看不到创建的项目  -- <font color="blue">项目列表中修改为已经通过</font></h4><br/>
        <h4>下拉框中默认显示不是需要操作项目  -- <font color="blue">项目列表中默认操作修改为是</font></h4><br/>
        <h4>Error:0是什么  -- <font color="blue">项目中字段转换或表名转换错误的为Error:0</font></h4><br/>
        <h4>处理Error:0功能  -- <font color="blue">在转换表中添加相应的映射名称和转换名称,然后点击处理Error:0自动解决</font></h4><br/>
        <h4>验证数据库功能  -- <font color="blue">验证项目连接数据库是否正确,若手动添加表或字段可以手动设置为通过验证</font></h4><br/>
        <h4>重置项目功能  -- <font color="blue">删除所有关于项目的信息,保留项目默认包(初始化状态)</font></h4><br/>
        <h4>项目包(一键替换)功能  -- <font color="blue">替换项目所有包路径替换值</font></h4><br/>
        <h4>Bean管理(智能添加)功能  -- <font color="blue">根据项目数据源找出数据库中对应的字段和表信息并匹配字段转换表</font></h4><br/>
        <h4>Bean管理(一键添加)功能  -- <font color="blue">根据项目数据源结合字段配置信息把所有的表添加到数据库中</font></h4><br/>
        <h4>Bean管理(导入)功能  -- <font color="blue">导入项目数据库设计Excel,程序会自动解析Excel并插入数据库</font></h4><br/>
        <h4>Bean管理(移除前缀)功能  -- <font color="blue">删除表名带_前面的,保留后面的</font></h4><br/>
        <h4>关系管理(自动找关系)功能  -- <font color="blue">通过项目中的表,根据字段名称和类型(Integer)自动建立关系</font></h4><br/>
        <h4>字段转换配置  -- <font color="blue">用于添加表和字段的时候会自动根据配置的信息找到转换的信息,只能是映射名不能重复</font></h4><br/>
        <h4>常用包名配置  -- <font color="blue">用于添加项目时读取对应的框架信息并替换[replace]为项目名称,插入到数据库中</font></h4><br/>
        <h4>数据库类型配置  -- <font color="blue">用于添加字段时类型的一个转换识别</font></h4><br/>
        <h4>类包转换配置  -- <font color="blue">用于识别字段类型是否导入,若需要导写入时会自动把相应的包写入</font></h4><br/>
        <h4>系统配置管理  -- <font color="blue">用于系统的配置,请不要随意修改,否则系统无法正常运行</font></h4><br/>
        <h4>模板管理  -- <font color="blue">用于项目生成</font></h4><br/>
        <h4>模板管理(导入模板)  -- <font color="blue">导入配置的模板用于解析</font></h4><br/>
        <h4>模板配置  -- <font color="blue">配置文件生成时使用相应的模板</font></h4><br/>
        <h4>项目生成  -- <font color="blue">一键生成项目所有文件</font></h4><br/>
        <h4>项目生成(文件数量不对)  -- <font color="blue">检查模板配置是否正确(主要检查动态生成静态生成和拷贝)</font></h4><br/>
        <h4>类别生成  -- <font color="blue">只生成选择模板(只有动态模板可选)</font></h4><br/>
        <h4>单表生成  -- <font color="blue">只生成选择表(只能选择一张表)</font></h4><br/>
        <h4>生成项目报错  -- <font color="blue">检查模板是否正确</font></h4><br/>
      </div>
    </div>
  </div>
</body>
</html>