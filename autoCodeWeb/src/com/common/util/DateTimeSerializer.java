/*    */ package com.common.util;
/*    */ 
/*    */ import java.io.IOException;
/*    */ import java.text.SimpleDateFormat;
/*    */ import java.util.Date;
/*    */ import org.codehaus.jackson.JsonGenerator;
/*    */ import org.codehaus.jackson.JsonProcessingException;
/*    */ import org.codehaus.jackson.map.JsonSerializer;
/*    */ import org.codehaus.jackson.map.SerializerProvider;
/*    */ import org.springframework.stereotype.Component;
/*    */ 
/*    */ @Component
/*    */ public class DateTimeSerializer extends JsonSerializer<Date>
/*    */ {
/* 22 */   private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
/*    */ 
/*    */   public void serialize(Date date, JsonGenerator gen, SerializerProvider provider) throws IOException, JsonProcessingException {
/* 25 */     String formattedDate = dateFormat.format(date);
/* 26 */     gen.writeString(formattedDate);
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.DateTimeSerializer
 * JD-Core Version:    0.6.2
 */