package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.PackageConvert;
import com.autocode.mapper.PackageConvertMapper;
import com.autocode.service.PackageConvertService;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("packageConvertService")
public class PackageConvertServiceImpl extends BaseService implements PackageConvertService {
	private static final Logger LOG = LoggerFactory.getLogger(PackageConvertServiceImpl.class);

	@Autowired
	private PackageConvertMapper packageConvertMapper;

	private void validation(PackageConvert packageConvert, String operatorState) {
		if (packageConvert == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (packageConvert.getPackageConvertId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(packageConvert.getClassName())) {
			throw new ServiceException("类名不能为空");
		}
		if (isBlank(packageConvert.getPackageName())) {
			throw new ServiceException("包名不能为空");
		}
		if (!packageConvert.getPackageName().contains("."))
			throw new ServiceException("包名必须包含 '点'");
	}

	public Integer insertPackageConvert(PackageConvert packageConvert) {
		validation(packageConvert, "insert");
		List list = this.packageConvertMapper.queryObjectListByColumns(packageConvert);
		if ((list != null) && (list.size() > 0))
			throw new ServiceException("类名重复,请修改!");
		try {
			this.packageConvertMapper.insert(packageConvert);
			return packageConvert.getPackageConvertId();
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.insertPackageConvert [ " + packageConvert + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updatePackageConvert(PackageConvert packageConvert) {
		validation(packageConvert, "update");
		List list = this.packageConvertMapper.queryObjectListByColumns(packageConvert);
		if ((list != null) && (list.size() > 0)) {
			for (int i = 0; i < list.size(); i++) {
				if (((PackageConvert) list.get(i)).getPackageConvertId().equals(packageConvert.getPackageConvertId())) {
					list.remove(i);
					break;
				}
			}
			if (list.size() > 0)
				throw new ServiceException("类名重复,请修改!");
		}
		try {
			return this.packageConvertMapper.update(packageConvert);
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.updatePackageConvert [ " + packageConvert + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deletePackageConvert(Integer packageConvertId) {
		try {
			return this.packageConvertMapper.delete(packageConvertId);
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.deletePackageConvert [ " + packageConvertId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deletePackageConverts(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.packageConvertMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.deletePackageConverts [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public PackageConvert querySinglePackageConvert(Integer packageConvertId) {
		try {
			return (PackageConvert) this.packageConvertMapper.querySingleObject(packageConvertId);
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.querySinglePackageConvert [ " + packageConvertId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryPackageConvertCount(PackageConvert packageConvert) {
		try {
			return this.packageConvertMapper.queryObjectCount(packageConvert);
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.queryPackageConvertCount [ " + packageConvert + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<PackageConvert> queryPackageConvertList(PackageConvert packageConvert) {
		try {
			return this.packageConvertMapper.queryObjectList(packageConvert);
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.queryPackageConvertList [ " + packageConvert + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<PackageConvert> queryPackageConvertSelect() {
		try {
			return this.packageConvertMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("PackageConvertServiceImpl.queryPackageConvertSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}
}
