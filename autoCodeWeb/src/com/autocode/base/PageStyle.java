package com.autocode.base;

public class PageStyle<E> {
	private Integer pageSize = Integer.valueOf(15);
	private Integer pageIndex = Integer.valueOf(1);
	private Integer pageCount;
	private Integer rowCount;
	private Integer maxPage;
	private Integer minPage;
	private Integer previousPage;
	private Integer naxtPage;
	private Integer firstPage;
	private Integer lastPage;
	private Integer doublePage;
	private boolean showPage;
	private Integer showPageNum = Integer.valueOf(7);

	public static void main(String[] args) {
	}

	public static String BootStarpStyleIndex(Integer pageIndex, Integer pageSize, Integer totalCount) {
		PageStyle p = new PageStyle(pageIndex, pageSize, totalCount);
		try {
			String html = "";
			if (p.getShowPage()) {
				html = "<div class=\"col-xs-12\"><ul class=\"pagination\">";
				if (p.getFirstPage() == p.getPageIndex())
					html = html + "<li class=\"disabled\"><a href=\"javascript:void(0)\">首页</a></li>";
				else {
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getFirstPage()
							+ "')\">首页</a></li>";
				}
				if (p.getPreviousPage() == p.getPageIndex()) {
					html = html
							+ "<li class=\"disabled hidden-xs hidden-sm\"><a href=\"javascript:void(0)\"><上一页</a></li>";
					html = html
							+ "<li class=\"disabled hidden-lg hidden-md\"><a href=\"javascript:void(0)\"><</a></li>";
				} else {
					html = html
							+ "<li><a class=\"hidden-xs hidden-sm\" href=\"javascript:void(0)\" onclick=\"JumpPage('"
							+ p.getPreviousPage() + "')\"><上一页</a></li>";
					html = html
							+ "<li><a class=\"hidden-lg hidden-md\" href=\"javascript:void(0)\" onclick=\"JumpPage('"
							+ p.getPreviousPage() + "')\"><  " + p.getPreviousPage() + "页</a></li>";
				}
				for (int i = p.getMinPage().intValue(); i <= p.getMaxPage().intValue(); i++) {
					if (i == p.getPageIndex().intValue())
						html = html + "<li class=\"active\"><a href=\"javascript:void(0)\">" + i + "</a></li>";
					else {
						html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + i + "')\">" + i
								+ "</a></li>";
					}
				}
				if (p.getDoublePage().intValue() != 0) {
					html = html + "<li><a  class='hidden-xs hidden-sm' href=\"javascript:void(0)\" onclick=\"JumpPage('"
							+ p.getDoublePage() + "')\">...</a></li>";
				}
				if (p.getNaxtPage() == p.getPageIndex()) {
					html = html + "<li class=\"disabled hidden-xs hidden-sm\"><a href=\"javascript:void(0)\">下一页></a> ";
					html = html
							+ "<li class=\"disabled hidden-lg hidden-md\"><a href=\"javascript:void(0)\">></a></li>";
				} else {
					html = html
							+ "<li><a class=\"hidden-xs hidden-sm\" href=\"javascript:void(0)\" onclick=\"JumpPage('"
							+ p.getNaxtPage() + "')\">下一页></a></li>";
					html = html
							+ "<li><a class=\"hidden-lg hidden-md\" href=\"javascript:void(0)\" onclick=\"JumpPage('"
							+ p.getNaxtPage() + "')\">" + p.getNaxtPage() + "页  ></a></li>";
				}
				if (p.getLastPage() == p.getPageIndex())
					html = html + "<li class=\"disabled\"><a href=\"javascript:void(0)\">尾页</a></li>";
				else
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getLastPage()
							+ "')\">尾页</a></li>";
			}
			return html + "</ul></div>";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String BootStarpStyleManage(Integer pageIndex, Integer pageSize, Integer totalCount) {
		PageStyle p = new PageStyle(pageIndex, pageSize, totalCount);
		try {
			String html = "";
			if (p.getShowPage()) {
				html = "<ul class=\"pagination\">";
				if (p.getFirstPage().intValue() == p.getPageIndex().intValue())
					html = html + "<li class='disabled'><a href=\"javascript:void(0)\">首页</a></li>";
				else {
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getFirstPage()
							+ "')\">首页</a></li>";
				}
				if (p.getPreviousPage().intValue() == p.getPageIndex().intValue())
					html = html + "<li class='disabled'><a href=\"javascript:void(0)\"><上一页</a></li>";
				else {
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getPreviousPage()
							+ "')\"><上一页</a></li>";
				}
				for (int i = p.getMinPage().intValue(); i <= p.getMaxPage().intValue(); i++) {
					if (i == p.getPageIndex().intValue())
						html = html + "<li class=\"active\"><a href=\"javascript:void(0)\">" + i + "</a></li>";
					else {
						html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + i + "')\">" + i
								+ "</a></li>";
					}
				}
				if (p.getDoublePage().intValue() != 0) {
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getDoublePage()
							+ "')\">...</a></li>";
				}
				if (p.getNaxtPage().intValue() == p.getPageIndex().intValue())
					html = html + "<li class='disabled'><a href=\"javascript:void(0)\">下一页></a> ";
				else {
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getNaxtPage()
							+ "')\">下一页></a></li>";
				}
				if (p.getLastPage().intValue() == p.getPageIndex().intValue())
					html = html + "<li class='disabled'><a href=\"javascript:void(0)\">尾页</a></li>";
				else
					html = html + "<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('" + p.getLastPage()
							+ "')\">尾页</a></li>";
			}
			return html + "</ul>";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public PageStyle() {
	}

	public PageStyle(Integer pageIndex, Integer pageSize, Integer rowCount) {
		this.pageIndex = pageIndex;
		if (pageIndex.intValue() == 0) {
			this.pageIndex = Integer.valueOf(1);
			pageIndex = Integer.valueOf(1);
		}
		this.pageSize = pageSize;
		this.rowCount = rowCount;

		if (rowCount.intValue() % pageSize.intValue() == 0)
			this.pageCount = Integer.valueOf(rowCount.intValue() / pageSize.intValue());
		else {
			this.pageCount = Integer.valueOf(rowCount.intValue() / pageSize.intValue() + 1);
		}

		if ((this.pageCount.intValue() == 1) || (rowCount.intValue() == 0)) {
			this.showPage = false;
		} else {
			this.showPage = true;
			this.previousPage = Integer.valueOf(pageIndex.intValue() - 1);
			this.naxtPage = Integer.valueOf(pageIndex.intValue() + 1);
			if (this.previousPage.intValue() == 0) {
				this.previousPage = Integer.valueOf(1);
			}
			if (this.naxtPage.intValue() > this.pageCount.intValue()) {
				this.naxtPage = this.pageCount;
			}
			int pageNum = this.showPageNum.intValue() / 2;
			this.minPage = Integer.valueOf(pageIndex.intValue() - pageNum);
			this.maxPage = Integer.valueOf(pageIndex.intValue() + pageNum);
			if (this.minPage.intValue() <= 0) {
				this.minPage = Integer.valueOf(1);
				if (this.pageCount.intValue() > this.showPageNum.intValue()) {
					this.maxPage = this.showPageNum;
				}
			}
			if (this.maxPage.intValue() > getPageCount().intValue()) {
				this.maxPage = getPageCount();
				if (getPageCount().intValue() - this.showPageNum.intValue() >= 0) {
					this.minPage = Integer.valueOf(getPageCount().intValue() - pageNum);
				}
			}
			if (this.maxPage.intValue() - this.minPage.intValue() < this.showPageNum.intValue()) {
				if (this.maxPage.intValue() - this.showPageNum.intValue() > 0)
					this.minPage = Integer.valueOf(this.maxPage.intValue() - this.showPageNum.intValue());
				else {
					this.minPage = Integer.valueOf(1);
				}
			}
			if (getPageCount().intValue() >= pageIndex.intValue() + this.showPageNum.intValue()) {
				this.doublePage = Integer.valueOf(pageIndex.intValue() + this.showPageNum.intValue());
			} else if (getPageCount().intValue() >= this.pageIndex.intValue() + pageNum)
				this.doublePage = getPageCount();
			else {
				this.doublePage = Integer.valueOf(0);
			}

			this.firstPage = Integer.valueOf(1);
			this.lastPage = this.pageCount;
		}
	}

	public Integer getPageSize() {
		return this.pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getPageIndex() {
		if ((this.pageIndex == null) || (this.pageIndex.intValue() == 0)) {
			this.pageIndex = Integer.valueOf(1);
		}
		return this.pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageCount() {
		return this.pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public Integer getRowCount() {
		return this.rowCount;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public Integer getMaxPage() {
		return this.maxPage;
	}

	public void setMaxPage(Integer maxPage) {
		this.maxPage = maxPage;
	}

	public Integer getMinPage() {
		return this.minPage;
	}

	public void setMinPage(Integer minPage) {
		this.minPage = minPage;
	}

	public Integer getPreviousPage() {
		return this.previousPage;
	}

	public void setPreviousPage(Integer previousPage) {
		this.previousPage = previousPage;
	}

	public Integer getNaxtPage() {
		return this.naxtPage;
	}

	public void setNaxtPage(Integer naxtPage) {
		this.naxtPage = naxtPage;
	}

	public Integer getFirstPage() {
		return this.firstPage;
	}

	public void setFirstRows(Integer firstPage) {
		this.firstPage = firstPage;
	}

	public Integer getLastPage() {
		return this.lastPage;
	}

	public void setLastRows(Integer lastPage) {
		this.lastPage = lastPage;
	}

	public boolean getShowPage() {
		return this.showPage;
	}

	public void setShowPage(boolean showPage) {
		this.showPage = showPage;
	}

	public Integer getDoublePage() {
		return this.doublePage;
	}

	public void setDoublePage(Integer doublePage) {
		this.doublePage = doublePage;
	}

	public Integer getShowPageNum() {
		return this.showPageNum;
	}

	public void setShowPageNum(Integer showPageNum) {
		this.showPageNum = showPageNum;
	}

	public void setFirstPage(Integer firstPage) {
		this.firstPage = firstPage;
	}

	public void setLastPage(Integer lastPage) {
		this.lastPage = lastPage;
	}
}
