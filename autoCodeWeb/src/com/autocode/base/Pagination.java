package com.autocode.base;

import java.util.ArrayList;
import java.util.List;

public class Pagination<E> {
	private Integer pageStart;
	private Integer pageEnd;
	private Integer pageCount;
	private String pageHtml;
	private boolean result;
	private String message;
	private List<E> dataList = new ArrayList <E> ();

	public Pagination(BaseBean bean, Integer totalCount, List<E> dataList) {
		if (totalCount.intValue() == 0) {
			this.pageCount = Integer.valueOf(0);
			this.pageStart = Integer.valueOf(1);
			this.pageEnd = Integer.valueOf(10);
			this.dataList = new ArrayList <E> ();
			this.result = true;
			this.pageHtml = "";
		} else {
			this.pageCount = totalCount;
			this.pageStart = Integer.valueOf(bean.getPageStart().intValue() + 1);
			this.pageEnd = Integer.valueOf(bean.getPageStart().intValue() + bean.getPageSize().intValue());
			this.dataList = dataList;
			this.result = true;
			this.pageHtml = PageStyle.BootStarpStyleManage(bean.getPageIndex(), bean.getPageSize(), totalCount);
		}
	}

	public Pagination(String message) {
		if ((message == null) || (message.equals(""))) {
			message = "查询列表失败";
		}
		this.message = message;
		this.result = false;
	}

	public Integer getPageStart() {
		return this.pageStart;
	}

	public void setPageStart(Integer pageStart) {
		this.pageStart = pageStart;
	}

	public Integer getPageEnd() {
		return this.pageEnd;
	}

	public void setPageEnd(Integer pageEnd) {
		this.pageEnd = pageEnd;
	}

	public Integer getPageCount() {
		return this.pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public String getPageHtml() {
		return this.pageHtml;
	}

	public void setPageHtml(String pageHtml) {
		this.pageHtml = pageHtml;
	}

	public List<E> getDataList() {
		return this.dataList;
	}

	public void setDataList(List<E> dataList) {
		this.dataList = dataList;
	}

	public boolean isResult() {
		return this.result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
