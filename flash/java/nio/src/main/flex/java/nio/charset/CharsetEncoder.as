package java.nio.charset
{
	import flash.utils.ByteArray;
	
	/**
	* 	An engine that can transform a sequence of sixteen-bit
	* 	Unicode characters into a sequence of bytes in a
	* 	specific charset.
	* 
	* 	<p>The input character sequence is provided in a
	* 	character buffer or a series of such buffers.
	* 	The output byte sequence is written to a byte
	* 	buffer or a series of such buffers. An encoder
	* 	should always be used by making the following
	* 	sequence of method invocations, hereinafter referred
	* 	to as an encoding operation:</p>
	* 
	* 	<ol>
	* 		<li>Reset the encoder via the reset method, unless
	* 		it has not been used before;</li>
	* 		<li>Invoke the encode method zero or more times, as
	* 		long as additional input may be available, passing
	* 		false for the endOfInput argument and filling the input
	* 		buffer and flushing the output buffer between invocations;</li>
	* 		<li>Invoke the encode method one final time, passing
	* 		true for the endOfInput argument; and then</li>
	* 		<li>Invoke the flush method so that the encoder can
	* 		flush any internal state to the output buffer.</li>
	* 	</ol>
	* 
	* 	<p>Each invocation of the encode method will encode
	* 	as many characters as possible from the input buffer,
	* 	writing the resulting bytes to the output buffer. The
	* 	encode method returns when more input is required, when
	* 	there is not enough room in the output buffer, or when
	* 	an encoding error has occurred. In each case a CoderResult
	* 	object is returned to describe the reason for termination.
	* 	An invoker can examine this object and fill the input buffer,
	* 	flush the output buffer, or attempt to recover from an
	* 	encoding error, as appropriate, and try again.</p>
	* 
	* 	<p>There are two general types of encoding errors. If the
	* 	input character sequence is not a legal sixteen-bit Unicode
	* 	sequence then the input is considered malformed. If the input
	* 	character sequence is legal but cannot be mapped to a valid
	* 	byte sequence in the given charset then an unmappable
	* 	character has been encountered.</p>
	* 
	* 	<p>How an encoding error is handled depends upon the action
	* 	requested for that type of error, which is described by an
	* 	instance of the CodingErrorAction class. The possible error
	* 	actions are to ignore the erroneous input, report the error
	* 	to the invoker via the returned CoderResult object, or replace
	* 	the erroneous input with the current value of the replacement
	* 	byte array. The replacement is initially set to the encoder's
	* 	default replacement, which often (but not always) has the
	* 	initial value { (byte)'?' }; its value may be changed via
	* 	the replaceWith method.</p>
	* 
	* 	<p>The default action for malformed-input and unmappable-character
	* 	errors is to report them. The malformed-input error action may
	* 	be changed via the onMalformedInput method; the unmappable-character
	* 	action may be changed via the onUnmappableCharacter method.</p>
	* 
	* 	<p>This class is designed to handle many of the details of the
	* 	encoding process, including the implementation of error actions.
	* 	An encoder for a specific charset, which is a concrete subclass
	* 	of this class, need only implement the abstract encodeLoop method,
	* 	which encapsulates the basic encoding loop. A subclass that maintains
	* 	internal state should, additionally, override the implFlush and
	* 	implReset methods.</p>
	* 
	* 	<p>Instances of this class are not safe for use by multiple
	* 	concurrent threads.</p>
	*/
	public class CharsetEncoder extends Object
	{
		private var _charset:Charset;
		
		/**
		* 	Creates a <code>CharsetEncoder</code> instance.
		* 
		* 	The new encoder will have the given bytes-per-char
		* 	and replacement values.
		* 
		* 	@param cs The target character set.
		* 	@param averageBytesPerChar A positive float value indicating
		* 	the expected number of bytes that will be produced for
		* 	each input character.
		* 	@param maxBytesPerChar A positive float value indicating the
		* 	maximum number of bytes that will be produced for each input character.
		* 	@param replacement The initial replacement; must not be null, must
		* 	have non-zero length, must not be longer than maxBytesPerChar,
		* 	and must be legal.
		*/
		public function CharsetEncoder(
			cs:Charset,
			averageBytesPerChar:uint,
			maxBytesPerChar:uint,
			replacement:ByteArray )
		{
			super();
			_charset = cs;
		}
		
		public function get charset():Charset
		{
			return _charset;
		}
		
		public function reset():CharsetEncoder
		{
			return this;
		}
	}
}