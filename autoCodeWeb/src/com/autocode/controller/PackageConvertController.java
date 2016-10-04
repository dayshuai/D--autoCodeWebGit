package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.PackageConvert;
import com.autocode.service.PackageConvertService;
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
@RequestMapping({ "/packageConvert" })
public class PackageConvertController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(PackageConvertController.class);

	@Inject
	private PackageConvertService packageConvertService;

	@RequestMapping
	public String packageConvert(Model model) {
		model.addAttribute("nav_3", "onnav");
		model.addAttribute("packageConvert", "focus");
		return "packageConvert";
	}

	@ResponseBody
	@RequestMapping({ "insertPackageConvert" })
	public Map<String, Object> insertPackageConvert(Model model, PackageConvert packageConvert) {
		try {
			this.packageConvertService.insertPackageConvert(packageConvert);
		} catch (Exception e) {
			LOG.error("PackageConvertController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updatePackageConvert" })
	public Map<String, Object> updatePackageConvert(Model model, PackageConvert packageConvert) {
		try {
			this.packageConvertService.updatePackageConvert(packageConvert);
		} catch (Exception e) {
			LOG.error("PackageConvertController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deletePackageConvert" })
	public Map<String, Object> deletePackageConvert(Model model, Integer packageConvertId) {
		try {
			this.packageConvertService.deletePackageConvert(packageConvertId);
		} catch (Exception e) {
			LOG.error("PackageConvertController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deletePackageConverts" })
	public Map<String, Object> deletePackageConverts(Model model, String ids) {
		try {
			this.packageConvertService.deletePackageConverts(ids);
		} catch (Exception e) {
			LOG.error("PackageConvertController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryPackageConvertList" })
	public Pagination queryPackageConvertList(Model model, PackageConvert packageConvert) {
		try {
			Integer totalCount = this.packageConvertService.queryPackageConvertCount(packageConvert);
			List dataList = this.packageConvertService.queryPackageConvertList(packageConvert);
			return new Pagination(packageConvert, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("PackageConvertController[查询列表失败]");
		}
		return new Pagination("查询列表异常");
	}
}
