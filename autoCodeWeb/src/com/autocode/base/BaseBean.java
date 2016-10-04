package com.autocode.base;

public class BaseBean {
	private Integer pageSize = Integer.valueOf(10);
	private Integer pageIndex = Integer.valueOf(1);
	private String searchColumn;
	private String searchValue;
	private String sortColumn;
	private Integer pageStart;

	public Integer getPageSize() {
		return this.pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getPageIndex() {
		return this.pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public void setPageStart(Integer pageStart) {
		this.pageStart = pageStart;
	}

	public Integer getPageStart() {
		Integer start = Integer.valueOf((this.pageIndex.intValue() - 1) * this.pageSize.intValue());
		if (start.intValue() < 0) {
			start = Integer.valueOf(0);
		}
		return start;
	}

	public String getSearchColumn() {
		return this.searchColumn;
	}

	public void setSearchColumn(String searchColumn) {
		this.searchColumn = searchColumn;
	}

	public String getSortColumn() {
		return this.sortColumn;
	}

	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}

	public String getSearchValue() {
		return this.searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
}
