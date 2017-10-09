package ${serviceImplPackage};

import com.hundsun.sse.common.exception.ServiceException;
import ${beanPackage}.${table.tableName?cap_first};
import com.hundsun.sse.bond.project.dto.${table.tableName?cap_first}Qry;
import ${mapperPackage}.${table.tableName?cap_first}DAO;

import ${servicePackage}.${table.tableName?cap_first}Service;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("${table.tableName?uncap_first}Service")
public class ${className?cap_first} implements ${table.tableName?cap_first}Service {

    /** 日志管理 */
    private static final Logger logger = LoggerFactory.getLogger(${className?cap_first}.class);
    
	@Autowired
	private ${table.tableName?cap_first}DAO ${table.tableName?uncap_first}DAO;
	


	/**
	* 添加${table.tableTitle}信息
	* 
 	*/
 	@Override
    public Long insert(${table.tableName?cap_first} ${table.tableName?uncap_first}){
    	try {
		    ${table.tableName?uncap_first}DAO.insert(${table.tableName?uncap_first});
		    return ${table.tableName?uncap_first}.get${javaPrimary?cap_first}();
		} catch (Exception e) {
		    logger.error("添加${table.tableTitle}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("保存失败");
		}
    }

	/**
 	* ${table.tableTitle}属性非空保存
 	* 
 	*/
 	@Override
    public Long insertSelective(${table.tableName?cap_first} ${table.tableName?uncap_first}){
    	try {
		    ${table.tableName?uncap_first}DAO.insert(${table.tableName?uncap_first});
		    return ${table.tableName?uncap_first}.get${javaPrimary?cap_first}();
		} catch (Exception e) {
		    logger.error("添加${table.tableTitle}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("保存失败");
		}
    }
	
	/**
 	* 根据Id查询${table.tableTitle}
 	* 
 	*/
 	@Override
    public ${table.tableName?cap_first} selectById(Long id){
    	try {
		    return ${table.tableName?uncap_first}DAO.selectById(id);
		} catch (Exception e) {
		    logger.error("根据${table.tableTitle}ID查询${table.tableTitle}失败,id=" + ${javaPrimary?uncap_first}, e);
		    throw new ServiceException("查询${table.tableTitle}失败");
		}
    };

	/**
 	* 修改${table.tableTitle}
 	* 
 	*/
 	@Override
    public int updateById(${table.tableName?cap_first} ${table.tableName?uncap_first}){
    	try {
		    return ${table.tableName?uncap_first}DAO.updateById(${table.tableName?uncap_first});
		} catch (Exception e) {
		    logger.error("修改${table.tableTitle}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("修改失败");
		}
    }
    
    /**
 	* ${table.tableTitle}属性非空修改
 	* 
 	*/
 	@Override
    public int updateIdKeySelective(${table.tableName?cap_first} ${table.tableName?uncap_first}){
    	try {
		    return ${table.tableName?uncap_first}DAO.updateIdKeySelective(${table.tableName?uncap_first});
		} catch (Exception e) {
		    logger.error("修改${table.tableTitle}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("修改失败");
		}
    }
    
    /**
 	* 根据id删除${table.tableTitle}
 	* 
 	*/
 	@Override  	
	public int deleteById(Long id){
		try {
		    return ${table.tableName?uncap_first}DAO.deleteById(${javaPrimary?uncap_first});
		} catch (Exception e) {
		    logger.error("删除${table.tableTitle}失败,id=" + ${javaPrimary?uncap_first}, e);
		    throw new ServiceException("删除失败");
		}
	}
    
    /**
 	* 根据查询参数查询列表 ${table.tableTitle}
 	* 
 	*/	 
 	@Override
	public List<${table.tableName?cap_first}> findAll(${table.tableName?cap_first}Qry query){
		try {
		    return ${table.tableName?uncap_first}DAO.findAll(query);
		} catch (Exception e) {
		    logger.error("根据${table.tableTitle}属性查询列表失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(query), e);
		    throw new ServiceException("查询列表失败");
		}
	}
}
