package com.autocode.service;

import com.autocode.bean.Relation;
import java.util.List;

public abstract interface RelationService {
	public abstract Integer insertRelation(Relation paramRelation);

	public abstract Integer updateRelation(Relation paramRelation);

	public abstract Integer deleteRelation(Integer paramInteger);

	public abstract void deleteRelations(String paramString);

	public abstract Relation querySingleRelation(Integer paramInteger);

	public abstract Integer queryRelationCount(Relation paramRelation);

	public abstract List<Relation> queryRelationList(Relation paramRelation);

	public abstract List<Relation> queryRelationSelect();

	public abstract List<Relation> queryRelationListForColumnName(String paramString, Object paramObject);

	public abstract Integer deleteRelationByProjectId(Integer paramInteger);

	public abstract Integer autoRelation(Integer paramInteger);
}
