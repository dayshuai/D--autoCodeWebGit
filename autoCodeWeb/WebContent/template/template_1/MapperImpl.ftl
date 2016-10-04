<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperPackage}.${table.tableName?cap_first}Mapper">
	<sql id="columns">
		<#list columnList as column>${column.mappingName?uncap_first}<#if column_has_next>,</#if></#list>
	</sql>
	
	<insert id="insert" parameterType="${table.tableName?cap_first}"  useGeneratedKeys="true" keyProperty="${databasePrimary?uncap_first}">
		INSERT INTO ${table.mappingName?uncap_first} (<#list columnList as column><#if column.isPrimary!="YES">${column.mappingName?uncap_first}<#if column_has_next>,</#if></#if></#list>)
		VALUES (<#list columnList as column><#if column.isPrimary!="YES">${r"#{"}${column.columnName?uncap_first}${r"}"}<#if column_has_next>,</#if></#if></#list>)
	</insert>

	<update id="update" parameterType="${table.tableName?cap_first}">
		UPDATE ${table.mappingName?uncap_first}
 		SET <#list columnList as column><#if column.isPrimary!="YES"&&column.isUpdate=="YES">${column.mappingName?uncap_first}=${r"#{"}${column.columnName?uncap_first}${r"}"}<#if column_has_next>,</#if></#if></#list>
		WHERE ${databasePrimary?uncap_first}=${r"#{"}${javaPrimary?uncap_first}${r"}"}
	</update>

	<delete id="delete" parameterType="Integer">
		DELETE FROM ${table.mappingName?uncap_first} WHERE ${databasePrimary?uncap_first}=${r"#{value}"}
	</delete>
	
	<delete id="deletes" parameterType="String">
		DELETE FROM ${table.mappingName?uncap_first} WHERE ${databasePrimary?uncap_first} in ( ${r"#{value}"} )
	</delete>
	
	<delete id="deleteForMap" parameterType="Map">
		DELETE FROM ${table.mappingName?uncap_first} WHERE ${r"${columnName}=#{columnValue}"}
	</delete>

	<select id="queryObjectPaginationCount" resultType="Integer" parameterType="${table.tableName?cap_first}">
		SELECT COUNT(1) FROM ${table.mappingName?uncap_first} 
		WHERE 1=1 
		<if test="searchColumn!=null and searchColumn!='' and searchValue!=null and searchValue!=''">
			AND ${r"${searchColumn}"} like ${r"'%${searchValue}%'"}
		</if>
		<if test="(searchColumn==null || searchColumn=='') and searchValue!=null and searchValue!=''">
			<#list columnList as c><#if c.isQuery=="YES">
			AND (<#list columnList as column><#if column.isQuery=="YES">${column.mappingName?uncap_first} like ${r"'%${searchValue}%'"}<#list columnList as c><#if (c_index>column_index)><#if c.isQuery=="YES"> or <#break></#if></#if></#list></#if></#list>)
			<#break></#if></#list>
		</if>
	</select>

	<select id="queryObjectPaginationList" resultType="${table.tableName?cap_first}" parameterType="${table.tableName?cap_first}">
		<#if isRelation=="false">
		SELECT
		<include refid="columns"/>
		FROM ${table.mappingName?uncap_first} ${table.tableName}
		WHERE 1=1 
		<if test="searchColumn!=null and searchColumn!='' and searchValue!=null and searchValue!=''">
			AND ${r"${searchColumn}"} like ${r"'%${searchValue}%'"}
		</if>
		<if test="(searchColumn==null || searchColumn=='') and searchValue!=null and searchValue!=''">
			<#list columnList as c><#if c.isQuery=="YES">
			AND (<#list columnList as column><#if column.isQuery=="YES">${column.mappingName?uncap_first} like ${r"'%${searchValue}%'"}<#list columnList as c><#if (c_index>column_index)><#if c.isQuery=="YES"> or <#break></#if></#if></#list></#if></#list>)
			<#break></#if></#list>
		</if>
		<if test="sortColumn!=null and sortColumn!=''">
			ORDER BY ${r"${sortColumn}"}
		</if>
		<if test="sortColumn==null||sortColumn==''">
			ORDER BY ${databasePrimary}
		</if>
		<#else>
		SELECT
		${table.tableName?uncap_first}.*,<#list relationList as relation><#if relation.relation!='ManyToMany'&&relation.relation!='OneToMany'>${relation.relationTableName?uncap_first}.${relation.relationShowMappingName}<#if relation_has_next>,</#if></#if></#list>
		FROM ${table.mappingName?uncap_first} ${table.tableName?uncap_first},<#list relationList as relation><#if relation.relation!='ManyToMany'>${relation.relationTableMappingName} ${relation.relationTableName?uncap_first}<#if relation_has_next>,</#if></#if></#list>
		WHERE 1=1 AND <#list relationList as relation><#if relation.relation!='ManyToMany'>${relation.tableName?uncap_first}.${relation.columnMappingName}=${relation.relationTableName?uncap_first}.${relation.relationColumnMappingName}<#if relation_has_next> AND </#if></#if></#list>
		<if test="searchColumn!=null and searchColumn!='' and searchValue!=null and searchValue!=''">
			AND ${table.tableName?uncap_first}.${r"${searchColumn}"} like ${r"'%${searchValue}%'"}
		</if>
		<if test="(searchColumn==null || searchColumn=='') and searchValue!=null and searchValue!=''">
			<#list columnList as c><#if c.isQuery=="YES">
			AND (<#list columnList as column><#if column.isQuery=="YES">${table.tableName?uncap_first}.${column.mappingName?uncap_first} like ${r"'%${searchValue}%'"}<#list columnList as c><#if (c_index>column_index)><#if c.isQuery=="YES"> or <#break></#if></#if></#list></#if></#list>)
			<#break></#if></#list>
		</if>
		<if test="sortColumn!=null and sortColumn!=''">
			ORDER BY ${table.tableName?uncap_first}.${r"${sortColumn}"}
		</if>
		<if test="sortColumn==null||sortColumn==''">
			ORDER BY ${table.tableName?uncap_first}.${databasePrimary}
		</if>
		</#if>
		LIMIT ${r"${pageStart},${pageSize}"}
	</select>

	<select id="querySingleObject" resultType="${table.tableName?cap_first}" parameterType="Integer">
		SELECT <include refid="columns"/> FROM ${table.mappingName?uncap_first} WHERE ${databasePrimary?uncap_first}=${r"#{value}"} LIMIT 0,1
	</select>
	
	<select id="querySingleObjectForMap" resultType="${table.tableName?cap_first}" parameterType="Map">
		SELECT <include refid="columns"/> FROM ${table.mappingName?uncap_first} WHERE ${r"${columnName}=#{columnValue}"} LIMIT 0,1
	</select>

	<select id="queryObjectCount" resultType="Integer">
		SELECT count(1) FROM ${table.mappingName?uncap_first} 
	</select>

	<select id="queryObjectList" resultType="${table.tableName?cap_first}">
		SELECT <include refid="columns"/> FROM ${table.mappingName?uncap_first} 
	</select>
	
	<select id="queryObjectCountForMap" resultType="Integer" parameterType="Map">
		SELECT count(1) FROM ${table.mappingName?uncap_first} WHERE ${r"${columnName}=#{columnValue}"}
	</select>
	
	<select id="queryObjectListForMap" resultType="${table.tableName?cap_first}" parameterType="Map">
		SELECT <include refid="columns"/> FROM ${table.mappingName?uncap_first} WHERE ${r"${columnName}=#{columnValue}"}
	</select>
</mapper>
