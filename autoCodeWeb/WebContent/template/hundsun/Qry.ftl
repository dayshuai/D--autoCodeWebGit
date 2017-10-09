package com.hundsun.sse.bond.project.dto;

import com.hundsun.sse.bond.project.entity.${table.tableName?cap_first};
import com.hundsun.sse.common.model.QueryBase;

<#-- 循环自身字段导包 --> 
<#list columnList as column>
	<#if column.isImportPackage=="YES">
import ${column.importPackageName};
	</#if>
</#list>

public class ${className?cap_first} extends QueryBase<${table.tableName?cap_first}> {
	
<#-- 循环自身字段 --> 
<#list columnList as column>

	/** ${column.columnZhName} **/
	private ${column.columnType?cap_first} ${column.columnName?uncap_first};
</#list>

	public ${className?cap_first}(){

	}

	public ${className?cap_first}(<#list columnList as column><#if column.isPrimary!="YES"><#if column_has_next>${column.columnType} ${column.columnName},<#else>${column.columnType} ${column.columnName}</#if></#if></#list>){
	<#list columnList as column>
		<#if column.isPrimary!="YES">
		this.${column.columnName?uncap_first}=${column.columnName?uncap_first};
		</#if> 
	</#list>
	}
<#-- 循环自身字段 getset --> 	
<#list columnList as column>
	public void set${column.columnName?cap_first}(${column.columnType?cap_first} ${column.columnName?uncap_first}){
		this.${column.columnName?uncap_first}=${column.columnName?uncap_first};
	}

	public ${column.columnType?cap_first} get${column.columnName?cap_first}(){
		return this.${column.columnName?uncap_first};
	}
	
</#list>
}