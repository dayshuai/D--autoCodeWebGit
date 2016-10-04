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

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("${table.tableName?uncap_first}Service")
public class ${className?cap_first} extends BaseService implements ${table.tableName?cap_first}Service {
	private static final Log LOG = LogFactory.getLog(${className?cap_first}.class);
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
	
	@Override
	public Integer insert${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first}){
		validation(${table.tableName?uncap_first},"insert");
		try {
			${table.tableName?uncap_first}Mapper.insert(${table.tableName?uncap_first});
			return ${table.tableName?uncap_first}.get${javaPrimary?cap_first}();
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.insert${table.tableName?cap_first} [ "+${table.tableName?uncap_first}+" ] 添加失败", e);
			throw new ServiceException("添加失败");
		}
	}

	@Override
	public Integer update${table.tableName?cap_first}(${table.tableName?cap_first} ${table.tableName?uncap_first}){
		validation(${table.tableName?uncap_first},"update");
		try {
			return ${table.tableName?uncap_first}Mapper.update(${table.tableName?uncap_first});
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.update${table.tableName?cap_first} [ "+${table.tableName?uncap_first}+" ] 修改失败", e);
			throw new ServiceException("修改失败");
		}
	}

	@Override
	public Integer delete${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first}){
		try {
			<#if isRelation=="true">
			<#list relationList as relation>
			<#if relation.cascadeDelete=="YES">
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("columnName", "${databasePrimary?uncap_first}");
			map.put("columnValue", ${javaPrimary?uncap_first});
			<#break>
			</#if>
			</#list>
			</#if>
			<#if isRelation=="true">
			<#list relationList as relation>
			<#if relation.cascadeDelete=="YES">
			${relation.relationTableName?uncap_first}Mapper.deleteForMap(map);
			</#if>
			</#list>
			</#if>
			return ${table.tableName?uncap_first}Mapper.delete(${javaPrimary?uncap_first});
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.delete${table.tableName?cap_first} [ "+${javaPrimary?uncap_first}+" ] 删除失败", e);
			throw new ServiceException("删除失败");
		}
	}

	@Override
	public Integer delete${table.tableName?cap_first}s(String idStrs){
		try {
			<#if isRelation=="true">
			<#list relationList as relation>
			<#if relation.cascadeDelete=="YES">
			String[] ids=idStrs.split(",");
			for (int i = 0; i < ids.length; i++) {
				delete${table.tableName?cap_first}(Integer.parseInt(ids[i]));
			}
			return ids.length;
			<#break>
			</#if>
			<#if !relation_has_next>
			return ${table.tableName?uncap_first}Mapper.deletes(idStrs);
			</#if>
			</#list>
			<#else>
			return ${table.tableName?uncap_first}Mapper.deletes(idStrs);
			</#if>
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.delete${table.tableName?cap_first}s [ "+idStrs+" ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}
	
	@Override
	public Integer delete${table.tableName?cap_first}ForColumn(String columnName,Object columnValue){
		try {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return ${table.tableName?uncap_first}Mapper.deleteForMap(map);
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.delete${table.tableName?cap_first}ForColumn [ columnName="+columnName+",columnValue="+columnValue+" ] 根据字段删除失败", e);
			throw new ServiceException("根据字段删除失败");
		}
	}
	
	@Override
	public ${table.tableName?cap_first} querySingle${table.tableName?cap_first}(Integer ${javaPrimary?uncap_first}) {
		try {
			return ${table.tableName?uncap_first}Mapper.querySingleObject(${javaPrimary?uncap_first});
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.querySingle${table.tableName?cap_first} [ "+${javaPrimary?uncap_first}+" ] 查询对象失败", e);
			throw new ServiceException("查询对象失败");
		}
	}
	
	@Override
	public ${table.tableName?cap_first} querySingle${table.tableName?cap_first}ForColumn(String columnName,Object columnValue) {
		try {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return ${table.tableName?uncap_first}Mapper.querySingleObjectForMap(map);
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.querySingle${table.tableName?cap_first}ForColumn [ columnName="+columnName+",columnValue="+columnValue+" ] 根据字段查询对象失败", e);
			throw new ServiceException("根据字段查询对象失败");
		}
	}
	
	@Override
	public Integer query${table.tableName?cap_first}PaginationCount(${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
			return ${table.tableName?uncap_first}Mapper.queryObjectPaginationCount(${table.tableName?uncap_first});
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.query${table.tableName?cap_first}Count [ "+${table.tableName?uncap_first}+" ] 查询条数失败", e);
			throw new ServiceException("查询条数失败");
		}
	}

	@Override
	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}PaginationList(${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
			return ${table.tableName?uncap_first}Mapper.queryObjectPaginationList(${table.tableName?uncap_first});
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.query${table.tableName?cap_first}List [ "+${table.tableName?uncap_first}+" ] 查询列表失败", e);
			throw new ServiceException("查询列表失败");
		}
	}
	
	@Override
	public Integer query${table.tableName?cap_first}Count() {
		try {
			return ${table.tableName?uncap_first}Mapper.queryObjectCount();
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.query${table.tableName?cap_first}Count 统计查询失败", e);
			throw new ServiceException("统计查询失败");
		}
	}
	
	@Override
	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}List() {
		try {
			return ${table.tableName?uncap_first}Mapper.queryObjectList();
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.query${table.tableName?cap_first}Select 查询下拉框列表失败", e);
			throw new ServiceException("查询下拉框列表失败");
		}
	}
	
	@Override
	public Integer query${table.tableName?cap_first}CountForColumn(String columnName,Object columnValue) {
		try {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return ${table.tableName?uncap_first}Mapper.queryObjectCountForMap(map);
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.query${table.tableName?cap_first}CountForColumnName 根据字段统计查询失败", e);
			throw new ServiceException("根据字段统计查询失败");
		}
	}
	
	@Override
	public List<${table.tableName?cap_first}> query${table.tableName?cap_first}ListForColumn(String columnName,Object columnValue) {
		try {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return ${table.tableName?uncap_first}Mapper.queryObjectListForMap(map);
		} catch (Exception e) {
			LOG.error("${table.tableName?cap_first}ServiceImpl.query${table.tableName?cap_first}ListForColumnName 根据字段查询失败", e);
			throw new ServiceException("根据字段查询失败");
		}
	}
}
