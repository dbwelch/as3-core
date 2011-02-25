package java.lang
{
	/**
	* 	Utility methods for extracting the memory address
	* 	of an object.
	* 
	* 	The methods used to extract the memory address
	* 	of an object <em>force a failed coercion</em>
	* 	and extract the hexadecimal representation of the
	* 	address, optionally the <code>valueOf</code> method
	* 	will convert the string representation, eg: 1ae1add9
	* 	to it's decimal equivalent.
	*/
	public class MemoryAddress extends Object
	{
		/**
		* 	The regular expression used to extract the
		* 	hexadecimal string representation of the memory address.
		*/
		public static const MEMORY_ADDRESS:RegExp = /@([0-9a-fA-F]{8}) /;
		
		/**
		* 	The delimiter used between class names and a memory address
		* 	value.
		*/
		public static const DELIMITER:String = "@";
	
		/**
		* 	Retrieves the memory address of target as a hexadecimal value.
		* 
		* 	@param target The target whose memory address you wish
		* 	to determine.
		* 
		* 	@throw ArgumentError If target is null.
		* 
		* 	@return A string representation of the memory location,
		* 	eg: <code>1ae1add9</code>.
		*/
		static public function toString( target:Object ):String
		{
			if( target == null )
			{
				throw new ArgumentError( "Cannot extract a memory address for a null object." );
			}
			
			try
			{
				PrivateCoerceFail( target );
			}catch( e:Error )
			{
				var results:Array = MEMORY_ADDRESS.exec( e.message );
				if( results != null && results[ 1 ] is String )
				{
					return results[ 1 ] as String;
				}
			}
			
			return null;
		}
		
		/**
		* 	Retrieves the memory address of an object
		* 	as a 32-bit unsigned integer.
		* 
		* 	@param target The target whose memory address you wish
		* 	to determine.
		* 
		* 	@throw ArgumentError If target is null.
		* 
		* 	@return The memory address as a 32-bit unsigned integer.
		*/
		static public function valueOf( target:Object ):uint
		{
			var addr:String = toString( target );
			return uint( "0x" + addr );
		}
	}
}

/**
*	@private
*
*	Declared so that we can create a scenario
*	whereby we are sure a coercion will fail, which
*	in turn allows us to extract the memory address
*	of any object.
*/
class PrivateCoerceFail{}