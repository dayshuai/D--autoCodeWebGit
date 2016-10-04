<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
	<link rel="stylesheet" href="css/menu.css"/>
	<div class="menudetail">
		<ul>
			<#list tableList as table>
			<li><a href="${table.tableName?uncap_first}${project.requestPostfix}">${table.tableTitle}</a></li>
			</#list>
		</ul>
	</div>
