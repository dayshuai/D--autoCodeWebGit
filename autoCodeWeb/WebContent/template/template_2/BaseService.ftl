package ${basePackage};

import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.util.CollectionUtils;

public class BaseService {

    public static boolean isBlank(String str) {
		int length;
		if ((str == null) || ((length = str.length()) == 0)) {
		    return true;
		}
		for (int i = 0; i < length; i++) {
		    if (!Character.isWhitespace(str.charAt(i))) {
			return false;
		    }
		}
		return true;
    }

    public static boolean isBlank(Date date) {
		if (date == null) {
		    return true;
		}
		return false;
    }

    public static boolean isBlank(Integer value) {
		if ((value == null) || (value == 0)) {
		    return true;
		}
		return false;
    }

    public static boolean isBlank(List<?> list) {
		if ((list == null) || (list.size() == 0)) {
		    return true;
		}
		return false;
    }

    public static boolean isNotBlank(Integer value) {
		if ((value == null) || (value == 0)) {
		    return false;
		}
		return true;
    }

    public static boolean isNotBlank(String str) {
		int length;
		if ((str == null) || ((length = str.length()) == 0)) {
		    return false;
		}
		for (int i = 0; i < length; i++) {
		    if (!Character.isWhitespace(str.charAt(i))) {
			return true;
		    }
		}
		return false;
    }

    public static boolean equals(String str, String str1) {
		if (str == null) {
		    return str1 == null;
		}
		return str.equals(str1);
    }

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
		pagination.setRows(CollectionUtils.isEmpty(dataList) ? Collections.EMPTY_LIST : dataList);
		return pagination;
    }
}