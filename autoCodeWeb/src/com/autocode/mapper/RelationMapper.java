package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.Relation;
import java.util.List;
import java.util.Map;

public abstract interface RelationMapper extends BaseMapper<Relation> {
	public abstract Integer deleteObjectByProjectId(Integer paramInteger);

	public abstract List<Relation> queryObjectListForRepeat(Map<String, Object> paramMap);
}
