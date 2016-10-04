package ${basePackage};

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;

public class BaseController {

    /**
     * 查询成功
     * 
     * @param totalCount
     * @param dataList
     */
    public static Pagination buildPagination(Integer totalCount, List<?> dataList) {
		Pagination pagination = new Pagination();
		pagination.setResult(true);
		pagination.setMessage("查询成功");
		pagination.setTotal(totalCount);
		pagination.setRows(dataList);
		return pagination;
    }

    /**
     * 查询失败
     * 
     * @param totalCount
     * @param dataList
     */
    public static Pagination buildPagination(String message) {
		Pagination pagination = new Pagination();
		pagination.setResult(true);
		pagination.setMessage("查询失败");
		pagination.setTotal(0);
		pagination.setRows(Collections.EMPTY_LIST);
		return pagination;
    }

    /**
     * 操作失败
     * 
     * @param message
     * @return
     */
    public Map<String, Object> resultFalse(String message) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", false);
		resultMap.put("message", message);
		return resultMap;
    }

    /**
     * 操作成功
     * 
     * @return
     */
    public Map<String, Object> resultTrue() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", true);
		resultMap.put("message", "操作成功");
		return resultMap;
    }

    /**
     * 操作成功
     * 
     * @param value
     * @return
     */
    public Map<String, Object> resultTrue(String value) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", true);
		resultMap.put("data", value);
		return resultMap;
    }

    /**
     * 操作成功
     * 
     * @param map
     * @return
     */
    public Map<String, Object> resultTrue(Map<?, ?> map) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", true);
		resultMap.put("data", map);
		return resultMap;
    }

    /**
     * 操作成功
     * 
     * @param jsonArray
     * @return
     */
    public Map<String, Object> resultTrue(JSONArray jsonArray) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", true);
		resultMap.put("dataList", jsonArray);
		return resultMap;
    }

    /**
     * 操作成功
     * 
     * @param list
     * @return
     */
    public Map<String, Object> resultTrue(List<?> list) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", true);
		resultMap.put("dataList", list);
		return resultMap;
    }

    /**
     * map转换 select option list
     * 
     * @param dataMap
     * @return
     */
    public List<String> buildSelectList(Map<Object, Object> dataMap) {
		List<String> selectList = new ArrayList<String>();
		if (dataMap != null && dataMap.size() > 0) {
		    for (Map.Entry<Object, Object> data : dataMap.entrySet()) {
			String option = "<option value='" + data.getKey() + "'>" + data.getValue() + "</option>";
			selectList.add(option);
		    }
		}
		return selectList;
    }
}