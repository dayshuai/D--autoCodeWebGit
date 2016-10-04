package ${basePackage};

import java.util.List;
import java.util.Map;

public interface BaseMapper<T> {

	public Integer insert(T object);
	
	public Integer update(T object);
	
	public Integer delete(Integer id);
	
	public Integer deletes(String ids);
	
	public Integer deleteForMap(Map<String, Object> map);
	
	public T querySingleObject(Integer id);
	
	public T querySingleObjectForMap(Map<String, Object> map);
	
	public Integer queryObjectPaginationCount(T object);
	
	public List<T> queryObjectPaginationList(T object);
	
	public Integer queryObjectCount();
	
	public List<T> queryObjectList();
	
	public Integer queryObjectCountForMap(Map<String, Object> map);
	
	public List<T> queryObjectListForMap(Map<String, Object> map);
}
