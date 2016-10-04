package ${basePackage};

import java.util.List;

public interface BaseMapper<T> {
	
	/**
	 * 添加
	 * 
	 * @param object
	 * @return
	 */
	public Integer insert(T object);
	
	/**
	 * 修改
	 * 
	 * @param object
	 * @return
	 */
	public Integer update(T object);
	
	/**
	 * 删除数据
	 * 
	 * @param id
	 * @return
	 */
	public Integer delete(Integer id);
	
	/**
	 * 批量删除数据
	 * 
	 * @param ids
	 * @return
	 */
	public Integer deletes(String ids);
	
	/**
	 * 根据主键查询数据
	 * 
	 * @param id
	 * @return
	 */
	public T querySingleObject(Integer id);
	
	/**
	 * 查询记录总条数
	 * 
	 * @param id
	 * @return
	 */
	public Integer queryPaginationCount(T object);
	
	/**
	 * 查询分页列表
	 * 
	 * @param id
	 * @return
	 */
	public List<T> queryPaginationList(T object);
	
	/**
	 * 
	 * 根据对象属性作为查询条件 列表
	 * 
	 * @param object
	 * @return
	 */
	public List<T> queryObjectList(T object);
	
	/**
	 * 
	 * 查询所有,用于页面下拉框 业务特殊自行修改sql
	 * 
	 * @param object
	 * @return
	 */
	public List<T> queryObjectSelect();
}
