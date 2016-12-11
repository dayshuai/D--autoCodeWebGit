package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.bean.Relation;
import com.autocode.service.ColumnService;
import com.autocode.service.RelationService;
import java.util.HashMap;
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
@RequestMapping({ "/relation" })
public class RelationController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(RelationController.class);

	@Inject
	private RelationService relationService;

	@Autowired
	private ColumnService columnService;

	@RequestMapping
	public String index(Model model) {
		model.addAttribute("nav_2", "onnav");
		model.addAttribute("relation", "focus");
		return "relation";
	}

	@ResponseBody
	@RequestMapping({ "insertRelation" })
	public Map<String, Object> insertRelation(Model model, Relation relation) {
		try {
			this.relationService.insertRelation(relation);
		} catch (Exception e) {
			LOG.error("RelationController[添加失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateRelation" })
	public Map<String, Object> updateRelation(Model model, Relation relation) {
		try {
			this.relationService.updateRelation(relation);
		} catch (Exception e) {
			LOG.error("RelationController[修改失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteRelation" })
	public Map<String, Object> deleteRelation(Model model, Integer relationId) {
		try {
			this.relationService.deleteRelation(relationId);
		} catch (Exception e) {
			LOG.error("RelationController[删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteRelations" })
	public Map<String, Object> deleteRelations(Model model, String ids) {
		try {
			this.relationService.deleteRelations(ids);
		} catch (Exception e) {
			LOG.error("RelationController[删除多个失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryRelationList" })
	public Pagination queryRelationList(Model model, Relation relation) {
		try {
			Integer totalCount = this.relationService.queryRelationCount(relation);
			List dataList = this.relationService.queryRelationList(relation);
			return new Pagination(relation, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("RelationController[查询列表失败]", e);
		}
		return new Pagination("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "autoRelation" })
	public Map<String, Object> autoRelation(Model model, Integer projectId) {
		try {
			Integer success = this.relationService.autoRelation(projectId);
			if ((success == null) || (success.intValue() == 0)) {
				return resultTrue("没有找到关系!");
			}
			return resultTrue("自动找关系成功,合计找到" + success + "个关系!");
		} catch (Exception e) {
			LOG.error("RelationController[自动找关系失败]", e);
			return resultFalse(e.getMessage());
		}
	}

	@ResponseBody
	@RequestMapping({ "autoColumnRelation" })
	public Map<String, Object> autoColumnRelation(Model model, Integer columnId, Integer relationColumnId) {
		try {
			Column c1 = this.columnService.querySingleColumn(columnId);
			Column c2 = this.columnService.querySingleColumn(relationColumnId);
			Map map = new HashMap();
			if ((c1.getIsPrimary().equals("YES")) && (c2.getIsPrimary().equals("YES"))) {
				map.put("relation", "OneToOne");
				map.put("cascadeDelete", "YES");
			} else if (c1.getIsPrimary().equals("YES")) {
				map.put("relation", "OneToMany");
				map.put("cascadeDelete", "YES");
			} else if (c2.getIsPrimary().equals("YES")) {
				map.put("relation", "ManyToOne");
				map.put("cascadeDelete", "NO");
			} else {
				map.put("relation", "");
				map.put("cascadeDelete", "NO");
			}
			return resultTrue(map);
		} catch (Exception e) {
			LOG.error("RelationController[找出对应的关系失败]");
		}
		return resultFalse("找出对应的关系失败!");
	}
}
