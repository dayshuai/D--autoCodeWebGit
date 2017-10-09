<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperPackage}.${table.tableName?cap_first}DAO">
	
	<resultMap type="${beanPackage}.${table.tableName?cap_first}" id="BaseResultMap">
		<#list columnList as column>
			<#if column.isPrimary=="YES">
				<id column="${column.mappingName?lower_case}" property="${column.columnName?uncap_first}" />
			<#else>
				<result column="${column.mappingName?lower_case}" property="${column.columnName?uncap_first}"/>
			</#if>
		</#list>
	</resultMap>
	
	<sql id="Base_Column_List">
		<#list columnList as column>${column.mappingName?uncap_first}<#if column_has_next>,</#if></#list>
	</sql>
	
	<sql id="Where_Column_List">
  		<#list columnList as column>
			<#if column.isPrimary!="YES">
		<if test="${column.columnName?uncap_first}!=null and ${column.columnName?uncap_first}!=''">
			AND ${column.mappingName?lower_case} = ${r"#{"}${column.columnName?uncap_first}${r"}"}
		</if>
			</#if>
		</#list>
  	</sql>
	
	<insert id="insert" parameterType="${beanPackage}.${table.tableName?cap_first}" useGeneratedKeys = "true" keyProperty = "id">
		INSERT INTO ${table.mappingName?lower_case} (<#list columnList as column><#if column.isPrimary!="YES">${column.mappingName?lower_case}<#if column_has_next>,</#if></#if></#list>)
		VALUES (<#list columnList as column><#if column.isPrimary!="YES">${r"#{"}${column.columnName?uncap_first}${r"}"}<#if column_has_next>,</#if></#if></#list>)
	</insert>
	
	<insert id="insertSelective" parameterType="${beanPackage}.${table.tableName?cap_first}" useGeneratedKeys = "true" keyProperty = "id">
		INSERT INTO ${table.mappingName?lower_case} 
		<trim prefix="(" suffix=")" suffixOverrides="," >
			<#list columnList as column>
				<#if column.isPrimary!="YES">
					<if test="${column.columnName?uncap_first} != null" >
		        		${column.mappingName?lower_case},
		      		</if>
		      	</#if>
			</#list>
	    </trim>
    	<trim prefix="values (" suffix=")" suffixOverrides="," >
			<#list columnList as column>
				<#if column.isPrimary!="YES">
                	<if test="${column.columnName?uncap_first} != null">
					${r"#{"}${column.columnName?uncap_first}${r"}"},
					</if>
				</#if>
			</#list>
		</trim>
	</insert>
	
	<update id="updateById" parameterType="${beanPackage}.${table.tableName?cap_first}">
		UPDATE ${table.mappingName?lower_case}
 		SET <#list columnList as column><#if column.isPrimary!="YES"&&column.isUpdate=="YES">${column.mappingName?lower_case}=${r"#{"}${column.columnName?uncap_first}${r"}"}<#if column_has_next>,</#if></#if></#list>
		WHERE ${databasePrimary?uncap_first}=${r"#{"}${javaPrimary?uncap_first}${r"}"}
	</update>
	
	<update id="updateIdKeySelective" parameterType="${beanPackage}.${table.tableName?cap_first}">
		UPDATE ${table.mappingName?lower_case}
 		<set>
 		<#list columnList as column>
 			<#if column.isPrimary!="YES"&&column.isUpdate=="YES">
 			<if test="${column.columnName?uncap_first} != null" >
 				${column.mappingName?lower_case}=${r"#{"}${column.columnName?uncap_first}${r"}"},
 			</if>
 			</#if>
 		</#list>
 		</set>
		WHERE ${databasePrimary?uncap_first}=${r"#{"}${javaPrimary?uncap_first}${r"}"}
	</update>

	<delete id="deleteById" parameterType="java.lang.Long">
		DELETE FROM ${table.mappingName?lower_case} WHERE ${databasePrimary?uncap_first}=${r"#{value}"}
	</delete>

	<select id="selectById" resultMap="BaseResultMap" parameterType="java.lang.Long">
		SELECT <include refid="Base_Column_List"/> FROM ${table.mappingName?lower_case} WHERE ${databasePrimary?uncap_first}=${r"#{value}"} LIMIT 0,1
	</select>
	
	<select id="findAll" resultMap="BaseResultMap" parameterType="com.hundsun.sse.bond.project.dto.${table.tableName?cap_first}Qry">
		SELECT <include refid="Base_Column_List"/> FROM ${table.mappingName?lower_case} 
		 where 1 = 1
    	<include refid="Where_Column_List" />
    	order by id 
	</select>
	
</mapper>
