package com.autocode.base;

public class SystemConstant {
	public static class AjaxRequest {
		public static final String SUCCESS = "SUCCESS";
		public static final String FAILED = "FAILED";
	}

	public static class ConfigType {
		public static final String STATIC = "STATIC";
		public static final String DYNAMIC = "DYNAMIC";
		public static final String COPY = "COPY";
	}

	public static class DatabaseType {
		public static final String MySql = "MySql";
		public static final String SqlServer = "SqlServer";
		public static final String Oracle = "Oracle";
	}

	public static class RelationType {
		public static final String None = "NONE";
		public static final String OneToOne = "OneToOne";
		public static final String ManyToOne = "ManyToOne";
		public static final String OneToMany = "OneToMany";
		public static final String ManyToMany = "ManyToMany";
	}

	public static class TrueOrFalse {
		public static final String TRUE = "true";
		public static final String FALSE = "false";
	}

	public static class YesOrNo {
		public static final String YES = "YES";
		public static final String NO = "NO";
	}
}

