package java.util.regex
{
	import flash.utils.ByteArray;
	
	/**
	* 	Represents a pattern as a binary file.
	*/
	public class PatternFile extends Object
	{
		/**
		* 	@private
		*/
		internal var _bytes:ByteArray;
		
		/**
		*	Represents no compression method.
		*/
		public static const COMPRESSION_NONE:int = 0;
		
		/**
		* 	Represents the deflated ccompression method.
		*/
		public static const COMPRESSION_DEFLATED:int = 8;
		
		/**
		* 	The rule signature.
		*/
		public static const SIG_RULE:uint = 0x52554C45;
		
		/**
		* 	The pattern signature.
		*/
		public static const SIG_PATTERN:uint = 0x50544E00;
		
		/**
		* 	Creates a <code>PatternFile</code> instance.
		*/
		public function PatternFile()
		{
			super();
		}
		
		/**
		* 	The bytes for this file.
		*/
		public function get bytes():ByteArray
		{
			if( _bytes == null )
			{
				_bytes = new ByteArray();
			}
			return _bytes;
		}
		
		/**
		* 	@private
		* 	
		* 	Writes the pattern file signature to this
		* 	pattern file.
		*/
		internal function writeSignature():void
		{
			trace("[SIG] PatternFile::writeSignature()", this );
			
			var b:ByteArray = this.bytes;
			b.writeUTFBytes( "R" );
			b.writeUTFBytes( "U" );
			b.writeUTFBytes( "L" );
			b.writeUTFBytes( "E" );
			
			b.position = 0;
			
			//
			//0x50544E00 - pattern
			
			trace("PatternFile::writeSignature()", b.length, b.readUnsignedInt() );
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
			pattern:Pattern,
			compression:uint = COMPRESSION_DEFLATED ):PatternFile
		{
			var file:PatternFile = new PatternFile();
			trace("[ENCODE] PatternFile::encode()", pattern, compression );
			
			file.writeSignature();
			
			return file;
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