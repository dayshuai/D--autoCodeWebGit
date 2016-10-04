package ${serviceImplPackage};

import ${basePackage}.ServiceException;
import ${beanPackage}.${table.tableName?cap_first};
import ${mapperPackage}.${table.tableName?cap_first}Mapper;
<#if isRelation=="true">
<#list relationList as relation>
<#if relation.cascadeDelete=="YES">
import ${mapperPackage}.${relation.relationTableName?cap_first}Mapper;
</#if>
</#list>
</#if>
import ${servicePackage}.${table.tableName?cap_first}Service;
import ${basePackage}.BaseService;
import ${basePackage}.Pagination;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("${table.tableName?uncap_first}Service")
public class ${className?cap_first} extends BaseService implements ${table.tableName?cap_first}Service {

    /** 日志管理 */
    private static final Logger logger = LoggerFactory.getLogger(${className?cap_first}.class);
    
	@Autowired
	private ${table.tableName?cap_first}Mapper ${table.tableName?uncap_first}Mapper;
	
	<#if isRelation=="true">
	<#list relationList as relation>
	<#if relation.cascadeDelete=="YES">
	@Autowired
	private ${relation.relationTableName?cap_first}Mapper ${relation.relationTableName?uncap_first}Mapper;
	
	</#if>
	</#list>
	</#if>
	private void validation(${table.tableName?cap_first} ${table.tableName?uncap_first},String operatorState) {
		if (${table.tableName?uncap_first}==null) {
			throw new ServiceException("表单不能为空");
		}
		if (operatorState.equals("update")) {
			if (${table.tableName?uncap_first}.get${javaPrimary?cap_first}()==null) {
				throw new ServiceException("序号不能为空");
			}
		}
<#list columnList as column>
	<#if column.isPrimary!="YES">
		if (isBlank(${table.tableName?uncap_first}.get${column.columnName?cap_first}())) {
			throw new ServiceException("${column.columnZhName}不能为空");
		}
	</#if>
</#list>
	}
	
	/**
     * 添加${table.tableTitle}
     * 
     * @param column
     * @return
     */
    @Override
	public Integer insert${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		validation(${table.tableName?uncap_first}, "insert");
		try {
		    ${table.tableName?uncap_first}Mapper.insert(${table.tableName?uncap_first});
		    return ${table.tableName?uncap_first}.get${javaPrimary?cap_first}();
		} catch (Exception e) {
		    logger.error("添加${table.tableTitle}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("保存失败");
		}
    }

    /**
     * 更新${table.tableTitle}
     * 
     * @param ${table.tableName?uncap_first}
     * @return
     */
    @Override
    public Integer update${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		validation(${table.tableName?uncap_first}, "update");
		try {
		    return ${table.tableName?uncap_first}Mapper.update(${table.tableName?uncap_first});
		} catch (Exception e) {
		    logger.error("修改${table.tableName}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("修改失败");
		}
    }

    /**
     * 根据id删除${table.tableTitle}
     * 
     * @param ${javaPrimary?uncap_first}
     * @return
     */
    @Override
    public Integer delete${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first}) {
		try {
		    return ${table.tableName?uncap_first}Mapper.delete(${javaPrimary?uncap_first});
		} catch (Exception e) {
		    logger.error("删除${table.tableTitle}失败,id=" + ${javaPrimary?uncap_first}, e);
		    throw new ServiceException("删除失败");
		}
    }

    /**
     * 根据批量删除${table.tableTitle}
     * 
     * @param ids
     * @return
     */
    @Override
    public Integer delete${table.tableName?cap_first}s(String ids) {
		try {
		    return ${table.tableName?uncap_first}Mapper.deletes(ids);
		} catch (Exception e) {
		    logger.error("批量删除${table.tableTitle}失败,ids=" + ids, e);
		    throw new ServiceException("批量删除失败");
		}
    }

    /**
     * 根据主键id查询
     * 
     * @param ${javaPrimary?uncap_first}
     * @return
     */
    @Override
    public ${table.tableName?cap_first} querySingle${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first}) {
		try {
		    return ${table.tableName?uncap_first}Mapper.querySingleObject(${javaPrimary?uncap_first});
		} catch (Exception e) {
		    logger.error("根据${table.tableTitle}ID查询${table.tableName}失败,${javaPrimary?uncap_first}=" + ${javaPrimary?uncap_first}, e);
		    throw new ServiceException("查询${table.tableName}失败");
		}
    }

    /**
     * 分页查询${table.tableTitle}
     * 
     * @param ${table.tableName?uncap_first}
     * @return
     */
    @Override
    public Pagination query${table.tableName?cap_first}PaginationList(${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
		    Integer totalCount = ${table.tableName?uncap_first}Mapper.queryPaginationCount(${table.tableName?uncap_first});
		    List<${table.tableName?cap_first}> dataList = null;
		    if (totalCount > 0) {
			dataList = ${table.tableName?uncap_first}Mapper.queryPaginationList(${table.tableName?uncap_first});
		    }
		    return buildPagination(totalCount, dataList);
		} catch (Exception e) {
		    logger.error("分页查询${table.tableTitle}失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("查询异常");
		}
    }

    /**
     * 根据${table.tableTitle}属性查询(不包含主键)
     * 
     * @param ${table.tableName?uncap_first}
     * @return
     */
    @Override
    public List<${table.tableName?cap_first}> query${table.tableName?cap_first}List(${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
		    return ${table.tableName?uncap_first}Mapper.queryObjectList(${table.tableName?uncap_first});
		} catch (Exception e) {
		    logger.error("根据${table.tableTitle}属性查询列表失败,${table.tableName?uncap_first}=" + ToStringBuilder.reflectionToString(${table.tableName?uncap_first}), e);
		    throw new ServiceException("查询列表失败");
		}
    }

    /**
     * 查询${table.tableTitle}下拉框列表
     * 
     * @param ${table.tableName?uncap_first}
     * @return
     */
    @Override
    public Map<Object, Object> query${table.tableName?cap_first}Select() {
		try {
		    List<${table.tableName?cap_first}> ${table.tableName?uncap_first}List = ${table.tableName?uncap_first}Mapper.queryObjectSelect();
		    Map<Object, Object> dataMap = new HashMap<Object, Object>();
		    for (${table.tableName?cap_first} ${table.tableName?uncap_first} : ${table.tableName?uncap_first}List) {
				dataMap.put(${table.tableName?uncap_first}.get${javaPrimary?cap_first}(), ${table.tableName?uncap_first}.get${showColumnName?cap_first}());
		    }
		    return dataMap;
		} catch (Exception e) {
		    logger.error("查询${table.tableTitle}下拉框列表失败", e);
		    throw new ServiceException("加载${table.tableTitle}下拉框列表失败");
		}
    }
}
