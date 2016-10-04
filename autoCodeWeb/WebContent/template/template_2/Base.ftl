package ${beanPackage};

import ${basePackage}.BaseBean;

public class ${bean?cap_first} extends BaseBean implements java.io.Serializable {

<#list columnList as column>
	private ${column.columnType?cap_first} ${column.columnName?uncap_first};
</#list>

	public ${bean?cap_first}(){

	}

	public ${bean?cap_first}(${structureParameter}){
	<#list columnList as column>
		<#if column.isPrimary!="YES">
		this.${column.columnName?uncap_first}=${column.columnName?uncap_first} ;
		</#if> 
	</#list>
	}
	
<#list columnList as column>
	public void set${column.columnName?cap_first}(${column.columnType?cap_first} ${column.columnName?uncap_first}){
		this.${column.columnName?uncap_first}=${column.columnName?uncap_first};
	}

	public ${column.columnType?cap_first} get${column.columnName?cap_first}(){
		return this.${column.columnName?uncap_first};
	}
	
</#list>
	@Override
	public String toString(){
		return "${bean?cap_first}[${beanToString} ]";
	}

}