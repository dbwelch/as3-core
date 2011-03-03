package javax.script
{
	
	import java.util.Map;
	
	/**
	* 	A mapping of key/value pairs, all of whose keys are Strings.
	*/
	public interface Bindings extends Map
	{
		
		/*
		
		boolean	containsKey(Object key) 
	          Returns true if this map contains a mapping for the specified key.
	 Object	get(Object key) 
	          Returns the value to which this map maps the specified key.
	 Object	put(String name, Object value) 
	          Set a named value.
	 void	putAll(Map<? extends String,? extends Object> toMerge) 
	          Adds all the mappings in a given Map to this Bindings.
	 Object	remove(Object key) 
	          Removes the mapping for this key from this map if it is present (optional operation).
		
		*/
		
	}
}