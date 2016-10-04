package com.common.util;

import java.io.PrintStream;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class PinyinUtil {
	private static final HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();

	static {
		format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		format.setVCharType(HanyuPinyinVCharType.WITH_V);
	}

	public static void main(String[] args) {
		System.out.println(getFirstLetterCapital("转换拼音"));
	}

	public static String getFirstLetterCapital(String str) {
		try {
			StringBuffer sb = new StringBuffer();
			char c = str.charAt(0);

			if ((c >= '一') && (c <= 40869)) {
				sb.append(net.sourceforge.pinyin4j.PinyinHelper.toHanyuPinyinStringArray(c, format)[0].charAt(0));
				return sb.toString().toUpperCase();
			}
			String value = str.substring(0, 1);
			if ((value.equals(" ")) || (value.equals(""))) {
				return null;
			}
			return value.toUpperCase();
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean isPinyin(String str) {
		try {
			if ((str == null) || (str.equals(""))) {
				return false;
			}
			for (int i = 0; i < str.length(); i++) {
				char c = str.charAt(i);
				if ((c >= '一') && (c <= 40869))
					return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static String getPinyin(String str) {
		try {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < str.length(); i++) {
				char c = str.charAt(i);

				if ((c >= '一') && (c <= 40869)) {
					sb.append(net.sourceforge.pinyin4j.PinyinHelper.toHanyuPinyinStringArray(c, format)[0]);
				} else if (((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'))) {
					sb.append(c);
				}
			}

			return sb.toString();
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getTextFirstLetter(String str) {
		try {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < str.length(); i++) {
				char c = str.charAt(i);

				if ((c >= '一') && (c <= 40869))
					sb.append(net.sourceforge.pinyin4j.PinyinHelper.toHanyuPinyinStringArray(c, format)[0].charAt(0));
				else {
					return null;
				}
			}
			return sb.toString();
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return str;
	}
}
