package com.autocode.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Table;
import com.autocode.service.TableService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping({ "/table" })
public class TableController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(TableController.class);

	@Inject
	private TableService tableService;

	@RequestMapping
	public String table(Model model) {
		model.addAttribute("nav_2", "onnav");
		model.addAttribute("table", "focus");
		return "table";
	}

	@ResponseBody
	@RequestMapping({ "insertTable" })
	public Map<String, Object> insertTable(Model model, Table table) {
		try {
			this.tableService.insertTable(table);
		} catch (Exception e) {
			LOG.error("TableController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	/**
	 * 添加需要的实体
	 * 
	 * @param model
	 * @param table
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "transmitAppend" })
	public Map<String, Object> transmitAppend(Model model, Table table) {
		try {
			this.tableService.transmitAppend(table);
		} catch (Exception e) {
			LOG.error("TableController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateTable" })
	public Map<String, Object> updateTable(Model model, Table table) {
		try {
			this.tableService.updateTable(table);
		} catch (Exception e) {
			LOG.error("TableController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteTable" })
	public Map<String, Object> deleteTable(Model model, Integer tableId) {
		try {
			this.tableService.deleteTable(tableId);
		} catch (Exception e) {
			LOG.error("TableController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteTables" })
	public Map<String, Object> deleteTables(Model model, String ids) {
		try {
			this.tableService.deleteTables(ids);
		} catch (Exception e) {
			LOG.error("TableController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryTableList" })
	public Pagination<Table> queryTableList(Model model, Table table) {
		try {
			Integer totalCount = this.tableService.queryTableCount(table);
			List<Table> dataList = this.tableService.queryTableList(table);
			return new Pagination<Table>(table, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("TableController[查询列表失败]");
		}
		return new Pagination<Table>("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "queryProjectTableList" })
	public Map<String, Object> queryProjectTableList(Model model, Integer projectId) {
		try {
			JSONArray jsonArray = this.tableService.queryDataBaseTableListByProjectId(projectId);
			return resultTrue(jsonArray);
		} catch (Exception e) {
			LOG.error("TableController[获取数据库表失败]");
			return resultFalse(e.getMessage());
		}
	}

	@ResponseBody
	@RequestMapping({ "onKeyAutoAppendTable" })
	public Map<String, Object> onKeyAutoAppendTable(Model model, Integer projectId) {
		try {
			Integer countSuccess = this.tableService.onKeyAutoAppendTable(projectId);
			return resultTrue("合计添加" + countSuccess + "张表!");
		} catch (Exception e) {
			LOG.error("TableController[一键添加项目表异常]");
			return resultFalse(e.getMessage());
		}
	}

	@ResponseBody
	@RequestMapping({ "removePrefix" })
	public Map<String, Object> removePrefix(Model model, Integer projectId) {
		try {
			this.tableService.removePrefix(projectId);
			return resultTrue();
		} catch (Exception e) {
			LOG.error("TableController[一键表前缀]");
			return resultFalse(e.getMessage());
		}
	}
	
	@ResponseBody
	@RequestMapping({ "replaceBean" })
	public Map<String, Object> replaceBean(Model model, Integer projectId, String sourceName,
			String replaceName) {
		try {
			this.tableService.replaceBean(projectId, sourceName, replaceName);
		} catch (Exception e) {
			LOG.error("Bean[一键替换失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "tableSelect" })
	public Map<String, Object> tableSelect(Model model, Integer projectId) {
		try {
			List<?> list = this.tableService.queryTableSelectByProjectId(projectId);
			if (list == null) {
				return resultTrue(new ArrayList<Object>());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("ProjectController[查询引用数据库表失败]");
		}
		return resultFalse("查询引用数据库表失败!");
	}
}
