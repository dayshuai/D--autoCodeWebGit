package ${beanPackage};

import ${basePackage}.BootstrapQueryBean;
<#-- 循环自身字段导包 --> 
<#list columnList as column>
	<#if column.columnType=="Date">
import ${utilPackage}.DateTimeSerializer;
	</#if>
	<#if column.isImportPackage=="YES">
import ${column.importPackageName};
	</#if>
</#list>
<#-- 循环关系字段导包 --> 
<#list relationList as relation>
	<#if relation.tableId==table.tableId>
		<#if relation.relation=="OneToMany">
import ${List};
		<#break>
		</#if>
	</#if>
</#list>
import java.io.Serializable;
<#list columnList as column>
	<#if column.columnType=="Date">
import org.codehaus.jackson.map.annotate.JsonSerialize;
	<#break>
	</#if>
</#list>

@SuppressWarnings("serial")
public class ${className?cap_first} extends BootstrapQueryBean implements Serializable{
<#-- 循环自身字段 --> 
<#list columnList as column>
	/** ${column.columnZhName} **/
	private ${column.columnType?cap_first} ${column.columnName?uncap_first};
</#list>
<#-- 循环引用关系字段 --> 
	//-------- 以下字段只能用于查询赋值或临时使用  ----------
<#list relationList as relation>
	<#if relation.tableId==table.tableId>
		<#if relation.relation=="OneToOne"||relation.relation=="ManyToOne">
	private ${relation.relationColumnType} ${relation.relationShowColumnName?uncap_first};
		<#elseif relation.relation=="OneToMany">
	private List<${relation.relationTableName?cap_first}> ${relation.relationTableName?uncap_first}List;
		</#if>
	</#if>
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
	<#if column.columnType=="Date">
	@JsonSerialize(using=DateTimeSerializer.class)
	</#if> 
	public void set${column.columnName?cap_first}(${column.columnType?cap_first} ${column.columnName?uncap_first}){
		this.${column.columnName?uncap_first}=${column.columnName?uncap_first};
	}

	public ${column.columnType?cap_first} get${column.columnName?cap_first}(){
		return this.${column.columnName?uncap_first};
	}
	
</#list>
<#-- 循环引用关系字段getset --> 
<#list relationList as relation>
	<#if relation.tableId==table.tableId>
		<#if relation.relation=="OneToOne"||relation.relation=="ManyToOne">
	public void set${relation.relationShowColumnName?cap_first}(${relation.relationColumnType} ${relation.relationShowColumnName?uncap_first}){
		this.${relation.relationShowColumnName?uncap_first}=${relation.relationShowColumnName?uncap_first};
	}

	public ${relation.relationColumnType?cap_first} get${relation.relationShowColumnName?cap_first}(){
		return this.${relation.relationShowColumnName?uncap_first};
	}
			
		<#elseif relation.relation=="OneToMany">
	public void set${relation.relationTableName?cap_first}List(List<${relation.relationTableName?cap_first}> ${relation.relationTableName?uncap_first}List){
		this.${relation.relationTableName?uncap_first}List=${relation.relationTableName?uncap_first}List;
	}

	public List<${relation.relationTableName?cap_first}> get${relation.relationTableName?cap_first}List(){
		return this.${relation.relationTableName?uncap_first}List;
	}
		</#if>
	</#if> 
</#list>
}