package com.autocode.produce;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.bean.Control;
import com.autocode.bean.PackageConvert;
import com.autocode.bean.Produce;
import com.autocode.bean.Project;
import com.autocode.bean.ProjectPackage;
import com.autocode.bean.Table;
import com.autocode.bean.TemplateConfig;
import com.autocode.service.ProduceService;
import com.autocode.util.ZipUtil;

public class ProduceRun extends Thread {

	@Autowired
	private ProduceService produceService;
	private Project project;
	private List<ProjectPackage> projectPackageList;
	private List<Table> tableList;
	private List<Control> controlList;
	private List<PackageConvert> packageConvertList;
	private List<TemplateConfig> templateConfigList;
	private Integer produceCount;
	private boolean isOpenFile;
	private String templatePath;
	private String writePath;
	private String projectName;
	private String produceType;
	private Integer writeCount = Integer.valueOf(0);
	private String fileName;
	private String fileType;
	private String fileWritePath;
	private Map<String, Object> contentMap = new HashMap<String, Object>();

	public ProduceRun(Project project, ProduceService produceService, List<ProjectPackage> projectPackageList,
			List<Table> tableList, List<Control> controlList, List<PackageConvert> packageConvertList,
			List<TemplateConfig> templateConfigList, boolean isOpenFile, int produceCount, String templatePath,
			String writePath, String produceType) {
		this.project = project;
		this.projectPackageList = projectPackageList;
		this.tableList = tableList;
		this.controlList = controlList;
		this.packageConvertList = packageConvertList;
		this.templateConfigList = templateConfigList;
		this.produceCount = Integer.valueOf(produceCount);
		this.isOpenFile = isOpenFile;
		this.templatePath = templatePath;
		this.writePath = writePath;
		this.projectName = project.getProjectName();
		this.produceType = produceType;
		this.produceService = produceService;
		initPrepare();
	}

	private void initPrepare() {
		/*
		 * for (int j = 0; j < this.tableList.size(); j++) { Table table =
		 * this.tableList.get(j); for (int k = 0; k <
		 * table.getColumnList().size(); k++) { Column localColumn =
		 * table.getColumnList().get(k); } }
		 */

		this.contentMap.put("tableList", this.tableList);

		for (int i = 0; i < this.projectPackageList.size(); i++) {
			ProjectPackage pp = (ProjectPackage) this.projectPackageList.get(i);
			this.contentMap.put(firstToLower(pp.getPackageName()) + "Package", pp.getPackagePath());
		}

		for (int i = 0; i < this.packageConvertList.size(); i++) {
			PackageConvert pc = (PackageConvert) this.packageConvertList.get(i);
			this.contentMap.put(pc.getClassName(), pc.getPackageName());
		}
	}

	private String getPackagePath(String className) {
		String writeClassPath = (String) this.contentMap.get(firstToLower(className) + "Package");
		if (writeClassPath == null)
			writeClassPath = "";
		else {
			writeClassPath = writeClassPath.replace(".", "/");
		}
		return writeClassPath;
	}

	private String getClassName(String className) {
		if (className.contains(".")) {
			className = className.substring(0, className.lastIndexOf("."));
		}
		return className;
	}

	public void run() {
		Date startDate = new Date();
		boolean bool = false;
		String classPath = "\\" + this.project.getProjectName() + "\\src\\";
		String assignPath = "\\" + this.project.getProjectName();
		this.contentMap.put("project", this.project);
		for (int i = 0; i < this.templateConfigList.size(); i++) {
			TemplateConfig templateConfig = (TemplateConfig) this.templateConfigList.get(i);
			this.fileType = templateConfig.getConfigName();
			// 静态
			if (templateConfig.getConfigType().equals("STATIC")) {
				this.fileName = templateConfig.getProduceName();
				this.contentMap.put("className", getClassName(this.fileName));
				if (templateConfig.getIsAssignPath().equals("YES")) {
					fileWritePath = assignPath + "\\" + templateConfig.getSavePath();
				} else {
					fileWritePath = classPath + "\\" + getPackagePath(templateConfig.getConfigName());
				}
				bool = writeFile(fileWritePath, templateConfig.getConfigValue(), this.contentMap);
				if (!bool) {
					return;
				}
				// 动态
			} else if (templateConfig.getConfigType().equals("DYNAMIC")) {
				if (templateConfig.getIsAssignPath().equals("YES")) {
					if ((templateConfig.getConfigName().equals("Controller"))
							|| (templateConfig.getConfigName().equals("Action"))
							|| (templateConfig.getConfigName().equals("Page"))) {
						for (int j = 0; j < this.controlList.size(); j++) {
							Control control = (Control) this.controlList.get(j);
							this.fileName = templateConfig.getProduceName().replace("[replace]",
									control.getTableName());
							for (int k = 0; k < this.tableList.size(); k++) {
								Table table = (Table) this.tableList.get(k);
								if (table.getTableId().equals(control.getTableId())) {
									this.contentMap.put("table", table);
									this.contentMap.put("control", control);
									putPrimaryKeyColumn(table);
									this.contentMap.put("columnList", table.getColumnList());
									break;
								}
							}
							this.contentMap.put("className", getClassName(this.fileName));
							bool = writeFile(assignPath + "\\" + templateConfig.getSavePath(),
									templateConfig.getConfigValue(), this.contentMap);
							if (!bool) {
								return;
							}
						}
					} else {
						for (int j = 0; j < this.tableList.size(); j++) {
							Table table = (Table) this.tableList.get(j);
							this.contentMap.put("table", table);
							putPrimaryKeyColumn(table);
							this.fileName = templateConfig.getProduceName().replace("[replace]", table.getTableName());
							this.contentMap.put("className", getClassName(this.fileName));
							this.contentMap.put("columnList", table.getColumnList());
							bool = writeFile(assignPath + "\\" + templateConfig.getSavePath(),
									templateConfig.getConfigValue(), this.contentMap);
							if (!bool) {
								return;
							}
						}
					}

				} else if ((templateConfig.getConfigName().equals("Controller"))
						|| (templateConfig.getConfigName().equals("Action"))
						|| (templateConfig.getConfigName().equals("Page"))) {
					for (int j = 0; j < this.controlList.size(); j++) {
						Control control = (Control) this.controlList.get(j);
						this.fileName = templateConfig.getProduceName().replace("[replace]", control.getTableName());
						for (int k = 0; k < this.tableList.size(); k++) {
							Table table = (Table) this.tableList.get(k);
							if (table.getTableId().equals(control.getTableId())) {
								this.contentMap.put("table", table);
								this.contentMap.put("control", control);
								putPrimaryKeyColumn(table);
								this.contentMap.put("columnList", table.getColumnList());
								break;
							}
						}
						this.contentMap.put("className", getClassName(this.fileName));
						bool = writeFile(classPath + "/" + getPackagePath(templateConfig.getConfigName()),
								templateConfig.getConfigValue(), this.contentMap);
						if (!bool) {
							return;
						}
					}
				} else {
					for (int j = 0; j < this.tableList.size(); j++) {
						Table table = (Table) this.tableList.get(j);
						this.contentMap.put("table", table);
						putPrimaryKeyColumn(table);
						this.fileName = templateConfig.getProduceName().replace("[replace]", table.getTableName());
						this.contentMap.put("columnList", table.getColumnList());
						this.contentMap.put("className", getClassName(this.fileName));
						bool = writeFile(classPath + "/" + getPackagePath(templateConfig.getConfigName()),
								templateConfig.getConfigValue(), this.contentMap);
						if (!bool)
							return;
					}
				}
			} else {
				if (templateConfig.getIsAssignPath().equals("YES")) {
					this.fileName = templateConfig.getProduceName();
					bool = ZipUtil.unZip(this.templatePath + "/" + templateConfig.getConfigValue(),
							this.writePath + assignPath + "\\" + templateConfig.getSavePath());
					if (!bool)
						writeState(false, templateConfig.getConfigValue() + ",解压文件异常");
				} else {
					this.fileName = templateConfig.getConfigValue().replace(".zip", "");
					bool = ZipUtil.unZip(this.templatePath + "/" + templateConfig.getConfigValue(),
							this.writePath + "\\" + assignPath + "\\WebRoot\\" + this.fileName);
					if (!bool) {
						writeState(false, templateConfig.getConfigValue() + ",解压文件异常");
						return;
					}
				}
				this.writeCount = Integer.valueOf(this.writeCount.intValue() + 1);
				writeState(true, "");
			}
			if (this.produceCount.equals(this.writeCount)) {
				Date endDate = new Date();
				Produce produce = null;
				if (this.produceType.equals("projectProduce")) {
					produce = new Produce(this.project.getProjectTitle(), this.project.getProjectName(),
							Integer.valueOf(this.tableList.size()), this.produceCount,
							endDate.getTime() - startDate.getTime() + "毫秒", new Date(), "项目生成");
				} /*
					 * else if (this.produceType.equals("classProduce")) {
					 * produce = new Produce(this.project.getProjectTitle(),
					 * this.project.getProjectName(),
					 * Integer.valueOf(this.tableList.size()),
					 * this.produceCount, endDate.getTime() -
					 * startDate.getTime() + "毫秒", new Date(), "类别生成"); } else {
					 * produce = new Produce(this.project.getProjectTitle(),
					 * this.project.getProjectName(), Integer.valueOf(1),
					 * this.produceCount, endDate.getTime() -
					 * startDate.getTime() + "毫秒", new Date(), "单表生成"); }
					 */

				try {
					this.produceService.insertProduce(produce);
				} catch (Exception e) {
					throw new ServiceException("insertProject失败");
				}
			}
			if ((this.isOpenFile) && (this.produceCount.equals(this.writeCount)))
				try {
					String cmd = "cmd /c start " + this.writePath.replace(this.projectName, "");
					Runtime.getRuntime().exec(cmd);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	private void putPrimaryKeyColumn(Table table) {
		try {
			this.contentMap.remove("javaPrimary");
			this.contentMap.remove("databasePrimary");
			this.contentMap.remove("showColumnName");

			List<Column> columnList = table.getColumnList();
			for (int i = 0; i < columnList.size(); i++) {
				Column column = (Column) columnList.get(i);
				if (column.getIsPrimary().equals("YES")) {
					this.contentMap.put("javaPrimary", column.getColumnName());
					this.contentMap.put("databasePrimary", column.getMappingName());
				} else if ((column.getColumnType().equals("String"))
						&& (this.contentMap.get("showColumnName") == null)) {
					if (column.getColumnName().toLowerCase().equals(table.getTableName().toLowerCase() + "name")) {
						this.contentMap.put("showColumnName", column.getColumnName());
					}
				}
			}
			if (this.contentMap.get("showColumnName") == null) {
				for (int i = 0; i < columnList.size(); i++) {
					Column column = (Column) columnList.get(i);
					if ((column.getColumnType().equals("String"))
							&& ((column.getColumnName().toLowerCase().contains(table.getTableName().toLowerCase()))
									|| (column.getColumnName().toLowerCase().contains("name")))) {
						this.contentMap.put("showColumnName", column.getColumnName());
					}
				}
			}

			if (this.contentMap.get("showColumnName") == null) {
				for (int i = 0; i < columnList.size(); i++) {
					Column column = (Column) columnList.get(i);
					if (column.getColumnType().equals("String")) {
						this.contentMap.put("showColumnName", column.getColumnName());
					}
				}
			}
			if (this.contentMap.get("showColumnName") == null) {
				this.contentMap.put("showColumnName", this.contentMap.get("javaPrimary"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (this.contentMap.get("javaPrimary") == null) {
			writeState(false, table.getTableName() + "下没有主键");
			throw new ServiceException(table.getTableName() + "下没有主键");
		}
	}

	private boolean writeFile(String packagePath, String templateName, Map<String, Object> contentMap) {
		try {
			if (this.produceType.equals("projectProduce"))
				FreemarkerUtil.WriteFile(this.writePath + "/" + packagePath, this.fileName, this.templatePath,
						templateName, contentMap);
			else {
				FreemarkerUtil.WriteFile(this.writePath + "/" + this.projectName, this.fileName, this.templatePath,
						templateName, contentMap);
			}
			this.writeCount = Integer.valueOf(this.writeCount.intValue() + 1);
			writeState(true, "");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			writeState(false, "模板名称:" + templateName + "，异常信息:" + e.getMessage());
		}
		return false;
	}

	private void writeState(boolean fileState, String reason) {
		if ((!fileState) && ((reason == null) || (reason.equals("")))) {
			throw new ServiceException("失败时原因不能为空");
		}

		ProduceFileUtil.WriteState(this.writePath, this.projectName, this.fileName, this.fileType, this.produceCount,
				this.writeCount, fileState, reason);
	}

	public static String firstToLower(String str) {
		if ((str == null) || (str.equals(""))) {
			return "";
		}
		return String.valueOf(str.charAt(0)).toLowerCase() + str.substring(1, str.length());
	}
}
