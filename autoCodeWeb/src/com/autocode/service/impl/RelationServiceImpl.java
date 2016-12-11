package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.bean.Config;
import com.autocode.bean.Project;
import com.autocode.bean.Relation;
import com.autocode.bean.Table;
import com.autocode.mapper.RelationMapper;
import com.autocode.mapper.TableMapper;
import com.autocode.service.ColumnService;
import com.autocode.service.ConfigService;
import com.autocode.service.ProjectService;
import com.autocode.service.RelationService;
import java.io.PrintStream;
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
@Service("relationService")
public class RelationServiceImpl extends BaseService implements RelationService {
	private static final Logger LOG = LoggerFactory.getLogger(RelationServiceImpl.class);

	@Autowired
	private RelationMapper relationMapper;

	@Autowired
	private TableMapper tableMapper;

	@Autowired
	private ColumnService columnService;

	@Autowired
	private ProjectService projectService;

	@Autowired
	private ConfigService configService;

	private void validation(Relation relation, String operatorState) {
		if (relation == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (relation.getRelationId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(relation.getProjectId())) {
			throw new ServiceException("项目不能为空");
		}
		if (isBlank(relation.getTableId())) {
			throw new ServiceException("主关系表不能为空");
		}
		if (isBlank(relation.getColumnId())) {
			throw new ServiceException("主关系字段不能为空");
		}
		if (isBlank(relation.getRelation())) {
			throw new ServiceException("关系不能为空");
		}
		if (isBlank(relation.getRelationTableId())) {
			throw new ServiceException("关系表不能为空");
		}
		if (isBlank(relation.getRelationColumnId())) {
			throw new ServiceException("关系表关系字段不能为空");
		}
		if ((relation.getRelation().equals("OneToOne")) || (relation.getRelation().equals("ManyToOne"))) {
			if (isBlank(relation.getRelationShowColumnId())) {
				throw new ServiceException("关系显示字段不能为空");
			}
			if (relation.getRelationShowColumnId().equals(relation.getRelationColumnId()))
				throw new ServiceException("关系显示字段不能和关系字段相同");
		} else if (relation.getRelation().equals("OneToMany")) {
			relation.setRelationShowColumnId(null);
		}
		if (isBlank(relation.getCascadeDelete()))
			throw new ServiceException("级联删除不能为空");
	}

	public Integer insertRelation(Relation relation) {
		validation(relation, "insert");
		Map map = new HashMap();
		map.put("projectId", relation.getProjectId());
		map.put("tableId", relation.getTableId());
		map.put("columnId", relation.getColumnId());
		map.put("relationTableId", relation.getRelationTableId());
		map.put("relationColumnId", relation.getRelationColumnId());
		List relationList = this.relationMapper.queryObjectListForRepeat(map);
		if ((relationList != null) && (relationList.size() > 0))
			throw new ServiceException("关系已经重复,请修改!");
		try {
			this.relationMapper.insert(relation);
			return relation.getRelationId();
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.insertRelation [ " + relation + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateRelation(Relation relation) {
		validation(relation, "update");
		Map map = new HashMap();
		map.put("projectId", relation.getProjectId());
		map.put("tableId", relation.getTableId());
		map.put("columnId", relation.getColumnId());
		map.put("relationTableId", relation.getRelationTableId());
		map.put("relationColumnId", relation.getRelationColumnId());
		List relationList = this.relationMapper.queryObjectListForRepeat(map);
		if ((relationList != null) && (relationList.size() > 0)) {
			for (int i = 0; i < relationList.size(); i++) {
				Relation r = (Relation) relationList.get(i);
				if (r.getRelationId().equals(relation.getRelationId())) {
					relationList.remove(i);
					break;
				}
			}
			if (relationList.size() > 0)
				throw new ServiceException("关系已经重复,请修改!");
		}
		try {
			return this.relationMapper.update(relation);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("RelationServiceImpl.updateRelation [ " + relation + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteRelation(Integer relationId) {
		try {
			return this.relationMapper.delete(relationId);
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.deleteRelation [ " + relationId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteRelations(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.relationMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.deleteRelations [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Relation querySingleRelation(Integer relationId) {
		try {
			return (Relation) this.relationMapper.querySingleObject(relationId);
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.querySingleRelation [ " + relationId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryRelationCount(Relation relation) {
		try {
			return this.relationMapper.queryObjectCount(relation);
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.queryRelationCount [ " + relation + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Relation> queryRelationList(Relation relation) {
		try {
			return this.relationMapper.queryObjectList(relation);
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.queryRelationList [ " + relation + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<Relation> queryRelationSelect() {
		try {
			return this.relationMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.queryRelationSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<Relation> queryRelationListForColumnName(String columnName, Object columnValue) {
		try {
			Map map = new HashMap();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return this.relationMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.queryRelationListForColumnName 根据字段查询失败", e);
		}
		throw new ServiceException("根据字段查询失败");
	}

	public Integer deleteRelationByProjectId(Integer projectId) {
		try {
			return this.relationMapper.deleteObjectByProjectId(projectId);
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.deleteRelationByProjectId [ " + projectId + " ] 删除关系失败", e);
		}
		throw new ServiceException("删除关系失败");
	}

	public Integer autoRelation(Integer projectId) {
		Project project = this.projectService.querySingleProject(projectId);
		if (project == null) {
			throw new ServiceException("项目不能为空,请刷新页面后重试");
		}
		try {
			List tableList = this.tableMapper.queryObjectListByProjectId(projectId);
			int success = 0;
			if ((tableList != null) && (tableList.size() > 1)) {
				List addRelationList = new ArrayList();

				List relationList = queryRelationListForColumnName("projectId", projectId);
				Config config = this.configService.queryConfigListForColumnName("ConfigName", "RelationShowColumn");
				String[] relationColumns = new String[0];
				if (config != null) {
					relationColumns = config.getConfigValue().split(",");
				}

				for (int i = 0; i < tableList.size(); i++) {
					Table table = (Table) tableList.get(i);
					List columnList = this.columnService.queryColumnListByTableId(table.getTableId());
					if ((columnList != null) && (columnList.size() > 1)) {
						table.setColumnList(columnList);
					} else {
						tableList.remove(i);
						i--;
					}
				}

				if (tableList.size() > 0) {
					tableList.add((Table) tableList.get(0));
				}
				for (int i = 0; i < tableList.size(); i++) {
					Table table = (Table) tableList.get(i);
					for (int j = 0; j < table.getColumnList().size(); j++) {
						Column c = (Column) table.getColumnList().get(j);
						if (c.getIsPrimary().equals("YES")) {
							for (int k = 0; k < tableList.size(); k++) {
								Table table1 = (Table) tableList.get(k);

								if (!table.getMappingName().equals(table1.getMappingName())) {
									for (int l = 0; l < table1.getColumnList().size(); l++) {
										Column c1 = (Column) table1.getColumnList().get(l);

										if ((c1.getColumnType().equals("Integer")) && (c1.getMappingName().toLowerCase()
												.equals(c.getMappingName().toLowerCase()))) {
											Integer relationShowColumnId = Integer.valueOf(0);

											for (int m = 0; m < table.getColumnList().size(); m++) {
												if ((((Column) table.getColumnList().get(m)).getColumnType()
														.equals("String"))
														&& (((Column) table.getColumnList().get(m)).getColumnName()
																.toLowerCase()
																.equals(table.getTableName().toString() + "name"))) {
													relationShowColumnId = ((Column) table.getColumnList().get(m))
															.getColumnId();
													break;
												}
											}

											if ((relationShowColumnId.intValue() == 0)
													&& (relationColumns.length > 0)) {
												for (int m = 0; m < table1.getColumnList().size(); m++) {
													for (int m1 = 0; m1 < relationColumns.length; m1++) {
														if (((Column) table1.getColumnList().get(m)).getMappingName()
																.toLowerCase().contains(relationColumns[m1])) {
															relationShowColumnId = ((Column) table1.getColumnList()
																	.get(m)).getColumnId();
															break;
														}
													}
													if (relationShowColumnId.intValue() != 0) {
														break;
													}
												}
											}
											if (relationShowColumnId.intValue() == 0) {
												for (int m = 0; m < table1.getColumnList().size(); m++) {
													if (((Column) table1.getColumnList().get(m)).getColumnType()
															.equals("String")) {
														relationShowColumnId = ((Column) table1.getColumnList().get(m))
																.getColumnId();
														break;
													}
												}
												if (relationShowColumnId.intValue() == 0) {
													relationShowColumnId = ((Column) table1.getColumnList().get(1))
															.getColumnId();
												}
											}

											if (c1.getIsPrimary().equals("YES")) {
												addRelationList.add(new Relation(projectId, table.getTableId(),
														c.getColumnId(), "OneToOne", table1.getTableId(),
														c1.getColumnId(), relationShowColumnId, "YES"));
											} else {
												addRelationList.add(new Relation(projectId, table.getTableId(),
														c.getColumnId(), "OneToMany", table1.getTableId(),
														c1.getColumnId(), null, "YES"));
												relationShowColumnId = Integer.valueOf(0);

												for (int m = 0; m < table.getColumnList().size(); m++) {
													if ((((Column) table.getColumnList().get(m)).getColumnType()
															.equals("String"))
															&& (((Column) table.getColumnList().get(m)).getColumnName()
																	.toLowerCase()
																	.equals(table.getTableName().toString()
																			+ "name"))) {
														relationShowColumnId = ((Column) table.getColumnList().get(m))
																.getColumnId();
														break;
													}
												}

												if ((relationShowColumnId.intValue() == 0)
														&& (relationColumns.length > 0)) {
													for (int m = 0; m < table.getColumnList().size(); m++) {
														for (int m1 = 0; m1 < relationColumns.length; m1++) {
															if (((Column) table.getColumnList().get(m)).getMappingName()
																	.toLowerCase().contains(relationColumns[m1])) {
																relationShowColumnId = ((Column) table.getColumnList()
																		.get(m)).getColumnId();
																break;
															}
														}
														if (relationShowColumnId.intValue() != 0) {
															break;
														}
													}
												}
												if (relationShowColumnId.intValue() == 0) {
													for (int m = 0; m < table.getColumnList().size(); m++) {
														if (((Column) table.getColumnList().get(m)).getColumnType()
																.equals("String")) {
															relationShowColumnId = ((Column) table.getColumnList()
																	.get(m)).getColumnId();
															break;
														}
													}
													if (relationShowColumnId.intValue() == 0) {
														relationShowColumnId = ((Column) table.getColumnList().get(1))
																.getColumnId();
													}
												}

												addRelationList.add(new Relation(projectId, table1.getTableId(),
														c1.getColumnId(), "ManyToOne", table.getTableId(),
														c.getColumnId(), relationShowColumnId, "NO"));
											}
										}
									}
								}
							}
						}
					}
				}
				for (int i = 0; i < addRelationList.size(); i++) {
					Relation r1 = (Relation) addRelationList.get(i);
					for (int j = i + 1; j < addRelationList.size(); j++) {
						Relation r2 = (Relation) addRelationList.get(j);
						if ((r1.getTableId().equals(r2.getTableId())) && (r1.getColumnId().equals(r2.getColumnId()))
								&& (r1.getRelationTableId().equals(r2.getRelationTableId()))
								&& (r1.getRelation().equals(r2.getRelation()))) {
							addRelationList.remove(j);
							j--;
						}
					}
				}
				if (addRelationList.size() > 0) {
					for (int i = 0; i < relationList.size(); i++) {
						Relation r1 = (Relation) relationList.get(i);
						for (int j = 0; j < addRelationList.size(); j++) {
							Relation r2 = (Relation) addRelationList.get(j);
							System.out.println(r1.getTableId().equals(r2.getTableId()) + ","
									+ r1.getColumnId().equals(r2.getColumnId()) + ","
									+ r1.getRelationTableId().equals(r2.getRelationTableId()) + ","
									+ r1.getRelation().equals(r2.getRelation()));
							if ((r1.getTableId().equals(r2.getTableId())) && (r1.getColumnId().equals(r2.getColumnId()))
									&& (r1.getRelationTableId().equals(r2.getRelationTableId()))
									&& (r1.getRelation().equals(r2.getRelation()))) {
								addRelationList.remove(j);
								j--;
							}
						}
					}
					success = addRelationList.size();
					for (int i = 0; i < addRelationList.size(); i++) {
						Relation relation = (Relation) addRelationList.get(i);
						this.relationMapper.insert(relation);
					}
					return Integer.valueOf(success);
				}
			}
		} catch (Exception e) {
			LOG.error("RelationServiceImpl.autoRelation [ " + projectId + " ] 自动找关系失败", e);
			throw new ServiceException("自动找关系异常");
		}
		return null;
	}
}
