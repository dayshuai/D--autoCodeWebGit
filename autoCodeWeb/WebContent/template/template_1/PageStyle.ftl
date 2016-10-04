package ${basePackage};

public class PageStyle<E> {
	private Integer pageSize=15;	//条数	0
	private Integer pageIndex=1;	//当前页	0
	private Integer pageCount;		//所有页数	0
	private Integer rowCount;		//所有条数	0
	private Integer maxPage;		//最大页数	0
	private Integer minPage;		//最小页数	0
	private Integer previousPage;	//上一页		0
	private Integer naxtPage;		//下一页		0
	private Integer firstPage;		//首页		0
	private Integer lastPage;		//尾页		0
	private Integer doublePage;		//双倍分页	0
	private boolean showPage;		//是否显示分页0
	private Integer showPageNum=7;	//显示分页按钮个数
	
	public static void main(String[] args) {
//		Page p=new Page(1, 28, 1159);
//		if(p.getShowPage()){
//			System.out.print("首页"+p.getFirstPage());
//			System.out.print("\t上一页"+p.getPreviousPage());
//			for (int i = p.getMinPage(); i <=p.getMaxPage(); i++) {
//				if(i==p.getPageIndex()){
//					System.out.print("\t当前"+i);	
//				}else{
//					System.out.print("\t页"+i);	
//				}
//			}
//			System.out.print("\t双倍分页"+p.getDoublePage());
//			System.out.print("\t下一页"+p.getNaxtPage());
//			System.out.print("\t尾页"+p.getLastPage());
//			System.out.print("\t条数"+p.getRowCount());
//			System.out.println("\t页数"+p.getPageIndex()+"/"+p.getLastPage());
//		}
//		System.out.println(Page.BootStarpStyle(1,30,1159));
//		System.out.println(Page.ToJsonForList(1,30,1159).toString());
	}
	
	public static String BootStarpStyleIndex(Integer pageIndex,Integer pageSize,Integer totalCount) {
		PageStyle p=new PageStyle(pageIndex, pageSize, totalCount);
		try {
			String html="";
			if(p.getShowPage()){
				html="<div class=\"col-xs-12\"><ul class=\"pagination\">";
				if(p.getFirstPage()==p.getPageIndex()){
					html+="<li class=\"disabled\"><a href=\"javascript:void(0)\">首页</a></li>";
				}else{
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getFirstPage()+"')\">首页</a></li>";
				}
				if(p.getPreviousPage()==p.getPageIndex()){
					html+="<li class=\"disabled hidden-xs hidden-sm\"><a href=\"javascript:void(0)\"><上一页</a></li>";
					html+="<li class=\"disabled hidden-lg hidden-md\"><a href=\"javascript:void(0)\"><</a></li>";
				}else{
					html+="<li><a class=\"hidden-xs hidden-sm\" href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getPreviousPage()+"')\"><上一页</a></li>";
					html+="<li><a class=\"hidden-lg hidden-md\" href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getPreviousPage()+"')\"><  "+p.getPreviousPage()+"页</a></li>";
				}
				for (int i = p.getMinPage(); i <=p.getMaxPage(); i++) {
					if(i==p.getPageIndex()){
						html+="<li class=\"active\"><a href=\"javascript:void(0)\">"+i+"</a></li>";
					}else{
						html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+i+"')\">"+i+"</a></li>";
					}
				}
				if(p.getDoublePage()!=0){
					html+="<li><a  class='hidden-xs hidden-sm' href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getDoublePage()+"')\">...</a></li>";
				}
				if(p.getNaxtPage()==p.getPageIndex()){
					html+="<li class=\"disabled hidden-xs hidden-sm\"><a href=\"javascript:void(0)\">下一页></a> ";
					html+="<li class=\"disabled hidden-lg hidden-md\"><a href=\"javascript:void(0)\">></a></li>";
				}else{
					html+="<li><a class=\"hidden-xs hidden-sm\" href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getNaxtPage()+"')\">下一页></a></li>";
					html+="<li><a class=\"hidden-lg hidden-md\" href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getNaxtPage()+"')\">"+p.getNaxtPage()+"页  ></a></li>";
				}
				if(p.getLastPage()==p.getPageIndex()){
					html+="<li class=\"disabled\"><a href=\"javascript:void(0)\">尾页</a></li>";
				}else{
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getLastPage()+"')\">尾页</a></li>";
				}
				html+="</ul></div>";
			}
			return html;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public static String BootStarpStyleManage(Integer pageIndex,Integer pageSize,Integer totalCount) {
		PageStyle p=new PageStyle(pageIndex, pageSize, totalCount);
		try {
			String html="";
			if(p.getShowPage()){
				html="<ul class=\"pagination\">";
				if(p.getFirstPage().intValue()==p.getPageIndex().intValue()){
					html+="<li class='disabled'><a href=\"javascript:void(0)\">首页</a></li>";
				}else{
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getFirstPage()+"')\">首页</a></li>";
				}
				if(p.getPreviousPage().intValue()==p.getPageIndex().intValue()){
					html+="<li class='disabled'><a href=\"javascript:void(0)\"><上一页</a></li>";
				}else{
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getPreviousPage()+"')\"><上一页</a></li>";
				}
				for (int i = p.getMinPage(); i <=p.getMaxPage(); i++) {
					if(i==p.getPageIndex()){
						html+="<li class=\"active\"><a href=\"javascript:void(0)\">"+i+"</a></li>";
					}else{
						html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+i+"')\">"+i+"</a></li>";
					}
				}
				if(p.getDoublePage()!=0){
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getDoublePage()+"')\">...</a></li>";
				}
				if(p.getNaxtPage().intValue()==p.getPageIndex().intValue()){
					html+="<li class='disabled'><a href=\"javascript:void(0)\">下一页></a> ";
				}else{
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getNaxtPage()+"')\">下一页></a></li>";
				}
				if(p.getLastPage().intValue()==p.getPageIndex().intValue()){
					html+="<li class='disabled'><a href=\"javascript:void(0)\">尾页</a></li>";
				}else{
					html+="<li><a href=\"javascript:void(0)\" onclick=\"JumpPage('"+p.getLastPage()+"')\">尾页</a></li>";
				}
				html+="</ul>";
			}
			return html;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public PageStyle() {
		
	}
	//显示8个页面按钮
//	public Page(Integer pageIndex,Integer pageSize,Integer rowCount){
//		this.pageIndex=pageIndex;
//		if(pageIndex==0){
//			this.pageIndex=1;
//			pageIndex=1;
//		}
//		this.pageSize=pageSize;
//		this.rowCount=rowCount;
//		//计算出总页数
//		if (rowCount % pageSize == 0) {
//			this.pageCount=rowCount/pageSize;
//		} else {
//			this.pageCount=rowCount/pageSize + 1;
//		}
//		//是否显示分页
//		if(this.pageCount==1||rowCount==0){
//			this.showPage=false;
//		}else{
//			this.showPage=true;
//			this.previousPage = pageIndex - 1;
//			this.naxtPage = pageIndex + 1;
//			if(previousPage==0){
//				this.previousPage=1;
//			}
//			if (this.naxtPage > this.pageCount) {
//				this.naxtPage = this.pageCount;
//			}
//			minPage = pageIndex - 4;
//			maxPage = pageIndex + 3;
//			if (minPage <= 0) {
//				minPage = 1;
//				if(this.pageCount>8){
//					this.maxPage=8;
//				}
//			}
//			if (maxPage > this.getPageCount()) {
//				maxPage = this.getPageCount();
//				if(this.getPageCount()-8>=0){
//					minPage=this.getPageCount()-7;
//				}
//			}
//			if(this.getPageCount()>=pageIndex+8){
//				this.doublePage=pageIndex+8;
//			}else{
//				if(this.getPageCount()>=this.pageIndex+4){
//					this.doublePage=this.getPageCount();
//				}else{
//					this.doublePage=0;
//				}
//			}
//			this.firstPage=1;
//			this.lastPage=pageCount;
//		}
//	}
	//显示5个页面按钮
	public PageStyle(Integer pageIndex,Integer pageSize,Integer rowCount){
		this.pageIndex=pageIndex;
		if(pageIndex==0){
			this.pageIndex=1;
			pageIndex=1;
		}
		this.pageSize=pageSize;
		this.rowCount=rowCount;
		//计算出总页数
		if (rowCount % pageSize == 0) {
			this.pageCount=rowCount/pageSize;
		} else {
			this.pageCount=rowCount/pageSize + 1;
		}
		//是否显示分页
		if(this.pageCount==1||rowCount==0){
			this.showPage=false;
		}else{
			this.showPage=true;
			this.previousPage = pageIndex - 1;
			this.naxtPage = pageIndex + 1;
			if(previousPage==0){
				this.previousPage=1;
			}
			if (this.naxtPage > this.pageCount) {
				this.naxtPage = this.pageCount;
			}
			int pageNum=showPageNum/2;
			minPage = pageIndex - pageNum;
			maxPage = pageIndex + pageNum;
			if (minPage <= 0) {
				minPage = 1;
				if(this.pageCount>showPageNum){
					this.maxPage=showPageNum;
				}
			}
			if (maxPage > this.getPageCount()) {
				maxPage = this.getPageCount();
				if(this.getPageCount()-showPageNum>=0){
					minPage=this.getPageCount()-pageNum;
				}
			}
			if (maxPage-minPage<showPageNum) {
				if (maxPage-showPageNum>0) {
					minPage=maxPage-showPageNum;
				}else{
					minPage=1;
				}
			}
			if(this.getPageCount()>=pageIndex+showPageNum){
				this.doublePage=pageIndex+showPageNum;
			}else{
				if(this.getPageCount()>=this.pageIndex+pageNum){
					this.doublePage=this.getPageCount();
				}else{
					this.doublePage=0;
				}
			}
			this.firstPage=1;
			this.lastPage=pageCount;
		}
	}
	
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageIndex() {
		if(pageIndex==null||pageIndex==0){
			pageIndex=1;
		}
		return pageIndex;
	}
	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}
	public Integer getPageCount() {
		return pageCount;
	}
	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
	public Integer getRowCount() {
		return rowCount;
	}
	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}
	public Integer getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(Integer maxPage) {
		this.maxPage = maxPage;
	}
	public Integer getMinPage() {
		return minPage;
	}
	public void setMinPage(Integer minPage) {
		this.minPage = minPage;
	}
	public Integer getPreviousPage() {
		return previousPage;
	}
	public void setPreviousPage(Integer previousPage) {
		this.previousPage = previousPage;
	}
	public Integer getNaxtPage() {
		return naxtPage;
	}
	public void setNaxtPage(Integer naxtPage) {
		this.naxtPage = naxtPage;
	}
	public Integer getFirstPage() {
		return firstPage;
	}
	public void setFirstRows(Integer firstPage) {
		this.firstPage = firstPage;
	}
	public Integer getLastPage() {
		return lastPage;
	}
	public void setLastRows(Integer lastPage) {
		this.lastPage = lastPage;
	}
	public boolean getShowPage() {
		return showPage;
	}
	public void setShowPage(boolean showPage) {
		this.showPage = showPage;
	}
	public Integer getDoublePage() {
		return doublePage;
	}
	public void setDoublePage(Integer doublePage) {
		this.doublePage = doublePage;
	}

	public Integer getShowPageNum() {
		return showPageNum;
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
