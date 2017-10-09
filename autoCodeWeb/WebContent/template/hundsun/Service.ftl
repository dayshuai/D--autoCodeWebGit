package ${servicePackage};

import java.util.List;

import com.hundsun.jresplus.remoting.impl.annotation.ServiceModule;
import com.hundsun.sse.bond.project.dto.${table.tableName?cap_first}Qry;
import ${beanPackage}.${table.tableName?cap_first};
import com.hundsun.sse.common.service.IService;

@ServiceModule
public interface ${className?cap_first} extends IService{

	/**
	* 添加${table.tableTitle}信息
	* 
 	*/
    public Long insert(${table.tableName?cap_first} ${table.tableName?uncap_first});

	/**
 	* ${table.tableTitle}属性非空保存
 	* 
 	*/
    public Long insertSelective(${table.tableName?cap_first} ${table.tableName?uncap_first});
	
	/**
 	* 根据Id查询${table.tableTitle}
 	* 
 	*/
    public ${table.tableName?cap_first} selectById(Long id);

	/**
 	* 修改${table.tableTitle}
 	* 
 	*/
    public int updateById(${table.tableName?cap_first} ${table.tableName?uncap_first});
    
    /**
 	* ${table.tableTitle}属性非空修改
 	* 
 	*/
    public int updateIdKeySelective(${table.tableName?cap_first} ${table.tableName?uncap_first});
    
    /**
 	* 根据id删除${table.tableTitle}
 	* 
 	*/	    	
	public int deleteById(Long id);
    
    /**
 	* 根据查询参数查询列表 ${table.tableTitle}
 	* 
 	*/	 
	public List<${table.tableName?cap_first}> findAll(${table.tableName?cap_first}Qry ${table.tableName?uncap_first}Qry);
	
}
