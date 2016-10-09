package com.autocode.service;

import com.autocode.bean.Table;
import java.util.List;
import net.sf.json.JSONArray;

public abstract interface TableService {
	public abstract Integer insertTable(Table paramTable);

	public abstract Integer updateTable(Table paramTable);

	public abstract Integer deleteTable(Integer paramInteger);

	public abstract void deleteTables(String paramString);

	public abstract Table querySingleTable(Integer paramInteger);

	public abstract Integer queryTableCount(Table paramTable);

	public abstract List<Table> queryTableList(Table paramTable);

	public abstract List<Table> queryTableSelect();

	public abstract List<Table> queryTableListByProjectId(Integer paramInteger);

	public abstract JSONArray queryDataBaseTableListByProjectId(Integer paramInteger);

	public abstract Integer onKeyAutoAppendTable(Integer paramInteger);

	public abstract Integer deleteTableByModuleId(Integer paramInteger);

	public abstract Integer transmitAppend(Table paramTable);

	public abstract List<String> queryTableSelectByProjectId(Integer paramInteger);

	public abstract Integer deleteTableByProjectId(Integer paramInteger);

	public abstract List<Table> queryTableListForConvertError(Integer paramInteger, String paramString);

	public abstract List<Integer> queryTableListIdsByProjectId(Integer paramInteger);

	public abstract void removePrefix(Integer paramInteger);

	public abstract Integer replaceBean(Integer projectId, String sourceName, String replaceName);
}
