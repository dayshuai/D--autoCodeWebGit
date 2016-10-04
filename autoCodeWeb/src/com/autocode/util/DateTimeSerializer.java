/*    */ package com.autocode.util;
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
/* 15 */   private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
/*    */ 
/* 17 */   public void serialize(Date date, JsonGenerator gen, SerializerProvider provider) throws IOException, JsonProcessingException { String formattedDate = dateFormat.format(date);
/* 18 */     gen.writeString(formattedDate);
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.util.DateTimeSerializer
 * JD-Core Version:    0.6.2
 */