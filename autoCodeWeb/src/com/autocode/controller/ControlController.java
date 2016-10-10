package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Control;
import com.autocode.service.ControlService;
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
@RequestMapping({ "/control" })
public class ControlController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(ControlController.class);

	@Inject
	private ControlService controlService;

	@RequestMapping
	public String control(Model model) {
		model.addAttribute("nav_2", "onnav");
		model.addAttribute("control", "focus");
		return "control";
	}

	@ResponseBody
	@RequestMapping({ "insertControl" })
	public Map<String, Object> insertControl(Model model, Control control) {
		try {
			this.controlService.insertControl(control);
		} catch (Exception e) {
			LOG.error("ControlController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateControl" })
	public Map<String, Object> updateControl(Model model, Control control) {
		try {
			this.controlService.updateControl(control);
		} catch (Exception e) {
			LOG.error("ControlController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteControl" })
	public Map<String, Object> deleteControl(Model model, Integer controlId) {
		try {
			this.controlService.deleteControl(controlId);
		} catch (Exception e) {
			LOG.error("ControlController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteControls" })
	public Map<String, Object> deleteControls(Model model, String ids) {
		try {
			this.controlService.deleteControls(ids);
		} catch (Exception e) {
			LOG.error("ControlController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryControlList" })
	public Pagination<Control> queryControlList(Model model, Control control) {
		try {
			Integer totalCount = this.controlService.queryControlCount(control);
			List <Control> dataList = this.controlService.queryControlList(control);
			return new Pagination<Control>(control, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("ControlController[查询列表失败]");
		}
		return new Pagination<Control>("查询列表异常");
	}
}
