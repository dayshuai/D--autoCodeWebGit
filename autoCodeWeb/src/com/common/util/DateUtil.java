/*     */ package com.common.util;
/*     */ 
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.Calendar;
/*     */ import java.util.Date;
/*     */ import org.apache.commons.lang.time.DateFormatUtils;
/*     */ import org.apache.commons.lang.time.DateUtils;
/*     */ 
/*     */ public class DateUtil
/*     */ {
/*     */   public static final long MILLIS_PER_SECOND = 1000L;
/*     */   public static final long MILLIS_PER_MINUTE = 60000L;
/*     */   public static final long MILLIS_PER_HOUR = 3600000L;
/*     */   public static final long MILLIS_PER_DAY = 86400000L;
/*     */ 
/*     */   public static Date parseDate(String str, DateFormatEnum format)
/*     */     throws Exception
/*     */   {
/*  32 */     if (str == null)
/*  33 */       return null;
/*     */     try
/*     */     {
/*  36 */       SimpleDateFormat formatter = new SimpleDateFormat(format.getCode());
/*  37 */       return formatter.parse(str);
/*     */     } catch (Exception e) {
/*  39 */       throw new Exception("parse date " + str + " error", e);
/*     */     }
/*     */   }
/*     */ 
/*     */   public static Date parseDate(String str, String format)
/*     */     throws Exception
/*     */   {
/*  52 */     if (str == null)
/*  53 */       return null;
/*     */     try
/*     */     {
/*  56 */       SimpleDateFormat formatter = new SimpleDateFormat(format);
/*  57 */       return formatter.parse(str);
/*     */     } catch (Exception e) {
/*  59 */       throw new Exception("parse date " + str + " error", e);
/*     */     }
/*     */   }
/*     */ 
/*     */   public static final String dateFormat(Date date, DateFormatEnum format)
/*     */   {
/*  70 */     if (date == null) {
/*  71 */       return null;
/*     */     }
/*  73 */     return DateFormatUtils.format(date, format.getCode());
/*     */   }
/*     */ 
/*     */   public static final String dateFormat(Date date, String format)
/*     */   {
/*  84 */     if (date == null) {
/*  85 */       return null;
/*     */     }
/*  87 */     return DateFormatUtils.format(date, format);
/*     */   }
/*     */ 
/*     */   public static long diffDay(Date date1, Date date2)
/*     */   {
/*  98 */     Date d1 = DateUtils.truncate(date1, 5);
/*  99 */     Date d2 = DateUtils.truncate(date2, 5);
/* 100 */     return (d1.getTime() - d2.getTime()) / 86400000L;
/*     */   }
/*     */ 
/*     */   public static int diffMonth(Date date1, Date date2)
/*     */   {
/* 111 */     Calendar cal1 = Calendar.getInstance();
/* 112 */     cal1.setTime(date1);
/* 113 */     Calendar cal2 = Calendar.getInstance();
/* 114 */     cal2.setTime(date2);
/* 115 */     return cal1.get(1) * 12 + cal1.get(2) - (cal2.get(1) * 12 + cal2.get(2));
/*     */   }
/*     */ 
/*     */   public static Date truncatedDay(Date date)
/*     */   {
/* 125 */     return DateUtils.truncate(date, 5);
/*     */   }
/*     */ 
/*     */   public static Date truncatedCommon(Date date, int calendar)
/*     */   {
/* 154 */     return DateUtils.truncate(date, calendar);
/*     */   }
/*     */ 
/*     */   public static int compareTruncateDay(Date date1, Date date2)
/*     */   {
/* 165 */     Calendar cal1 = Calendar.getInstance();
/* 166 */     cal1.setTime(date1);
/* 167 */     Calendar cal2 = Calendar.getInstance();
/* 168 */     cal2.setTime(date2);
/* 169 */     return DateUtils.truncatedCompareTo(cal1, cal2, 5);
/*     */   }
/*     */ 
/*     */   public static boolean between(Date start, Date end, Date point)
/*     */     throws Exception
/*     */   {
/* 181 */     if ((start == null) || (end == null) || (point == null)) {
/* 182 */       throw new Exception("日期不能为空");
/*     */     }
/* 184 */     if (start.compareTo(end) > 0) {
/* 185 */       throw new Exception("开始日期大于结束时期,还比较个蛋");
/*     */     }
/* 187 */     if (point.compareTo(start) < 0) {
/* 188 */       return false;
/*     */     }
/*     */ 
/* 191 */     if (point.compareTo(end) > 0) {
/* 192 */       return false;
/*     */     }
/* 194 */     return true;
/*     */   }
/*     */ 
/*     */   public static Date addYears(Date date, int amount)
/*     */   {
/* 206 */     return DateUtils.addYears(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addMonths(Date date, int amount)
/*     */   {
/* 218 */     return DateUtils.addMonths(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addWeeks(Date date, int amount)
/*     */   {
/* 230 */     return DateUtils.addWeeks(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addDays(Date date, int amount)
/*     */   {
/* 242 */     return DateUtils.addDays(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addHours(Date date, int amount)
/*     */   {
/* 254 */     return DateUtils.addHours(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addMinutes(Date date, int amount)
/*     */   {
/* 266 */     return DateUtils.addMinutes(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addSeconds(Date date, int amount)
/*     */   {
/* 278 */     return DateUtils.addSeconds(date, amount);
/*     */   }
/*     */ 
/*     */   public static Date addMilliseconds(Date date, int amount)
/*     */   {
/* 290 */     return DateUtils.addMilliseconds(date, amount);
/*     */   }
/*     */ 
/*     */   public static boolean isSameDay(Date date1, Date date2)
/*     */   {
/* 304 */     return DateUtils.isSameDay(date1, date2);
/*     */   }
/*     */ 
/*     */   public static boolean isSameMonth(Date date1, Date date2)
/*     */   {
/* 319 */     Calendar cal1 = Calendar.getInstance();
/* 320 */     cal1.setTime(date1);
/* 321 */     Calendar cal2 = Calendar.getInstance();
/* 322 */     cal2.setTime(date2);
/* 323 */     return (cal1.get(0) == cal2.get(0)) && (cal1.get(1) == cal2.get(1)) && (cal1.get(2) == cal2.get(2));
/*     */   }
/*     */ 
/*     */   private static boolean isSameCalendarXValue(Date date1, Date date2, int x) {
/* 327 */     Calendar cal1 = Calendar.getInstance();
/* 328 */     cal1.setTime(date1);
/* 329 */     Calendar cal2 = Calendar.getInstance();
/* 330 */     cal2.setTime(date2);
/* 331 */     return (cal1.get(0) == cal2.get(0)) && (cal1.get(x) == cal2.get(x));
/*     */   }
/*     */ 
/*     */   public static boolean isSameYearValue(Date date1, Date date2)
/*     */   {
/* 345 */     return isSameCalendarXValue(date1, date2, 1);
/*     */   }
/*     */ 
/*     */   public static boolean isSameMonthValue(Date date1, Date date2)
/*     */   {
/* 359 */     return isSameCalendarXValue(date1, date2, 2);
/*     */   }
/*     */ 
/*     */   public static boolean isSameDayValue(Date date1, Date date2)
/*     */   {
/* 373 */     return isSameCalendarXValue(date1, date2, 5);
/*     */   }
/*     */ 
/*     */   public static int getCurrentMonthDayAmount()
/*     */   {
/* 382 */     Calendar a = Calendar.getInstance();
/* 383 */     a.set(5, 1);
/* 384 */     a.roll(5, -1);
/* 385 */     int maxDate = a.get(5);
/* 386 */     return maxDate;
/*     */   }
/*     */ 
/*     */   public static int getCurrentYearDayAmount()
/*     */   {
/* 395 */     Calendar date = Calendar.getInstance();
/* 396 */     date.set(2, 11);
/* 397 */     date.set(5, 31);
/* 398 */     return date.get(6);
/*     */   }
/*     */ 
/*     */   public static String FormatSystemDateSN() {
/* 402 */     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
/* 403 */     return sdf.format(new Date());
/*     */   }
/*     */ 
/*     */   public static String FormatWithTime(Date date) {
/* 407 */     if (date == null)
/* 408 */       return "";
/* 409 */     return Format(date, "yyyy-MM-dd HH:mm:ss");
/*     */   }
/*     */ 
/*     */   public static String FormatNoTime(Date date) {
/* 413 */     if (date == null)
/* 414 */       return "";
/* 415 */     return Format(date, "yyyy-MM-dd");
/*     */   }
/*     */ 
/*     */   public static String Format(Date date, String formatString) {
/* 419 */     if (date == null)
/* 420 */       return "";
/* 421 */     SimpleDateFormat formatter = new SimpleDateFormat(formatString);
/* 422 */     return formatter.format(date);
/*     */   }
/*     */ 
/*     */   public static String FormatCurrentDateTime() {
/* 426 */     Date date = new Date(System.currentTimeMillis());
/* 427 */     return Format(date, "yyyy-MM-dd HH:mm:ss");
/*     */   }
/*     */ 
/*     */   public static String FormatCurrentDate() {
/* 431 */     Date date = new Date(System.currentTimeMillis());
/* 432 */     return Format(date, "yyyy-MM-dd");
/*     */   }
/*     */ 
/*     */   public static Date CurrentDateTime() {
/* 436 */     return new Date(System.currentTimeMillis());
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.DateUtil
 * JD-Core Version:    0.6.2
 */