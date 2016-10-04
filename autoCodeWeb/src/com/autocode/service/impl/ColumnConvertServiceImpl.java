package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.ColumnConvert;
import com.autocode.mapper.ColumnConvertMapper;
import com.autocode.service.ColumnConvertService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("columnConvertService")
public class ColumnConvertServiceImpl extends BaseService implements ColumnConvertService {
	private static final Logger LOG = LoggerFactory.getLogger(ColumnConvertServiceImpl.class);

	@Autowired
	private ColumnConvertMapper columnConvertMapper;

	private void validation(ColumnConvert columnConvert, String operatorState) {
		if (columnConvert == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (columnConvert.getColumnConvertId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(columnConvert.getMappingName())) {
			throw new ServiceException("字段名称不能为空");
		}
		columnConvert.setMappingName(columnConvert.getMappingName().toLowerCase());

		if (isBlank(columnConvert.getColumnName())) {
			throw new ServiceException("转换名称不能为空");
		}
		columnConvert.setColumnName(columnConvert.getColumnName().substring(0, 1).toLowerCase()
				+ columnConvert.getColumnName().substring(1, columnConvert.getColumnName().length()));

		if (isBlank(columnConvert.getColumnZhName()))
			throw new ServiceException("中文名称不能为空");
	}

	public Integer insertColumnConvert(ColumnConvert columnConvert) {
		validation(columnConvert, "insert");
		try {
			this.columnConvertMapper.insert(columnConvert);
			return columnConvert.getColumnConvertId();
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.insertColumnConvert [ " + columnConvert + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateColumnConvert(ColumnConvert columnConvert) {
		validation(columnConvert, "update");
		try {
			return this.columnConvertMapper.update(columnConvert);
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.updateColumnConvert [ " + columnConvert + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteColumnConvert(Integer columnConvertId) {
		try {
			return this.columnConvertMapper.delete(columnConvertId);
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.deleteColumnConvert [ " + columnConvertId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteColumnConverts(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.columnConvertMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.deleteColumnConverts [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public ColumnConvert querySingleColumnConvert(Integer columnConvertId) {
		try {
			return (ColumnConvert) this.columnConvertMapper.querySingleObject(columnConvertId);
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.querySingleColumnConvert [ " + columnConvertId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryColumnConvertCount(ColumnConvert columnConvert) {
		try {
			return this.columnConvertMapper.queryObjectCount(columnConvert);
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.queryColumnConvertCount [ " + columnConvert + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<ColumnConvert> queryColumnConvertList(ColumnConvert columnConvert) {
		try {
			return this.columnConvertMapper.queryObjectList(columnConvert);
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.queryColumnConvertList [ " + columnConvert + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<ColumnConvert> queryColumnConvertSelect() {
		try {
			return this.columnConvertMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.queryColumnConvertSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<ColumnConvert> queryColumnConvertListForColumnName(String columnName, String columnValue) {
		try {
			Map map = new HashMap();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return this.columnConvertMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.queryColumnConvertListForColumnName 根据字段查询失败", e);
		}
		throw new ServiceException("根据字段查询失败");
	}

	public List<ColumnConvert> queryColumnConvertListForRepeat() {
		try {
			return this.columnConvertMapper.queryObjectListForRepeat();
		} catch (Exception e) {
			LOG.error("ColumnConvertServiceImpl.queryColumnConvertListForRepeat 查询重复数据异常", e);
		}
		throw new ServiceException("查询重复数据异常");
	}
}
