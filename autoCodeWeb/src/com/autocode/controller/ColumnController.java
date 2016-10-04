package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.service.ColumnService;
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

@Controller
@RequestMapping({ "/column" })
public class ColumnController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(ColumnController.class);

	@Inject
	private ColumnService columnService;

	@RequestMapping
	public String column(Model model) {
		model.addAttribute("nav_2", "onnav");
		model.addAttribute("column", "focus");
		return "column";
	}

	@ResponseBody
	@RequestMapping({ "insertColumn" })
	public Map<String, Object> insertColumn(Model model, Column column) {
		try {
			this.columnService.insertColumn(column);
		} catch (Exception e) {
			LOG.error("ColumnController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateColumn" })
	public Map<String, Object> updateColumn(Model model, Column column) {
		try {
			this.columnService.updateColumn(column);
		} catch (Exception e) {
			LOG.error("ColumnController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteColumn" })
	public Map<String, Object> deleteColumn(Model model, Integer columnId) {
		try {
			this.columnService.deleteColumn(columnId);
		} catch (Exception e) {
			LOG.error("ColumnController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteColumns" })
	public Map<String, Object> deleteColumns(Model model, String ids) {
		try {
			this.columnService.deleteColumns(ids);
		} catch (Exception e) {
			LOG.error("ColumnController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryColumnList" })
	public Pagination queryColumnList(Model model, Column column) {
		try {
			Integer totalCount = this.columnService.queryColumnCount(column);
			List dataList = this.columnService.queryColumnList(column);
			return new Pagination(column, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("ColumnController[查询列表失败]");
		}
		return new Pagination("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "columnSelectByTableId" })
	public Map<String, Object> columnSelectByTableId(Model model, Integer tableId) {
		try {
			List list = this.columnService.columnSelectByTableId(tableId);
			if (list == null) {
				return resultTrue(new ArrayList());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("ProjectController[查询引用字段异常]");
		}
		return resultFalse("查询引用字段失败!");
	}
}
