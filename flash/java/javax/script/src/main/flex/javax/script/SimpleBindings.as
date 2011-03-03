package javax.script
{
	import java.util.AbstractMap;
	import java.util.HashMap;
	import java.util.Map;
	
	/**
	* 	A simple implementation of Bindings backed by
	* 	a HashMap or some other specified Map.
	*/
	public class SimpleBindings extends AbstractMap
		implements Bindings
	{
		/**
		* 	Creates a <code>SimpleBindings</code> instance.
		* 
		* 	@param map The map used to back these bindings;
		* 	if no map is specified a default HashMap is created.
		*/
		public function SimpleBindings( map:Map = null )
		{
			super();
		}
		
		/*
		
	 void	clear() 
	          Removes all of the mappings from this map (optional operation).
	 boolean	containsKey(Object key) 
	          Returns true if this map contains a mapping for the specified key.
	 boolean	containsValue(Object value) 
	          Returns true if this map maps one or more keys to the specified value.
	 Set<Map.Entry<String,Object>>	entrySet() 
	          Returns a Set view of the mappings contained in this map.
	 Object	get(Object key) 
	          Returns the value to which this map maps the specified key.
	 boolean	isEmpty() 
	          Returns true if this map contains no key-value mappings.
	 Set<String>	keySet() 
	          Returns a Set view of the keys contained in this map.
	 Object	put(String name, Object value) 
	          Sets the specified key/value in the underlying map field.
	 void	putAll(Map<? extends String,? extends Object> toMerge) 
	          putAll is implemented using Map.putAll.
	 Object	remove(Object key) 
	          Removes the mapping for this key from this map if it is present (optional operation).
	 int	size() 
	          Returns the number of key-value mappings in this map.
	 Collection<Object>	values() 
	          Returns a Collection view of the values contained in this map.		
		
		*/
	}
}