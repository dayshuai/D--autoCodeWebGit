package ${basePackage};

import java.util.List;

public class Pagination {

	/** 查询结果 */
	private boolean result;

	/** 消息 */
	private String message;

	/** 总条数 */
	private Integer total;

	/** 数据列表 */
	private List<?> rows;

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}
}
