package com.autocode.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.bean.ColumnConvert;
import com.autocode.bean.Control;
import com.autocode.bean.DatabaseConvert;
import com.autocode.bean.PackageConvert;
import com.autocode.bean.Project;
import com.autocode.bean.Table;
import com.autocode.database.operator.ConnectMySql;
import com.autocode.mapper.TableMapper;
import com.autocode.service.ColumnConvertService;
import com.autocode.service.ColumnService;
import com.autocode.service.ControlService;
import com.autocode.service.DatabaseConvertService;
import com.autocode.service.PackageConvertService;
import com.autocode.service.ProjectService;
import com.autocode.service.TableService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Transactional
@Service("tableService")
public class TableServiceImpl extends BaseService implements TableService {
	private static final Logger LOG = LoggerFactory.getLogger(TableService.class);

	@Autowired
	private TableMapper tableMapper;
	
	@Autowired
	private ControlService controlService;

	
	@Autowired
	private ColumnService columnService;
	
	@Autowired
	private ProjectService projectService;

	@Autowired
	private ColumnConvertService columnConvertService;

	@Autowired
	private PackageConvertService packageConvertService;

	@Autowired
	private DatabaseConvertService databaseConvertService;


	private void validation(Table table, String operatorState) {
		if (table == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (table.getTableId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(table.getProjectId())) {
			throw new ServiceException("项目不能为空");
		}
		if (isBlank(table.getTableTitle())) {
			throw new ServiceException("表标题不能为空");
		}
		if (isBlank(table.getMappingName())) {
			throw new ServiceException("字段名不能为空");
		}
		if (isBlank(table.getTableName())) {
			throw new ServiceException("表名称不能为空");
		}
		table.setTableName(firstToUpper(table.getTableName()));
		if (isBlank(table.getValidationDelete())) {
			throw new ServiceException("删除验证不能为空");
		}
		if (isBlank(table.getTableMemo()))
			throw new ServiceException("表说明不能为空");
	}

	public Integer transmitAppend(Table table) {
		Project project = this.projectService.querySingleProject(table.getProjectId());
		if (project == null) {
			throw new ServiceException("请刷新网页后重试");
		}
		if (project.getIsValidation().equals("NO")) {
			throw new ServiceException("请先验证项目数据库");
		}
		table.setValidationDelete("NO");
		table.setProjectId(project.getProjectId());
		table.setTableMemo("智能生成");
		return insertTable(table);
	}
	
	public Integer replaceBean(Integer projectId, String sourceName, String replaceName) {
		if (isBlank(projectId)) {
			throw new ServiceException("项目不能为空");
		}
		if (isBlank(sourceName)) {
			throw new ServiceException("被替换值不能为空");
		}
		if (isBlank(replaceName)) {
			replaceName = "";
		}
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("columnName", "projectId");
			map.put("columnValue", projectId);
			List<Table> list = this.tableMapper.queryObjectListForColumnName(map);
			if (isNotBlank(list)) {
				for (int i = 0; i < list.size(); i++) {
					Table t = list.get(i);
					t.setTableName(t.getTableName().replace(sourceName, replaceName));
					updateTable(t);
				}
			}
			return Integer.valueOf(list.size());
		} catch (Exception e) {
			LOG.error("Bean 一键替换失败", e);
		}
		throw new ServiceException("一键替换失败");
	}

	public Integer insertTable(Table table) {
		validation(table, "insert");
		List <Table> list = this.tableMapper.queryObjectListByColumns(table);
		if ((list != null) && (list.size() > 0))
			throw new ServiceException(table.getMappingName() + ",据库表已经存在,请修改!");
		try {
			this.tableMapper.insert(table);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.insertTable [ " + table + " ] 添加失败", e);
			throw new ServiceException("添加失败");
		}
		//默认control
		try {
			if (table != null) {
				Control c = new Control();
				c.setIsDeleteMethod("YES");
				c.setIsInsertMethod("YES");
				c.setIsQueryMethod("YES");
				c.setIsSelectMethod("YES");
				c.setIsUpdateMethod("YES");
				c.setProjectId(table.getProjectId());
				c.setTableId(table.getTableId());
				this.controlService.insertControl(c);
			}
		} catch (Exception e) {
			throw new ServiceException("默认添加control失败");
		}
		
		try {
			Project project = this.projectService.querySingleProject(table.getProjectId());
			if (project == null) {
				throw new ServiceException("请刷新网页后重试");
			}
			boolean readFlag = true;
			if ((table.getColumnList() == null) || (table.getColumnList().size() == 0)) {
				if (project.getIsValidation().equals("NO")) {
					throw new ServiceException("请先验证项目数据库");
				}
				//字段名转化 
				List <ColumnConvert> columnConvertList = this.columnConvertService.queryColumnConvertSelect();
				//包名转化 如Date java.util.date
				List <PackageConvert> packageConvertList = this.packageConvertService.queryPackageConvertSelect();
				//数据库字段转化 如 vachar String 
				List <DatabaseConvert> databaseConvertList = this.databaseConvertService
						.queryDatabaseConvertListByDatabaseType(project.getDatabaseType());
				ConnectMySql connectMySql = new ConnectMySql();

				ArrayList <Column> columnList = connectMySql.queryColumnList(project, table, columnConvertList,
						packageConvertList, databaseConvertList);
				table.setColumnList(columnList);
				readFlag = false;
			}

			Map <String, String> databaseConvertMap = new HashMap <String, String> ();
			Map <String, String> packageConvertMap = new HashMap <String, String> ();
			if (readFlag) {
				List <DatabaseConvert> databaseConvertList = this.databaseConvertService
						.queryDatabaseConvertListByDatabaseType(project.getDatabaseType());
				if ((databaseConvertList != null) && (databaseConvertList.size() > 0)) {
					for (int i = 0; i < databaseConvertList.size(); i++) {
						DatabaseConvert dc = (DatabaseConvert) databaseConvertList.get(i);
						databaseConvertMap.put(dc.getColumnType().toLowerCase(), dc.getConvertType());
					}
				}
				List <PackageConvert> packageConvertList = this.packageConvertService.queryPackageConvertSelect();
				if ((packageConvertList != null) && (packageConvertList.size() > 0)) {
					for (int i = 0; i < packageConvertList.size(); i++) {
						PackageConvert pc = (PackageConvert) packageConvertList.get(i);
						packageConvertMap.put(pc.getClassName(), pc.getPackageName());
					}
				}
			}
			//将表中column存入表中
			if ((table.getColumnList() != null) && (table.getColumnList().size() > 0)) {
				
				for (int i = 0; i < table.getColumnList().size(); i++) {
					Column column = (Column) table.getColumnList().get(i);
					if (readFlag) {
						column.setProjectId(table.getProjectId());
						column.setTableId(table.getTableId());
						column.setShowOrder(Integer.valueOf(i + 1));
						String columnType = (String) databaseConvertMap.get(workedColumnType(column.getMappingType()));
						if (columnType != null)
							column.setColumnType(columnType);
						else {
							column.setColumnType("Error:0");
						}
						if (packageConvertMap.get(column.getColumnType()) != null)
							column.setIsImportPackage("YES");
						else {
							column.setIsImportPackage("NO");
						}
					}
					
					if ((column.getIsQuery() == null) || (column.getIsQuery().equals(""))) {
						column.setIsQuery("NO");
					}
					this.columnService.insertColumn(column);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
		return table.getTableId();
	}

	public Integer updateTable(Table table) {
		validation(table, "update");
		List <Table> list = this.tableMapper.queryObjectListByColumns(table);
		if ((list != null) && (list.size() > 0)) {
			for (int i = 0; i < list.size(); i++) {
				if (((Table) list.get(i)).getTableId().equals(table.getTableId())) {
					list.remove(i);
					break;
				}
			}
			if (list.size() > 0)
				throw new ServiceException("该项目下的数据库表已经存在,请修改!");
		}
		try {
			return this.tableMapper.update(table);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.updateTable [ " + table + " ] 修改失败", e);
		}
		
		throw new ServiceException("修改失败");
	}

	public Integer deleteTable(Integer tableId) {
		try {
			Integer countDelete = this.tableMapper.delete(tableId);
			return countDelete;
		} catch (Exception e) {
			LOG.error("TableServiceImpl.deleteTable [ " + tableId + " ] 删除失败", e);
		}
		//删除table对应的column
		try {
			this.columnService.deleteColumnByTableId(tableId);
		} catch (Exception e) {
			LOG.error("columnService.deleteColumnByTableId [ " + tableId + " ] 删除失败", e);
		}
		//删除table对应的control
		try {
			this.controlService.deleteControlByTableId(tableId);
		} catch (Exception e) {
			LOG.error("controlService.deleteControlByTableId [ " + tableId + " ] 删除失败", e);
		}
		
		
		
		throw new ServiceException("删除失败");
	}

	public void deleteTables(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				deleteTable(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("TableServiceImpl.deleteTables [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Table querySingleTable(Integer tableId) {
		try {
			return (Table) this.tableMapper.querySingleObject(tableId);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.querySingleTable [ " + tableId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryTableCount(Table table) {
		try {
			return this.tableMapper.queryObjectCount(table);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableCount [ " + table + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Table> queryTableList(Table table) {
		try {
			List <Table> tableList = this.tableMapper.queryObjectList(table);
			if (isNotBlank(tableList)) {
				for (int i = 0; i < tableList.size(); i++) {
					Table t = tableList.get(i);
					t.setCountColumn(this.columnService.queryColumnCountByTableId(t.getTableId()));

				}
			}

			return tableList;
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableList [ " + table + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<Table> queryTableSelect() {
		try {
			return this.tableMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<Table> queryTableListByProjectId(Integer projectId) {
		try {
			return this.tableMapper.queryObjectListByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableListByProjectId [" + projectId + "] 查询Table列表失败", e);
		}
		throw new ServiceException("查询Table列表失败");
	}

	public JSONArray queryDataBaseTableListByProjectId(Integer projectId) {
		Project project = this.projectService.querySingleProject(projectId);
		if (project == null) {
			throw new ServiceException("请刷新网页后重试");
		}
		if (project.getIsValidation().equals("NO")) {
			throw new ServiceException("请先验证项目数据库");
		}
		List <ColumnConvert> columnConvertList = this.columnConvertService.queryColumnConvertSelect();
		if (project.getDatabaseType().equals("MySql")) {
			ConnectMySql connectMySql = new ConnectMySql();
			List <Table> tableList = connectMySql.queryProjectTableList(project, columnConvertList);
			if (isBlank(tableList)) {
				LOG.error("TableServiceImpl.queryProjectTableList[projectId:" + projectId + ",projectName:"
						+ project.getProjectName() + "]获取数据库表失败");
				throw new ServiceException("没有查询到数据库表");
			}
			List <Table> projectTableList = this.tableMapper.queryObjectListByProjectId(projectId);
			JSONArray array = new JSONArray();
			for (int i = 0; i < tableList.size(); i++) {
				Table t = (Table) tableList.get(i);
				boolean bool = true;
				for (int j = 0; j < projectTableList.size(); j++) {
					if (t.getMappingName().toLowerCase()
							.equals(((Table) projectTableList.get(j)).getMappingName().toLowerCase())) {
						projectTableList.remove(j);
						bool = false;
						break;
					}
				}
				if (bool) {
					JSONObject json = new JSONObject();
					json.put("tableName", t.getTableName());
					json.put("tableTitle", t.getTableTitle());
					json.put("mappingName", t.getMappingName());
					json.put("countColumn", Integer.valueOf(t.getColumnList().size()));
					json.put("serviceName", t.getTableName() + "Service");
					if (project.getProjectFrame().equals("SSH"))
						json.put("daoName", t.getTableName() + "Dao");
					else if (project.getProjectFrame().equals("SM")) {
						json.put("daoName", t.getTableName() + "Mapper");
					}
					array.add(json);
				}
			}
			if (array.size() == 0) {
				throw new ServiceException("没有可以添加数据库表");
			}
			return array;
		}
		if (project.getDatabaseType().equals("SqlServer"))
			throw new ServiceException("功能开发中...");
		if (project.getDatabaseType().equals("Oracle")) {
			throw new ServiceException("功能开发中...");
		}
		return null;
	}

	public Integer onKeyAutoAppendTable(Integer projectId) {
		Project project = this.projectService.querySingleProject(projectId);
		if (project == null) {
			throw new ServiceException("请刷新网页后重试");
		}
		if (project.getIsValidation().equals("NO")) {
			throw new ServiceException("请先验证项目数据库");
		}
		List<ColumnConvert> columnConvertList = this.columnConvertService.queryColumnConvertSelect();
		List<PackageConvert> packageConvertList = this.packageConvertService.queryPackageConvertSelect();
		List<DatabaseConvert> databaseConvertList = this.databaseConvertService
				.queryDatabaseConvertListByDatabaseType(project.getDatabaseType());
		List<Table> projectTableList = this.tableMapper.queryObjectListByProjectId(projectId);

		if (project.getDatabaseType().equals("MySql")) {
			ConnectMySql connectMySql = new ConnectMySql();
			List<Table> tableList = connectMySql.queryProjectTableList(project, columnConvertList);
			if (isBlank(tableList)) {
				LOG.error("TableServiceImpl.onKeyAutoAppendTable[projectId:" + projectId + ",projectName:"
						+ project.getProjectName() + "]获取数据库表失败");
				throw new ServiceException("没有查询到数据库表");
			}
			for (int i = 0; i < tableList.size(); i++) {
				Table t = (Table) tableList.get(i);
				boolean guolvFlag = true;
				for (int j = 0; j < projectTableList.size(); j++) {
					if (t.getMappingName().equals(((Table) projectTableList.get(j)).getMappingName())) {
						guolvFlag = false;
						tableList.remove(i);
						projectTableList.remove(j);
						i--;
						break;
					}
				}
				if (guolvFlag) {
					ArrayList<Column> columnList = connectMySql.queryColumnList(project, t, columnConvertList,
							packageConvertList, databaseConvertList);
					t.setColumnList(columnList);
				}
			}
			if (tableList.size() == 0) {
				throw new ServiceException("没有可以添加数据库表");
			}
			for (int i = 0; i < tableList.size(); i++) {
				Table t = (Table) tableList.get(i);
				insertTable(t);
			}

			return Integer.valueOf(tableList.size());
		}
		if (project.getDatabaseType().equals("SqlServer"))
			throw new ServiceException("功能开发中...");
		if (project.getDatabaseType().equals("Oracle")) {
			throw new ServiceException("功能开发中...");
		}
		return null;
	}

	public Integer deleteTableByModuleId(Integer moduleId) {
		try {
			List<Table> tableList = this.tableMapper.queryObjectListByModuleId(moduleId);
			for (int i = 0; i < tableList.size(); i++) {
				deleteTable(((Table) tableList.get(i)).getTableId());
			}
			return Integer.valueOf(tableList.size());
		} catch (Exception e) {
			LOG.error("TableServiceImpl.deleteTableByProjectId 根据项目ID删除table失败", e);
		}
		throw new ServiceException("根据项目ID删除table失败");
	}

	public List<String> queryTableSelectByProjectId(Integer projectId) {
		try {
			List<?> tableList = this.tableMapper.queryTableSelectByProjectId(projectId);
			if ((tableList == null) || (tableList.size() == 0)) {
				return null;
			}
			List<String> list = new ArrayList<String>();
			for (int i = 0; i < tableList.size(); i++) {
				Table t = (Table) tableList.get(i);
				String value = "<option value='" + t.getTableId() + "'>" + t.getTableName() + "</option>";
				list.add(value);
			}
			return list;
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.queryProjectSelectByIsValidation 查询已经验证通过下拉框列表失败", e);
		}
		throw new ServiceException("查询已经验证通过下拉框列表失败");
	}

	public Integer deleteTableByProjectId(Integer projectId) {
		try {
			return this.tableMapper.deleteObjectByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.deleteTableByProjectId [ " + projectId + " ] 删除Bean失败", e);
		}
		throw new ServiceException("删除Bean失败");
	}

	public List<Table> queryTableListForConvertError(Integer projectId, String errorName) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projectId", projectId);
			map.put("errorName", errorName);
			return this.tableMapper.queryObjectListForConvertError(map);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableListForConvertError [ " + projectId + " ] 查询转换失败列表异常", e);
		}
		throw new ServiceException("查询转换失败列表异常");
	}

	public List<Integer> queryTableListIdsByProjectId(Integer projectId) {
		try {
			return this.tableMapper.queryObjectListIdsByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableListIdsByProjectId [ " + projectId + " ] 根据项目查询数据库表列表异常", e);
		}
		throw new ServiceException("根据项目查询数据库表列表异常");
	}

	public void removePrefix(Integer projectId) {
		if ((projectId == null) || (projectId.intValue() == 0))
			throw new ServiceException("项目ID不能为空!");
		try {
			List<Table> tableList = this.tableMapper.queryObjectListByProjectId(projectId);
			if ((tableList != null) && (tableList.size() > 0))
				for (int i = 0; i < tableList.size(); i++) {
					Table t = (Table) tableList.get(i);
					if (t.getTableName().indexOf("_") > -1) {
						t.setTableName(t.getTableName().substring(t.getTableName().indexOf("_") + 1,
								t.getTableName().length()));
						this.tableMapper.update(t);
					}
				}
		} catch (Exception e) {
			LOG.error("TableServiceImpl.queryTableListIdsByProjectId [ " + projectId + " ] 移除TableName前缀异常", e);
			throw new ServiceException("移除TableName前缀异常");
		}
	}

	private String workedColumnType(String str) {
		if (str.contains("(")) {
			str = str.substring(0, str.indexOf("("));
		}
		return str;
	}

	public static String firstToUpper(String str) {
		if ((str == null) || (str.equals(""))) {
			return "";
		}
		return String.valueOf(str.charAt(0)).toUpperCase() + str.substring(1, str.length());
	}
}
