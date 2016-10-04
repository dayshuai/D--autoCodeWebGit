package ${controllerPackage};

import ${beanPackage}.${table.tableName?cap_first};
import ${servicePackage}.${table.tableName?cap_first}Service;
import ${basePackage}.BaseController;
import ${basePackage}.Pagination;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/${table.tableName?uncap_first}")
public class ${className?cap_first} extends BaseController{ 

	/** 日志管理 */
    private static final Logger logger = LoggerFactory.getLogger(${className?cap_first}.class);
	
	/** ${table.tableTitle}管理 */
    @Autowired
	private ${table.tableName?cap_first}Service ${table.tableName?uncap_first}Service;
	
    @RequestMapping()
    public String index(Model model) {
		return "${table.tableName?uncap_first}";
    }
    
	/**
     * 保存${table.tableTitle}
     * 
     * @param model
     * @param ${table.tableName?uncap_first}
     * @return
     */
	<#if control.isInsertMethod=="NO">
	/**
	</#if>
    @ResponseBody
    @RequestMapping("insert${table.tableName?cap_first}")
    public Map<String, Object> insert${table.tableName?cap_first}(Model model, ${table.tableName?cap_first} ${table.tableName?uncap_first}) {
		try {
		    ${table.tableName?uncap_first}Service.insert${table.tableName?cap_first}(${table.tableName?uncap_first});
		} catch (Exception e) {
		    logger.error("添加${table.tableTitle}失败,Message="+e.getMessage(), e);
		    return resultFalse(e.getMessage());
		}
		return resultTrue();
    }
	<#if control.isInsertMethod=="NO">
	**/
	</#if>

	/**
     * 修改${table.tableTitle}
     * 
     * @param model
     * @param column
     * @return
     */
	<#if control.isUpdateMethod=="NO">
	/**
	</#if>
    @ResponseBody
    @RequestMapping("update${table.tableName?cap_first}")
    public Map<String, Object> update${table.tableName?cap_first}(Model model, ${table.tableName?cap_first} column) {
		try {
		    ${table.tableName?uncap_first}Service.update${table.tableName?cap_first}(column);
		} catch (Exception e) {
		    logger.error("修改${table.tableTitle}失败,"+e.getMessage(), e);
		    return resultFalse(e.getMessage());
		}
		return resultTrue();
    }
	<#if control.isUpdateMethod=="NO">
	**/
	</#if>

	/**
     * 删除${table.tableTitle}
     * 
     * @param model
     * @param ${javaPrimary?uncap_first}
     * @return
     */
	<#if control.isDeleteMethod=="NO">
	/**
	</#if>
    @ResponseBody
    @RequestMapping("delete${table.tableName?cap_first}")
    public Map<String, Object> delete${table.tableName?cap_first}(Model model, Integer ${javaPrimary?uncap_first}) {
		try {
		    ${table.tableName?uncap_first}Service.delete${table.tableName?cap_first}(${javaPrimary?uncap_first});
		} catch (Exception e) {
		    logger.error("删除${table.tableTitle}失败,Message="+e.getMessage(), e);
		    return resultFalse(e.getMessage());
		}
		return resultTrue();
    }
	
	<#if control.isDeleteMethod=="NO">
	**/
	</#if>

	/**
     * 批量删除${table.tableTitle}
     * 
     * @param model
     * @param ids
     * @return
     */
	<#if control.isDeleteMethod=="NO">
	/**
	</#if>
    @ResponseBody
    @RequestMapping("delete${table.tableName?cap_first}s")
    public Map<String, Object> delete${table.tableName?cap_first}s(Model model, String ids) {
		try {
		    ${table.tableName?uncap_first}Service.delete${table.tableName?cap_first}s(ids);
		} catch (Exception e) {
		    logger.error("批量删除${table.tableTitle}失败,Message="+e.getMessage(), e);
		    return resultFalse(e.getMessage());
		}
		return resultTrue();
    }
	<#if control.isDeleteMethod=="NO">
	**/
	</#if>

	
	 /**
     * 分页查询${table.tableTitle}
     * 
     * @param model
     * @param column
     * @return
     */
    <#if control.isQueryMethod=="NO">
	/**
	</#if>
    @ResponseBody
    @RequestMapping("query${table.tableName?cap_first}PaginationList")
    public Pagination queryPaginationList(Model model, ${table.tableName?cap_first} column) {
		try {
		    return ${table.tableName?uncap_first}Service.query${table.tableName?cap_first}PaginationList(column);
		} catch (Exception e) {
		    logger.error("分页查询${table.tableTitle}列表失败,Message="+e.getMessage(), e);
		    return buildPagination(e.getMessage());
		}
    }
	<#if control.isQueryMethod=="NO">
	**/
	</#if>

	
	
	/**
     * 查询${table.tableTitle}下拉框列表
     * 
     * @param model
     * @return
     */
    <#if control.isSelectMethod=="NO">
	/**
	</#if>
    @ResponseBody
    @RequestMapping("query${table.tableName?cap_first}Select")
    public Map<String, Object> query${table.tableName?cap_first}Select(Model model) {
		try {
		    Map<Object, Object> dataMap = ${table.tableName?uncap_first}Service.query${table.tableName?cap_first}Select();
		    List<String> selectList = buildSelectList(dataMap);
		    return resultTrue(selectList);
		} catch (Exception e) {
		    logger.error("查询${table.tableTitle}下拉框列表失败,Message="+e.getMessage(), e);
		    return resultFalse(e.getMessage());
		}
    }
	<#if control.isSelectMethod=="NO">
	**/
	</#if>
}
