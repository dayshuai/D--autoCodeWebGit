package ${utilPackage};

public class StringConvertUtil {
	
	public static String firstLetterToLower(String str){
		return String.valueOf(str.charAt(0)).toLowerCase()+str.substring(1,str.length());
	}
	
	public static String firstLetterToUpper(String str){
		return String.valueOf(str.charAt(0)).toUpperCase()+str.substring(1,str.length());
	}
}
