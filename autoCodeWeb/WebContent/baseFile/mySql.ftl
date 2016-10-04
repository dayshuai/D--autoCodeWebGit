/*
AutoCode

Source Server         : ${project.projectName}
Source Host           : ${project.databaseIp}:${project.databasePort?c}
Source Database       : ${project.databaseName}
Target Server Type    : MYSQL

作者: Loose_Yuan
Q Q : 12566859
Date: ${date}
*/

SET FOREIGN_KEY_CHECKS=0;
<#list tableList as table>
-- ----------------------------
-- Table structure for ${table.mappingName} -- ${table.tableTitle}
-- ----------------------------
DROP TABLE IF EXISTS `${table.mappingName}`;
CREATE TABLE `${table.mappingName}` (
  <#list table.columnList as column>
  <#if column.isPrimary=="YES">
  `${column.mappingName}` ${column.mappingType} NOT NULL auto_increment COMMENT '主键',
  <#else>
  `${column.mappingName}` ${column.mappingType} default NULL COMMENT '${column.columnZhName}',
  </#if>
  </#list>
  <#list table.columnList as column><#if column.isPrimary=="YES">PRIMARY KEY  (`${column.mappingName}`)<#break></#if></#list>
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='${table.tableTitle}';
</#list>