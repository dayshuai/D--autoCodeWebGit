package ${servicePackage};

import ${beanPackage}.${table.tableName?cap_first};
import java.util.List;

public interface ${className?cap_first} {

	public Integer insert${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first});

	public Integer update${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first});

	public Integer delete${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first});

	public Integer delete${table.tableName?cap_first}s(String ids);
	
	public Integer delete${table.tableName?cap_first}ForColumn(String columnName,Object columnValue);
	
	public ${table.tableName?cap_first} querySingle${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first});

	public ${table.tableName?cap_first} querySingle${table.tableName?cap_first}ForColumn(String columnName,Object columnValue);
	
	public Integer query${table.tableName?cap_first}PaginationCount(${table.tableName?cap_first} ${table.tableName?uncap_first});

	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}PaginationList(${table.tableName?cap_first} ${table.tableName?uncap_first});

	public Integer query${table.tableName?cap_first}Count();
	
	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}List();
	
	public Integer query${table.tableName?cap_first}CountForColumn(String columnName,Object columnValue);
	
	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}ListForColumn(String columnName,Object columnValue);
}
