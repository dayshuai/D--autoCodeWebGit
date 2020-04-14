/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : autocode

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-08-17 12:41:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ac_column`
-- ----------------------------
DROP TABLE IF EXISTS `ac_column`;
CREATE TABLE `ac_column` (
  `columnId` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) DEFAULT NULL,
  `tableId` int(11) DEFAULT NULL,
  `mappingName` varchar(50) DEFAULT NULL,
  `columnName` varchar(50) DEFAULT NULL,
  `columnZhName` varchar(1000) DEFAULT NULL,
  `mappingType` varchar(50) DEFAULT NULL,
  `columnType` varchar(50) DEFAULT NULL,
  `showType` varchar(50) DEFAULT NULL,
  `isPrimary` varchar(10) DEFAULT NULL,
  `isUpdate` varchar(10) DEFAULT NULL,
  `isDefault` varchar(10) DEFAULT NULL,
  `isRepeat` varchar(10) DEFAULT NULL,
  `isShow` varchar(10) DEFAULT NULL,
  `isQuery` varchar(10) DEFAULT NULL,
  `isImportPackage` varchar(10) DEFAULT NULL,
  `isCheck` varchar(10) DEFAULT NULL,
  `showOrder` int(10) DEFAULT NULL,
  PRIMARY KEY (`columnId`),
  KEY `waijian` (`projectId`),
  CONSTRAINT `waijian` FOREIGN KEY (`projectId`) REFERENCES `ac_project` (`projectId`)
) ENGINE=InnoDB AUTO_INCREMENT=3328 DEFAULT CHARSET=utf8 COMMENT='字段信息表';

-- ----------------------------
-- Records of ac_column
-- ----------------------------
INSERT INTO `ac_column` VALUES ('300', '16', '48', 'collectingId', 'collectingId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('301', '16', '48', 'musicUserId', 'musicUserId', '用户id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('302', '16', '48', 'musicId', 'musicId', '歌曲id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('303', '16', '49', 'deleteLogId', 'deleteLogId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('304', '16', '49', 'fileType', 'fileType', '文件类型', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('305', '16', '49', 'fileUrl', 'fileUrl', '文件Url', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('306', '16', '49', 'newUrl', 'newUrl', '新文件URL', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('307', '16', '49', 'action', 'action', '动作', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('308', '16', '49', 'memo', 'memo', '备注', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('309', '16', '50', 'musicId', 'musicId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('310', '16', '50', 'musicName', 'musicName', '歌曲名字', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('311', '16', '50', 'starId', 'starId', '演唱者id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('312', '16', '50', 'musicClassId', 'musicClassId', '歌曲分类', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('313', '16', '50', 'musicUrl', 'musicUrl', '歌曲Url', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('314', '16', '50', 'hits', 'hits', '歌曲点击次数', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('315', '16', '50', 'uploadDate', 'uploadDate', '上传时间', 'timestamp', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '7');
INSERT INTO `ac_column` VALUES ('316', '16', '51', 'musicClassId', 'musicClassId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('317', '16', '51', 'musicClassName', 'musicClassName', '类别名称', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('318', '16', '51', 'memo', 'memo', '备注', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('319', '16', '52', 'musicUserId', 'musicUserId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('320', '16', '52', 'userName', 'userName', '姓名', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('321', '16', '52', 'loginName', 'loginName', '登陆名', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('322', '16', '52', 'loginPwd', 'loginPwd', '登陆密码', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('323', '16', '52', 'sex', 'sex', '性别', 'varchar(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('324', '16', '52', 'imageUrl', 'imageUrl', '图片路径', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('325', '16', '52', 'tencentQq', 'tencentQq', 'QQ号码', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('326', '16', '52', 'integral', 'integral', '积分', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('327', '16', '52', 'role', 'role', '角色', 'varchar(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('328', '16', '52', 'loginDate', 'loginDate', '最近登录', 'timestamp', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '10');
INSERT INTO `ac_column` VALUES ('329', '16', '52', 'state', 'state', '账号状态', 'varchar(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '11');
INSERT INTO `ac_column` VALUES ('330', '16', '53', 'playId', 'playId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('331', '16', '53', 'songId', 'songId', '歌单列表id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('332', '16', '53', 'musicId', 'musicId', '歌曲id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('333', '16', '54', 'errorId', 'errorId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('334', '16', '54', 'errorContent', 'errorContent', '来至某表', 'text', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('335', '16', '54', 'errordate', 'errorDate', '文件类型', 'timestamp', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '3');
INSERT INTO `ac_column` VALUES ('336', '16', '55', 'protecteId', 'protecteId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('337', '16', '55', 'musicUserId', 'musicUserId', '用户id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('338', '16', '55', 'question', 'question', '问题', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('339', '16', '55', 'answer', 'answer', '答案', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('340', '16', '56', 'songId', 'songId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('341', '16', '56', 'songName', 'songName', '歌单名称', 'varchar(30)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('342', '16', '56', 'musicUserId', 'musicUserId', '用户id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('343', '16', '56', 'imageUrl', 'imageUrl', '图片路径', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('344', '16', '56', 'createDate', 'createDate', '创建时间', 'timestamp', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '5');
INSERT INTO `ac_column` VALUES ('345', '16', '56', 'hits', 'hits', '歌曲点击次数', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('346', '16', '57', 'starId', 'starId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('347', '16', '57', 'starName', 'starName', '姓名', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('348', '16', '57', 'sex', 'sex', '性别', 'varchar(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('349', '16', '57', 'birthday', 'birthday', '出生日期', 'date', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '4');
INSERT INTO `ac_column` VALUES ('350', '16', '57', 'birthplace', 'birthplace', '出生地', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('351', '16', '57', 'musicStyle', 'musicStyle', '歌曲风格', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('352', '16', '57', 'imageUrl', 'imageUrl', '图片路径', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('353', '16', '57', 'initial', 'initial', '名字开头', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('354', '16', '57', 'memo', 'memo', '备注', 'text', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('355', '16', '58', 'uploadId', 'uploadId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('356', '16', '58', 'fileName', 'fileName', '上传文件名', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('357', '16', '58', 'fileUrl', 'fileUrl', '文件Url', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('358', '16', '58', 'musicUserId', 'musicUserId', '用户id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('359', '16', '58', 'fileType', 'fileType', '文件类型', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('360', '16', '58', 'uploadDate', 'uploadDate', '上传时间', 'timestamp', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '6');
INSERT INTO `ac_column` VALUES ('361', '16', '58', 'isUpload', 'isUpload', '是否上传至七牛', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('362', '16', '58', 'uploadMemo', 'uploadMemo', '上传备注', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('363', '16', '59', 'videoId', 'videoId', '序号', 'int(11)', 'Integer', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('364', '16', '59', 'videoName', 'videoName', '视屏名字', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('365', '16', '59', 'starId', 'starId', '演唱者id', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('366', '16', '59', 'videoUrl', 'videoUrl', '视屏Url', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('367', '16', '59', 'imageUrl', 'imageUrl', '图片路径', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('368', '16', '59', 'hits', 'hits', '歌曲点击次数', 'int(11)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('369', '16', '59', 'uploadDate', 'uploadDate', '上传时间', 'timestamp', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '7');
INSERT INTO `ac_column` VALUES ('2971', '20', '428', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('2972', '20', '428', 'project_id', 'projectId', '项目表ID', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('2973', '20', '428', 'issuser_id', 'issuserId', '发行人流水编号', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('2974', '20', '428', 'internal_encoding', 'internalEncoding', '机构内部编码', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('2975', '20', '428', 'certification_name', 'certificationName', '业务资格名称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('2976', '20', '428', 'approval_number', 'approvalNumber', '批准文号/资格证书号', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('2977', '20', '428', 'approval_unit', 'approvalUnit', '批准单位', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('2978', '20', '428', 'approval_date', 'approvalDate', '批准日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '8');
INSERT INTO `ac_column` VALUES ('2981', '20', '429', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('2982', '20', '429', 'project_id', 'projectId', '项目表ID', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('2983', '20', '429', 'issuser_id', 'issuserId', '发行人流水编号', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('2984', '20', '429', 'internal_encoding', 'internalEncoding', '机构内部编码', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('2985', '20', '429', 'attache_name', 'attacheName', '专员姓名', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('2986', '20', '429', 'attache_phone1', 'attachePhone1', '电话1', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('2987', '20', '429', 'attache_phone2', 'attachePhone2', '电话2', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('2988', '20', '429', 'attache_email', 'attacheEmail', '电子邮箱', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('2989', '20', '429', 'remark', 'remark', '备注', 'varchar(255)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('2992', '20', '430', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('2993', '20', '430', 'internal_encoding', 'internalEncoding', '内部编码(用于关联主表和子表，报送单位自定义)', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('2994', '20', '430', 'identification_code_type', 'identificationCodeType', '人员主要身份识别代码类型(0:身份证，1：护照，2：军官证，3：士兵证，4：回乡证，5：户口，6：其他，7：未知)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('2995', '20', '430', 'identification_code', 'identificationCode', '人员主要身份识别代码', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('2996', '20', '430', 'personal_name', 'personalName', '姓名', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('2997', '20', '430', 'used_name', 'usedName', '曾用名', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('2998', '20', '430', 'gender', 'gender', '性别(1:男，2：女，3：未知)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('2999', '20', '430', 'photo_file_name', 'photoFileName', '照片文件名', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3000', '20', '430', 'now_institutions_code', 'nowInstitutionsCode', '现任职机构的组织机构代码', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3001', '20', '430', 'now_institutions_name', 'nowInstitutionsName', '现任职机构名称全称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3002', '20', '430', 'served_now_type', 'servedNowType', '现担任职务类别（1：董事长，2：副董事长，3:董事，4：监视长，5：副监事长，6：监事，7：高级管理人员，8：其他负责人，9：保荐代表人，10：基金经理，11：会计师，12：律师，13：资产评估师，14：一般证券期货从业人员，99：其他）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '11');
INSERT INTO `ac_column` VALUES ('3003', '20', '430', 'served_now_name', 'servedNowName', '现担任职务名称', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '12');
INSERT INTO `ac_column` VALUES ('3004', '20', '430', 'state', 'state', '账号状态', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '13');
INSERT INTO `ac_column` VALUES ('3005', '20', '430', 'remarks', 'remarks', '备注', 'varchar(1000)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '14');
INSERT INTO `ac_column` VALUES ('3006', '20', '430', 'project_id', 'projectId', '对应的项目编号', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '15');
INSERT INTO `ac_column` VALUES ('3007', '20', '430', 'issuser_id', 'issuserId', '发行人流水编号', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '16');
INSERT INTO `ac_column` VALUES ('3010', '20', '431', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3011', '20', '431', 'project_id', 'projectId', '项目表ID', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3012', '20', '431', 'issuser_id', 'issuserId', '发行人流水编号', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3013', '20', '431', 'internal_encoding', 'internalEncoding', '机构内部编码', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3014', '20', '431', 'principal_name', 'principalName', '主要负责人名称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3015', '20', '431', 'principal_gender', 'principalGender', '主要负责人性别（1：男，2：女，3：未知）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3016', '20', '431', 'main_identification_type', 'mainIdentificationType', '人员主要身份识别代码类型（1：组织机构代码（机构），2：工商注册号码（机构），3：身份证（人员），4：护照（人员），5：军官证（人员），6：士兵证（人员），7：回乡证（人员），8：户口（人员），9：其他，10：未知）', 'varchar(2)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3017', '20', '431', 'main_identification_code', 'mainIdentificationCode', '人员主要身份识别代码', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3018', '20', '431', 'position', 'position', '现担任职务（1：董事长，2：副董事长，3:董事，4：监视长，5：副监事长，6：监事，7：高级管理人员，8：其他负责人）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3019', '20', '431', 'describe_of_position', 'describeOfPosition', '现担任职务具体描述', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3096', '20', '438', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3097', '20', '438', 'b_issuser_personal_info_id', 'bIssuserPersonalInfoId', '人员基本信息id', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3098', '20', '438', 'internal_encoding', 'internalEncoding', '内部编码(用于关联主表和子表)', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3099', '20', '438', 'identification_code_type', 'identificationCodeType', '人员身份识别代码类型(0:身份证，1：护照，2：军官证，3：士兵证，4：回乡证，5：户口，6：其他，7：未知)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3100', '20', '438', 'identification_code', 'identificationCode', '人员身份识别代码', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3103', '20', '439', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3104', '20', '439', 'internal_encoding', 'internalEncoding', '内部编码(用于关联主表和子表)', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3105', '20', '439', 'begin_and_end_dates', 'beginAndEndDates', '起止日期学习开始与截止的年、月、日（从大学起，按时间先后顺序排列）输入格式为：“1998-12-01——2001-12-01”，或“1998-12-01——”', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3106', '20', '439', 'academy', 'academy', '院校', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3107', '20', '439', 'professional', 'professional', '专业', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3108', '20', '439', 'education_background', 'educationBackground', '学历（1：其他，2：无，3：小学，4：初中，5：高中，6：大专，7：本科，8：硕士研究生，9:博士研究生）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3109', '20', '439', 'education_background_other', 'educationBackgroundOther', '其它学历', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3110', '20', '439', 'degree', 'degree', '学位（1：其他，2：学士，3：硕士，4；博士）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3111', '20', '439', 'degree_other', 'degreeOther', '其他学位', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3114', '20', '439', 'b_issuser_personal_info_id', 'bIssuserPersonalInfoId', '人员基本信息id', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '12');
INSERT INTO `ac_column` VALUES ('3115', '20', '440', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3116', '20', '440', 'internal_encoding', 'internalEncoding', '内部编码(用于关联主表和子表)', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3117', '20', '440', 'qualified_name', 'qualifiedName', '资格名称(证券执业资格、期货从业资格、证监会及派出机构批准的任职资格或业务资格、注册会计师证书、律师执业证书等)', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3118', '20', '440', 'approver_code', 'approverCode', '批准文号/资格证书号', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3119', '20', '440', 'approvers', 'approvers', '批准单位', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3120', '20', '440', 'approval_date', 'approvalDate', '批准日期(输入格式为(YYYY-MM-DD)：2012-12-02)', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3123', '20', '440', 'b_issuser_personal_info_id', 'bIssuserPersonalInfoId', '人员基本信息id', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3124', '20', '441', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3125', '20', '441', 'internal_encoding', 'internalEncoding', '内部编码(用于关联主表和子表)', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3126', '20', '441', 'begin_and_end_dates', 'beginAndEndDates', '起止日期(工作开始与截止的年、月、日（按时间先后顺序排列）输入格式为：“1998-12-01——2001-12-01”，或“1998-12-01——”', 'varchar(100)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3127', '20', '441', 'institutions_code', 'institutionsCode', '任职机构的组织机构代码', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3128', '20', '441', 'institutions_name', 'institutionsName', '任职机构名称全称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3129', '20', '441', 'served_type', 'servedType', '担任职务类别（1：董事长，2：副董事长，3:董事，4：监视长，5：副监事长，6：监事，7：高级管理人员，8：其他负责人，9：保荐代表人，10：基金经理，11：会计师，12：律师，13：资产评估师，14：一般证券期货从业人员，99：其他）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3130', '20', '441', 'served_name', 'servedName', '担任职务名称', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3133', '20', '441', 'b_issuser_personal_info_id', 'bIssuserPersonalInfoId', '人员基本信息id', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3152', '21', '444', 'bond_info_id', 'bondInfoId', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3153', '21', '444', 'bond_code', 'bondCode', '债券代码', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3154', '21', '444', 'short_name', 'shortName', '债券简称', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3155', '21', '444', 'bond_name', 'bondName', '债券名称', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3156', '21', '444', 'special_bond_type', 'specialBondType', '特殊债券类型（0:熊猫债券,1:绿色债券,2:可续期债券,3:证券公司短期债券,7:双创债券,9:可交换公司债券,c:中小企业私募债券,d:证券公司次级债券,e:全民所有制企业）', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3157', '21', '444', 'trading_floor', 'tradingFloor', '交易场所（统一显示“上海证券交易所”）', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3158', '21', '444', 'issuing_way', 'issuingWay', '发行方式（0:大公募、1:小公募、2:私募）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3159', '21', '444', 'main_rating', 'mainRating', '主体评级', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3160', '21', '444', 'bond_rating', 'bondRating', '债券评级', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3161', '21', '444', 'measurestrust_type', 'measurestrustType', '增信措施(0:抵质押,1:信用担保,2:其他,3:创新方式,4:混合增信,5:无)', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3162', '21', '444', 'apply_issuing_scale', 'applyIssuingScale', '申请发行规模（亿）', 'decimal(16,4)', 'BigDecimal', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '11');
INSERT INTO `ac_column` VALUES ('3163', '21', '444', 'approve_issuing_scale', 'approveIssuingScale', '核准发行规模（亿）', 'decimal(16,4)', 'BigDecimal', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '12');
INSERT INTO `ac_column` VALUES ('3164', '21', '444', 'reality_issuing_scale', 'realityIssuingScale', '实际发行规模（亿）', 'decimal(16,4)', 'BigDecimal', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '13');
INSERT INTO `ac_column` VALUES ('3165', '21', '444', 'collocation_scale', 'collocationScale', '托管规模（亿）', 'decimal(16,4)', 'BigDecimal', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '14');
INSERT INTO `ac_column` VALUES ('3166', '21', '444', 'deadline', 'deadline', '期限（年）', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '15');
INSERT INTO `ac_column` VALUES ('3167', '21', '444', 'deadline_info', 'deadlineInfo', '期限备注', 'varchar(128)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '16');
INSERT INTO `ac_column` VALUES ('3168', '21', '444', 'interest_rate', 'interestRate', '发行利率', 'decimal(10,2)', 'BigDecimal', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '17');
INSERT INTO `ac_column` VALUES ('3169', '21', '444', 'issuing_date', 'issuingDate', '发行日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '18');
INSERT INTO `ac_column` VALUES ('3170', '21', '444', 'offering_date', 'offeringDate', '上市日', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '19');
INSERT INTO `ac_column` VALUES ('3171', '21', '444', 'value_date', 'valueDate', '起息日', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '20');
INSERT INTO `ac_column` VALUES ('3172', '21', '444', 'due_date', 'dueDate', '到期日', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '21');
INSERT INTO `ac_column` VALUES ('3173', '21', '444', 'sell_date', 'sellDate', '回售日', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '22');
INSERT INTO `ac_column` VALUES ('3174', '21', '444', 'approve_date', 'approveDate', '核准日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '23');
INSERT INTO `ac_column` VALUES ('3175', '21', '444', 'remark', 'remark', '备注', 'text', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '24');
INSERT INTO `ac_column` VALUES ('3176', '21', '444', 'csrc_reference_number', 'csrcReferenceNumber', '证监会核准文号', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '25');
INSERT INTO `ac_column` VALUES ('3177', '21', '444', 'csrc_reference_date', 'csrcReferenceDate', '证监会核准时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '26');
INSERT INTO `ac_column` VALUES ('3178', '21', '444', 'csrc_reference_scale', 'csrcReferenceScale', '证监会核准规模（亿元）', 'decimal(16,4)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '27');
INSERT INTO `ac_column` VALUES ('3179', '21', '444', 'sse_state', 'sseState', '交易所状态(不通过、已受理、已反馈、已接受反馈意见回复、已通过专家会、已出具无异议函、中止审核、终止审核)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '28');
INSERT INTO `ac_column` VALUES ('3180', '21', '444', 'receipt_date', 'receiptDate', '申请材料接收时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '29');
INSERT INTO `ac_column` VALUES ('3181', '21', '444', 'accept_date', 'acceptDate', '受理决定或者不予受理决定时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '30');
INSERT INTO `ac_column` VALUES ('3182', '21', '444', 'first_feedback_date', 'firstFeedbackDate', '第一次反馈意见出具时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '31');
INSERT INTO `ac_column` VALUES ('3183', '21', '444', 'receive_first_feedback_date', 'receiveFirstFeedbackDate', '接收第一次反馈意见回复材料时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '32');
INSERT INTO `ac_column` VALUES ('3184', '21', '444', 'second_feedback_date', 'secondFeedbackDate', '第二次反馈意见出具时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '33');
INSERT INTO `ac_column` VALUES ('3185', '21', '444', 'receive_second_feedback_date', 'receiveSecondFeedbackDate', '接收第二次反馈意见回复材料时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '34');
INSERT INTO `ac_column` VALUES ('3186', '21', '444', 'pass_specialist_meet_date', 'passSpecialistMeetDate', '通过专家会审核日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '35');
INSERT INTO `ac_column` VALUES ('3187', '21', '444', 'suspend_investigate_date', 'suspendInvestigateDate', '中止审查时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '36');
INSERT INTO `ac_column` VALUES ('3188', '21', '444', 'recover_investigate_date', 'recoverInvestigateDate', '恢复审查时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '37');
INSERT INTO `ac_column` VALUES ('3189', '21', '444', 'provide_audit_opinion_date', 'provideAuditOpinionDate', '出具预审核意见/出具无异议函时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '38');
INSERT INTO `ac_column` VALUES ('3190', '21', '444', 'project_no', 'projectNo', '审核项目编号（仅上交所用户可见，该债券若是在上交所审核的，显示审核系统中的项目编号）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '39');
INSERT INTO `ac_column` VALUES ('3191', '21', '444', 'industry_first', 'industryFirst', '申万行业一级分类', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '40');
INSERT INTO `ac_column` VALUES ('3192', '21', '444', 'industry_second', 'industrySecond', '申万行业二级分类', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '41');
INSERT INTO `ac_column` VALUES ('3193', '21', '444', 'industry_three', 'industryThree', '申万行业三级分类', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '42');
INSERT INTO `ac_column` VALUES ('3194', '21', '444', 'industry_four', 'industryFour', '申万行业四级分类', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '43');
INSERT INTO `ac_column` VALUES ('3195', '21', '444', 'bond_type', 'bondType', '债券类型', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '44');
INSERT INTO `ac_column` VALUES ('3196', '21', '444', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '45');
INSERT INTO `ac_column` VALUES ('3197', '21', '444', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '46');
INSERT INTO `ac_column` VALUES ('3198', '21', '444', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '47');
INSERT INTO `ac_column` VALUES ('3199', '21', '444', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '48');
INSERT INTO `ac_column` VALUES ('3200', '21', '445', 'creator_id', 'creatorId', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3201', '21', '445', 'foreign_id', 'foreignId', '外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3202', '21', '445', 'operation_type', 'operationType', '操作类型（0：债券基本信息，1：在审，2：风险及违约，3：债券监管）', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3203', '21', '445', 'operator', 'operator', '操作人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3204', '21', '445', 'operation_time', 'operationTime', '操作时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3205', '21', '445', 'operation_status', 'operationStatus', '操作状态（0:新增、1:修改、2:删除、3:导入、4:导出）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3206', '21', '445', 'operation_ip', 'operationIp', '操作人IP', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3207', '21', '445', 'instructions', 'instructions', '说明（系统写死“已同意保密承诺”）', 'varchar(128)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3208', '21', '446', 'csrc_id', 'csrcId', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3209', '21', '446', 'bond_info_id', 'bondInfoId', '债券基本信息外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3210', '21', '446', 'state', 'state', '证监会审核状态（显示：已受理、已反馈、已接收反馈意见回复、已通过审核专题会、已核准、不予核准、中止审查、终止审查）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3211', '21', '446', 'accept_date', 'acceptDate', '证监会受理时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3212', '21', '446', 'first_feedbank_date', 'firstFeedbankDate', '证监会第一次反馈意见时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3213', '21', '446', 'accept_first_feedbank_date', 'acceptFirstFeedbankDate', '证监会接受第一次反馈意见时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3214', '21', '446', 'second_feedbank_date', 'secondFeedbankDate', '证监会第二次反馈意见时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3215', '21', '446', 'accept_second_feedbank_date', 'acceptSecondFeedbankDate', '证监会接受第二次反馈意见时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3216', '21', '446', 'pass_audit_date', 'passAuditDate', '证监会通过审核专题会时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3217', '21', '446', 'suspend_review_date', 'suspendReviewDate', '证监会中止审查时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3218', '21', '446', 'regain_review_date', 'regainReviewDate', '证监会恢复审查时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '11');
INSERT INTO `ac_column` VALUES ('3219', '21', '446', 'approve_date', 'approveDate', '证监会核准/不予核准/终止审查时间', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '12');
INSERT INTO `ac_column` VALUES ('3220', '21', '446', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '13');
INSERT INTO `ac_column` VALUES ('3221', '21', '446', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '14');
INSERT INTO `ac_column` VALUES ('3222', '21', '446', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '15');
INSERT INTO `ac_column` VALUES ('3223', '21', '446', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '16');
INSERT INTO `ac_column` VALUES ('3224', '21', '447', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3225', '21', '447', 'bond_info_id', 'bondInfoId', '债券基本信息表外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3226', '21', '447', 'person_name', 'personName', '发行人信息披露专员', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3227', '21', '447', 'person_contact_way', 'personContactWay', '信息披露专员联系方式', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3228', '21', '447', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3229', '21', '447', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3230', '21', '447', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3231', '21', '447', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3232', '21', '448', 'issuer_id', 'issuerId', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3233', '21', '448', 'bond_info_id', 'bondInfoId', '债券基本信息外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3234', '21', '448', 'issuer_name', 'issuerName', '发行人名称', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3235', '21', '448', 'issuer_industry', 'issuerIndustry', '发行人行业', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3236', '21', '448', 'issuer_org_code', 'issuerOrgCode', '组织机构代码（统一社会信用代码）', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3237', '21', '448', 'issuer_scope_business', 'issuerScopeBusiness', '主营业务', 'varchar(600)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3238', '21', '448', 'issuer_register_country', 'issuerRegisterCountry', '注册地（国家）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3239', '21', '448', 'issuer_register_province', 'issuerRegisterProvince', '注册地（省份）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3240', '21', '448', 'issuer_register_city', 'issuerRegisterCity', '注册地（市）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3241', '21', '448', 'issuser_bureau_area', 'issuserBureauArea', '发行人所属证监局(字典维护，取申报系统对应字典)', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3242', '21', '448', 'stock_code', 'stockCode', '股票代码（如有）', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '11');
INSERT INTO `ac_column` VALUES ('3243', '21', '448', 'business_propertise', 'businessPropertise', '企业性质（“地方国有企业”，“中央国有企业”，“民营”，“外商独资”，“中外合资”，“其他”，“中外合作、境外企业”）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '12');
INSERT INTO `ac_column` VALUES ('3244', '21', '448', 'is_financial_industry', 'isFinancialIndustry', '是否属于金融行业(“是”，“否”)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '13');
INSERT INTO `ac_column` VALUES ('3245', '21', '448', 'is_listed_company', 'isListedCompany', '是否上市公司(“是”，“否”)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '14');
INSERT INTO `ac_column` VALUES ('3246', '21', '448', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '15');
INSERT INTO `ac_column` VALUES ('3247', '21', '448', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '16');
INSERT INTO `ac_column` VALUES ('3248', '21', '448', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '17');
INSERT INTO `ac_column` VALUES ('3249', '21', '448', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '18');
INSERT INTO `ac_column` VALUES ('3250', '21', '449', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3251', '21', '449', 'bond_info_id', 'bondInfoId', '债券基本信息表外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3252', '21', '449', 'office_type', 'officeType', '事务所类型(0:会计事务所，1:律师事务所)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3253', '21', '449', 'office_name', 'officeName', '事务所名称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3254', '21', '449', 'sign_person', 'signPerson', '签字人（签字律师或者签字会计师）', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3255', '21', '449', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3256', '21', '449', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3257', '21', '449', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3258', '21', '449', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3259', '21', '450', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3260', '21', '450', 'bond_info_id', 'bondInfoId', '债券基本信息表外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3261', '21', '450', 'org_kind', 'orgKind', '机构种类（0:资信评级机构:1：受托管理人:2：中介机构）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3262', '21', '450', 'org_name', 'orgName', '机构名称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3263', '21', '450', 'leaders_name', 'leadersName', '负责人(负责人A、负责人B/负责人C、负责人D)', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3264', '21', '450', 'leaders_contact_way', 'leadersContactWay', '负责人联系方式（电话A、电话B/电话C、电话D）', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3265', '21', '450', 'bureau_area', 'bureauArea', '所属证监局', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3266', '21', '450', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3267', '21', '450', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3268', '21', '450', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3269', '21', '450', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '11');
INSERT INTO `ac_column` VALUES ('3270', '21', '451', 'risk_default_id', 'riskDefaultId', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3271', '21', '451', 'bond_code', 'bondCode', '债券代码', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3272', '21', '451', 'risk_state', 'riskState', '风险状态(一般、中、高、违约、违约已化解、风险已化解)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3273', '21', '451', 'current_interest_rate', 'currentInterestRate', '当前利率', 'decimal(7,0)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3274', '21', '451', 'sell_date', 'sellDate', '回售日', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3275', '21', '451', 'bondholders_accounts', 'bondholdersAccounts', '持债账户总数(显示格式每3位以英文逗号分节 手填 )', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3276', '21', '451', 'investors_accounts', 'investorsAccounts', '个人投资者账户数', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3277', '21', '451', 'personal_bondhold_value', 'personalBondholdValue', '个人持债面值（亿元）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3278', '21', '451', 'personal_bondhold_ratio', 'personalBondholdRatio', '个人持债面值占比', 'decimal(7,0)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3279', '21', '451', 'deal_state', 'dealState', '交易状态（显示“未上市”“正常交易”“暂停上市”“终止上市”）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3280', '21', '451', 'is_appropriate_management', 'isAppropriateManagement', '是否实行投资者适当性管理', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '11');
INSERT INTO `ac_column` VALUES ('3281', '21', '451', 'appropriate_management_date', 'appropriateManagementDate', '实行投资者适当性管理日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '12');
INSERT INTO `ac_column` VALUES ('3282', '21', '451', 'is_collateralised_repo', 'isCollateralisedRepo', '是否属于质押式回购可质押债券', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '13');
INSERT INTO `ac_column` VALUES ('3283', '21', '451', 'initial_main_rating', 'initialMainRating', '初始主体评级', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '14');
INSERT INTO `ac_column` VALUES ('3284', '21', '451', 'initial_bond_rating', 'initialBondRating', '初始债项评级', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '15');
INSERT INTO `ac_column` VALUES ('3285', '21', '451', 'current_main_rating', 'currentMainRating', '当前主体评级', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '16');
INSERT INTO `ac_column` VALUES ('3286', '21', '451', 'current_bond_rating', 'currentBondRating', '当前债项评级', 'varchar(10)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '17');
INSERT INTO `ac_column` VALUES ('3287', '21', '451', 'newest_measurestrust_way', 'newestMeasurestrustWay', '最新增信方式', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '18');
INSERT INTO `ac_column` VALUES ('3288', '21', '451', 'Mutual_compensatory_situation', 'mutualCompensatorySituation', '增信代偿情况', 'text', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '19');
INSERT INTO `ac_column` VALUES ('3289', '21', '451', 'default_date', 'defaultDate', '违约日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '20');
INSERT INTO `ac_column` VALUES ('3290', '21', '451', 'default_nature', 'defaultNature', '违约性质(利息违约、本金违约、利息和本金双违约、回信款建约、其他)', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '21');
INSERT INTO `ac_column` VALUES ('3291', '21', '451', 'risk_default_cause', 'riskDefaultCause', '风险或违约原因', 'varchar(1000)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '22');
INSERT INTO `ac_column` VALUES ('3292', '21', '451', 'risk_happen_condition', 'riskHappenCondition', '风险发生及处置进展情况', 'text', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '23');
INSERT INTO `ac_column` VALUES ('3293', '21', '451', 'compensation_amount', 'compensationAmount', '已偿金额（亿元）', 'decimal(16,0)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '24');
INSERT INTO `ac_column` VALUES ('3294', '21', '451', 'outstanding_amount', 'outstandingAmount', '未偿金额（亿元）', 'decimal(16,0)', 'Integer', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '25');
INSERT INTO `ac_column` VALUES ('3295', '21', '451', 'pay_off_date', 'payOffDate', '全部清偿日期或风险化解日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '26');
INSERT INTO `ac_column` VALUES ('3296', '21', '451', 'supervise_condition', 'superviseCondition', '监管情况（主要针对违法违规）', 'text', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '27');
INSERT INTO `ac_column` VALUES ('3297', '21', '451', 'supervise_linkman_sse', 'superviseLinkmanSse', '监管联系人（交易所）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '28');
INSERT INTO `ac_column` VALUES ('3298', '21', '451', 'supervise_linkman_srb', 'superviseLinkmanSrb', '监管联系人（证监局）', 'varchar(20)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '29');
INSERT INTO `ac_column` VALUES ('3299', '21', '451', 'bond_type', 'bondType', '债券类型', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '30');
INSERT INTO `ac_column` VALUES ('3300', '21', '451', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '31');
INSERT INTO `ac_column` VALUES ('3301', '21', '451', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '32');
INSERT INTO `ac_column` VALUES ('3302', '21', '451', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '33');
INSERT INTO `ac_column` VALUES ('3303', '21', '451', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '34');
INSERT INTO `ac_column` VALUES ('3304', '21', '452', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3305', '21', '452', 'supervise_id', 'superviseId', '监管信息表外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3306', '21', '452', 'file_name', 'fileName', '监管文件名称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3307', '21', '452', 'file_id', 'fileId', '监管文件对应附件表id', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3308', '21', '453', 'supervise_info_id', 'superviseInfoId', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3309', '21', '453', 'bond_code', 'bondCode', '债券代码', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3310', '21', '453', 'supervise_object_type', 'superviseObjectType', '监管对象类型（下拉框：“发行人”“中介机构”）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3311', '21', '453', 'letters_type', 'lettersType', '函件类型（证监会函、证监局函、交易所函、回函、其他）', 'char(1)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3312', '21', '453', 'issued_date', 'issuedDate', '发布日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3313', '21', '453', 'publisher', 'publisher', '发布方', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3314', '21', '453', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3315', '21', '453', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3316', '21', '453', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3317', '21', '453', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '10');
INSERT INTO `ac_column` VALUES ('3318', '21', '454', 'id', 'id', '序号', 'bigint(20)', 'Long', 'TEXT', 'YES', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO', 'NO', '1');
INSERT INTO `ac_column` VALUES ('3319', '21', '454', 'bond_info_id', 'bondInfoId', '债券基本信息外键', 'bigint(20)', 'Long', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '2');
INSERT INTO `ac_column` VALUES ('3320', '21', '454', 'name', 'name', '主承销商名称', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', '3');
INSERT INTO `ac_column` VALUES ('3321', '21', '454', 'org_code', 'orgCode', '组织机构代码（统一社会信用代码）', 'varchar(64)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '4');
INSERT INTO `ac_column` VALUES ('3322', '21', '454', 'project_leader', 'projectLeader', '主承销商项目负责人', 'varchar(200)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '5');
INSERT INTO `ac_column` VALUES ('3323', '21', '454', 'belongs_bureau', 'belongsBureau', '主承销商所属证监局', 'varchar(50)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '6');
INSERT INTO `ac_column` VALUES ('3324', '21', '454', 'creater', 'creater', '创建人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '7');
INSERT INTO `ac_column` VALUES ('3325', '21', '454', 'created_date', 'createdDate', '创建日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '8');
INSERT INTO `ac_column` VALUES ('3326', '21', '454', 'modification', 'modification', '修改人', 'varchar(32)', 'String', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'NO', 'YES', '9');
INSERT INTO `ac_column` VALUES ('3327', '21', '454', 'changed_date', 'changedDate', '修改日期', 'datetime', 'Date', 'TEXT', 'NO', 'YES', 'NO', 'YES', 'YES', 'NO', 'YES', 'YES', '10');

-- ----------------------------
-- Table structure for `ac_columnconvert`
-- ----------------------------
DROP TABLE IF EXISTS `ac_columnconvert`;
CREATE TABLE `ac_columnconvert` (
  `columnConvertId` int(11) NOT NULL AUTO_INCREMENT,
  `mappingName` varchar(50) DEFAULT NULL,
  `columnName` varchar(50) DEFAULT NULL,
  `columnZhName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`columnConvertId`)
) ENGINE=InnoDB AUTO_INCREMENT=1205 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_columnconvert
-- ----------------------------

-- ----------------------------
-- Table structure for `ac_config`
-- ----------------------------
DROP TABLE IF EXISTS `ac_config`;
CREATE TABLE `ac_config` (
  `configId` int(11) NOT NULL AUTO_INCREMENT,
  `configName` varchar(50) DEFAULT NULL,
  `configValue` varchar(500) DEFAULT NULL,
  `memo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`configId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_config
-- ----------------------------
INSERT INTO `ac_config` VALUES ('1', 'DefaultQuery', 'name', '匹配默认查询,逗号隔开');
INSERT INTO `ac_config` VALUES ('2', 'RelationShowColumn', 'name', '关系显示字段,逗号隔开');
INSERT INTO `ac_config` VALUES ('3', 'LocalhostRun', 'NO', 'YES表示本地,NO表示服务器,用于生成后打开文件夹');
INSERT INTO `ac_config` VALUES ('4', 'SSHTemplateMap', 'Hibernate:xml,Struts:xml,Spring:xml,Page:jsp,Web:xml', '用于SSH配置附加模板配置名称,以逗号隔开 :后面跟生成文件名');
INSERT INTO `ac_config` VALUES ('5', 'SMTemplateMap', 'MapperImpl:xml,Spring:xml,Page:jsp,Web:xml,Properties:properties', '用于SM配置附加模板配置名称,以逗号隔开 :后面跟生成文件名');
INSERT INTO `ac_config` VALUES ('6', 'ConfigTypeMap', 'Base,Util,Spring,Web,Properties', '用于匹配添加模板时静态拷贝');

-- ----------------------------
-- Table structure for `ac_control`
-- ----------------------------
DROP TABLE IF EXISTS `ac_control`;
CREATE TABLE `ac_control` (
  `controlId` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) DEFAULT NULL,
  `tableId` int(11) DEFAULT NULL,
  `isInsertMethod` varchar(10) DEFAULT NULL,
  `isUpdateMethod` varchar(10) DEFAULT NULL,
  `isDeleteMethod` varchar(10) DEFAULT NULL,
  `isQueryMethod` varchar(10) DEFAULT NULL,
  `isSelectMethod` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`controlId`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_control
-- ----------------------------
INSERT INTO `ac_control` VALUES ('48', '16', '48', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('49', '16', '49', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('50', '16', '50', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('51', '16', '51', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('52', '16', '52', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('53', '16', '53', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('54', '16', '54', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('55', '16', '55', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('56', '16', '56', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('57', '16', '57', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('58', '16', '58', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('59', '16', '59', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('428', '20', '428', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('429', '20', '429', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('430', '20', '430', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('431', '20', '431', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('438', '20', '438', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('439', '20', '439', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('440', '20', '440', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('441', '20', '441', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('444', '21', '444', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('445', '21', '445', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('446', '21', '446', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('447', '21', '447', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('448', '21', '448', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('449', '21', '449', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('450', '21', '450', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('451', '21', '451', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('452', '21', '452', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('453', '21', '453', 'YES', 'YES', 'YES', 'YES', 'YES');
INSERT INTO `ac_control` VALUES ('454', '21', '454', 'YES', 'YES', 'YES', 'YES', 'YES');

-- ----------------------------
-- Table structure for `ac_databaseconvert`
-- ----------------------------
DROP TABLE IF EXISTS `ac_databaseconvert`;
CREATE TABLE `ac_databaseconvert` (
  `databaseConvertId` int(11) NOT NULL AUTO_INCREMENT,
  `columnType` varchar(20) DEFAULT NULL,
  `convertType` varchar(20) DEFAULT NULL,
  `databaseType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`databaseConvertId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_databaseconvert
-- ----------------------------
INSERT INTO `ac_databaseconvert` VALUES ('1', 'varchar', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('2', 'char', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('3', 'nchar', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('4', 'nvarchar', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('5', 'text', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('6', 'ntext', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('7', 'int', 'Integer', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('8', 'tinyint', 'Integer', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('9', 'smallint', 'Integer', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('10', 'float', 'Float', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('11', 'money', 'Double', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('12', 'datetime', 'Date', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('13', 'nvarchar2', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('14', 'long', 'Long', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('15', 'number', 'Integer', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('16', 'date', 'Date', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('17', 'timestamp', 'Date', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('18', 'short', 'Integer', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('19', 'byte', 'Integer', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('20', 'double', 'Double', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('21', 'character', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('22', 'string', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('23', 'boolean', 'Boolean', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('24', 'yes_no', 'Boolean', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('25', 'true_false', 'Boolean', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('26', 'bigint', 'Long', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('28', 'bit', 'Boolean', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('29', 'longtext', 'String', 'MySql');
INSERT INTO `ac_databaseconvert` VALUES ('30', 'decimal', 'BigDecimal', 'MySql');

-- ----------------------------
-- Table structure for `ac_packageconfig`
-- ----------------------------
DROP TABLE IF EXISTS `ac_packageconfig`;
CREATE TABLE `ac_packageconfig` (
  `packageConfigId` int(11) NOT NULL AUTO_INCREMENT,
  `applyFrame` varchar(20) DEFAULT NULL,
  `packageName` varchar(50) DEFAULT NULL,
  `packagePath` varchar(50) DEFAULT NULL,
  `memo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`packageConfigId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_packageconfig
-- ----------------------------
INSERT INTO `ac_packageconfig` VALUES ('1', 'SM', 'Base', 'com.[replace].base', '基本的包');
INSERT INTO `ac_packageconfig` VALUES ('2', 'SM', 'Bean', 'com.[replace].bean', '实体Bean');
INSERT INTO `ac_packageconfig` VALUES ('3', 'SM', 'Controller', 'com.[replace].controller', 'Controller控制器');
INSERT INTO `ac_packageconfig` VALUES ('4', 'SM', 'Service', 'com.[replace].service', 'Service接口');
INSERT INTO `ac_packageconfig` VALUES ('5', 'SM', 'ServiceImpl', 'com.[replace].service.impl', 'Service实现类');
INSERT INTO `ac_packageconfig` VALUES ('6', 'SM', 'Mapper', 'com.[replace].mapper', 'Mapper接口');
INSERT INTO `ac_packageconfig` VALUES ('7', 'SM', 'Util', 'com.[replace].util', 'Util工具类');
INSERT INTO `ac_packageconfig` VALUES ('8', 'SSH', 'Base', 'com.[replace].base', '基本的包');
INSERT INTO `ac_packageconfig` VALUES ('9', 'SSH', 'Bean', 'com.[replace].bean', '实体Bean');
INSERT INTO `ac_packageconfig` VALUES ('10', 'SSH', 'Action', 'com.[replace].controller', 'Action控制器');
INSERT INTO `ac_packageconfig` VALUES ('11', 'SSH', 'Service', 'com.[replace].service', 'Service接口');
INSERT INTO `ac_packageconfig` VALUES ('12', 'SSH', 'ServiceImpl', 'com.[replace].service.impl', 'Service实现类');
INSERT INTO `ac_packageconfig` VALUES ('13', 'SSH', 'Dao', 'com.[replace].mapper', 'Dao接口');
INSERT INTO `ac_packageconfig` VALUES ('14', 'SSH', 'DaoImpl', 'com.[replace].daoimpl', 'Dao实现类');
INSERT INTO `ac_packageconfig` VALUES ('15', 'SSH', 'Json', 'com.[replace].json', 'Json转换类');
INSERT INTO `ac_packageconfig` VALUES ('16', 'SSH', 'Util', 'com.[replace].util', 'Util工具类');

-- ----------------------------
-- Table structure for `ac_packageconvert`
-- ----------------------------
DROP TABLE IF EXISTS `ac_packageconvert`;
CREATE TABLE `ac_packageconvert` (
  `packageConvertId` int(11) NOT NULL AUTO_INCREMENT,
  `className` varchar(20) DEFAULT NULL,
  `packageName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`packageConvertId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_packageconvert
-- ----------------------------
INSERT INTO `ac_packageconvert` VALUES ('1', 'Date', 'java.util.Date');
INSERT INTO `ac_packageconvert` VALUES ('2', 'List', 'java.util.List');
INSERT INTO `ac_packageconvert` VALUES ('3', 'HashMap', 'java.util.HashMap');
INSERT INTO `ac_packageconvert` VALUES ('4', 'ArrayList', 'java.util.ArrayList');
INSERT INTO `ac_packageconvert` VALUES ('5', 'Vector', 'java.util.Vector');
INSERT INTO `ac_packageconvert` VALUES ('6', 'BigDecimal', 'java.math.BigDecimal');

-- ----------------------------
-- Table structure for `ac_produce`
-- ----------------------------
DROP TABLE IF EXISTS `ac_produce`;
CREATE TABLE `ac_produce` (
  `produceId` int(11) NOT NULL AUTO_INCREMENT,
  `produceTitle` varchar(50) DEFAULT NULL,
  `produceName` varchar(50) DEFAULT NULL,
  `tableAmount` int(11) DEFAULT NULL,
  `fileAmount` int(11) DEFAULT NULL,
  `wasteTime` varchar(50) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`produceId`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_produce
-- ----------------------------
INSERT INTO `ac_produce` VALUES ('1', 'aaaaaa', 'aaaaaa', '13', '120', '6秒', '2015-05-04 16:34:02', '项目生成');
INSERT INTO `ac_produce` VALUES ('2', 'aaaaaa', 'aaaaaa', '13', '13', '0秒', '2015-05-04 16:34:13', '类别生成');
INSERT INTO `ac_produce` VALUES ('3', 'aaaaaa', 'aaaaaa', '1', '7', '0秒', '2015-05-04 16:34:18', '单表生成');
INSERT INTO `ac_produce` VALUES ('4', 'aaaaaa', 'aaaaaa', '13', '120', '5087毫秒', '2015-05-04 16:35:57', '项目生成');
INSERT INTO `ac_produce` VALUES ('5', 'aaaaaa', 'aaaaaa', '13', '120', '4805毫秒', '2015-05-04 16:36:21', '项目生成');
INSERT INTO `ac_produce` VALUES ('6', 'aaaaaa', 'aaaaaa', '13', '120', '5136毫秒', '2015-05-04 20:58:21', '项目生成');
INSERT INTO `ac_produce` VALUES ('7', 'aaaaaa', 'aaaaaa', '13', '120', '4593毫秒', '2015-05-04 20:58:26', '项目生成');
INSERT INTO `ac_produce` VALUES ('8', 'aaaaaa', 'aaaaaa', '13', '13', '407毫秒', '2015-05-04 20:58:37', '类别生成');
INSERT INTO `ac_produce` VALUES ('9', 'aaaaaa', 'aaaaaa', '1', '7', '238毫秒', '2015-05-04 20:58:44', '单表生成');
INSERT INTO `ac_produce` VALUES ('10', 'aaaaaa', 'aaaaaa', '13', '120', '6316毫秒', '2015-05-04 21:32:43', '项目生成');
INSERT INTO `ac_produce` VALUES ('11', 'aaaaaa', 'aaaaaa', '13', '120', '5880毫秒', '2015-05-05 16:32:43', '项目生成');
INSERT INTO `ac_produce` VALUES ('12', 'aaaaaa', 'aaaaaa', '13', '120', '4733毫秒', '2015-05-05 17:03:03', '项目生成');
INSERT INTO `ac_produce` VALUES ('13', 'aaaaaa', 'aaaaaa', '13', '120', '4630毫秒', '2015-05-05 17:06:27', '项目生成');
INSERT INTO `ac_produce` VALUES ('14', 'aaaaaa', 'aaaaaa', '13', '120', '6229毫秒', '2015-05-05 17:10:40', '项目生成');
INSERT INTO `ac_produce` VALUES ('15', 'aaaaaa', 'aaaaaa', '13', '120', '5964毫秒', '2015-05-05 17:14:57', '项目生成');
INSERT INTO `ac_produce` VALUES ('16', 'aaaaaa', 'aaaaaa', '13', '120', '5164毫秒', '2015-05-05 17:16:26', '项目生成');
INSERT INTO `ac_produce` VALUES ('17', 'aaaaaa', 'aaaaaa', '13', '120', '4567毫秒', '2015-05-05 17:18:40', '项目生成');
INSERT INTO `ac_produce` VALUES ('18', 'aaaaaa', 'aaaaaa', '13', '120', '4911毫秒', '2015-05-05 17:20:44', '项目生成');
INSERT INTO `ac_produce` VALUES ('19', 'aaaaaa', 'aaaaaa', '13', '120', '5433毫秒', '2015-05-05 17:23:31', '项目生成');
INSERT INTO `ac_produce` VALUES ('20', 'aaaaaa', 'aaaaaa', '13', '120', '5726毫秒', '2015-05-05 17:25:26', '项目生成');
INSERT INTO `ac_produce` VALUES ('21', '渝乐音乐网', 'music', '12', '113', '5633毫秒', '2015-05-05 17:53:22', '项目生成');
INSERT INTO `ac_produce` VALUES ('22', 'aaaaaa', 'aaaaaa', '13', '120', '4119毫秒', '2015-05-06 22:00:19', '项目生成');
INSERT INTO `ac_produce` VALUES ('23', 'aaaaaa', 'aaaaaa', '13', '120', '3893毫秒', '2015-05-06 22:02:07', '项目生成');
INSERT INTO `ac_produce` VALUES ('24', 'aaaaaa', 'aaaaaa', '13', '120', '3916毫秒', '2015-05-06 22:06:21', '项目生成');
INSERT INTO `ac_produce` VALUES ('25', 'aaaaaa', 'aaaaaa', '13', '120', '4024毫秒', '2015-05-06 22:08:12', '项目生成');
INSERT INTO `ac_produce` VALUES ('26', 'aaaaaa', 'aaaaaa', '13', '120', '4085毫秒', '2015-05-06 22:10:06', '项目生成');
INSERT INTO `ac_produce` VALUES ('27', 'aaaaaa', 'aaaaaa', '13', '120', '4010毫秒', '2015-05-06 22:11:25', '项目生成');
INSERT INTO `ac_produce` VALUES ('28', 'aaaaaa', 'aaaaaa', '13', '120', '3921毫秒', '2015-05-06 22:11:35', '项目生成');
INSERT INTO `ac_produce` VALUES ('29', 'aaaaaa', 'aaaaaa', '13', '120', '3929毫秒', '2015-05-06 22:12:55', '项目生成');
INSERT INTO `ac_produce` VALUES ('30', 'aaaaaa', 'aaaaaa', '13', '120', '3923毫秒', '2015-05-06 22:13:13', '项目生成');
INSERT INTO `ac_produce` VALUES ('31', 'hmh', 'hmh', '1', '7', '1061毫秒', '2015-05-06 23:32:14', '单表生成');
INSERT INTO `ac_produce` VALUES ('32', '渝乐音乐网', 'music', '12', '113', '5043毫秒', '2015-05-07 00:45:02', '项目生成');
INSERT INTO `ac_produce` VALUES ('33', '渝乐音乐网', 'music', '12', '113', '6070毫秒', '2015-05-07 21:02:10', '项目生成');
INSERT INTO `ac_produce` VALUES ('34', '渝乐音乐网', 'music', '12', '113', '5125毫秒', '2015-05-07 23:41:16', '项目生成');
INSERT INTO `ac_produce` VALUES ('35', '渝乐音乐网', 'music', '12', '113', '5757毫秒', '2015-05-12 21:46:11', '项目生成');
INSERT INTO `ac_produce` VALUES ('36', '渝乐音乐网', 'music', '12', '113', '6114毫秒', '2015-05-12 21:54:44', '项目生成');
INSERT INTO `ac_produce` VALUES ('37', '渝乐音乐网', 'music', '12', '113', '5881毫秒', '2015-05-12 22:04:38', '项目生成');
INSERT INTO `ac_produce` VALUES ('38', '渝乐音乐网', 'music', '12', '113', '6007毫秒', '2015-05-12 22:51:49', '项目生成');
INSERT INTO `ac_produce` VALUES ('39', '渝乐音乐网', 'music', '12', '113', '4946毫秒', '2015-05-12 22:55:15', '项目生成');
INSERT INTO `ac_produce` VALUES ('40', '渝乐音乐网', 'music', '12', '113', '3622毫秒', '2015-06-12 20:22:41', '项目生成');
INSERT INTO `ac_produce` VALUES ('41', '渝乐音乐网', 'music', '12', '113', '4509毫秒', '2015-08-18 21:34:43', '项目生成');
INSERT INTO `ac_produce` VALUES ('42', '骑来骑去', 'qlqq', '24', '197', '10022毫秒', '2015-09-23 00:53:25', '项目生成');
INSERT INTO `ac_produce` VALUES ('43', '骑来骑去', 'qlqq', '24', '197', '5875毫秒', '2015-09-23 01:01:40', '项目生成');
INSERT INTO `ac_produce` VALUES ('44', '骑来骑去', 'qlqq', '24', '197', '5694毫秒', '2015-09-23 01:03:03', '项目生成');
INSERT INTO `ac_produce` VALUES ('45', '骑来骑去', 'qlqq', '24', '197', '7760毫秒', '2015-09-23 01:47:48', '项目生成');
INSERT INTO `ac_produce` VALUES ('46', '骑来骑去', 'qlqq', '24', '197', '6696毫秒', '2015-09-23 01:50:49', '项目生成');
INSERT INTO `ac_produce` VALUES ('47', '骑来骑去', 'qlqq', '24', '197', '5731毫秒', '2015-09-23 01:59:28', '项目生成');
INSERT INTO `ac_produce` VALUES ('48', '骑来骑去', 'qlqq', '24', '197', '6119毫秒', '2015-09-23 02:00:14', '项目生成');
INSERT INTO `ac_produce` VALUES ('49', '骑来骑去', 'qlqq', '24', '197', '5992毫秒', '2015-09-23 02:04:11', '项目生成');
INSERT INTO `ac_produce` VALUES ('50', '骑来骑去', 'qlqq', '24', '197', '6817毫秒', '2015-09-23 02:05:41', '项目生成');
INSERT INTO `ac_produce` VALUES ('51', '骑来骑去', 'qlqq', '24', '197', '8097毫秒', '2015-09-23 02:10:25', '项目生成');
INSERT INTO `ac_produce` VALUES ('52', '骑来骑去', 'qlqq', '24', '197', '9379毫秒', '2015-09-23 02:13:15', '项目生成');
INSERT INTO `ac_produce` VALUES ('53', '骑来骑去', 'qlqq', '24', '197', '8393毫秒', '2015-09-23 02:17:32', '项目生成');
INSERT INTO `ac_produce` VALUES ('54', '骑来骑去', 'qlqq', '24', '197', '7089毫秒', '2015-09-23 19:51:55', '项目生成');
INSERT INTO `ac_produce` VALUES ('55', '骑来骑去', 'qlqq', '24', '197', '7897毫秒', '2015-09-23 20:07:53', '项目生成');
INSERT INTO `ac_produce` VALUES ('56', '骑来骑去', 'qlqq', '24', '197', '7824毫秒', '2015-09-23 20:10:04', '项目生成');
INSERT INTO `ac_produce` VALUES ('57', '骑来骑去', 'qlqq', '24', '197', '8412毫秒', '2015-09-23 20:23:49', '项目生成');
INSERT INTO `ac_produce` VALUES ('58', '骑来骑去', 'qlqq', '24', '197', '7615毫秒', '2015-09-23 20:25:28', '项目生成');
INSERT INTO `ac_produce` VALUES ('59', '骑来骑去', 'qlqq', '24', '197', '7092毫秒', '2015-09-23 20:26:41', '项目生成');
INSERT INTO `ac_produce` VALUES ('60', '骑来骑去', 'qlqq', '24', '197', '7678毫秒', '2015-09-23 20:55:35', '项目生成');
INSERT INTO `ac_produce` VALUES ('61', 'sfg', 'sfg', '17', '17', '532毫秒', '2015-09-26 18:06:10', '类别生成');
INSERT INTO `ac_produce` VALUES ('62', 'sfg', 'sfg', '17', '17', '602毫秒', '2015-09-26 18:16:02', '类别生成');
INSERT INTO `ac_produce` VALUES ('63', 'sfg', 'sfg', '17', '17', '491毫秒', '2015-09-26 18:16:10', '类别生成');
INSERT INTO `ac_produce` VALUES ('64', 'sfg', 'sfg', '17', '17', '638毫秒', '2015-09-26 18:16:15', '类别生成');
INSERT INTO `ac_produce` VALUES ('65', 'sfg', 'sfg', '17', '17', '613毫秒', '2015-09-26 18:16:50', '类别生成');
INSERT INTO `ac_produce` VALUES ('66', '骑来骑去', 'qlqq', '24', '197', '6687毫秒', '2015-09-27 17:54:14', '项目生成');
INSERT INTO `ac_produce` VALUES ('67', '骑来骑去', 'qlqq', '1', '7', '985毫秒', '2015-10-09 21:44:30', '单表生成');
INSERT INTO `ac_produce` VALUES ('68', '骑来骑去', 'qlqq', '1', '7', '2016毫秒', '2015-11-03 20:35:05', '单表生成');
INSERT INTO `ac_produce` VALUES ('69', '骑来骑去', 'qlqq', '1', '7', '1008毫秒', '2015-11-28 12:33:07', '单表生成');
INSERT INTO `ac_produce` VALUES ('70', '骑来骑去', 'qlqq', '1', '7', '999毫秒', '2016-01-09 16:29:28', '单表生成');
INSERT INTO `ac_produce` VALUES ('71', '骑来骑去', 'qlqq', '1', '7', '991毫秒', '2016-01-16 00:15:40', '单表生成');
INSERT INTO `ac_produce` VALUES ('72', '彩票', 'lottery', '6', '71', '2268毫秒', '2016-05-22 16:22:14', '项目生成');
INSERT INTO `ac_produce` VALUES ('73', '彩票', 'lottery', '6', '71', '3110毫秒', '2016-05-23 01:22:11', '项目生成');
INSERT INTO `ac_produce` VALUES ('74', '彩票', 'lottery', '6', '71', '3048毫秒', '2016-05-23 01:39:35', '项目生成');
INSERT INTO `ac_produce` VALUES ('75', '彩票', 'lottery', '6', '71', '2090毫秒', '2016-05-23 01:39:46', '项目生成');
INSERT INTO `ac_produce` VALUES ('76', '彩票', 'lottery', '6', '71', '3127毫秒', '2016-05-23 01:59:11', '项目生成');
INSERT INTO `ac_produce` VALUES ('77', '彩票', 'lottery', '6', '71', '2089毫秒', '2016-05-23 02:07:34', '项目生成');
INSERT INTO `ac_produce` VALUES ('78', '彩票', 'lottery', '6', '71', '2083毫秒', '2016-05-23 02:08:17', '项目生成');
INSERT INTO `ac_produce` VALUES ('79', '彩票', 'lottery', '6', '71', '2126毫秒', '2016-05-23 02:11:47', '项目生成');
INSERT INTO `ac_produce` VALUES ('80', '彩票', 'lottery', '6', '71', '2958毫秒', '2016-05-23 21:57:14', '项目生成');
INSERT INTO `ac_produce` VALUES ('81', '彩票', 'lottery', '6', '71', '2148毫秒', '2016-05-23 21:57:55', '项目生成');
INSERT INTO `ac_produce` VALUES ('82', '彩票', 'lottery', '6', '71', '2053毫秒', '2016-05-23 21:58:03', '项目生成');
INSERT INTO `ac_produce` VALUES ('83', '彩票', 'lottery', '1', '7', '1088毫秒', '2016-05-23 23:42:43', '单表生成');
INSERT INTO `ac_produce` VALUES ('84', '彩票', 'lottery', '1', '7', '250毫秒', '2016-05-23 23:42:49', '单表生成');
INSERT INTO `ac_produce` VALUES ('85', '彩票', 'lottery', '8', '85', '3770毫秒', '2016-05-29 23:11:55', '项目生成');
INSERT INTO `ac_produce` VALUES ('86', '彩票', 'lottery', '8', '85', '2657毫秒', '2016-05-29 23:15:56', '项目生成');
INSERT INTO `ac_produce` VALUES ('87', '彩票', 'lottery', '8', '85', '3478毫秒', '2016-06-03 22:06:09', '项目生成');
INSERT INTO `ac_produce` VALUES ('88', '彩票', 'lottery', '8', '85', '3723毫秒', '2016-06-04 02:39:29', '项目生成');
INSERT INTO `ac_produce` VALUES ('89', '彩票', 'lottery', '8', '85', '3545毫秒', '2016-06-04 12:11:48', '项目生成');
INSERT INTO `ac_produce` VALUES ('90', '彩票', 'lottery', '8', '85', '2461毫秒', '2016-06-04 12:28:35', '项目生成');
INSERT INTO `ac_produce` VALUES ('91', '彩票', 'lottery', '8', '85', '2451毫秒', '2016-06-04 12:37:01', '项目生成');
INSERT INTO `ac_produce` VALUES ('92', '彩票', 'lottery', '12', '113', '3386毫秒', '2016-06-27 22:23:34', '项目生成');
INSERT INTO `ac_produce` VALUES ('93', '彩票', 'lottery', '12', '113', '5620毫秒', '2016-06-27 22:31:03', '项目生成');
INSERT INTO `ac_produce` VALUES ('94', '彩票', 'lottery', '4', '57', '2331毫秒', '2016-07-26 20:30:42', '项目生成');
INSERT INTO `ac_produce` VALUES ('95', '彩票', 'lottery', '4', '57', '5836毫秒', '2016-07-26 20:32:26', '项目生成');
INSERT INTO `ac_produce` VALUES ('96', '彩票', 'lottery', '4', '57', '1879毫秒', '2016-07-26 20:33:05', '项目生成');
INSERT INTO `ac_produce` VALUES ('97', '彩票', 'lottery', '4', '57', '2403毫秒', '2016-07-26 23:37:31', '项目生成');
INSERT INTO `ac_produce` VALUES ('98', '彩票', 'lottery', '4', '57', '2394毫秒', '2016-07-30 01:27:25', '项目生成');
INSERT INTO `ac_produce` VALUES ('99', '债券项目', 'sse', '7', '78', '3763毫秒', '2016-08-04 09:43:46', '项目生成');
INSERT INTO `ac_produce` VALUES ('100', '债券项目', 'sse', '7', '55', '2005毫秒', '2016-08-04 10:03:11', '项目生成');
INSERT INTO `ac_produce` VALUES ('101', '债券项目', 'sse', '7', '55', '2597毫秒', '2016-08-04 10:31:59', '项目生成');
INSERT INTO `ac_produce` VALUES ('102', '债券项目', 'sse', '7', '55', '1682毫秒', '2016-08-04 10:36:49', '项目生成');
INSERT INTO `ac_produce` VALUES ('103', '债券项目', 'sse', '7', '42', '1383毫秒', '2016-08-04 10:43:39', '项目生成');
INSERT INTO `ac_produce` VALUES ('104', '债券项目', 'sse', '7', '42', '1252毫秒', '2016-08-04 10:44:43', '项目生成');
INSERT INTO `ac_produce` VALUES ('105', '债券项目', 'sse', '7', '42', '1247毫秒', '2016-08-04 10:45:00', '项目生成');
INSERT INTO `ac_produce` VALUES ('106', '债券项目', 'sse', '7', '49', '1699毫秒', '2016-08-04 10:49:18', '项目生成');
INSERT INTO `ac_produce` VALUES ('107', '债券项目', 'sse', '7', '49', '1918毫秒', '2016-08-04 10:55:30', '项目生成');
INSERT INTO `ac_produce` VALUES ('108', '债券项目', 'sse', '7', '49', '1533毫秒', '2016-08-04 10:56:57', '项目生成');
INSERT INTO `ac_produce` VALUES ('109', '债券项目', 'sse', '7', '49', '1877毫秒', '2016-08-04 10:58:24', '项目生成');
INSERT INTO `ac_produce` VALUES ('110', '债券项目', 'sse', '7', '49', '1489毫秒', '2016-08-04 11:00:30', '项目生成');
INSERT INTO `ac_produce` VALUES ('111', '债券项目', 'sse', '7', '49', '1966毫秒', '2016-08-04 11:01:14', '项目生成');
INSERT INTO `ac_produce` VALUES ('112', '债券项目', 'sse', '7', '49', '1478毫秒', '2016-08-04 11:01:20', '项目生成');
INSERT INTO `ac_produce` VALUES ('113', '债券项目', 'sse', '7', '49', '1783毫秒', '2016-08-04 11:03:31', '项目生成');
INSERT INTO `ac_produce` VALUES ('114', '债券项目', 'sse', '7', '49', '1621毫秒', '2016-08-04 11:04:33', '项目生成');
INSERT INTO `ac_produce` VALUES ('115', '债券项目', 'sse', '7', '49', '1685毫秒', '2016-08-04 11:05:32', '项目生成');
INSERT INTO `ac_produce` VALUES ('116', '债券项目', 'sse', '7', '49', '1793毫秒', '2016-08-04 11:07:42', '项目生成');
INSERT INTO `ac_produce` VALUES ('117', '债券项目', 'sse', '7', '49', '1690毫秒', '2016-08-04 11:08:36', '项目生成');
INSERT INTO `ac_produce` VALUES ('118', '债券项目', 'sse', '7', '49', '1614毫秒', '2016-08-04 11:09:22', '项目生成');
INSERT INTO `ac_produce` VALUES ('119', '债券项目', 'sse', '7', '49', '1708毫秒', '2016-08-04 11:11:20', '项目生成');
INSERT INTO `ac_produce` VALUES ('120', '债券项目', 'sse', '8', '56', '2645毫秒', '2016-08-04 14:30:53', '项目生成');
INSERT INTO `ac_produce` VALUES ('121', '债券项目', 'sse', '9', '63', '2264毫秒', '2016-08-04 14:32:59', '项目生成');
INSERT INTO `ac_produce` VALUES ('122', '债券项目', 'sse', '9', '63', '2361毫秒', '2016-08-04 15:02:12', '项目生成');
INSERT INTO `ac_produce` VALUES ('123', '债券项目', 'sse', '9', '63', '2546毫秒', '2016-08-04 15:10:43', '项目生成');
INSERT INTO `ac_produce` VALUES ('124', '债券项目', 'sse', '9', '63', '2569毫秒', '2016-08-04 15:17:44', '项目生成');
INSERT INTO `ac_produce` VALUES ('125', '债券项目', 'sse', '9', '63', '2960毫秒', '2016-08-04 16:09:09', '项目生成');
INSERT INTO `ac_produce` VALUES ('126', '债券项目', 'sse', '8', '56', '1972毫秒', '2016-08-04 17:10:28', '项目生成');
INSERT INTO `ac_produce` VALUES ('127', '债券项目', 'sse', '8', '56', '2685毫秒', '2016-08-05 12:02:29', '项目生成');
INSERT INTO `ac_produce` VALUES ('128', '债券项目', 'sse', '8', '56', '2063毫秒', '2016-08-05 12:04:54', '项目生成');
INSERT INTO `ac_produce` VALUES ('129', '债券项目', 'sse', '8', '56', '2039毫秒', '2016-08-05 12:05:44', '项目生成');
INSERT INTO `ac_produce` VALUES ('130', '债券项目', 'sse', '8', '56', '1670毫秒', '2016-08-05 12:06:30', '项目生成');
INSERT INTO `ac_produce` VALUES ('131', '债券项目', 'sse', '8', '56', '1694毫秒', '2016-08-05 12:44:04', '项目生成');
INSERT INTO `ac_produce` VALUES ('132', '债券项目', 'sse', '8', '56', '1713毫秒', '2016-08-05 12:46:19', '项目生成');
INSERT INTO `ac_produce` VALUES ('133', '债券项目', 'sse', '8', '56', '1874毫秒', '2016-08-05 12:48:16', '项目生成');
INSERT INTO `ac_produce` VALUES ('134', '债券项目', 'sse', '8', '56', '1729毫秒', '2016-08-05 12:48:44', '项目生成');
INSERT INTO `ac_produce` VALUES ('135', '债券项目', 'sse', '8', '56', '1893毫秒', '2016-08-05 13:18:03', '项目生成');
INSERT INTO `ac_produce` VALUES ('136', '债券监管', 'supervise', '1', '7', '371毫秒', '2016-08-17 10:11:42', '项目生成');
INSERT INTO `ac_produce` VALUES ('137', '债券监管', 'supervise', '1', '7', '778毫秒', '2016-08-17 10:28:03', '项目生成');
INSERT INTO `ac_produce` VALUES ('138', '债券监管', 'supervise', '1', '7', '196毫秒', '2016-08-17 10:29:10', '项目生成');
INSERT INTO `ac_produce` VALUES ('139', '债券监管', 'supervise', '1', '1', '63毫秒', '2016-08-17 10:33:01', '类别生成');
INSERT INTO `ac_produce` VALUES ('140', '渝乐音乐网', 'music', '12', '84', '3060毫秒', '2016-08-17 10:33:52', '项目生成');
INSERT INTO `ac_produce` VALUES ('141', '渝乐音乐网', 'music', '12', '84', '2618毫秒', '2016-08-17 10:34:46', '项目生成');
INSERT INTO `ac_produce` VALUES ('142', '债券监管', 'supervise', '11', '11', '423毫秒', '2016-08-17 11:13:01', '类别生成');
INSERT INTO `ac_produce` VALUES ('143', '债券监管', 'supervise', '11', '77', '2953毫秒', '2016-08-17 11:24:36', '项目生成');
INSERT INTO `ac_produce` VALUES ('144', '债券项目', 'sse', '8', '56', '1865毫秒', '2016-08-17 11:25:29', '项目生成');
INSERT INTO `ac_produce` VALUES ('145', '债券监管', 'supervise', '11', '77', '2946毫秒', '2016-08-17 11:50:38', '项目生成');
INSERT INTO `ac_produce` VALUES ('146', '债券监管', 'supervise', '11', '77', '2632毫秒', '2016-08-17 11:54:09', '项目生成');

-- ----------------------------
-- Table structure for `ac_project`
-- ----------------------------
DROP TABLE IF EXISTS `ac_project`;
CREATE TABLE `ac_project` (
  `projectId` int(11) NOT NULL AUTO_INCREMENT,
  `projectTitle` varchar(50) DEFAULT NULL,
  `projectName` varchar(50) DEFAULT NULL,
  `projectFrame` varchar(10) DEFAULT NULL,
  `requestPostfix` varchar(30) DEFAULT NULL,
  `databaseName` varchar(100) DEFAULT NULL,
  `databaseType` varchar(10) DEFAULT NULL,
  `databaseIp` varchar(128) DEFAULT NULL,
  `databasePort` int(11) DEFAULT NULL,
  `databaseUser` varchar(30) DEFAULT NULL,
  `databasePwd` varchar(30) DEFAULT NULL,
  `createDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isDefault` varchar(10) DEFAULT NULL,
  `isValidation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`projectId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_project
-- ----------------------------
INSERT INTO `ac_project` VALUES ('16', '渝乐音乐网', 'music', 'SM', '.html', 'musicsong', 'MySql', 'localhost', '3306', 'root', '123321', '2015-08-29 20:00:42', 'NO', 'YES');
INSERT INTO `ac_project` VALUES ('20', '债券项目', 'sse', 'SM', '.htm', 'ssedb', 'MySql', 'localhost', '3306', 'root', '', '2016-08-17 09:57:51', 'NO', 'YES');
INSERT INTO `ac_project` VALUES ('21', '债券监管', 'supervise', 'SM', '.json', 'ssesupdb', 'MySql', '192.168.101.249', '3306', 'ssesupbase', 'ssesupbase', '2016-08-17 09:57:51', 'YES', 'YES');

-- ----------------------------
-- Table structure for `ac_projectpackage`
-- ----------------------------
DROP TABLE IF EXISTS `ac_projectpackage`;
CREATE TABLE `ac_projectpackage` (
  `projectPackageId` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) DEFAULT NULL,
  `packageName` varchar(100) DEFAULT NULL,
  `packagePath` varchar(100) DEFAULT NULL,
  `memo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`projectPackageId`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_projectpackage
-- ----------------------------
INSERT INTO `ac_projectpackage` VALUES ('86', '16', 'Base', 'com.music.base', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('87', '16', 'Bean', 'com.music.bean', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('88', '16', 'Controller', 'com.music.controller', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('89', '16', 'Service', 'com.music.service', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('90', '16', 'ServiceImpl', 'com.music.service.impl', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('91', '16', 'Mapper', 'com.music.mapper', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('92', '16', 'Util', 'com.music.util', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('121', '20', 'Base', 'com.sse.base', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('122', '20', 'Bean', 'com.hundsun.sse.bond.project.entity', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('123', '20', 'Controller', 'com.hundsun.sse.bond.project.action', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('124', '20', 'Service', 'com.hundsun.sse.bond.project.service', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('125', '20', 'ServiceImpl', 'com.hundsun.sse.bond.project.service.impl', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('126', '20', 'Mapper', 'com.hundsun.sse.bond.project.dao', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('127', '20', 'Util', 'com.hundsun.sse.bond.project.dao', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('128', '21', 'Base', 'com.hundsun.supervise.base', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('129', '21', 'Bean', 'com.hundsun.supervise.bean', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('130', '21', 'Controller', 'com.hundsun.supervise.controller', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('131', '21', 'Service', 'com.hundsun.supervise.service', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('132', '21', 'ServiceImpl', 'com.hundsun.supervise.service.impl', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('133', '21', 'Mapper', 'com.hundsun.supervise.mapper', '自动生成');
INSERT INTO `ac_projectpackage` VALUES ('134', '21', 'Util', 'com.hundsun.supervise.util', '自动生成');

-- ----------------------------
-- Table structure for `ac_relation`
-- ----------------------------
DROP TABLE IF EXISTS `ac_relation`;
CREATE TABLE `ac_relation` (
  `relationId` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) DEFAULT NULL,
  `tableId` int(11) DEFAULT NULL,
  `columnId` int(11) DEFAULT NULL,
  `relation` varchar(20) DEFAULT NULL,
  `relationTableId` int(11) DEFAULT NULL,
  `relationColumnId` int(11) DEFAULT NULL,
  `relationShowColumnId` int(11) DEFAULT NULL,
  `cascadeDelete` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`relationId`)
) ENGINE=InnoDB AUTO_INCREMENT=5560 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_relation
-- ----------------------------
INSERT INTO `ac_relation` VALUES ('5540', '16', '50', '309', 'OneToMany', '48', '302', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5541', '16', '48', '302', 'ManyToOne', '50', '309', '310', 'NO');
INSERT INTO `ac_relation` VALUES ('5542', '16', '50', '309', 'OneToMany', '53', '332', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5543', '16', '53', '332', 'ManyToOne', '50', '309', '310', 'NO');
INSERT INTO `ac_relation` VALUES ('5544', '16', '51', '316', 'OneToMany', '50', '312', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5545', '16', '50', '312', 'ManyToOne', '51', '316', '317', 'NO');
INSERT INTO `ac_relation` VALUES ('5546', '16', '52', '319', 'OneToMany', '48', '301', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5547', '16', '48', '301', 'ManyToOne', '52', '319', '320', 'NO');
INSERT INTO `ac_relation` VALUES ('5548', '16', '52', '319', 'OneToMany', '55', '337', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5549', '16', '55', '337', 'ManyToOne', '52', '319', '320', 'NO');
INSERT INTO `ac_relation` VALUES ('5550', '16', '52', '319', 'OneToMany', '56', '342', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5551', '16', '56', '342', 'ManyToOne', '52', '319', '320', 'NO');
INSERT INTO `ac_relation` VALUES ('5552', '16', '52', '319', 'OneToMany', '58', '358', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5553', '16', '58', '358', 'ManyToOne', '52', '319', '320', 'NO');
INSERT INTO `ac_relation` VALUES ('5554', '16', '56', '340', 'OneToMany', '53', '331', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5555', '16', '53', '331', 'ManyToOne', '56', '340', '341', 'NO');
INSERT INTO `ac_relation` VALUES ('5556', '16', '57', '346', 'OneToMany', '50', '311', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5557', '16', '50', '311', 'ManyToOne', '57', '346', '347', 'NO');
INSERT INTO `ac_relation` VALUES ('5558', '16', '57', '346', 'OneToMany', '59', '365', null, 'YES');
INSERT INTO `ac_relation` VALUES ('5559', '16', '59', '365', 'ManyToOne', '57', '346', '347', 'NO');

-- ----------------------------
-- Table structure for `ac_table`
-- ----------------------------
DROP TABLE IF EXISTS `ac_table`;
CREATE TABLE `ac_table` (
  `tableId` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) DEFAULT NULL,
  `tableTitle` varchar(50) DEFAULT NULL,
  `mappingName` varchar(50) DEFAULT NULL,
  `tableName` varchar(50) DEFAULT NULL,
  `validationDelete` varchar(10) DEFAULT NULL,
  `tableMemo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tableId`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_table
-- ----------------------------
INSERT INTO `ac_table` VALUES ('48', '16', '我的收藏', 'collecting', 'Collecting', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('49', '16', '删除文件记录表', 'deletelog', 'DeleteLog', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('50', '16', '歌曲列表', 'music', 'Music', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('51', '16', '歌曲类别', 'musicclass', 'MusicClass', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('52', '16', '用户列表', 'musicuser', 'MusicUser', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('53', '16', '歌单列表', 'play', 'Play', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('54', '16', '项目异常记录', 'projecterror', 'ProjectError', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('55', '16', '密保', 'protecte', 'Protecte', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('56', '16', '歌单', 'song', 'Song', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('57', '16', '明星信息', 'star', 'Star', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('58', '16', '文件上传列表', 'upload', 'Upload', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('59', '16', '视屏', 'video', 'Video', 'NO', '自动生成');
INSERT INTO `ac_table` VALUES ('428', '20', '业务资格信息表', 'b_certification_info', 'BCertificationInfo', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('429', '20', '发行人信息披露专员表', 'b_issuser_announce_attache', 'BIssuserAnnounceAttache', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('430', '20', '人员基本信息', 'b_issuser_personal_info', 'BIssuserPersonalInfo', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('431', '20', '主要负责人信息表', 'b_issuser_principal_information', 'BIssuserPrincipalInformation', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('438', '20', '人员其他身份识别信息', 'b_issuser_personal_info_other', 'BIssuserPersonalInfoOther', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('439', '20', '人员学习经历信息', 'b_issuser_personal_learning_experience', 'BIssuserPersonalLearningExperience', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('440', '20', '人员从业/执业/任职资格信息', 'b_issuser_personal_qualifications', 'BIssuserPersonalQualifications', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('441', '20', '人员工作经历信息', 'b_issuser_personal_work_experience', 'BIssuserPersonalWorkExperience', 'NO', '智能生成');
INSERT INTO `ac_table` VALUES ('444', '21', '债券基本信息表', 'sup_bond_info', 'SupBondInfo', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('445', '21', '记录人跟踪表', 'sup_creator_log', 'SupCreatorLog', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('446', '21', '证监会相关信息表', 'sup_csrc', 'SupCsrc', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('447', '21', '发行人信息披露专员表', 'sup_info_disclosure_person', 'SupInfoDisclosurePerson', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('448', '21', '发行人基本信息表', 'sup_issuer', 'SupIssuer', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('449', '21', '事务所相关信息表', 'sup_office', 'SupOffice', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('450', '21', '机构表', 'sup_organization', 'SupOrganization', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('451', '21', '风险及违约信息表', 'sup_risk_default', 'SupRiskDefault', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('452', '21', '监管文件信息表', 'sup_supervise_file', 'SupSuperviseFile', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('453', '21', '监管基本信息表', 'sup_supervise_info', 'SupSuperviseInfo', 'NO', '手动生成');
INSERT INTO `ac_table` VALUES ('454', '21', '承销商信息表', 'sup_underwriting', 'SupUnderwriting', 'NO', '手动生成');

-- ----------------------------
-- Table structure for `ac_template`
-- ----------------------------
DROP TABLE IF EXISTS `ac_template`;
CREATE TABLE `ac_template` (
  `templateId` int(11) NOT NULL AUTO_INCREMENT,
  `templateTitle` varchar(50) DEFAULT NULL,
  `templateName` varchar(50) DEFAULT NULL,
  `applyFrame` varchar(50) DEFAULT NULL,
  `isValidation` varchar(10) DEFAULT NULL,
  `imageUrl` varchar(100) DEFAULT NULL,
  `memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`templateId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_template
-- ----------------------------
INSERT INTO `ac_template` VALUES ('1', '恒生专用', 'hundsun', 'SM', 'YES', '20150419023312556.jpg', '支持Spring + MyBatis + MySql');
INSERT INTO `ac_template` VALUES ('12', 'Bootstrap 后台管理模板', 'template_1', 'SM', 'YES', '20150419023312556.jpg', '支持Spring + MyBatis + MySql');
INSERT INTO `ac_template` VALUES ('13', 'spring + freemark', 'template_2', 'SM', 'YES', '20150419023312556.jpg', '支持Spring + MyBatis + MySql');

-- ----------------------------
-- Table structure for `ac_templateconfig`
-- ----------------------------
DROP TABLE IF EXISTS `ac_templateconfig`;
CREATE TABLE `ac_templateconfig` (
  `templateConfigId` int(11) NOT NULL AUTO_INCREMENT,
  `templateId` int(11) DEFAULT NULL,
  `configType` varchar(20) DEFAULT NULL,
  `configName` varchar(50) DEFAULT NULL,
  `configValue` varchar(50) DEFAULT NULL,
  `isAssignPath` varchar(10) DEFAULT NULL,
  `savePath` varchar(100) DEFAULT NULL,
  `produceName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`templateConfigId`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ac_templateconfig
-- ----------------------------
INSERT INTO `ac_templateconfig` VALUES ('1', '12', 'STATIC', 'Base', 'BaseBean.ftl', 'NO', '', 'BaseBean.java');
INSERT INTO `ac_templateconfig` VALUES ('2', '12', 'DYNAMIC', 'Bean', 'Bean.ftl', 'NO', '', '[replace].java');
INSERT INTO `ac_templateconfig` VALUES ('3', '12', 'DYNAMIC', 'Controller', 'Controller.ftl', 'NO', '', '[replace]Controller.java');
INSERT INTO `ac_templateconfig` VALUES ('4', '12', 'DYNAMIC', 'Service', 'Service.ftl', 'NO', '', '[replace]Service.java');
INSERT INTO `ac_templateconfig` VALUES ('5', '12', 'DYNAMIC', 'ServiceImpl', 'ServiceImpl.ftl', 'NO', '', '[replace]ServiceImpl.java');
INSERT INTO `ac_templateconfig` VALUES ('6', '12', 'DYNAMIC', 'Mapper', 'Mapper.ftl', 'NO', '', '[replace]Mapper.java');
INSERT INTO `ac_templateconfig` VALUES ('8', '12', 'DYNAMIC', 'MapperImpl', 'MapperImpl.ftl', 'YES', 'src\\mappings', '[replace]_Mapper.xml');
INSERT INTO `ac_templateconfig` VALUES ('9', '12', 'STATIC', 'Spring', 'SpringApplication.ftl', 'YES', 'src', 'spring-application.xml');
INSERT INTO `ac_templateconfig` VALUES ('10', '12', 'DYNAMIC', 'Page', 'Page.ftl', 'YES', 'WebRoot\\WEB-INF\\index', '[replace].jsp');
INSERT INTO `ac_templateconfig` VALUES ('11', '12', 'STATIC', 'Web', 'Web.ftl', 'YES', 'WebRoot\\WEB-INF', 'web.xml');
INSERT INTO `ac_templateconfig` VALUES ('12', '12', 'STATIC', 'Base', 'BaseController.ftl', 'NO', '', 'BaseController.java');
INSERT INTO `ac_templateconfig` VALUES ('13', '12', 'STATIC', 'Base', 'BaseMapper.ftl', 'NO', '', 'BaseMapper.java');
INSERT INTO `ac_templateconfig` VALUES ('14', '12', 'STATIC', 'Base', 'BaseService.ftl', 'NO', '', 'BaseService.java');
INSERT INTO `ac_templateconfig` VALUES ('15', '12', 'STATIC', 'Base', 'PageStyle.ftl', 'NO', '', 'PageStyle.java');
INSERT INTO `ac_templateconfig` VALUES ('16', '12', 'STATIC', 'Base', 'Pagination.ftl', 'NO', '', 'Pagination.java');
INSERT INTO `ac_templateconfig` VALUES ('17', '12', 'STATIC', 'Base', 'ServiceException.ftl', 'NO', '', 'ServiceException.java');
INSERT INTO `ac_templateconfig` VALUES ('18', '12', 'STATIC', 'Base', 'SystemConstant.ftl', 'NO', '', 'SystemConstant.java');
INSERT INTO `ac_templateconfig` VALUES ('33', '12', 'STATIC', 'Spring', 'SpringServlet.ftl', 'YES', 'src', 'spring-servlet.xml');
INSERT INTO `ac_templateconfig` VALUES ('34', '12', 'STATIC', 'Properties', 'Config.ftl', 'YES', 'src', 'config.properties');
INSERT INTO `ac_templateconfig` VALUES ('35', '12', 'STATIC', 'Properties', 'Log4j.ftl', 'YES', 'src', 'log4j.properties');
INSERT INTO `ac_templateconfig` VALUES ('36', '12', 'STATIC', 'Util', 'DateSerializer.ftl', 'NO', ' ', 'DateSerializer.java');
INSERT INTO `ac_templateconfig` VALUES ('37', '12', 'STATIC', 'Util', 'DateTimeSerializer.ftl', 'NO', '', 'DateTimeSerializer.java');
INSERT INTO `ac_templateconfig` VALUES ('38', '12', 'STATIC', 'Util', 'DateTimeUtil.ftl', 'NO', '', 'DateTimeUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('39', '12', 'STATIC', 'Util', 'FileOperations.ftl', 'NO', '', 'FileOperations.java');
INSERT INTO `ac_templateconfig` VALUES ('40', '12', 'STATIC', 'Util', 'Md5Util.ftl', 'NO', ' ', 'Md5Util.java');
INSERT INTO `ac_templateconfig` VALUES ('41', '12', 'STATIC', 'Util', 'PinyinUtil.ftl', 'NO', ' ', 'PinyinUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('42', '12', 'STATIC', 'Util', 'PropertiesUtil.ftl', 'NO', ' ', 'PropertiesUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('43', '12', 'STATIC', 'Util', 'StringConvertUtil.ftl', 'NO', '', 'StringConvertUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('45', '12', 'STATIC', 'Util', 'Valdatation.ftl', 'NO', '', 'Valdatation.java');
INSERT INTO `ac_templateconfig` VALUES ('46', '12', 'STATIC', 'Util', 'ZipUtil.ftl', 'NO', '', 'ZipUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('47', '12', 'STATIC', 'Util', 'MvcDateConverter.ftl', 'NO', ' ', 'MvcDateConverter.java');
INSERT INTO `ac_templateconfig` VALUES ('48', '12', 'STATIC', 'Page', 'Index.ftl', 'YES', 'WebRoot\\', 'index.jsp');
INSERT INTO `ac_templateconfig` VALUES ('49', '12', 'COPY', 'Copy', 'Css.zip', 'YES', 'WebRoot\\css', '');
INSERT INTO `ac_templateconfig` VALUES ('50', '12', 'COPY', 'Copy', 'Fonts.zip', 'YES', 'WebRoot\\fonts', '');
INSERT INTO `ac_templateconfig` VALUES ('51', '12', 'COPY', 'Copy', 'Js.zip', 'YES', 'WebRoot\\js', '');
INSERT INTO `ac_templateconfig` VALUES ('52', '12', 'COPY', 'Copy', 'Images.zip', 'YES', 'WebRoot\\images', '');
INSERT INTO `ac_templateconfig` VALUES ('53', '13', 'STATIC', 'Base', 'BootstrapQueryBean.ftl', 'NO', '', 'BootstrapQueryBean.java');
INSERT INTO `ac_templateconfig` VALUES ('54', '13', 'DYNAMIC', 'Bean', 'Bean.ftl', 'NO', '', '[replace].java');
INSERT INTO `ac_templateconfig` VALUES ('55', '13', 'DYNAMIC', 'Controller', 'Controller.ftl', 'NO', '', '[replace]Controller.java');
INSERT INTO `ac_templateconfig` VALUES ('56', '13', 'DYNAMIC', 'Service', 'Service.ftl', 'NO', '', '[replace]Service.java');
INSERT INTO `ac_templateconfig` VALUES ('57', '13', 'DYNAMIC', 'ServiceImpl', 'ServiceImpl.ftl', 'NO', '', '[replace]ServiceImpl.java');
INSERT INTO `ac_templateconfig` VALUES ('58', '13', 'DYNAMIC', 'Mapper', 'Mapper.ftl', 'NO', '', '[replace]Mapper.java');
INSERT INTO `ac_templateconfig` VALUES ('59', '13', 'DYNAMIC', 'MapperImpl', 'MapperImpl.ftl', 'YES', 'src\\mappings', '[replace]_Mapper.xml');
INSERT INTO `ac_templateconfig` VALUES ('60', '13', 'STATIC', 'Spring', 'SpringApplication.ftl', 'YES', 'src', 'spring-application.xml');
INSERT INTO `ac_templateconfig` VALUES ('61', '13', 'DYNAMIC', 'Page', 'Page.ftl', 'YES', 'WebRoot\\WEB-INF\\index', '[replace].ftl');
INSERT INTO `ac_templateconfig` VALUES ('62', '13', 'STATIC', 'Web', 'Web.ftl', 'YES', 'WebRoot\\WEB-INF', 'web.xml');
INSERT INTO `ac_templateconfig` VALUES ('63', '13', 'STATIC', 'Base', 'BaseController.ftl', 'NO', '', 'BaseController.java');
INSERT INTO `ac_templateconfig` VALUES ('64', '13', 'STATIC', 'Base', 'BaseMapper.ftl', 'NO', '', 'BaseMapper.java');
INSERT INTO `ac_templateconfig` VALUES ('65', '13', 'STATIC', 'Base', 'BaseService.ftl', 'NO', '', 'BaseService.java');
INSERT INTO `ac_templateconfig` VALUES ('66', '13', 'STATIC', 'Base', 'PageStyle.ftl', 'NO', '', 'PageStyle.java');
INSERT INTO `ac_templateconfig` VALUES ('67', '13', 'STATIC', 'Base', 'Pagination.ftl', 'NO', '', 'Pagination.java');
INSERT INTO `ac_templateconfig` VALUES ('68', '13', 'STATIC', 'Base', 'ServiceException.ftl', 'NO', '', 'ServiceException.java');
INSERT INTO `ac_templateconfig` VALUES ('69', '13', 'STATIC', 'Base', 'SystemConstant.ftl', 'NO', '', 'SystemConstant.java');
INSERT INTO `ac_templateconfig` VALUES ('70', '13', 'STATIC', 'Spring', 'SpringServlet.ftl', 'YES', 'src', 'spring-servlet.xml');
INSERT INTO `ac_templateconfig` VALUES ('71', '13', 'STATIC', 'Properties', 'Config.ftl', 'YES', 'src', 'config.properties');
INSERT INTO `ac_templateconfig` VALUES ('72', '13', 'STATIC', 'Properties', 'Log4j.ftl', 'YES', 'src', 'log4j.properties');
INSERT INTO `ac_templateconfig` VALUES ('73', '13', 'STATIC', 'Util', 'DateSerializer.ftl', 'NO', '', 'DateSerializer.java');
INSERT INTO `ac_templateconfig` VALUES ('74', '13', 'STATIC', 'Util', 'DateTimeSerializer.ftl', 'NO', '', 'DateTimeSerializer.java');
INSERT INTO `ac_templateconfig` VALUES ('75', '13', 'STATIC', 'Util', 'DateTimeUtil.ftl', 'NO', '', 'DateTimeUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('76', '13', 'STATIC', 'Util', 'FileOperations.ftl', 'NO', '', 'FileOperations.java');
INSERT INTO `ac_templateconfig` VALUES ('77', '13', 'STATIC', 'Util', 'Md5Util.ftl', 'NO', '', 'Md5Util.java');
INSERT INTO `ac_templateconfig` VALUES ('78', '13', 'STATIC', 'Util', 'PinyinUtil.ftl', 'NO', '', 'PinyinUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('79', '13', 'STATIC', 'Util', 'PropertiesUtil.ftl', 'NO', '', 'PropertiesUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('80', '13', 'STATIC', 'Util', 'StringConvertUtil.ftl', 'NO', '', 'StringConvertUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('81', '13', 'STATIC', 'Util', 'Valdatation.ftl', 'NO', '', 'Valdatation.java');
INSERT INTO `ac_templateconfig` VALUES ('82', '13', 'STATIC', 'Util', 'ZipUtil.ftl', 'NO', '', 'ZipUtil.java');
INSERT INTO `ac_templateconfig` VALUES ('83', '13', 'STATIC', 'Util', 'MvcDateConverter.ftl', 'NO', '', 'MvcDateConverter.java');
INSERT INTO `ac_templateconfig` VALUES ('84', '13', 'STATIC', 'Page', 'Index.ftl', 'YES', 'WebRoot\\', 'index.jsp');
INSERT INTO `ac_templateconfig` VALUES ('85', '13', 'COPY', 'Copy', 'Css.zip', 'YES', 'WebRoot\\css', '');
INSERT INTO `ac_templateconfig` VALUES ('86', '13', 'COPY', 'Copy', 'Fonts.zip', 'YES', 'WebRoot\\fonts', '');
INSERT INTO `ac_templateconfig` VALUES ('87', '13', 'COPY', 'Copy', 'Js.zip', 'YES', 'WebRoot\\js', '');
INSERT INTO `ac_templateconfig` VALUES ('88', '13', 'COPY', 'Copy', 'Images.zip', 'YES', 'WebRoot\\images', '');
INSERT INTO `ac_templateconfig` VALUES ('90', '1', 'DYNAMIC', 'Bean', 'Bean.ftl', 'NO', '', '[replace].java');
INSERT INTO `ac_templateconfig` VALUES ('91', '1', 'DYNAMIC', 'Controller', 'Controller.ftl', 'NO', '', '[replace]Controller.java');
INSERT INTO `ac_templateconfig` VALUES ('92', '1', 'DYNAMIC', 'Service', 'Service.ftl', 'NO', '', '[replace]Service.java');
INSERT INTO `ac_templateconfig` VALUES ('93', '1', 'DYNAMIC', 'ServiceImpl', 'ServiceImpl.ftl', 'NO', '', '[replace]ServiceImpl.java');
INSERT INTO `ac_templateconfig` VALUES ('94', '1', 'DYNAMIC', 'DAO', 'Dao.ftl', 'YES', 'src\\com\\hundsun\\sse\\bond\\project\\dao', '[replace]DAO.java');
INSERT INTO `ac_templateconfig` VALUES ('95', '1', 'DYNAMIC', 'DAOImpl', 'DaoImpl.ftl', 'YES', 'src\\com\\hundsun\\sse\\bond\\project\\dao', '[replace]DAO.xml');
INSERT INTO `ac_templateconfig` VALUES ('127', '1', 'DYNAMIC', 'Qry', 'Qry.ftl', 'YES', 'src\\com\\hundsun\\sse\\bond\\project\\dto', '[replace]Qry.java');
