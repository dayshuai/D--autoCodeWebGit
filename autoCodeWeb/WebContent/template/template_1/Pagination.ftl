package ${basePackage};

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

public class Pagination<E> {
	private Integer pageStart;	//条数	0
	private Integer pageEnd;	//当前页	0
	private Integer pageCount;		//所有页数	0
	private String pageHtml;		//所有页数	0
	private boolean result;
	private String message;
	private List<E> dataList = new ArrayList<E>();
	
	/**
	 * @param 成功调用该方法
	 */
	public Pagination(BaseBean bean,Integer totalCount,List<E> dataList){
		if(totalCount==0){
			this.pageCount=0;
			this.pageStart=1;
			this.pageEnd=10;
			this.dataList=new ArrayList<E>();
			this.result=true;
			this.pageHtml="";
		}else{
			this.pageCount=totalCount;
			this.pageStart=bean.getPageStart()+1;
			this.pageEnd=bean.getPageStart()+bean.getPageSize();
			this.dataList=dataList;
			this.result=true;
			this.pageHtml=PageStyle.BootStarpStyleManage(bean.getPageIndex(), bean.getPageSize(), totalCount);
		}
	}
	/**
	 * @param 失败调用该方法
	 */
	public Pagination(String message){
		if(message==null||message.equals("")){
			message="查询列表失败";
		}
		this.message=message;
		this.result=false;
	}
	
	public Integer getPageStart() {
		return pageStart;
	}
	public void setPageStart(Integer pageStart) {
		this.pageStart = pageStart;
	}
	public Integer getPageEnd() {
		return pageEnd;
	}
	public void setPageEnd(Integer pageEnd) {
		this.pageEnd = pageEnd;
	}
	public Integer getPageCount() {
		return pageCount;
	}
	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
	public String getPageHtml() {
		return pageHtml;
	}
	public void setPageHtml(String pageHtml) {
		this.pageHtml = pageHtml;
	}
	public List<E> getDataList() {
		return dataList;
	}
	public void setDataList(List<E> dataList) {
		this.dataList = dataList;
	}

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
}
