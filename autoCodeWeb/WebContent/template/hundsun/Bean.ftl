package com.hundsun.sse.bond.project.entity;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.hundsun.sse.common.model.AbstractEntity;

<#-- 循环自身字段导包 --> 
<#list columnList as column>
	<#if column.isImportPackage=="YES">
import ${column.importPackageName};
	</#if>
</#list>

@Entity
@XmlRootElement
@JsonNaming(PropertyNamingStrategy.LowerCaseWithUnderscoresStrategy.class) 
public class ${className?cap_first} extends AbstractEntity {

	private static final long serialVersionUID = 1L;
	
<#-- 循环自身字段 --> 
<#list columnList as column>

	/** ${column.columnZhName} **/
	@JsonProperty(value="${column.mappingName}")
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