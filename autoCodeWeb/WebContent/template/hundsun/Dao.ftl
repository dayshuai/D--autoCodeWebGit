package ${mapperPackage};

import java.util.List;

import ${beanPackage}.${table.tableName?cap_first};
import com.hundsun.sse.bond.project.dto.${table.tableName?cap_first}Qry;
import com.hundsun.sse.common.dao.IDAO;

/**
 * ${table.tableTitle}数据访问
 * 
 */
public interface ${className?cap_first} extends IDAO<${table.tableName?cap_first}, ${table.tableName?cap_first}Qry> {
	
	/**
 	* 保存${table.tableTitle}
 	* 
 	*/
    int insert(${table.tableName?cap_first} ${table.tableName?uncap_first});

	/**
 	* ${table.tableTitle}属性非空保存
 	* 
 	*/
    int insertSelective(${table.tableName?cap_first} ${table.tableName?uncap_first});
	
	/**
 	* 根据Id查询${table.tableTitle}
 	* 
 	*/
    ${table.tableName?cap_first} selectById(Long id);

	/**
 	* 修改${table.tableTitle}
 	* 
 	*/
    int updateById(${table.tableName?cap_first} ${table.tableName?uncap_first});
    
    /**
 	* ${table.tableTitle}属性非空修改
 	* 
 	*/
    int updateIdKeySelective(${table.tableName?cap_first} ${table.tableName?uncap_first});
    
    /**
 	* 根据id删除${table.tableTitle}
 	* 
 	*/	    	
	int deleteById(Long id);
    
    /**
 	* 根据对象属性查询列表 ${table.tableTitle}
 	* 
 	*/	 
	List<${table.tableName?cap_first}> findAll(${table.tableName?cap_first}Qry query);
	
}
