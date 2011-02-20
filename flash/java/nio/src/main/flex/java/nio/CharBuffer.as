package java.nio
{
	import flash.utils.ByteArray;
	
	import java.lang.Character;
	import java.lang.CharSequence;
	import java.lang.MemoryAddress;
	import java.lang.Readable;
	
	/**
	* 	A character buffer.
	* 
	* 	<p>This class defines four categories of operations
	* 	upon character buffers:</p>
	* 
	* 	<ul>
	* 		<li>Absolute and relative get and put methods that
	* 		read and write single characters;</li>
	* 		<li>Relative bulk get methods that transfer contiguous
	* 		sequences of characters from this buffer into an array; and</li>
	* 		<li>Relative bulk put methods that transfer contiguous
	* 		sequences of characters from a character array, a string,
	* 		or some other character buffer into this buffer; and</li>
	* 		<li>Methods for compacting, duplicating, and slicing
	* 		a character buffer.</li>
	* 	</ul>
	* 
	* 	<p>Character buffers can be created either by allocation,
	* 	which allocates space for the buffer's content, by wrapping
	* 	an existing character array or string into a buffer, or by
	* 	creating a view of an existing byte buffer.</p>
	* 
	* 	<p>Like a byte buffer, a character buffer is either direct
	* 	or non-direct. A character buffer created via the wrap methods
	* 	of this class will be non-direct. A character buffer created
	* 	as a view of a byte buffer will be direct if, and only if, the
	* 	byte buffer itself is direct. Whether or not a character buffer
	* 	is direct may be determined by invoking the isDirect method.</p>
	* 
	* 	<p>This class implements the CharSequence interface so that
	* 	character buffers may be used wherever character sequences are
	* 	accepted, for example in the regular-expression package java.util.regex.</p>
	* 
	* 	<p>Methods in this class that do not otherwise have a value to
	* 	return are specified to return the buffer upon which they are invoked.
	* 	This allows method invocations to be chained. The sequence of statements:</p>
	* 
	* 	<pre>cb.put("text/");
	*	cb.put(subtype);
	*	cb.put("; charset=");
	*	cb.put(enc);</pre>
	* 
	* 	<p>can, for example, be replaced by the single statement:</p>
	* 
	* 	<pre>cb.put("text/").put(subtype).put("; charset=").put(enc);</pre>
	*/
	public class CharBuffer extends Buffer
		implements CharSequence, Readable
	{
		/**
		* 	@private
		* 
		* 	The name of the character set used internally
		* 	by the virtual machine.
		*/
		private static const CHARSET_NAME:String = "unicode";
		
		/**
		* 	@private
		* 	
		* 	Creates a <code>CharBuffer</code> instance.
		* 
		* 	@param capacity The capacity of the buffer.
		*/
		public function CharBuffer( capacity:uint )
		{
			super( capacity );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function read( cb:CharBuffer ):int
		{
			//TODO
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function capacity():uint
		{
			var cap:uint = super.capacity();
			if( hasArray()
				&& array().length > cap )
			{
				return array().length / 2;		//two-bytes per character for vm strings
			}
			return cap;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function length():int
		{
			return capacity();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function charAt( index:int ):Character
		{
			//TODO			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function subSequence( start:int, end:int ):CharSequence
		{
			//TODO			
			return null;			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function toString():String
		{
			var bytes:ByteArray = array();
			if( bytes != null && bytes.length > 0 )
			{
				var pos:uint = position();
				position( 0 );
				var s:String = bytes.readMultiByte( bytes.length, CHARSET_NAME );
				position( pos );
				return s;
			}
			return MemoryAddress.id( this );
		}
		
		public function put( value:Object ):CharBuffer
		{
			if( value is String )
			{
				array().writeMultiByte( value as String, CHARSET_NAME );
			}
			return this;
		}
		
		/**
		* 	Allocates a new character buffer.
		* 
		* 	The new buffer's position will be zero,
		* 	its limit will be its capacity, and its mark
		* 	will be undefined. It will have a backing array,
		* 	and its array offset will be zero.
		* 
		* 	@param The new buffer's capacity, in characters.
		* 
		* 	@throws IllegalArgumentException If the capacity is a negative integer.
		* 
		* 	@return The new character buffer.
		*/
		public static function allocate( capacity:uint ):CharBuffer
		{
			return new CharBuffer( capacity );
		}
		
		public static function wrap( target:String ):CharBuffer
		{
			if( target != null )
			{
				var cb:CharBuffer = allocate( target.length );
				var bytes:ByteArray = cb.array();
				bytes.writeMultiByte( target, CHARSET_NAME );
				bytes.position = 0;
				return cb;
			}
			return null;
		}
	}
}