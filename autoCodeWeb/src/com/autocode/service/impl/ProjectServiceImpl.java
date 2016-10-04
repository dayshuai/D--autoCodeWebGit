package com.autocode.service.impl;

import java.util.ArrayList;
import java.util.Date;
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
import com.autocode.bean.PackageConfig;
import com.autocode.bean.Project;
import com.autocode.bean.ProjectPackage;
import com.autocode.mapper.ColumnMapper;
import com.autocode.mapper.ControlMapper;
import com.autocode.mapper.ProjectMapper;
import com.autocode.mapper.ProjectPackageMapper;
import com.autocode.mapper.TableMapper;
import com.autocode.service.PackageConfigService;
import com.autocode.service.ProjectPackageService;
import com.autocode.service.ProjectService;
import com.autocode.util.CheckDatabase;
import com.autocode.util.PinyinUtil;

@Transactional
@Service("projectService")
public class ProjectServiceImpl extends BaseService implements ProjectService {
	private static final Logger LOG = LoggerFactory.getLogger(ProjectServiceImpl.class);

	@Autowired
	private ProjectMapper projectMapper;
	@Autowired
	private ColumnMapper columnMapper;
	@Autowired
	private ControlMapper controlMapper;
	@Autowired
	private TableMapper tableMapper;
	@Autowired
	private ProjectPackageMapper projectPackageMapper;
	@Autowired
	private PackageConfigService packageConfigService;
	@Autowired
	private ProjectPackageService projectPackageService;

	private void validation(Project project, String operatorState) {
		if (project == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (project.getProjectId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(project.getProjectTitle())) {
			throw new ServiceException("项目标题不能为空");
		}
		if (isBlank(project.getProjectName())) {
			throw new ServiceException("项目名称不能为空");
		}
		if (PinyinUtil.isPinyin(project.getProjectName())) {
			throw new ServiceException("项目名称不能有中文");
		}
		project.setProjectName(project.getProjectName().toLowerCase());
		if (isBlank(project.getProjectFrame())) {
			throw new ServiceException("框架不能为空");
		}
		if (isBlank(project.getRequestPostfix())) {
			throw new ServiceException("请求后缀不能为空");
		}
		if (!equals(".", project.getRequestPostfix().substring(0, 1))) {
			throw new ServiceException("请求后缀必须是以点开头");
		}
		if (isBlank(project.getDatabaseName())) {
			throw new ServiceException("数据库名不能为空");
		}
		if (isBlank(project.getDatabaseType())) {
			throw new ServiceException("数据库类型不能为空");
		}
		if (isBlank(project.getDatabaseIp())) {
			throw new ServiceException("数据库IP不能为空");
		}
		if (isBlank(project.getDatabasePort())) {
			throw new ServiceException("端口不能为空");
		}
		if (isBlank(project.getDatabaseUser())) {
			throw new ServiceException("用户名不能为空");
		}
		if (isBlank(project.getIsDefault()))
			throw new ServiceException("默认操作项目不能为空");
	}

	public Integer insertProject(Project project) {
		validation(project, "insert");
		try {
			project.setCreateDate(new Date());
			if (equals(project.getIsDefault(), "YES")) {
				this.projectMapper.updateAllDefaultNo();
			}
			if (CheckDatabase.checkDatabase(project.getProjectName(), project.getDatabaseType(),
					project.getDatabaseIp(), project.getDatabasePort(), project.getDatabaseUser(),
					project.getDatabasePwd())) {
				project.setIsValidation("YES");
			}
			this.projectMapper.insert(project);
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.insertProject [ " + project + " ] 添加失败", e);
			throw new ServiceException("添加失败");
		}
		List <PackageConfig> packageConfigList = this.packageConfigService.queryPackageConfigListForColumnName("applyFrame",
				project.getProjectFrame());
		if ((packageConfigList == null) || (packageConfigList.size() == 0)) {
			throw new ServiceException("请在常用包名中配置!");
		}
		String projectContolPackage = null;
		String projectServicePackage = null;
		String projectDaoPackage = null;
		Map<String, String> configMap = new HashMap<String, String>();
		for (int i = 0; i < packageConfigList.size(); i++) {
			PackageConfig pc = (PackageConfig) packageConfigList.get(i);
			configMap.put(pc.getPackageName(),
					pc.getPackagePath().replace("[replace]", project.getProjectName().toLowerCase()));
			ProjectPackage projectPackage = new ProjectPackage(project.getProjectId(), pc.getPackageName(),
					pc.getPackagePath().replace("[replace]", project.getProjectName().toLowerCase()), "自动生成");
			try {
				this.projectPackageService.insertProjectPackage(projectPackage);
			} catch (Exception e) {
				LOG.error("ProjectServiceImpl.insertProject [ " + project + " ] 添加失败", e);
				throw new ServiceException("添加项目默认包失败,请检查常用包名配置");
			}
		}
		projectServicePackage = (String) configMap.get("Service");
		if (project.getProjectFrame().equals("SM")) {
			projectContolPackage = (String) configMap.get("Controller");
			projectDaoPackage = (String) configMap.get("Mapper");
			if (projectContolPackage == null) {
				throw new ServiceException("请在常用包名配置中配置SM框架Controller包");
			}
			if (projectDaoPackage == null) {
				throw new ServiceException("请在常用包名配置中配置SM框架Mapper包");
			}
			if (projectServicePackage == null)
				throw new ServiceException("请在常用包名配置中配置SM框架Service包");
		} else if (project.getProjectFrame().equals("SSH")) {
			projectContolPackage = (String) configMap.get("Action");
			projectDaoPackage = (String) configMap.get("Dao");
			if (projectContolPackage == null) {
				throw new ServiceException("请在常用包名配置中配置SSH框架Action包");
			}
			if (projectDaoPackage == null) {
				throw new ServiceException("请在常用包名配置中配置SSH框架Dao包");
			}
			if (projectServicePackage == null) {
				throw new ServiceException("请在常用包名配置中配置SSH框架Service包");
			}
		}
		return project.getProjectId();
	}

	public Integer updateProject(Project project) {
		validation(project, "update");
		Project p = querySingleProject(project.getProjectId());
		if ((p.getIsDefault().equals("NO")) && (equals(project.getIsDefault(), "YES"))) {
			this.projectMapper.updateAllDefaultNo();
		}
		if ((p.getIsValidation().equals("NO")) && (CheckDatabase.checkDatabase(project.getProjectName(),
				project.getDatabaseType(), project.getDatabaseIp(), project.getDatabasePort(),
				project.getDatabaseUser(), project.getDatabasePwd()))) {
			project.setIsValidation("YES");
		}

		if (!p.getProjectFrame().equals(project.getProjectFrame())) {
			this.projectPackageService.deleteProjectPackageByProjectId(project.getProjectId());
			List<PackageConfig> packageConfigList = this.packageConfigService.queryPackageConfigListForColumnName("applyFrame",
					project.getProjectFrame());
			if ((packageConfigList == null) || (packageConfigList.size() == 0)) {
				throw new ServiceException("请在常用包名中配置!");
			}
			Map<String, String> configMap = new HashMap<String, String>();
			for (int i = 0; i < packageConfigList.size(); i++) {
				PackageConfig pc = (PackageConfig) packageConfigList.get(i);
				configMap.put(pc.getPackageName(),
						pc.getPackagePath().replace("[replace]", project.getProjectName().toLowerCase()));
				ProjectPackage projectPackage = new ProjectPackage(project.getProjectId(), pc.getPackageName(),
						pc.getPackagePath().replace("[replace]", project.getProjectName().toLowerCase()), "自动生成");
				try {
					this.projectPackageService.insertProjectPackage(projectPackage);
				} catch (Exception e) {
					LOG.error("ProjectServiceImpl.insertProject [ " + project + " ] 添加失败", e);
					throw new ServiceException("添加项目默认包失败,请检查常用包名配置");
				}
			}
		}
		try {
			return this.projectMapper.update(project);
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.updateProject [ " + project + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteProject(Integer projectId) {
		try {
			this.columnMapper.deleteObjectByProjectId(projectId);
			this.controlMapper.deleteObjectByProjectId(projectId);
			this.tableMapper.deleteObjectByProjectId(projectId);
			this.projectPackageMapper.deleteObjectByProjectId(projectId);
			return this.projectMapper.delete(projectId);
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.deleteProject [ " + projectId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteProjects(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				deleteProject(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.deleteProjects [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Project querySingleProject(Integer projectId) {
		try {
			return (Project) this.projectMapper.querySingleObject(projectId);
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.querySingleProject [ " + projectId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryProjectCount(Project project) {
		try {
			return this.projectMapper.queryObjectCount(project);
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.queryProjectCount [ " + project + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Project> queryProjectList(Project project) {
		try {
			return this.projectMapper.queryObjectList(project);
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.queryProjectList [ " + project + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<Project> queryProjectSelect() {
		try {
			return this.projectMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.queryProjectSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<String> queryProjectListByIsValidation() {
		try {
			List <Project> projectList = this.projectMapper.queryObjectListByIsValidation();
			if ((projectList == null) || (projectList.size() == 0)) {
				return null;
			}
			List <String> list = new ArrayList <String> ();
			for (int i = 0; i < projectList.size(); i++) {
				Project p = (Project) projectList.get(i);
				String value = "<option value='" + p.getProjectId() + "'>" + p.getProjectTitle() + "</option>";
				list.add(value);
			}
			return list;
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.queryProjectSelectByIsValidation 查询已经验证通过下拉框列表失败", e);
		}
		throw new ServiceException("查询已经验证通过下拉框列表失败");
	}

	private String workedColumnType(String str) {
		if (str.contains("(")) {
			str = str.substring(0, str.indexOf("("));
		}
		return str;
	}

}
