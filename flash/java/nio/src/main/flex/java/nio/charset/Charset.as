package java.nio.charset
{
	import java.lang.*;
	import java.nio.*;
	import java.util.*;
	
	/*
	
	Charset

	Description

	US-ASCII		Seven-bit ASCII, a.k.a. ISO646-US, a.k.a. the Basic Latin block of the Unicode character set
	ISO-8859-1  	ISO Latin Alphabet No. 1, a.k.a. ISO-LATIN-1
	UTF-8			Eight-bit UCS Transformation Format
	UTF-16BE		Sixteen-bit UCS Transformation Format, big-endian byte order
	UTF-16LE		Sixteen-bit UCS Transformation Format, little-endian byte order
	UTF-16			Sixteen-bit UCS Transformation Format, byte order identified by an optional byte-order mark	
	
	*/
	
	/**
	* 	A named mapping between sequences of sixteen-bit Unicode
	* 	code units and sequences of bytes.
	* 
	* 	<p>This class defines methods for creating decoders and
	* 	encoders and for retrieving the various names associated
	* 	with a charset. Instances of this class are immutable.</p>
	* 
	* 	<p>This class also defines static methods for testing	
	*	whether a particular charset is supported, for
	* 	locating charset instances by name, and for constructing
	* 	a map that contains every charset for which support is
	* 	available in the current Java virtual machine.
	* 	Support for new charsets can be added via the
	* 	service-provider interface defined in the CharsetProvider class.</p>
	* 
	* 	<p>Charset names</p>
	*
	*	<p>Charsets are named by strings composed of the following characters:</p>
	* 
	* 	<ul>
	* 		<li>The uppercase letters 'A' through 'Z' ('\u0041' through '\u005a'),</li>
	* 		<li>The lowercase letters 'a' through 'z' ('\u0061' through '\u007a'),</li>
	* 		<li>The digits '0' through '9' ('\u0030' through '\u0039'),</li>
	* 		<li>The dash character '-' ('\u002d', HYPHEN-MINUS),</li>
	* 		<li>The period character '.' ('\u002e', FULL STOP),</li>
	* 		<li>The colon character ':' ('\u003a', COLON), and</li>
	* 		<li>The underscore character '_' ('\u005f', LOW LINE).</li>
	* 	</ul>
	* 
	* 	<p>A charset name must begin with either a letter or a digit.
	* 	The empty string is not a legal charset name. Charset names
	* 	are not case-sensitive; that is, case is always ignored
	* 	when comparing charset names. Charset names generally follow
	* 	the conventions documented in RFC 2278: IANA Charset
	* 	Registration Procedures.</p>
	* 
	* 	<p>Every charset has a canonical name and may also have one
	* 	or more aliases. The canonical name is returned by the
	* 	name method of this class. Canonical names are, by convention,
	* 	usually in upper case. The aliases of a charset are
	* 	returned by the aliases method.</p>
	* 
	* 	<p>Some charsets have an historical name that is defined
	* 	for compatibility with previous versions of the Java platform.
	* 	A charset's historical name is either its canonical name
	* 	or one of its aliases. The historical name is returned by
	* 	the getEncoding() methods of the InputStreamReader and
	* 	OutputStreamWriter classes.</p>
	* 
	* 	<p>If a charset listed in the IANA Charset Registry is supported
	* 	by an implementation of the Java platform then its canonical
	* 	name must be the name listed in the registry. Many charsets
	* 	are given more than one name in the registry, in which case
	* 	the registry identifies one of the names as MIME-preferred.
	* 	If a charset has more than one registry name then its canonical
	* 	name must be the MIME-preferred name and the other names in
	* 	the registry must be valid aliases. If a supported charset is
	* 	not listed in the IANA registry then its canonical name must begin
	* 	with one of the strings "X-" or "x-".</p>
	* 
	* 	<p>The IANA charset registry does change over time, and so the
	* 	canonical name and the aliases of a particular charset may
	* 	also change over time. To ensure compatibility it is
	* 	recommended that no alias ever be removed from a charset,
	* 	and that if the canonical name of a charset is changed
	* 	then its previous canonical name be made into an alias.</p>
	* 
	* 	<p>Standard charsets</p>
	* 
	* 	<p>Every implementation of the Java platform is required to
	* 	support the following standard charsets. Consult the release
	* 	documentation for your implementation to see if any other
	* 	charsets are supported. The behavior of such optional charsets
	* 	may differ between implementations.</p>
	* 
	* 	<ul>
	* 		<li>US-ASCII -- Seven-bit ASCII, a.k.a. ISO646-US, a.k.a. the Basic Latin block of the Unicode character set.</li>
	* 		<li>ISO-8859-1 -- ISO Latin Alphabet No. 1, a.k.a. ISO-LATIN-1.</li>
	* 		<li>UTF-8 -- Eight-bit UCS Transformation Format.</li>
	* 		<li>UTF-16BE -- Sixteen-bit UCS Transformation Format, big-endian byte order.</li>
	* 		<li>UTF-16LE -- Sixteen-bit UCS Transformation Format, little-endian byte order.</li>
	* 		<li>UTF-16 -- Sixteen-bit UCS Transformation Format, byte order identified by an optional byte-order mark.</li>
	* 	</ul>
	* 
	* 	<p>The UTF-8 charset is specified by RFC 2279; the transformation
	* 	format upon which it is based is specified in Amendment 2 of
	* 	ISO 10646-1 and is also described in the Unicode Standard.</p>
	* 
	* 	<p>The UTF-16 charsets are specified by RFC 2781; the
	* 	transformation formats upon which they are based are
	* 	specified in Amendment 1 of ISO 10646-1 and are also
	* 	described in the Unicode Standard.</p>
	* 
	* 	<p>The UTF-16 charsets use sixteen-bit quantities and
	* 	are therefore sensitive to byte order. In these encodings
	* 	the byte order of a stream may be indicated by an initial
	* 	byte-order mark represented by the Unicode character '\uFEFF'.
	* 	Byte-order marks are handled as follows:</p>
	* 
	* 	<ul>
	* 		<li>When decoding, the UTF-16BE and UTF-16LE charsets
	* 		ignore byte-order marks; when encoding, they do not
	* 		write byte-order marks.</li>
	* 		<li>When decoding, the UTF-16 charset interprets a
	* 		byte-order mark to indicate the byte order of the 
	* 		stream but defaults to big-endian if there is no
	* 		byte-order mark; when encoding, it uses big-endian
	* 		byte order and writes a big-endian byte-order mark.</li>
	* 	</ul>
	* 
	* 	<p>In any case, when a byte-order mark is read at the beginning
	* 	of a decoding operation it is omitted from the resulting
	* 	sequence of characters. Byte order marks occuring after the first
	* 	element of an input sequence are not omitted since the same code
	* 	is used to represent ZERO-WIDTH NON-BREAKING SPACE.</p>
	* 
	* 	<p>Every instance of the Java virtual machine has a
	* 	default charset, which may or may not be one of the
	* 	standard charsets. The default charset is determined during
	* 	virtual-machine startup and typically depends upon the locale
	* 	and charset being used by the underlying operating system.</p>
	* 
	* 	<p>Terminology</p>
	* 
	* 	<p>The name of this class is taken from the terms used in RFC 2278.
	* 	In that document a charset is defined as the combination of a
	* 	coded character set and a character-encoding scheme.</p>
	* 
	* 	<p>A coded character set is a mapping between a set of
	* 	abstract characters and a set of integers. US-ASCII,
	* 	ISO 8859-1, JIS X 0201, and full Unicode, which is the
	* 	same as ISO 10646-1, are examples of coded character sets.</p>
	* 
	* 	<p>A character-encoding scheme is a mapping between a coded
	* 	character set and a set of octet (eight-bit byte) sequences.
	* 	UTF-8, UCS-2, UTF-16, ISO 2022, and EUC are examples of
	* 	character-encoding schemes. Encoding schemes are often
	* 	associated with a particular coded character set; UTF-8,
	* 	for example, is used only to encode Unicode. Some schemes, however,
	* 	are associated with multiple character sets; EUC, for example,
	* 	can be used to encode characters in a variety of Asian character sets.</p>
	* 
	* 	<p>When a coded character set is used exclusively with a
	* 	single character-encoding scheme then the corresponding
	* 	charset is usually named for the character set; otherwise
	* 	a charset is usually named for the encoding scheme and,
	* 	possibly, the locale of the character sets that it supports.
	* 	Hence US-ASCII is the name of the charset for US-ASCII while
	* 	EUC-JP is the name of the charset that encodes the JIS X 0201,
	* 	JIS X 0208, and JIS X 0212 character sets.</p>
	* 
	* 	<p>The native character encoding of the Java programming
	* 	language is UTF-16. A charset in the Java platform therefore
	* 	defines a mapping between sequences of sixteen-bit UTF-16
	* 	code units and sequences of bytes.</p>
	*/
	public class Charset extends Object
	{	
		static private var _charsets:SortedMap = null;
		
		static private var _encoder:CharsetEncoder;
		static private var _decoder:CharsetDecoder;		
			
		/**
		* 	@private
		*/
		protected var _name:String;
		
		/**
		* 	@private
		*/
		protected var _aliases:Array;
		
		/**
		* 	Creates a <code>Charset</code> instance.
		* 
		* 	@param canonicalName The name of the character set.
		* 	@param aliases A list of alias names for the charset.
		*/
		public function Charset(
			canonicalName:String = null, ... aliases )
		{
			super();
			_name = canonicalName;
			
			var alias:String = null;
			
			if( aliases.length > 0 )
			{
				_aliases = new Array();
			}
			
			for( var i:int = 0;i < aliases.length;i++ )
			{
				alias = aliases[ i ];
				
				//valid string, non-empty
				//and contains non-whitespace characters
				if( alias is String
					&& !/^\s*$/.test( alias ) )
				{
					_aliases.push( alias );
				}
			}
		}
		
		/**
		* 	Constructs a sorted map from canonical charset names
		* 	to charset objects.
		* 
		* 	The map returned by this method will have one entry
		* 	for each charset for which support is available in the
		* 	current Java virtual machine. If two or more supported
		* 	charsets have the same canonical name then the resulting
		* 	map will contain just one of them; which one it will
		* 	contain is not specified.
		* 
		* 	The invocation of this method, and the subsequent use of
		* 	the resulting map, may cause time-consuming disk or
		* 	network I/O operations to occur. This method is provided
		* 	for applications that need to enumerate all of the available
		* 	charsets, for example to allow user charset selection. This
		* 	method is not used by the forName method, which instead
		* 	employs an efficient incremental lookup algorithm.
		* 
		* 	This method may return different results at different
		* 	times if new charset providers are dynamically made
		* 	available to the current Java virtual machine. In the absence
		* 	of such changes, the charsets returned by this method are exactly
		* 	those that can be retrieved via the forName method.
		* 
		* 	@return An immutable, case-insensitive map from canonical
		* 	charset names to charset objects.
		*/
		public static function get availableCharsets():SortedMap
		{
			if( _charsets == null )
			{
				_charsets = new CharacterSets();
			}
			return _charsets;
		}
		
		/**
		* 	Returns a set containing this charset's aliases.
		* 
		* 	@return An immutable set of this charset's aliases.
		*/
		public function get aliases():Set
		{
			return null;
		}
		
		/**
		* 	Returns this charset's canonical name.
		* 
		* 	@return The canonical name of this charset;
		*/
		public function name():String
		{
			return _name;
		}
		
		/**
		* 	Tells whether or not this charset supports encoding.
		* 
		* 	Nearly all charsets support encoding. The primary
		* 	exceptions are special-purpose auto-detect charsets whose
		* 	decoders can determine which of several possible encoding
		* 	schemes is in use by examining the input byte sequence. Such
		* 	charsets do not support encoding because there is no way to
		* 	determine which encoding should be used on output.
		* 	Implementations of such charsets should override this
		* 	method to return false.
		*
		*	@return true if, and only if, this charset supports encoding.
		*/
		public function canEncode():Boolean
		{
			return true;
		}
		
		/**
		* 	Constructs a new encoder for this charset.
		* 
		* 	@throws UnsupportedOperationException If this charset does not support encoding.
		* 
		* 	@return A new encoder for this charset.
		*/
		public function newEncoder():CharsetEncoder
		{
			if( _encoder == null )
			{
				//TODO: create a valid replacement byte array
				return new CharsetEncoder( this, 1, 1, null );
			}
			return _encoder;
		}
		
		/**
		* 	Constructs a new decoder for this charset.
		* 
		* 	@return A new decoder for this charset.
		*/
		public function newDecoder():CharsetDecoder
		{
			if( _decoder == null )
			{
				//TODO: create a valid replacement byte array
				return new CharsetDecoder( this, 1, 1 );
			}
			return _decoder;
		}
		
		/**
		* 	Convenience method that encodes Unicode characters
		* 	into bytes in this charset.
		* 
		* 	An invocation of this method upon a charset cs returns
		* 	the same result as the expression:
		* 
		* 	<pre>cs.newEncoder()
		*     .onMalformedInput(CodingErrorAction.REPLACE)
		*     .onUnmappableCharacter(CodingErrorAction.REPLACE)
		*     .encode(bb);</pre>
		*/
		public function encode( buffer:CharBuffer ):ByteBuffer
		{
			//the length of a charbuffer is in characters and we need
			//the byte length, as we know we are working with 16-bit units
			//in the char buffer we can double the charbuffer length
			var output:ByteBuffer = ByteBuffer.allocate(
				buffer.capacity() * CharsetEncoder.BYTES_PER_CHARACTER );
			var encoder:CharsetEncoder = newEncoder();
			encoder.onMalformedInput( CodingErrorAction.REPLACE );
			encoder.onUnmappableCharacter( CodingErrorAction.REPLACE );
			var result:CoderResult = encoder.encode( buffer, output, true );
			output.position( 0 );
			return output;
		}		
		
		/**
		* 	Convenience method that decodes bytes in this charset
		* 	into Unicode characters.
		* 
		* 	An invocation of this method upon a charset cs returns
		* 	the same result as the expression:
		* 
		* 	<pre>cs.newDecoder()
		*	  .onMalformedInput(CodingErrorAction.REPLACE)
		*	  .onUnmappableCharacter(CodingErrorAction.REPLACE)
		*	  .decode(bb);</pre>
		* 
		* 	Except that it is potentially more efficient because it
		* 	can cache decoders between successive invocations.
		* 
		* 	This method always replaces malformed-input and
		* 	unmappable-character sequences with this charset's
		* 	default replacement byte array. In order to detect
		* 	such sequences, use the CharsetDecoder.decode(java.nio.ByteBuffer)
		* 	method directly.
		*/
		public function decode( buffer:ByteBuffer ):CharBuffer
		{
			var output:CharBuffer = CharBuffer.allocate( 0 );
			_decoder = newDecoder();
			var pos:int = buffer.position();
			buffer.position( 0 );
			_decoder.decode( buffer, output, true );
			buffer.position( pos );
			_decoder = null;
			return output;
		}
		
		/**
		* 	Returns a string representation of this object.
		* 
		* 	@return A string representation of this object.
		*/
		public function toString():String
		{
			var nm:String = MemoryAddress.id( this );
			var output:String = nm + " [" + name() + "]";
			return output;
		}
	}
}