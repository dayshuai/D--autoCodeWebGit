package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.mapper.ColumnMapper;
import com.autocode.service.ColumnService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("columnService")
public class ColumnServiceImpl extends BaseService implements ColumnService {
	private static final Logger LOG = LoggerFactory.getLogger(ColumnServiceImpl.class);

	@Autowired
	private ColumnMapper columnMapper;

	private void validation(Column column, String operatorState) {
		if (column == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (column.getColumnId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(column.getProjectId())) {
			throw new ServiceException("项目不能为空");
		}
		if (isBlank(column.getTableId())) {
			throw new ServiceException("表不能为空");
		}
		if (isBlank(column.getMappingName())) {
			throw new ServiceException("数据库字段名称不能为空");
		}
		if (isBlank(column.getColumnName())) {
			throw new ServiceException("字段名不能为空");
		}
		if (isBlank(column.getColumnZhName())) {
			throw new ServiceException("翻译中文名称不能为空");
		}
		if (isBlank(column.getMappingType())) {
			throw new ServiceException("数据库类型不能为空");
		}
		if (isBlank(column.getColumnType())) {
			throw new ServiceException("字段类型不能为空");
		}
		if (isBlank(column.getShowType())) {
			throw new ServiceException("显示类型不能为空");
		}
		if (isBlank(column.getIsPrimary())) {
			throw new ServiceException("是否是主键不能为空");
		}
		if (isBlank(column.getIsShow())) {
			throw new ServiceException("是否显示不能为空");
		}
		if (isBlank(column.getIsQuery())) {
			throw new ServiceException("是否查询");
		}
		if (isBlank(column.getIsCheck())) {
			throw new ServiceException("是否验证不能为空");
		}
		if (isBlank(column.getShowOrder())) {
			throw new ServiceException("显示顺序不能为空");
		}
		if (isBlank(column.getIsImportPackage())) {
			throw new ServiceException("是否需要导包不能为空");
		}
		if (isBlank(column.getIsUpdate())) {
			throw new ServiceException("是否修改不能为空");
		}
		if (isBlank(column.getIsDefault())) {
			throw new ServiceException("是否默认值不能为空");
		}
		if (isBlank(column.getIsRepeat()))
			throw new ServiceException("是否重复不能为空");
	}

	public Integer insertColumn(Column column) {
		validation(column, "insert");
		try {
			this.columnMapper.insert(column);
			return column.getColumnId();
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.insertColumn [ " + column + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateColumn(Column column) {
		validation(column, "update");
		try {
			return this.columnMapper.update(column);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.updateColumn [ " + column + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteColumn(Integer columnId) {
		try {
			return this.columnMapper.delete(columnId);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.deleteColumn [ " + columnId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteColumns(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				deleteColumn(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.deleteColumns [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Column querySingleColumn(Integer columnId) {
		try {
			return (Column) this.columnMapper.querySingleObject(columnId);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.querySingleColumn [ " + columnId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryColumnCount(Column column) {
		try {
			return this.columnMapper.queryObjectCount(column);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnCount [ " + column + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Column> queryColumnList(Column column) {
		try {
			return this.columnMapper.queryObjectList(column);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnList [ " + column + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<Column> queryColumnSelect() {
		try {
			return this.columnMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public Integer queryColumnCountByTableId(Integer tableId) {
		try {
			return this.columnMapper.queryObjectCountByTableId(tableId);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnCountByTableId [" + tableId + "] 查询字段条数失败", e);
		}
		throw new ServiceException("查询字段条数失败");
	}

	public Integer deleteColumnByTableId(Integer tableId) {
		try {
			return this.columnMapper.deleteObjectByTableId(tableId);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.deleteByTableId [ " + tableId + " ] 根据tableId删除失败", e);
		}
		throw new ServiceException("根据tableId删除失败");
	}

	public List<Column> queryColumnListByTableIds(List<Integer> tables) {
		try {
			return this.columnMapper.queryObjectListByTableIds(tables);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnListByTableIdsParmary [ " + tables.toString() + " ] 根据tableIds查询失败",
					e);
		}
		throw new ServiceException("根据tableIds查询失败");
	}

	public Integer deleteColumnByProjectId(Integer projectId) {
		try {
			return this.columnMapper.deleteObjectByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.deleteRelationByProjectId [ " + projectId + " ] 删除字段失败", e);
		}
		throw new ServiceException("删除字段失败");
	}

	public List<Column> queryColumnListForConvertError(Integer projectId, String errorName) {
		try {
			Map map = new HashMap();
			map.put("projectId", projectId);
			map.put("errorName", errorName);
			return this.columnMapper.queryObjectListForConvertError(map);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnListForConvertError [ " + projectId + " ] 查询转换失败列表异常", e);
		}
		throw new ServiceException("查询转换失败列表异常");
	}

	public List<Column> queryColumnListByTableId(Integer tableId) {
		try {
			return this.columnMapper.queryObjectListByTableId(tableId);
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.queryColumnListByTableId [" + tableId + "] 根据表ID查询字段列表失败", e);
		}
		throw new ServiceException("查询字段列表失败");
	}

	public List<String> columnSelectByTableId(Integer tableId) {
		try {
			List columnList = this.columnMapper.queryObjectListByTableId(tableId);
			if ((columnList == null) || (columnList.size() == 0)) {
				return null;
			}
			List list = new ArrayList();
			for (int i = 0; i < columnList.size(); i++) {
				Column c = (Column) columnList.get(i);
				String value = "<option value='" + c.getColumnId() + "'>" + c.getColumnName() + ":" + c.getColumnType()
						+ "</option>";
				list.add(value);
			}
			return list;
		} catch (Exception e) {
			LOG.error("ColumnServiceImpl.columnSelectByTableId 查询字段下拉框列表失败", e);
		}
		throw new ServiceException("查询字段下拉框列表失败");
	}
}
