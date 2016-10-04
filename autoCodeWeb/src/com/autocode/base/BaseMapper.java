package com.autocode.base;

import java.util.List;
import java.util.Map;

public abstract interface BaseMapper<T> {
	public abstract Integer insert(T paramT);

	public abstract Integer update(T paramT);

	public abstract Integer delete(Integer paramInteger);

	public abstract T querySingleObject(Integer paramInteger);

	public abstract Integer queryObjectCount(T paramT);

	public abstract List<T> queryObjectList(T paramT);

	public abstract List<T> queryObjectSelect();

	public abstract List<T> queryObjectListForColumnName(Map<String, Object> paramMap);
}

