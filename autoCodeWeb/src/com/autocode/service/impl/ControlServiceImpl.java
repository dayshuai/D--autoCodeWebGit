package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Control;
import com.autocode.mapper.ControlMapper;
import com.autocode.service.ControlService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("controlService")
public class ControlServiceImpl extends BaseService implements ControlService {
	private static final Logger LOG = LoggerFactory.getLogger(ControlServiceImpl.class);

	@Autowired
	private ControlMapper controlMapper;

	private void validation(Control control, String operatorState) {
		if (control == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (control.getControlId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(control.getProjectId())) {
			throw new ServiceException("项目ID不能为空");
		}
		if (isBlank(control.getTableId())) {
			throw new ServiceException("表ID不能为空");
		}
		if (isBlank(control.getIsInsertMethod())) {
			throw new ServiceException("添加方法不能为空");
		}
		if (isBlank(control.getIsUpdateMethod())) {
			throw new ServiceException("修改方法不能为空");
		}
		if (isBlank(control.getIsDeleteMethod())) {
			throw new ServiceException("删除方法不能为空");
		}
		if (isBlank(control.getIsQueryMethod())) {
			throw new ServiceException("查询方法不能为空");
		}
		if (isBlank(control.getIsSelectMethod()))
			throw new ServiceException("SELECT方法不能为空");
	}

	public Integer insertControl(Control control) {
		validation(control, "insert");
		try {
			this.controlMapper.insert(control);
			return control.getControlId();
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.insertControl [ " + control + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateControl(Control control) {
		validation(control, "update");
		try {
			return this.controlMapper.update(control);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.updateControl [ " + control + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteControl(Integer controlId) {
		try {
			return this.controlMapper.delete(controlId);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.deleteControl [ " + controlId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteControls(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.controlMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.deleteControls [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Control querySingleControl(Integer controlId) {
		try {
			return (Control) this.controlMapper.querySingleObject(controlId);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.querySingleControl [ " + controlId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryControlCount(Control control) {
		try {
			return this.controlMapper.queryObjectCount(control);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.queryControlCount [ " + control + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Control> queryControlList(Control control) {
		try {
			return this.controlMapper.queryObjectList(control);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.queryControlList [ " + control + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<Control> queryControlSelect() {
		try {
			return this.controlMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.queryControlSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public Integer deleteControlByProjectId(Integer projectId) {
		try {
			return this.controlMapper.deleteObjectByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.deleteControlByProjectId [ " + projectId + " ] 删除控制器失败", e);
		}
		throw new ServiceException("删除控制器失败");
	}

	public Integer deleteControlByTableId(Integer tableId) {
		try {
			return this.controlMapper.deleteObjectByTableId(tableId);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.deleteControlByProjectId [ " + tableId + " ] 删除控制器失败", e);
		}
		throw new ServiceException("删除控制器失败");
	}

	public List<Control> queryControlListByProjectId(Integer projectId) {
		try {
			Map map = new HashMap();
			map.put("columnName", "projectId");
			map.put("columnValue", projectId);
			return this.controlMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.queryControlListByProjectId 查询控制器列表失败", e);
		}
		throw new ServiceException("查询控制器列表失败");
	}

	public Control querySingleControlByColumnName(String columnName, Integer tableId) {
		try {
			Map map = new HashMap();
			map.put("columnName", columnName);
			map.put("columnValue", tableId);
			List controlList = this.controlMapper.queryObjectListForColumnName(map);
			if ((controlList == null) || (controlList.size() > 0)) {
				return (Control) controlList.get(0);
			}
			return null;
		} catch (Exception e) {
			LOG.error("ControlServiceImpl.querySingleControlByColumnName 查询控制器列表失败", e);
		}
		throw new ServiceException("查询控制器列表失败");
	}
}
