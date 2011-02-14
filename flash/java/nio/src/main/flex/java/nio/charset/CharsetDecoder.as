package java.nio.charset
{
	
	/**
	* 	An engine that can transform a sequence of bytes
	* 	in a specific charset into a sequence of
	* 	sixteen-bit Unicode characters.
	* 
	* 	<p>The input byte sequence is provided in a
	* 	byte buffer or a series of such buffers.
	* 	The output character sequence is written to
	* 	a character buffer or a series of such buffers.
	* 	A decoder should always be used by making the
	* 	following sequence of method invocations,
	* 	hereinafter referred to as a decoding operation:</p>
	* 
	* 	<ol>
	* 		<li>Reset the decoder via the reset method, unless
	* 		it has not been used before;</li>
	* 		<li>Invoke the decode method zero or more times,
	* 		as long as additional input may be available, passing
	* 		false for the endOfInput argument and filling the input
	* 		buffer and flushing the output buffer between invocations;</li>
	* 		<li>Invoke the decode method one final time, passing true
	* 		for the endOfInput argument; and then</li>
	* 		<li>Invoke the flush method so that the decoder
	* 		can flush any internal state to the output buffer.</li>
	* 	</ol>
	* 
	* 	<p>Each invocation of the decode method will decode as many
	* 	bytes as possible from the input buffer, writing the resulting
	* 	characters to the output buffer. The decode method returns when
	* 	more input is required, when there is not enough room in the
	* 	output buffer, or when a decoding error has occurred. In each
	* 	case a CoderResult object is returned to describe the reason
	* 	for termination. An invoker can examine this object and fill
	* 	the input buffer, flush the output buffer, or attempt to recover
	* 	from a decoding error, as appropriate, and try again.</p>
	* 
	* 	<p>There are two general types of decoding errors. If the
	* 	input byte sequence is not legal for this charset then the
	* 	input is considered malformed. If the input byte sequence is
	* 	legal but cannot be mapped to a valid Unicode character then
	* 	an unmappable character has been encountered.</p>
	* 
	* 	<p>How a decoding error is handled depends upon the action
	* 	requested for that type of error, which is described by an
	* 	instance of the CodingErrorAction class. The possible error
	* 	actions are to ignore the erroneous input, report the error
	* 	to the invoker via the returned CoderResult object, or replace
	* 	the erroneous input with the current value of the replacement
	* 	string. The replacement has the initial value "\uFFFD"; its value
	* 	may be changed via the replaceWith method.</p>
	* 
	* 	<p>The default action for malformed-input and unmappable-character
	* 	errors is to report them. The malformed-input error action may
	* 	be changed via the onMalformedInput method; the unmappable-character
	* 	action may be changed via the onUnmappableCharacter method.</p>
	* 
	* 	<p>This class is designed to handle many of the details of the
	* 	decoding process, including the implementation of error actions.
	* 	A decoder for a specific charset, which is a concrete subclass of
	* 	this class, need only implement the abstract decodeLoop method,
	* 	which encapsulates the basic decoding loop. A subclass that maintains
	* 	internal state should, additionally, override the implFlush and
	* 	implReset methods.</p>
	* 
	* 	<p>Instances of this class are not safe for use by multiple
	* 	concurrent threads.</p>
	*/
	public class CharsetDecoder extends Object
	{		
		/**
		* 	Initializes a new decoder.
		* 
		* 	The new decoder will have the given chars-per-byte values
		* 	and its replacement will be the string "\uFFFD".
		* 
		* 	@param cs The character set.
		* 	@param averageCharsPerByte A positive float value indicating
		* 	the expected number of characters that will be produced
		* 	for each input byte
		* 	@param maxCharsPerByte A positive float value indicating
		* 	the maximum number of characters that will be produced for
		* 	each input byte.
		*/
		public function CharsetDecoder(
			cs:Charset, averageCharsPerByte:Number, maxCharsPerByte:Number )
		{
			super();
		}
	}
}