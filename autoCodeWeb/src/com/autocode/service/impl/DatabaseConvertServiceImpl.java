package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.DatabaseConvert;
import com.autocode.mapper.DatabaseConvertMapper;
import com.autocode.service.DatabaseConvertService;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("databaseConvertService")
public class DatabaseConvertServiceImpl extends BaseService implements DatabaseConvertService {
	private static final Logger LOG = LoggerFactory.getLogger(DatabaseConvertServiceImpl.class);

	@Autowired
	private DatabaseConvertMapper databaseConvertMapper;

	private void validation(DatabaseConvert databaseConvert, String operatorState) {
		if (databaseConvert == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (databaseConvert.getDatabaseConvertId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(databaseConvert.getDatabaseType())) {
			throw new ServiceException("数据库类型不能为空");
		}
		if (isBlank(databaseConvert.getColumnType())) {
			throw new ServiceException("数据类型不能为空");
		}
		if (isBlank(databaseConvert.getConvertType()))
			throw new ServiceException("Java类型不能为空");
	}

	public Integer insertDatabaseConvert(DatabaseConvert databaseConvert) {
		validation(databaseConvert, "insert");
		List list = this.databaseConvertMapper.queryObjectListByColumns(databaseConvert);
		if ((list != null) && (list.size() > 0))
			throw new ServiceException("数据库类型转换信息重复,请修改!");
		try {
			this.databaseConvertMapper.insert(databaseConvert);
			return databaseConvert.getDatabaseConvertId();
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.insertDatabaseConvert [ " + databaseConvert + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateDatabaseConvert(DatabaseConvert databaseConvert) {
		validation(databaseConvert, "update");
		List list = this.databaseConvertMapper.queryObjectListByColumns(databaseConvert);
		if ((list != null) && (list.size() > 0)) {
			for (int i = 0; i < list.size(); i++) {
				if (((DatabaseConvert) list.get(i)).getDatabaseConvertId() == databaseConvert.getDatabaseConvertId()) {
					list.remove(i);
					break;
				}
			}
			if (list.size() > 0)
				throw new ServiceException("数据库类型转换信息重复,请修改!");
		}
		try {
			return this.databaseConvertMapper.update(databaseConvert);
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.updateDatabaseConvert [ " + databaseConvert + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteDatabaseConvert(Integer databaseConvertId) {
		try {
			return this.databaseConvertMapper.delete(databaseConvertId);
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.deleteDatabaseConvert [ " + databaseConvertId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteDatabaseConverts(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.databaseConvertMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.deleteDatabaseConverts [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public DatabaseConvert querySingleDatabaseConvert(Integer databaseConvertId) {
		try {
			return (DatabaseConvert) this.databaseConvertMapper.querySingleObject(databaseConvertId);
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.querySingleDatabaseConvert [ " + databaseConvertId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryDatabaseConvertCount(DatabaseConvert databaseConvert) {
		try {
			return this.databaseConvertMapper.queryObjectCount(databaseConvert);
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.queryDatabaseConvertCount [ " + databaseConvert + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<DatabaseConvert> queryDatabaseConvertList(DatabaseConvert databaseConvert) {
		try {
			return this.databaseConvertMapper.queryObjectList(databaseConvert);
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.queryDatabaseConvertList [ " + databaseConvert + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<DatabaseConvert> queryDatabaseConvertSelect() {
		try {
			return this.databaseConvertMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.queryDatabaseConvertSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<DatabaseConvert> queryDatabaseConvertListByDatabaseType(String databaseType) {
		try {
			return this.databaseConvertMapper.queryObjectListByDatabaseType(databaseType);
		} catch (Exception e) {
			LOG.error("DatabaseConvertServiceImpl.queryDatabaseConvertListByDatabaseType [" + databaseType
					+ "] 根据数据库类型查询列表失败", e);
		}
		throw new ServiceException("根据数据库类型查询列表失败");
	}
}
