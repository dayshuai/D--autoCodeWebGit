<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
	http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
	http://www.springframework.org/schema/context
	http://www.springframework.org/schema/context/spring-context-3.0.xsd">
	
	<context:component-scan base-package="${controllerPackage}"/>
	<context:annotation-config/>

	<bean id="freemarkerResolver"
		class="org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver">
		<property name="order" value="1" />
		<property name="suffix" value=".ftl" />
		<property name="contentType" value="text/html;charset=utf-8" />
		<property name="viewClass">
			<value>org.springframework.web.servlet.view.freemarker.FreeMarkerView
			</value>
		</property>
	</bean>

	<bean id="freemarkerConfig"
		class="org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer">
		<property name="templateLoaderPath">
			<value>/WEB-INF/index/</value>
		</property>
		<property name="freemarkerSettings"><!-- 设置FreeMarker环境属性 -->
			<props>
				<prop key="template_update_delay">5</prop><!--刷新模板的周期，单位为秒 -->
				<prop key="default_encoding">UTF-8</prop><!--模板的编码格式 -->
				<prop key="locale">UTF-8</prop><!-- 本地化设置 -->
				<prop key="datetime_format">yyyy-MM-dd HH:mm:ss</prop>
				<prop key="time_format">HH:mm:ss</prop>
				<prop key="number_format">0.####</prop>
				<prop key="boolean_format">true,false</prop>
				<prop key="whitespace_stripping">true</prop>
				<prop key="tag_syntax">auto_detect</prop>
				<prop key="url_escaping_charset">UTF-8</prop>
			</props>
		</property>
		<property name="freemarkerVariables">
			<map>
				<!--				<entry key="xml_escape" value-ref="xmlEscape" />-->
				<entry key="basepath" value="${r"#{"}servletContext.contextPath${r"}"}" />
			</map>
		</property>
		<property name="defaultEncoding" value="UTF-8" />
	</bean>
	
	<bean id="xmlEscape" class="freemarker.template.utility.XmlEscape" />
	
	<bean id="multipartResolver"
		class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<!-- one of the properties available; the maximum file size in bytes -->
		<!-- 5M -->
		<property name="defaultEncoding" value="utf-8" />
		<property name="maxUploadSize" value="104857600" />
		<!-- 设置把上传的文件都存放在项目下的 uploadTemp 文件夹下  -->
		<property name="uploadTempDir" value="uploadTemp" />
	</bean>
	<bean class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter">
		<property name="messageConverters">
			<list>
				<ref bean="mappingJacksonHttpMessageConverter" />
			</list>
		</property>
		<property name="webBindingInitializer">
			<bean class="${utilPackage}.SpringMVCDateConverter" />
		</property>
	</bean>
	<bean id="mappingJacksonHttpMessageConverter"
		class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter">
		<property name="supportedMediaTypes">
			<list>
				<value>text/html;charset=UTF-8</value>
			</list>
		</property>
	</bean>
	<bean class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver">
		<property name="defaultErrorView" value="error"></property> 
		<!-- 默认为500，系统错误 (error.jsp) -->
		<property name="defaultStatusCode" value="500"></property>
		<property name="statusCodes"><!-- 配置多个statusCode -->
			<props>
				<prop key="error">500</prop> <!-- error.jsp -->
				<prop key="error">404</prop> <!-- error1.jsp -->
			</props>
		</property>
		<property name="exceptionMappings">
			<props>
 				<!-- 这里你可以根据需要定义N多个错误异常转发 -->
				<prop key="java.sql.SQLException">error</prop> <!-- 数据库错误(dbError.jsp) -->
				<prop key="org.springframework.web.bind.ServletRequestBindingException">error</prop> 
 				<!-- 参数绑定错误(如：必须参数没传递)(bizError.jsp) -->
				<prop key="java.lang.IllegalArgumentException">error</prop> 
				<!-- 参数错误(bizError.jsp) -->
				<prop key="org.springframework.validation.BindException">error</prop> 
				<!-- 参数类型有误 (bizError.jsp) -->
				<prop key="java.lang.Exception">error</prop> 
				<!-- 其他错误为'未定义错 误'(unknowError.jsp) -->
			</props>
		</property>
	</bean>
	
</beans>