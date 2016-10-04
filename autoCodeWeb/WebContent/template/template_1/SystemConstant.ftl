package ${basePackage};

/**
 * 系统常量
 * @author lihui.zhanglh
 *
 */
public class SystemConstant {

    public static class AjaxRequest {
        /**
         * 请求成功
         */
        public static final String SUCCESS = "SUCCESS";
        /**
         * 请求失败
         */
        public static final String FAILED  = "FAILED";
    }

    public static class YesOrNo {
        /**
         * 是
         */
        public static final String YES = "YES";
        /**
         * 否
         */
        public static final String NO  = "NO";
    }
    
    public static class TrueOrFalse {
        /**
         * 是
         */
        public static final String TRUE = "true";
        /**
         * 否
         */
        public static final String FALSE  = "false";
    }
    
    public static class DatabaseType {
    	
        public static final String MySql = "MySql";

        public static final String SqlServer  = "SqlServer";
        
        public static final String Oracle  = "Oracle";
    }
    
    public static class RelationType {
    	
        public static final String None = "NONE";

        public static final String OneToOne  = "OneToOne";
        
        public static final String ManyToOne  = "ManyToOne";
        
        public static final String OneToMany  = "OneToMany";
        
        public static final String ManyToMany  = "ManyToMany";
    }
    
    public static class ConfigType {
    	
        public static final String STATIC = "STATIC";

        public static final String DYNAMIC  = "DYNAMIC";
    }
}
