package java.util
{
	import java.lang.K;	
	import java.lang.V;	
	
	/**
	* 	
	*/
	public class TreeMap extends AbstractMap
		implements SortedMap
	{
		/**
		* 	Creates a <code>TreeMap</code> instance.
		* 
		* 	@param k The key type.
		* 	@param v The value type.
		*/
		public function TreeMap( k:K = null, v:V = null )
		{
			super( k, v );
		}
	}
}