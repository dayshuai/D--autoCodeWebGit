package ${basePackage};

/**
 * Bootstrap table 查询bean
 * 
 * @author autocode 
 */
public class BootstrapQueryBean {
	
	/** 页数	 */
	private Integer offset=1;
	
	/** 查询条数 */
	private Integer limit=10;
	
	/** 排序字段 */
	private String sort;
	
	/** 排序字段 */
	private String order = "ASC";

	public Integer getOffset() {
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
}