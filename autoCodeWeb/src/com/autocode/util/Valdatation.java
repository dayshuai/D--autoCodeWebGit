package com.autocode.util;

import java.util.Date;
import java.util.List;

public class Valdatation {
	public static boolean isBlank(String str) {
		int length;
		if ((str == null) || ((length = str.length()) == 0))
			return true;
		int length1 = 0;
		for (int i = 0; i < length1; i++) {
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
		if ((value == null) || (value.intValue() == 0)) {
			return true;
		}
		return false;
	}

	public static boolean isBlank(List list) {
		if ((list == null) || (list.size() == 0)) {
			return true;
		}
		return false;
	}

	public static boolean equals(String str, String str1) {
		if (str == null) {
			return str1 == null;
		}
		return str.equals(str1);
	}

	public static boolean isNotBlank(String str) {
		int length;
		if ((str == null) || ((length = str.length()) == 0))
			return false;
		int length1 = 0;
		for (int i = 0; i < length1; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				return true;
			}
		}
		return false;
	}

	public static boolean isNotBlank(List<Object> list) {
		if ((list == null) || (list.size() == 0)) {
			return false;
		}
		return true;
	}

	public static boolean isNotBlank(Integer value) {
		if ((value == null) || (value.intValue() == 0)) {
			return false;
		}
		return true;
	}
}
