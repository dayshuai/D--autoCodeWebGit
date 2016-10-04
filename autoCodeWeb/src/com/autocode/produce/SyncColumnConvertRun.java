package com.autocode.produce;

import com.autocode.bean.Column;
import com.autocode.bean.ColumnConvert;
import com.autocode.bean.Table;
import com.autocode.service.ColumnConvertService;
import java.util.List;

public class SyncColumnConvertRun extends Thread {
	private List<Table> tableList;
	private ColumnConvertService columnConvertService;

	public SyncColumnConvertRun(List<Table> tableList, ColumnConvertService columnConvertService) {
		this.tableList = tableList;
		this.columnConvertService = columnConvertService;
	}

	public void run() {
		if ((this.tableList != null) && (this.tableList.size() > 0))
			for (int i = 0; i < this.tableList.size(); i++) {
				Table table = (Table) this.tableList.get(i);
				ColumnConvert columnConvert = new ColumnConvert(table.getMappingName(), table.getTableName(),
						table.getTableTitle());
				handleColumnConvert(columnConvert);
				List columnList = table.getColumnList();
				if ((columnList != null) && (columnList.size() > 0))
					for (int j = 0; j < columnList.size(); j++) {
						Column c = (Column) columnList.get(j);
						columnConvert = new ColumnConvert(c.getMappingName(), c.getColumnName(), c.getColumnZhName());
						handleColumnConvert(columnConvert);
					}
			}
	}

	private void handleColumnConvert(ColumnConvert columnConvert) {
		List columnConvertList = this.columnConvertService.queryColumnConvertListForColumnName("mappingName",
				columnConvert.getMappingName());
		if ((columnConvertList != null) && (columnConvertList.size() > 0)) {
			ColumnConvert cc = (ColumnConvert) columnConvertList.get(0);
			cc.setColumnName(columnConvert.getColumnName());
			cc.setColumnZhName(columnConvert.getColumnZhName());
			this.columnConvertService.updateColumnConvert(cc);
		} else {
			this.columnConvertService.insertColumnConvert(columnConvert);
		}
	}
}
