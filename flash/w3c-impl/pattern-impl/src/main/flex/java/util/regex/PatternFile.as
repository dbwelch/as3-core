package java.util.regex
{
	import flash.utils.ByteArray;
	
	import java.util.BitSet;
	
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
		* 	@private
		*/
		internal var _flags:BitSet;
		
		/**
		* 	@private
		*/
		internal var _compression:uint = 0;
		
		/**
		* 	@private
		*/
		internal var _version:Number = VERSION;
		
		/**
		* 	The current file version.
		*/
		public static const VERSION:Number = 1.0;
		
		/**
		*	Represents no compression method.
		*/
		public static const COMPRESSION_NONE:int = 0;
		
		/**
		* 	Represents the deflated ccompression method.
		*/
		public static const COMPRESSION_DEFLATED:int = 8;
		
		/**
		* 	The file signature.
		*/
		public static const SIG_FILE:Number = 4.01321737981647e+78;
		
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
		* 	A compression method in use by this file.
		*/
		public function get compression():uint
		{
			return _compression;
		}
		
		public function set compression( value:uint ):void
		{
			_compression = value;
		}
		
		/**
		* 	The version of this file.
		* 
		* 	When a file is encoded it will always use
		* 	the current default version.
		*/
		public function get version():Number
		{
			return _version;
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
		* 	The general purpose bit flags for this file,
		* 	as a 16-bit set.
		* 
		* 	@return The general purpose file flags.
		*/
		public function get flags():BitSet
		{
			if( _flags == null )
			{
				_flags = new BitSet( 16 );
			}
			return _flags;
		}
		
		/**
		* 	@private
		*/
		internal function writeFileHeader(
			compressed:uint = 0, uncompressed:uint = 0 ):void
		{
			//clear any underlying data
			_bytes = new ByteArray();
			
			//write out the 24 byte header
			this.bytes.writeDouble( SIG_FILE );
			this.bytes.writeFloat( VERSION );
			
			//write the general purpose bit flags
			var b:ByteArray = flags.toByteArray();
			this.bytes.writeBytes( b, 0, b.length );
			
			//write compression method
			this.bytes.writeShort( this.compression );
			
			//the compressed and uncompressed sizes
			this.bytes.writeUnsignedInt( compressed );
			this.bytes.writeUnsignedInt( uncompressed );
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
			compression:uint = COMPRESSION_NONE ):PatternFile
		{
			var file:PatternFile = new PatternFile();
			file.compression = compression;
			file.writeFileHeader();
			
			trace("[ENCODE] PatternFile::encode()", pattern, compression, file.bytes.length );
			
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