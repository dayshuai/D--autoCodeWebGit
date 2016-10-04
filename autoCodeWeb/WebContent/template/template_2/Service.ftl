package ${servicePackage};

import ${basePackage}.Pagination;
import ${beanPackage}.${table.tableName?cap_first};

import java.util.List;
import java.util.Map;

public interface ${className?cap_first} {

	/**
	 * 添加${table.tableTitle}信息
	 * 
	 * @param ${table.tableName?uncap_first}
	 * @return
	 */
	public Integer insert${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first});

	/**
	 * 更新${table.tableTitle}信息
	 * 
	 * @param ${table.tableName?uncap_first}
	 * @return
	 */
	public Integer update${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first});

	/**
	 * 根据id删除${table.tableTitle}信息
	 * 
	 * @param ${table.tableName?uncap_first}Id
	 * @return
	 */
	public Integer delete${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first});

	/**
	 * 根据批量删除${table.tableTitle}信息
	 * 
	 * @param ids
	 * @return
	 */
	public Integer delete${table.tableName?cap_first}s(String ids);
	
	/**
	 * 根据主键id查询
	 * 
	 * @param ${table.tableName?uncap_first}Id
	 * @return
	 */
	public ${table.tableName?cap_first} querySingle${table.tableName?cap_first}(Integer ${table.tableName?uncap_first}Id);
	
	/**
	 * 根据${table.tableTitle}属性查询(不包含主键)
	 * 
	 * @param ${table.tableName?uncap_first}
	 * @return
	 */
	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}List(${table.tableName?cap_first} ${table.tableName?uncap_first});
	
	/**
	 * 分页查询${table.tableTitle}
	 * 
	 * @param ${table.tableName?uncap_first}
	 * @return
	 */
	public Pagination query${table.tableName?cap_first}PaginationList(${table.tableName?cap_first} ${table.tableName?uncap_first});

	/**
	 * 查询${table.tableTitle}下拉框列表
	 * 
	 * @param ${table.tableName?uncap_first}
	 * @return
	 */
	public Map<Object, Object> query${table.tableName?cap_first}Select();
	
}
