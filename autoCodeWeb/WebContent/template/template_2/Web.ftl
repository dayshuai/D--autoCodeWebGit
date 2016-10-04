<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee 
	http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">

	<context-param>
		<param-name>webAppRootKey</param-name>
		<param-value>${project.projectName}.root</param-value>
	</context-param>
	
	<context-param>
		<param-name>log4jConfigLocation</param-name>
		<param-value>classpath:log4j.properties</param-value>
	</context-param>
	
	<listener>
		<listener-class>org.springframework.web.util.Log4jConfigListener</listener-class>
	</listener>
	
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:spring-*.xml</param-value>
	</context-param>
	
	<filter>
		<filter-name>encode</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>encode</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<listener>          
		<listener-class>org.springframework.web.context.request.RequestContextListener</listener-class>
	</listener>
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	<session-config>
		<session-timeout>120</session-timeout>
	</session-config>
	<servlet>
		<servlet-name>springmvc</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:spring-servlet.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>

	<servlet-mapping>
		<servlet-name>springmvc</servlet-name>
		<url-pattern>*${project.requestPostfix}</url-pattern>
	</servlet-mapping>

	<filter>
		<filter-name>Common Filter</filter-name>
		<filter-class>com.lottery.filter.CommonFilter</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>Common Filter</filter-name>
		<url-pattern>*</url-pattern>
	</filter-mapping>
	
	<welcome-file-list>
		<welcome-file>index.jsp</welcome-file>
	</welcome-file-list>
	
	<error-page> 
		<error-code>404</error-code>
		<location>/error.jsp</location> 
	</error-page> 
	<error-page>
		<exception-type>java.lang.Exception</exception-type>
		<location>/error.jsp</location> 
	</error-page>
</web-app>
