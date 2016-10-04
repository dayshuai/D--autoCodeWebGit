<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperPackage}.${table.tableName?cap_first}Mapper">
	
	<resultMap type="${beanPackage}.${table.tableName?cap_first}" id="${table.tableName?uncap_first}_mapping">
		<#list columnList as column>
			<#if column.isPrimary=="YES">
				<id property="${column.columnName?uncap_first}" column="${column.mappingName?lower_case}"/>
			<#else>
				<result property="${column.columnName?uncap_first}" column="${column.mappingName?lower_case}"/>
			</#if>
		</#list>
	</resultMap>
	
	<sql id="columns">
		<#list columnList as column>${column.mappingName?uncap_first}<#if column_has_next>,</#if></#list>
	</sql>
	
	<insert id="insert" parameterType="${table.tableName?cap_first}"  useGeneratedKeys="true" keyProperty="${databasePrimary?uncap_first}">
		INSERT INTO ${table.mappingName?lower_case} (<#list columnList as column><#if column.isPrimary!="YES">${column.mappingName?lower_case}<#if column_has_next>,</#if></#if></#list>)
		VALUES (<#list columnList as column><#if column.isPrimary!="YES">${r"#{"}${column.columnName?uncap_first}${r"}"}<#if column_has_next>,</#if></#if></#list>)
	</insert>

	<update id="update" parameterType="${table.tableName?cap_first}">
		UPDATE ${table.mappingName?lower_case}
 		SET <#list columnList as column><#if column.isPrimary!="YES"&&column.isUpdate=="YES">${column.mappingName?lower_case}=${r"#{"}${column.columnName?uncap_first}${r"}"}<#if column_has_next>,</#if></#if></#list>
		WHERE ${databasePrimary?uncap_first}=${r"#{"}${javaPrimary?uncap_first}${r"}"}
	</update>

	<delete id="delete" parameterType="Integer">
		DELETE FROM ${table.mappingName?lower_case} WHERE ${databasePrimary?uncap_first}=${r"#{value}"}
	</delete>
	
	<delete id="deletes" parameterType="String">
		DELETE FROM ${table.mappingName?lower_case} WHERE ${databasePrimary?uncap_first} in ( ${r"#{value}"} )
	</delete>

	<select id="querySingleObject" resultMap="${table.tableName?uncap_first}_mapping" parameterType="Integer">
		SELECT <include refid="columns"/> FROM ${table.mappingName?lower_case} WHERE ${databasePrimary?uncap_first}=${r"#{value}"} LIMIT 0,1
	</select>
	
	<select id="queryObjectPaginationCount" resultType="Integer" parameterType="${table.tableName?cap_first}">
		SELECT COUNT(1) FROM ${table.mappingName?lower_case} 
		WHERE 1=1 
		<#list columnList as column>
			<#if column.isPrimary!="YES">
		<if test="${column.columnName?uncap_first}!=null and ${column.columnName?uncap_first}!=''">
			AND ${column.mappingName?lower_case} = ${r"#{"}${column.columnName?uncap_first}${r"}"}
		</if>
			</#if>
		</#list>
	</select>

	<select id="queryObjectPaginationList" resultMap="${table.tableName?uncap_first}_mapping" parameterType="${table.tableName?cap_first}">
		<#if isRelation=="false">
		SELECT
		<include refid="columns"/>
		FROM ${table.mappingName?lower_case} ${table.tableName?lower_case}
		WHERE 1=1
		<#list columnList as column>
			<#if column.isPrimary!="YES">
		<if test="${column.columnName?uncap_first}!=null and ${column.columnName?uncap_first}!=''">
			AND ${column.mappingName?lower_case} = ${r"#{"}${column.columnName?uncap_first}${r"}"}
		</if>
			</#if>
		</#list>
		<if test="sort!=null and sort!=''">
			ORDER BY ${r"${sort}"} ${r"${order}"}
		</if>
		<if test="sort!=null || sort!=''">
			ORDER BY ${databasePrimary} ASC
		</if>
		<#else>
		SELECT
			${table.tableName?lower_case}.*,<#list relationList as relation><#if relation.relation!='ManyToMany'&&relation.relation!='OneToMany'>${relation.relationTableName?lower_case}.${relation.relationShowMappingName?lower_case}<#if relation_has_next>,</#if></#if></#list>
		FROM ${table.mappingName?lower_case} ${table.tableName?lower_case},<#list relationList as relation><#if relation.relation!='ManyToMany'>${relation.relationTableMappingName?lower_case} ${relation.relationTableName?lower_case}<#if relation_has_next>,</#if></#if></#list>
		WHERE 1=1 AND 
		<#list relationList as relation><#if relation.relation!='ManyToMany'>${relation.tableName?lower_case}.${relation.columnMappingName}=${relation.relationTableName?uncap_first}.${relation.relationColumnMappingName}<#if relation_has_next> AND </#if></#if></#list>
		<#list columnList as column>
			<#if column.isPrimary!="YES">
		<if test="${column.columnName?uncap_first}!=null and ${column.columnName?uncap_first}!=''">
			AND ${table.tableName?lower_case}.${column.mappingName?lower_case} = ${r"#{"}${column.columnName?uncap_first}${r"}"}
		</if>
			</#if>
		</#list>
		<if test="sort!=null and sort!=''">
			ORDER BY ${table.tableName?lower_case}.${r"${sort}"} ${r"${order}"}
		</if>
		<if test="sort!=null || sort!=''">
			ORDER BY ${databasePrimary} ASC
		</if>
		<if test="sortColumn!=null and sortColumn!=''">
			ORDER BY ${table.tableName?uncap_first}.${r"${sortColumn}"}
		</if>
		<if test="sortColumn==null||sortColumn==''">
			ORDER BY ${table.tableName?uncap_first}.${databasePrimary}
		</if>
		</#if>
		LIMIT ${r"#{limit} offset #{offset}"}
	</select>

	<select id="queryObjectList" resultMap="${table.tableName?uncap_first}_mapping" parameterType="Map">
		SELECT <include refid="columns"/> FROM ${table.mappingName?lower_case} WHERE 1=1 
		<#list columnList as column>
			<#if column.isPrimary!="YES">
		<if test="${column.columnName?uncap_first}!=null and ${column.columnName?uncap_first}!=''">
			AND ${column.mappingName?lower_case} = ${r"#{"}${column.columnName?uncap_first}${r"}"}
		</if>
			</#if>
		</#list>
	</select>
	
	<select id="queryObjectSelect" resultMap="${table.tableName?uncap_first}_mapping">
		SELECT <include refid="columns"/> FROM ${table.mappingName?lower_case} 
	</select>
	
</mapper>
