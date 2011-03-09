package java.util.regex
{
	/**
	* 	An engine that performs match operations on a character
	* 	sequence by interpreting a Rule.
	* 
	* 	A matcher is created from a rule by invoking the rule's matcher method.
	* 	Once created, a matcher can be used to perform three different kinds of match operations:
	* 
	* 	<ul>
	* 		<li>The matches method attempts to match the entire
	* 		input sequence against the pattern.</li>
	* 		<li>The lookingAt method attempts to match the input sequence,
	* 		starting at the beginning, against the pattern.</li>
	* 		<li>The find method scans the input sequence looking for the
	* 		next subsequence that matches the pattern.</li>
	* 	</ul>
	* 
	* 	Each of these methods returns a boolean indicating success or failure.
	* 	More information about a successful match can be obtained by querying
	* 	the state of the matcher.
	* 
	* 	A matcher finds matches in a subset of its input called the region.
	* 	By default, the region contains all of the matcher's input. The region
	* 	can be modified via theregion method and queried via the regionStart
	* 	and regionEnd methods. The way that the region boundaries interact with
	* 	some pattern constructs can be changed. See useAnchoringBounds and
	* 	useTransparentBounds for more details.
	* 
	* 	This class also defines methods for replacing matched subsequences
	* 	with new strings whose contents can, if desired, be computed from the
	* 	match result. The appendReplacement and appendTail methods can be used
	* 	in tandem in order to collect the result into an existing string buffer,
	* 	or the more convenient replaceAll method can be used to create a string
	* 	in which every matching subsequence in the input sequence is replaced.
	* 
	* 	The explicit state of a matcher includes the start and end indices of
	* 	the most recent successful match. It also includes the start and end
	* 	indices of the input subsequence captured by each capturing group in
	* 	the pattern as well as a total count of such subsequences. As a convenience,
	* 	methods are also provided for returning these captured subsequences in string form.
	* 
	* 	The explicit state of a matcher is initially undefined; attempting to
	* 	query any part of it before a successful match will cause an IllegalStateException
	* 	to be thrown. The explicit state of a matcher is recomputed by every match operation.
	* 
	* 	The implicit state of a matcher includes the input character sequence as well
	* 	as the append position, which is initially zero and is updated by the
	* 	appendReplacement method.
	* 
	* 	A matcher may be reset explicitly by invoking its reset() method or,
	* 	if a new input sequence is desired, its reset(CharSequence) method. Resetting a
	* 	matcher discards its explicit state information and sets the append position to zero.
	*/
	public class Matcher extends Object
		implements MatchResult
	{
		private var _ptn:Pattern;
		private var _input:*;
		
		/**
		* 	@private
		* 	
		* 	Creates a <code>Matcher</code> instance.
		* 
		* 	@param ptn The pattern this matcher is using.
		* 	@param input The input to use for matching.
		*/
		public function Matcher( ptn:Pattern, input:* )
		{
			super();
			_ptn = ptn;
			_input = input;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function start( group:int = -1 ):int
		{
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function end( group:int = -1 ):int
		{
			return -1;			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function group( group:int = -1 ):int
		{
			return -1;			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function groupCount():int
		{
			if( _ptn != null )
			{
				return _ptn.groupCount();
			}
			return 0;
		}
	}
}