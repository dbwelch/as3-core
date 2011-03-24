package org.flashx.utils.string {
	
	/**
	*	Super class for all
	*	<code>String</code> helper class.
	*	
	*	@see com.ffsys.utils.string.StringConstants
	*	@see com.ffsys.utils.string.StringFormatter
	*	@see com.ffsys.utils.string.StringPad
	*	@see com.ffsys.utils.string.StringRepeater
	*	@see com.ffsys.utils.string.StringStrip
	*	@see com.ffsys.utils.string.StringSubstitutor
	*	@see com.ffsys.utils.string.StringTrim
	*	@see com.ffsys.utils.string.StringUtils
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.02.2008
	*/
	public class StringHelper extends Object {
		
		/**
		*	@private
		*/
		private var _source:String;		
		
		/**
		*	@private
		*/
		public function StringHelper(
			source:String = "" )
		{
			super();
			this.source = source;
		}
		
		/**
		*	The <code>source</code> for this helper.
		*	
		*	Whenever a public method is accessed that
		*	accepts an <code>input</code> parameter,
		*	if the <code>input</code> is not specified
		*	the value of <code>source</code> will be
		*	used instead.
		*/
		public function set source( val:String ):void
		{
			_source = val;
		}
		
		public function get source():String
		{
			return _source;
		}
		
		/**
		*	Splits a <code>String</code> on the
		*	space delimiter and returns an
		*	<code>Array</code> of the words
		*	in the source <code>String</code>.
		*	
		*	@param input The input <code>String</code>.
		*	
		*	@return An <code>Array</code> of the words
		*	in the <code>input</code>.
		*/
		public function words(
			input:String = null ):Array
		{
			if( input == null )
			{
				input = source;
			}
			
			return input.split( StringConstants.SPACE );
		}
		
		/**
		*	Splits a <code>String</code> on the
		*	new line delimiter and returns an
		*	<code>Array</code> of the lines
		*	in the source <code>String</code>.
		*	
		*	@param input The input <code>String</code>.
		*	
		*	@return An <code>Array</code> of the words
		*	in the <code>input</code>.
		*/
		public function lines(
			input:String = null ):Array
		{
			if( input == null )
			{
				input = source;
			}
			
			return input.split( StringConstants.NEWLINE );
		}
	}
}