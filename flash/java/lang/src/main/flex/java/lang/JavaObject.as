package java.lang
{
	
	/**
	* 	
	*/
	public class JavaObject extends Object
	{
		/**
		* 	@private
		*/
		protected var __hashCode:Number = NaN;
	
		/**
		* 	Creates a <code>JavaObject</code> instance.
		*/
		public function JavaObject()
		{
			super();
		}
		
		/**
		* 	
		*/
		public function hashCode():int
		{
			//TODO: cache the hash code
			
			if( isNaN( __hashCode ) )
			{
				__hashCode = MemoryAddress.valueOf( this );
			}
			return __hashCode;
		}
		
		/**
		* 	
		*/
		public function getClass():T
		{
			return T.getInstance( this );
		}
		
		/**
		* 	
		*/
		public function equals( o:Object ):Boolean
		{
			return o != null && o === this;
		}
		
		/**
		* 	
		*/
		public function toString():String
		{
			return T.id( this );
		}
	}
}