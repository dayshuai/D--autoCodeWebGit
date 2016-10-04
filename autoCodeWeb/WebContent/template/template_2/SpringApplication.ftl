<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:tx="http://www.springframework.org/schema/tx" 
	xmlns:task="http://www.springframework.org/schema/task"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/beans  
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd   
    http://www.springframework.org/schema/context   
    http://www.springframework.org/schema/context/spring-context-3.0.xsd  
    http://www.springframework.org/schema/tx
    http://www.springframework.org/schema/tx/spring-tx-3.0.xsd
    http://www.springframework.org/schema/task 
    http://www.springframework.org/schema/task/spring-task-3.0.xsd
    http://www.springframework.org/schema/mvc
	http://www.springframework.org/schema/mvc/spring-mvc-3.0.xsd 
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop-3.0.xsd">
     
	<!-- 定时器开关 开始 -->
	<task:annotation-driven />
	<context:annotation-config/>  
    <bean class="org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor"/>  
    
    <!-- 配置定时任务路径 -->
    <context:component-scan base-package="${serviceImplPackage}"/>  
	
	<!-- 标注类型 的事务配置 -->
	<tx:annotation-driven />
	
	<!-- 读取资源文件 -->
	<bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
		<property name="location" value="classpath:config.properties" />
	</bean>
	
	<!-- 线程池 -->
	<bean id="taskExecutor" class="org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor">  
		<property name="corePoolSize" value="1" /> <!-- 保留线程 --> 
		<property name="maxPoolSize" value="10" /> <!-- 最大使用线程 --> 
		<property name="queueCapacity" value="50" />  <!-- 等待线程 --> 
		<property name="keepAliveSeconds" value="2000" />  <!-- 最大线程执行时间,否则报错 -->
		<property name="rejectedExecutionHandler">  
			<bean class="java.util.concurrent.ThreadPoolExecutor$AbortPolicy" />  
		</property>  
	</bean> 
	
	<!-- 数据源 -->
	<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<property name="driverClassName" value="com.mysql.jdbc.Driver"></property>
		<property name="url" value="${r"${url}"}"></property>
		<property name="username" value="${r"${username}"}"></property>
		<property name="password" value="${r"${password}"}"></property>
	</bean>
	
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<!-- 自动匹配Mapper映射文件 -->
		<property name="mapperLocations" value="classpath:mappings/*_Mapper.xml"/>
		<property name="typeAliasesPackage" value="${beanPackage}"/>
	</bean>
	
	<!-- 通过扫描的模式，扫描目录在com.autocode.mapper目录下，所有的mapper都继承SqlMapper接口的接口， 这样一个bean就可以了 -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="${mapperPackage}" />
	</bean>
	
	<!-- 事务配置 -->
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
		<property name="globalRollbackOnParticipationFailure" value="false" />
	</bean>
	
	<aop:config>
		<aop:pointcut expression="execution(public * ${serviceImplPackage}.*Impl.*(..))" id="pointcut" />
		<aop:advisor advice-ref="txAdvice" pointcut-ref="pointcut" />
	</aop:config>
	<!-- 事务配置回滚数据 -->
	<tx:advice id="txAdvice" transaction-manager="transactionManager">
		<tx:attributes>
			<tx:method name="query*" propagation="REQUIRED" read-only="true" />
			<tx:method name="insert*" propagation="REQUIRED" />
			<tx:method name="update*" propagation="REQUIRED" />
			<tx:method name="delete*" propagation="REQUIRED" />
			<tx:method name="reset*" propagation="REQUIRED" />
		</tx:attributes>
	</tx:advice>

	<!-- 配置Spring AOP -->
<!--	<bean id="log4jHandlerAOP" class="com.autocode.logAop.LogAopAction"></bean> -->
<!--	-->
<!--	<aop:config proxy-target-class="true">-->
<!--	    <aop:aspect id="logAspect"> -->
<!--	    <aop:pointcut id="logPointCut" expression="execution(* com.autocode.service.impl.*.* (..))" /> -->
<!--	    <aop:around method="logAll" pointcut-ref="logPointCut" /> </aop:aspect> -->
<!--	</aop:config>-->

	<!-- 使用Spring组件扫描的方式来实现自动注入bean -->
	<context:component-scan base-package="${servicePackage}" />
	<!-- 隐式地向 Spring 容器注册 -->
	<context:annotation-config />
	
	<!--  Spring 拦截器 -->
	<mvc:interceptors>
		<mvc:interceptor>
			<mvc:mapping path="/*"/>
			<bean class="${servicePackage}.CommonInterceptor"/>
		</mvc:interceptor>
	</mvc:interceptors>
</beans>