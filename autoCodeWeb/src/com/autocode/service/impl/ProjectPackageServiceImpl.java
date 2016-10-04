package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.ProjectPackage;
import com.autocode.mapper.ProjectPackageMapper;
import com.autocode.service.ProjectPackageService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("projectPackageService")
public class ProjectPackageServiceImpl extends BaseService implements ProjectPackageService {
	private static final Logger LOG = LoggerFactory.getLogger(ProjectPackageServiceImpl.class);

	@Autowired
	private ProjectPackageMapper projectPackageMapper;

	private void validation(ProjectPackage projectPackage, String operatorState) {
		if (projectPackage == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (projectPackage.getProjectPackageId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(projectPackage.getPackageName())) {
			throw new ServiceException("包名称不能为空");
		}
		if (isBlank(projectPackage.getPackagePath())) {
			throw new ServiceException("包路径不能为空");
		}
		if (!projectPackage.getPackagePath().contains(".")) {
			throw new ServiceException("包路径必须包含 '点'");
		}
		if (isBlank(projectPackage.getMemo())) {
			throw new ServiceException("备注不能为空");
		}
		projectPackage.setPackagePath(projectPackage.getPackagePath().toLowerCase());
	}

	public Integer insertProjectPackage(ProjectPackage projectPackage) {
		validation(projectPackage, "insert");
		try {
			this.projectPackageMapper.insert(projectPackage);
			return projectPackage.getProjectPackageId();
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.insertProjectPackage [ " + projectPackage + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateProjectPackage(ProjectPackage projectPackage) {
		validation(projectPackage, "update");
		try {
			return this.projectPackageMapper.update(projectPackage);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.updateProjectPackage [ " + projectPackage + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteProjectPackage(Integer projectPackageId) {
		try {
			return this.projectPackageMapper.delete(projectPackageId);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.deleteProjectPackage [ " + projectPackageId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteProjectPackages(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.projectPackageMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.deleteProjectPackages [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public ProjectPackage querySingleProjectPackage(Integer projectPackageId) {
		try {
			return (ProjectPackage) this.projectPackageMapper.querySingleObject(projectPackageId);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.querySingleProjectPackage [ " + projectPackageId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryProjectPackageCount(ProjectPackage projectPackage) {
		try {
			return this.projectPackageMapper.queryObjectCount(projectPackage);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.queryProjectPackageCount [ " + projectPackage + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<ProjectPackage> queryProjectPackageList(ProjectPackage projectPackage) {
		try {
			return this.projectPackageMapper.queryObjectList(projectPackage);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.queryProjectPackageList [ " + projectPackage + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<ProjectPackage> queryProjectPackageSelect() {
		try {
			return this.projectPackageMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.queryProjectPackageSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public Integer replaceProjectPackage(Integer projectId, String sourceName, String replaceName) {
		if (isBlank(projectId)) {
			throw new ServiceException("项目不能为空");
		}
		if (isBlank(sourceName)) {
			throw new ServiceException("被替换值不能为空");
		}
		if (isBlank(replaceName))
			throw new ServiceException("替换值不能为空");
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("columnName", "projectId");
			map.put("columnValue", projectId);
			List<ProjectPackage> list = this.projectPackageMapper.queryObjectListForColumnName(map);
			if (isNotBlank(list)) {
				for (int i = 0; i < list.size(); i++) {
					ProjectPackage pp = (ProjectPackage) list.get(i);
					pp.setPackagePath(pp.getPackagePath().replace(sourceName, replaceName));
					updateProjectPackage(pp);
				}
			}
			return Integer.valueOf(list.size());
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.queryProjectPackageSelect 一键替换失败", e);
		}
		throw new ServiceException("一键替换失败");
	}

	public Integer deleteProjectPackageByProjectId(Integer projectId) {
		try {
			return this.projectPackageMapper.deleteObjectByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.deleteProjectPackageByProjectId [ " + projectId + " ] 删除项目包失败", e);
		}
		throw new ServiceException("删除项目包失败");
	}

	public List<ProjectPackage> queryProjectPackageListByProjectId(Integer projectId) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("columnName", "projectId");
			map.put("columnValue", projectId);
			return this.projectPackageMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("ProjectPackageServiceImpl.queryProjectPackageListByProjectId [ " + projectId + " ] 根据项目ID查询列表失败",
					e);
		}
		throw new ServiceException("根据项目ID查询列表失败");
	}
}
