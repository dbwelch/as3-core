package java.util.regex
{
	import flash.utils.ByteArray;
	
	/**
	* 	Represents a pattern as a binary file.
	*/
	public class PatternFile extends ByteArray
	{
		
		/**
		*	Represents no compression method. 
		*/		
		public static const COMPRESSION_NONE:int = 0;

		
		/**
		* 	Represents the deflated (zlib) ccompression method.
		*/
		public static const COMPRESSION_DEFLATED:int = 8;
		
		/**
		* 	Creates a <code>PatternFile</code> instance.
		*/
		public function PatternFile()
		{
			super();
		}
		
		/**
		* 	Encodes a pattern object graph to a file representation.
		* 
		* 	@param pattern The pattern to encode.
		* 	@param compression The compression method to use for the file
		* 	body data.
		* 
		* 	@return A file representation of the pattern.
		*/
		static public function encode(
			pattern:Pattern, compression:uint = 0 ):PatternFile
		{
			trace("[ENCODE] PatternFile::encode()", pattern, compression );
			//TODO
			return null;
		}
		
		/**
		* 	Decodes a file to a pattern object graph.
		* 
		* 	@param file The binary file data.
		* 
		* 	@return A pattern representing the file contents.
		*/
		static public function decode( file:PatternFile ):Pattern
		{
			//TODO
			return null;
		}
	}
}