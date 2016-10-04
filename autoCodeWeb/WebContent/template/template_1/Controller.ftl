package ${controllerPackage};

import ${beanPackage}.${table.tableName?cap_first};
import ${servicePackage}.${table.tableName?cap_first}Service;
import ${basePackage}.BaseController;
import ${basePackage}.Pagination;
import ${basePackage}.ServiceException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/${table.tableName?uncap_first}")
public class ${className?cap_first} extends BaseController{ 
	private static final Log LOG = LogFactory.getLog(${className?cap_first}.class);
	@Inject
	private ${table.tableName?cap_first}Service ${table.tableName?uncap_first}Service;

	@RequestMapping()
	public String index(Model model) {
		return "${table.tableName?uncap_first}";
	}
	
	<#if control.isInsertMethod=="NO">
	/**
	</#if>
	@ResponseBody
	@RequestMapping("insert${table.tableName?cap_first}")
	public Map<String, Object> insert${table.tableName?cap_first}(Model model,${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
			${table.tableName?uncap_first}Service.insert${table.tableName?cap_first}(${table.tableName?uncap_first});
		} catch (Exception e) {
			LOG.error("${className?cap_first}.insert${table.tableName?cap_first} [添加失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}
	<#if control.isInsertMethod=="NO">
	**/
	</#if>

	<#if control.isUpdateMethod=="NO">
	/**
	</#if>
	@ResponseBody
	@RequestMapping("update${table.tableName?cap_first}")
	public Map<String, Object> update${table.tableName?cap_first}(Model model,${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
			${table.tableName?uncap_first}Service.update${table.tableName?cap_first}(${table.tableName?uncap_first});
		} catch (Exception e) {
			LOG.error("${className?cap_first}.update${table.tableName?cap_first} [修改失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}
	<#if control.isUpdateMethod=="NO">
	**/
	</#if>

	<#if control.isDeleteMethod=="NO">
	/**
	</#if>
	@ResponseBody
	@RequestMapping("delete${table.tableName?cap_first}")
	public Map<String, Object> delete${table.tableName?cap_first}(Model model,Integer id) {
		try {
			${table.tableName?uncap_first}Service.delete${table.tableName?cap_first}(id);
		} catch (Exception e) {
			LOG.error("${className?cap_first}.delete${table.tableName?cap_first} [删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}
	
	<#if control.isDeleteMethod=="NO">
	**/
	</#if>

	<#if control.isDeleteMethod=="NO">
	/**
	</#if>
	@ResponseBody
	@RequestMapping("delete${table.tableName?cap_first}s")
	public Map<String, Object> delete${table.tableName?cap_first}s(Model model,String ids) {
		try {
			${table.tableName?uncap_first}Service.delete${table.tableName?cap_first}s(ids);
		} catch (Exception e) {
			LOG.error("${className?cap_first}.delete${table.tableName?cap_first}s [删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}
	<#if control.isDeleteMethod=="NO">
	**/
	</#if>

	<#if control.isQueryMethod=="NO">
	/**
	</#if>
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("query${table.tableName?cap_first}PaginationList")
	public Pagination query${table.tableName?cap_first}PaginationList(Model model,${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
			Integer totalCount=${table.tableName?uncap_first}Service.query${table.tableName?cap_first}PaginationCount(${table.tableName?uncap_first});
			List<${table.tableName?cap_first}> dataList=${table.tableName?uncap_first}Service.query${table.tableName?cap_first}PaginationList(${table.tableName?uncap_first});
			return new Pagination(${table.tableName?uncap_first}, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("${className?cap_first}.query${table.tableName?cap_first}PaginationList [查询列表失败]", e);
		}
		return new Pagination("查询列表异常");
	}
	<#if control.isQueryMethod=="NO">
	**/
	</#if>

	
	<#if control.isSelectMethod=="NO">
	/**
	</#if>
	@ResponseBody
	@RequestMapping("query${table.tableName?cap_first}ListForSelect")
	public Map<String, Object> query${table.tableName?cap_first}ListForSelect(Model model,${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
			List<${table.tableName?cap_first}> dataList=${table.tableName?uncap_first}Service.query${table.tableName?cap_first}List();
			if(dataList==null||dataList.size()==0){
				return resultTrue(dataList);
			}else{
				List<String> list=new ArrayList<String>();
				for (int i = 0; i < dataList.size(); i++) {
					${table.tableName?cap_first} object=dataList.get(i);
					String value="<option value='"+object.get${javaPrimary?cap_first}()+"'>"+object.get${showColumnName?cap_first}()+"</option>";
					list.add(value);
				}
				return resultTrue(list);
			}
		} catch (ServiceException e) {
			LOG.error("${className?cap_first}.query${table.tableName?cap_first}ListForSelect [查询${table.tableTitle}列表异常]", e);
		}
		return resultTrue("查询${table.tableTitle}列表异常");
	}
	<#if control.isSelectMethod=="NO">
	**/
	</#if>
}
