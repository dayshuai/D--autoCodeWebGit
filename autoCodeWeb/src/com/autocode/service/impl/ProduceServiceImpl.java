package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Produce;
import com.autocode.mapper.ProduceMapper;
import com.autocode.service.ProduceService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("produceService")
public class ProduceServiceImpl extends BaseService implements ProduceService {
	private static final Logger LOG = LoggerFactory.getLogger(ProduceServiceImpl.class);

	@Autowired
	private ProduceMapper produceMapper;

	private void validation(Produce produce, String operatorState) {
		if (produce == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (produce.getProduceId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(produce.getProduceTitle())) {
			throw new ServiceException("标题不能为空");
		}
		if (isBlank(produce.getProduceName())) {
			throw new ServiceException("生成文件不能为空");
		}
		if (isBlank(produce.getTableAmount())) {
			throw new ServiceException("表数量不能为空");
		}
		if (isBlank(produce.getFileAmount())) {
			throw new ServiceException("文件数量不能为空");
		}
		if (isBlank(produce.getWasteTime())) {
			throw new ServiceException("消耗时间不能为空");
		}
		if (isBlank(produce.getCreateDate()))
			throw new ServiceException("创建时间不能为空");
	}

	public Integer insertProduce(Produce produce) {
		validation(produce, "insert");
		try {
			this.produceMapper.insert(produce);
			return produce.getProduceId();
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.insertProduce [ " + produce + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateProduce(Produce produce) {
		validation(produce, "update");
		try {
			return this.produceMapper.update(produce);
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.updateProduce [ " + produce + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteProduce(Integer produceId) {
		try {
			return this.produceMapper.delete(produceId);
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.deleteProduce [ " + produceId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteProduces(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.produceMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.deleteProduces [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Produce querySingleProduce(Integer produceId) {
		try {
			return (Produce) this.produceMapper.querySingleObject(produceId);
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.querySingleProduce [ " + produceId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryProduceCount(Produce produce) {
		try {
			return this.produceMapper.queryObjectCount(produce);
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.queryProduceCount [ " + produce + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Produce> queryProduceList(Produce produce) {
		try {
			return this.produceMapper.queryObjectList(produce);
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.queryProduceList [ " + produce + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<Produce> queryProduceSelect() {
		try {
			return this.produceMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.queryProduceSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<Produce> queryProduceListForColumnName(String columnName, String columnValue) {
		try {
			Map <String, Object> map = new HashMap <String, Object> ();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return this.produceMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("ProduceServiceImpl.queryProduceListForColumnName 根据字段查询失败", e);
		}
		throw new ServiceException("根据字段查询失败");
	}
}
