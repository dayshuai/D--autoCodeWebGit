package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class ControMethod extends BaseBean implements Serializable {
	private Integer controMethodId;
	private Integer controlId;
	private String controMethodName;
	private String isIntercept;
	private String methodType;
	private String methodMemo;

	public ControMethod() {
	}

	public ControMethod(Integer controlId, String controMethodName, String isIntercept, String methodType,
			String methodMemo) {
		this.controlId = controlId;
		this.controMethodName = controMethodName;
		this.isIntercept = isIntercept;
		this.methodType = methodType;
		this.methodMemo = methodMemo;
	}

	public void setControMethodId(Integer controMethodId) {
		this.controMethodId = controMethodId;
	}

	public Integer getControMethodId() {
		return this.controMethodId;
	}

	public void setControlId(Integer controlId) {
		this.controlId = controlId;
	}

	public Integer getControlId() {
		return this.controlId;
	}

	public void setControMethodName(String controMethodName) {
		this.controMethodName = controMethodName;
	}

	public String getControMethodName() {
		return this.controMethodName;
	}

	public void setIsIntercept(String isIntercept) {
		this.isIntercept = isIntercept;
	}

	public String getIsIntercept() {
		return this.isIntercept;
	}

	public void setMethodType(String methodType) {
		this.methodType = methodType;
	}

	public String getMethodType() {
		return this.methodType;
	}

	public void setMethodMemo(String methodMemo) {
		this.methodMemo = methodMemo;
	}

	public String getMethodMemo() {
		return this.methodMemo;
	}

	public String toString() {
		return "ControMethod[ controMethodId=" + this.controMethodId + ", controlId=" + this.controlId
				+ ", controMethodName=" + this.controMethodName + ", isIntercept=" + this.isIntercept + ", methodType="
				+ this.methodType + ", methodMemo=" + this.methodMemo + " ]";
	}
}
