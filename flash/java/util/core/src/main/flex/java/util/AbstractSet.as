package java.util
{
	
	/**
	*	
	*/
	public class AbstractSet extends AbstractCollection
		implements Set
	{
		/**
		* 	@private
		* 	
		* 	Creates an <code>AbstractSet</code> instance.
		* 
		* 	@param c The class of the set values.
		*/
		public function AbstractSet( c:Class = null )
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function iterator():Iterator
		{
			//TODO
			return null;
		}
	}
}