package com.autocode.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;

public class BaseController {
	public static boolean isBlank(String str) {
		int length;
		if ((str == null) || ((length = str.length()) == 0))
			return true;
		for (int i = 0; i < length; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}

	public static boolean isNotBlank(String str) {
		int length;
		if ((str == null) || ((length = str.length()) == 0))
			return false;
		for (int i = 0; i < length; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				return true;
			}
		}
		return false;
	}

	public static boolean isNotBlank(List list) {
		if ((list == null) || (list.size() == 0)) {
			return false;
		}
		return true;
	}

	public static boolean equals(String str, String str1) {
		if (str == null) {
			return str1 == null;
		}
		return str.equals(str1);
	}

	public Map<String, Object> resultFalse(String message) {
		Map resultMap = new HashMap();
		resultMap.put("result", Boolean.valueOf(false));
		resultMap.put("message", message);
		return resultMap;
	}

	public Map<String, Object> resultTrue() {
		Map resultMap = new HashMap();
		resultMap.put("result", Boolean.valueOf(true));
		return resultMap;
	}

	public Map<String, Object> resultTrue(String value) {
		Map resultMap = new HashMap();
		resultMap.put("result", Boolean.valueOf(true));
		resultMap.put("data", value);
		return resultMap;
	}

	public Map<String, Object> resultTrue(Map map) {
		Map resultMap = new HashMap();
		resultMap.put("result", Boolean.valueOf(true));
		resultMap.put("data", map);
		return resultMap;
	}

	public Map<String, Object> resultTrue(JSONArray jsonArray) {
		Map resultMap = new HashMap();
		resultMap.put("result", Boolean.valueOf(true));
		resultMap.put("dataList", jsonArray);
		return resultMap;
	}

	public Map<String, Object> resultTrue(List list) {
		Map resultMap = new HashMap();
		resultMap.put("result", Boolean.valueOf(true));
		resultMap.put("dataList", list);
		return resultMap;
	}
}
