<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
	<div class="menus">
		<div class="logo">
		<!--  <a href="#" hidefocus="true" id="met_logo"><img src="images/230x83.png" style="width:225px;height:100%;"></a>
		-->
		</div>       
		<div class="menuNav" >
		  <ul id="topnav">
			<li id="metnav_2" class="list"><a href="javascript:void(0);" id="nav_2" class="${nav_2}" hidefocus="true"><span class="tab2"></span>项目管理</a></li>
			<li id="metnav_3" class="list"><a href="javascript:void(0);" id="nav_3" class="${nav_3}" hidefocus="true"><span class="tab3"></span>常用配置</a></li>
			<li id="metnav_4" class="list"><a href="javascript:void(0);" id="nav_4" class="${nav_4}" hidefocus="true"><span class="tab4"></span>模板管理</a></li>
			<li id="metnav_5" class="list"><a href="javascript:void(0);" id="nav_5" class="${nav_5}" hidefocus="true"><span class="tab5"></span>AutoCode
			</a></li>
		  </ul>
		</div>
		<div class="menudetail">
			<ul id="detail_2" style="<c:if test='${empty nav_2}'>display:none</c:if>" >
				<li><a href="project.html" class="${project}">项目列表</a></li>
				<li><a href="projectPackage.html" class="${projectPackage}">项目默认包</a></li>
				<li><a href="table.html" class="${table}">Bean管理</a></li>
				<li><a href="control.html" class="${control}">控制器管理</a></li>
				<li><a href="column.html" class="${column}">字段管理</a></li>
			    <li><a href="relation.html" class="${relation}">关系管理</a></li>
			</ul>
			<ul id="detail_3" style="<c:if test='${empty nav_3}'>display:none</c:if>" >
				<li><a href="columnConvert.html" class="${columnConvert}">字段转换配置</a></li>
				<li><a href="packageConfig.html" class="${packageConfig}">常用包名配置</a></li>
				<li><a href="databaseConvert.html" class="${databaseConvert}">数据类型配置</a></li>
				<li><a href="packageConvert.html" class="${packageConvert}">类包转换配置</a></li>
				<li><a href="config.html" class="${config}">系统配置管理</a></li>
			</ul>
			<ul id="detail_4" style="<c:if test='${empty nav_4}'>display:none</c:if>" >
				<li><a href="template.html" class="${template}">模板管理</a></li>
				<li><a href="templateConfig.html" class="${templateConfig}">模板配置</a></li>
			</ul>
			<ul id="detail_5" style="<c:if test='${empty nav_5}'>display:none</c:if>">
				<li><a href="produce/projectProduce.html" class="${oneKeyProduce}">项目生成</a></li>
				<!-- <li><a href="produce/classProduce.html" class="${classProduce}">类别生成</a></li>
				<li><a href="produce/tableProduce.html" class="${tableProduce}">单表生成</a></li>
				<li><a href="produce.html" class="${produce}">生成记录</a></li> -->
			</ul>
		</div>
	</div>
