package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.DatabaseConvert;
import com.autocode.bean.Project;
import com.autocode.service.DatabaseConvertService;
import com.autocode.service.ProjectService;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({ "/databaseConvert" })
public class DatabaseConvertController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(DatabaseConvertController.class);

	@Inject
	private DatabaseConvertService databaseConvertService;

	@Autowired
	private ProjectService projectService;

	@RequestMapping
	public String databaseConvert(Model model) {
		model.addAttribute("nav_3", "onnav");
		model.addAttribute("databaseConvert", "focus");
		return "databaseConvert";
	}

	@ResponseBody
	@RequestMapping({ "insertDatabaseConvert" })
	public Map<String, Object> insertDatabaseConvert(Model model, DatabaseConvert databaseConvert) {
		try {
			this.databaseConvertService.insertDatabaseConvert(databaseConvert);
		} catch (Exception e) {
			LOG.error("DatabaseConvertController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateDatabaseConvert" })
	public Map<String, Object> updateDatabaseConvert(Model model, DatabaseConvert databaseConvert) {
		try {
			this.databaseConvertService.updateDatabaseConvert(databaseConvert);
		} catch (Exception e) {
			LOG.error("DatabaseConvertController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteDatabaseConvert" })
	public Map<String, Object> deleteDatabaseConvert(Model model, Integer databaseConvertId) {
		try {
			this.databaseConvertService.deleteDatabaseConvert(databaseConvertId);
		} catch (Exception e) {
			LOG.error("DatabaseConvertController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteDatabaseConverts" })
	public Map<String, Object> deleteDatabaseConverts(Model model, String ids) {
		try {
			this.databaseConvertService.deleteDatabaseConverts(ids);
		} catch (Exception e) {
			LOG.error("DatabaseConvertController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryDatabaseConvertList" })
	public Pagination queryDatabaseConvertList(Model model, DatabaseConvert databaseConvert) {
		try {
			Integer totalCount = this.databaseConvertService.queryDatabaseConvertCount(databaseConvert);
			List dataList = this.databaseConvertService.queryDatabaseConvertList(databaseConvert);
			return new Pagination(databaseConvert, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("DatabaseConvertController[查询列表失败]");
		}
		return new Pagination("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "databaseConvertSelect" })
	public Map<String, Object> databaseConvertSelect(Model model, Integer projectId) {
		try {
			Project project = this.projectService.querySingleProject(projectId);
			List dcList = new ArrayList();
			List dataList = this.databaseConvertService
					.queryDatabaseConvertListByDatabaseType(project.getDatabaseType());
			if ((dataList != null) && (dataList.size() > 0)) {
				for (int i = 0; i < dataList.size(); i++) {
					DatabaseConvert dc = (DatabaseConvert) dataList.get(i);
					for (int j = i + 1; j < dataList.size(); j++) {
						if (dc.getConvertType().equals(((DatabaseConvert) dataList.get(j)).getConvertType())) {
							dataList.remove(j);
							j--;
						}
					}
				}
				for (int i = 0; i < dataList.size(); i++) {
					DatabaseConvert dc = (DatabaseConvert) dataList.get(i);
					String value = "<option value='" + dc.getConvertType() + "'>" + dc.getConvertType() + "</option>";
					dcList.add(value);
				}
			}
			return resultTrue(dcList);
		} catch (ServiceException e) {
			LOG.error("DatabaseConvertController[查询列表失败]");
			return resultFalse(e.getMessage());
		}
	}
}
