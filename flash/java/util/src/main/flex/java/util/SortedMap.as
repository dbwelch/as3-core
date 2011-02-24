package java.util
{

	public interface SortedMap extends Map
	{
		
		/*
		
		Comparator<? super K>	comparator() 
		          Returns the comparator used to order the keys in this map, or null if this map uses the natural ordering of its keys.
		 Set<Map.Entry<K,V>>	entrySet() 
		          Returns a Set view of the mappings contained in this map.
		 K	firstKey() 
		          Returns the first (lowest) key currently in this map.
		 SortedMap<K,V>	headMap(K toKey) 
		          Returns a view of the portion of this map whose keys are strictly less than toKey.
		 Set<K>	keySet() 
		          Returns a Set view of the keys contained in this map.
		 K	lastKey() 
		          Returns the last (highest) key currently in this map.
		 SortedMap<K,V>	subMap(K fromKey, K toKey) 
		          Returns a view of the portion of this map whose keys range from fromKey, inclusive, to toKey, exclusive.
		 SortedMap<K,V>	tailMap(K fromKey) 
		          Returns a view of the portion of this map whose keys are greater than or equal to fromKey.
		 Collection<V>	values() 
		          Returns a Collection view of the values contained in this map.		
		
		*/
	}
}