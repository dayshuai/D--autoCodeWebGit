package com.autocode.bean;

import com.autocode.base.BaseBean;
import com.autocode.util.DateTimeSerializer;
import java.io.Serializable;
import java.util.Date;
import org.codehaus.jackson.map.annotate.JsonSerialize;

public class Produce extends BaseBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer produceId;
	private String produceTitle;
	private String produceName;
	private Integer tableAmount;
	private Integer fileAmount;
	private String wasteTime;
	private Date createDate;
	private String memo;

	public Produce() {
	}

	public Produce(String produceTitle, String produceName, Integer tableAmount, Integer fileAmount, String wasteTime,
			Date createDate, String memo) {
		this.produceTitle = produceTitle;
		this.produceName = produceName;
		this.tableAmount = tableAmount;
		this.fileAmount = fileAmount;
		this.wasteTime = wasteTime;
		this.createDate = createDate;
		this.memo = memo;
	}

	public void setProduceId(Integer produceId) {
		this.produceId = produceId;
	}

	public Integer getProduceId() {
		return this.produceId;
	}

	public void setProduceTitle(String produceTitle) {
		this.produceTitle = produceTitle;
	}

	public String getProduceTitle() {
		return this.produceTitle;
	}

	public void setProduceName(String produceName) {
		this.produceName = produceName;
	}

	public String getProduceName() {
		return this.produceName;
	}

	public void setTableAmount(Integer tableAmount) {
		this.tableAmount = tableAmount;
	}

	public Integer getTableAmount() {
		return this.tableAmount;
	}

	public void setFileAmount(Integer fileAmount) {
		this.fileAmount = fileAmount;
	}

	public Integer getFileAmount() {
		return this.fileAmount;
	}

	public void setWasteTime(String wasteTime) {
		this.wasteTime = wasteTime;
	}

	public String getWasteTime() {
		return this.wasteTime;
	}

	@JsonSerialize(using = DateTimeSerializer.class)
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMemo() {
		return this.memo;
	}

	public String toString() {
		return "Produce [ produceTitle=" + this.produceTitle + ",produceName=" + this.produceName + ",tableAmount="
				+ this.tableAmount + ",fileAmount=" + this.fileAmount + ",wasteTime=" + this.wasteTime + ",createDate="
				+ this.createDate + ",memo=" + this.memo + "]";
	}
}
