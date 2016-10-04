package com.autocode.service;

import com.autocode.bean.Column;
import java.util.List;

public abstract interface ColumnService {
	public abstract Integer insertColumn(Column paramColumn);

	public abstract Integer updateColumn(Column paramColumn);

	public abstract Integer deleteColumn(Integer paramInteger);

	public abstract void deleteColumns(String paramString);

	public abstract Column querySingleColumn(Integer paramInteger);

	public abstract Integer queryColumnCount(Column paramColumn);

	public abstract List<Column> queryColumnList(Column paramColumn);

	public abstract List<Column> queryColumnSelect();

	public abstract Integer queryColumnCountByTableId(Integer paramInteger);

	public abstract Integer deleteColumnByTableId(Integer paramInteger);

	public abstract List<Column> queryColumnListByTableIds(List<Integer> paramList);

	public abstract Integer deleteColumnByProjectId(Integer paramInteger);

	public abstract List<Column> queryColumnListForConvertError(Integer paramInteger, String paramString);

	public abstract List<Column> queryColumnListByTableId(Integer paramInteger);

	public abstract List<String> columnSelectByTableId(Integer paramInteger);
}
