package com.autocode.controller;

import java.util.HashMap;
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
import com.autocode.bean.ColumnConvert;
import com.autocode.service.ColumnConvertService;

@Controller
@RequestMapping({ "/columnConvert" })
public class ColumnConvertController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(ColumnConvertController.class);

	@Inject
	private ColumnConvertService columnConvertService;

	@RequestMapping
	public String index(Model model) {
		model.addAttribute("nav_3", "onnav");
		model.addAttribute("columnConvert", "focus");
		return "columnConvert";
	}

	@ResponseBody
	@RequestMapping({ "insertColumnConvert" })
	public Map<String, Object> insertColumnConvert(Model model, ColumnConvert columnConvert) {
		try {
			this.columnConvertService.insertColumnConvert(columnConvert);
		} catch (Exception e) {
			LOG.error("ColumnConvertController[添加失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateColumnConvert" })
	public Map<String, Object> updateColumnConvert(Model model, ColumnConvert columnConvert) {
		try {
			List columnConvertList = this.columnConvertService.queryColumnConvertListForColumnName("mappingName",
					columnConvert.getMappingName());
			if ((columnConvertList != null) && (columnConvertList.size() > 0)) {
				throw new ServiceException("字段名称已经存在,请不要重复添加!");
			}
			this.columnConvertService.updateColumnConvert(columnConvert);
		} catch (Exception e) {
			LOG.error("ColumnConvertController[修改失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "oneKeyUpdate" })
	public Map<String, Object> oneKeyUpdate(Model model) {
		try {
			List columnConvertList = this.columnConvertService.queryColumnConvertListForRepeat();
			if ((columnConvertList != null) && (columnConvertList.size() > 0)) {
				Map map = new HashMap();
				for (int i = 0; i < columnConvertList.size(); i++) {
					ColumnConvert columnConvert = (ColumnConvert) columnConvertList.get(i);
					map.put(columnConvert.getMappingName(), Boolean.valueOf(true));
				}
				for (int i = 0; i < columnConvertList.size(); i++) {
					ColumnConvert columnConvert = (ColumnConvert) columnConvertList.get(i);
					if (((Boolean) map.get(columnConvert.getMappingName())).booleanValue()) {
						map.put(columnConvert.getMappingName(), Boolean.valueOf(false));
					} else
						this.columnConvertService.deleteColumnConvert(columnConvert.getColumnConvertId());
				}
			}
			columnConvertList = this.columnConvertService.queryColumnConvertSelect();
			if ((columnConvertList != null) && (columnConvertList.size() > 0))
				for (int i = 0; i < columnConvertList.size(); i++) {
					ColumnConvert columnConvert = (ColumnConvert) columnConvertList.get(i);
					String ch = columnConvert.getColumnName().substring(0, 1);
					boolean operatorFlag = true;

					if (ch.equals(ch.toUpperCase())) {
						this.columnConvertService.updateColumnConvert(columnConvert);
						operatorFlag = false;
					}
					if (operatorFlag) {
						String mapping = columnConvert.getMappingName();
						for (int j = 0; j < mapping.length(); j++) {
							char c = mapping.charAt(j);
							if (c < 'a') {
								this.columnConvertService.updateColumnConvert(columnConvert);
								break;
							}
						}
					}
				}
		} catch (Exception e) {
			LOG.error("ColumnConvertController[更正成功失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteColumnConvert" })
	public Map<String, Object> deleteColumnConvert(Model model, Integer columnConvertId) {
		try {
			this.columnConvertService.deleteColumnConvert(columnConvertId);
		} catch (Exception e) {
			LOG.error("ColumnConvertController[删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteColumnConverts" })
	public Map<String, Object> deleteColumnConverts(Model model, String ids) {
		try {
			this.columnConvertService.deleteColumnConverts(ids);
		} catch (Exception e) {
			LOG.error("ColumnConvertController[删除多个失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryColumnConvertList" })
	public Pagination queryColumnConvertList(Model model, ColumnConvert columnConvert) {
		try {
			Integer totalCount = this.columnConvertService.queryColumnConvertCount(columnConvert);
			List dataList = this.columnConvertService.queryColumnConvertList(columnConvert);
			return new Pagination(columnConvert, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("ColumnConvertController[查询列表失败]", e);
		}
		return new Pagination("查询列表异常");
	}
}
