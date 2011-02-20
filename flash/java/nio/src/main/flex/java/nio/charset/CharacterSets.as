package java.nio.charset
{
	
	import java.util.SortedMap;

	import java.nio.charset.iso.*;
	import java.nio.charset.utf.*;

	/**
	* 	A map of the available character sets.
	*/
	public final class CharacterSets extends SortedMap
	{
		/**
		* 	The <code>utf-8</code> character set.
		*/
		public static const UTF8:Charset = new UTF_8_Charset();
		
		/**
		* 	The <code>iso-8859-1</code> character set.
		*/
		public static const ISO_8859_1:Charset = new ISO_8859_1_Charset();
		
		/**
		* 	Creates a <code>CharacterSets</code> instance.
		*/
		public function CharacterSets():void
		{
			super();
			var c:Charset = null;
			
			c = UTF8;
			put( c.name, c );
			
			c = ISO_8859_1;
			put( c.name, c );
		}
	}
}