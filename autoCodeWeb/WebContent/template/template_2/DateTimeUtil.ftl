package ${utilPackage};

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {
	
	public static String FormatSystemDateSN()
	{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return sdf.format(new Date());
	}
	
	public static String FormatWithTime(Date date)
	{
		if(date == null)
			return "";
		return Format(date, "yyyy-MM-dd HH:mm:ss");
	}

	public static String FormatNoTime(Date date)
	{
		if(date == null)
			return "";
		return Format(date, "yyyy-MM-dd");
	}

	public static String Format(Date date, String formatString)
	{
		if(date == null)
			return "";
		SimpleDateFormat formatter = new SimpleDateFormat(formatString);
		return formatter.format(date); 	
	}

	public static String FormatCurrentDateTime()
	{
		Date date = new Date(System.currentTimeMillis());
		return Format(date, "yyyy-MM-dd HH:mm:ss");
	}

	public static String FormatCurrentDate()
	{
		Date date = new Date(System.currentTimeMillis());
		return Format(date, "yyyy-MM-dd");
	}

	public static Date CurrentDateTime()
	{
		return new Date(System.currentTimeMillis());
	}

}
