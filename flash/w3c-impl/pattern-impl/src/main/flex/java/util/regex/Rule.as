package java.util.regex
{
	/**
	* 	Represents a #ptnlib:term:rule;; a <em>rule</em>
	* 	is synonymous with the entire pattern of a regular expression.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.03.2011
	*/
	public class Rule extends Pattern
	{
		/**
		* 	Creates a <code>Rule</code> instance.
		* 
		* 	@param source The source for the rule.
		* 	@param flags The flags for the rule.
		* 	@param compile Whether this rule should
		* 	be compiled from the specified source.
		*/
		public function Rule(
			source:* = null,
			flags:String = "",
			compile:Boolean = true )
		{
			super( source, compile );
			this.flags = flags;
		}
		
		/**
		* 	The modifiers for this rule.
		* 
		* 	These can include the following:
		* 
		*	g - When using the replace() method of the String class, specify this
		* 	modifier to replace all matches, rather than only the first one.
		*	This modifier corresponds to the global property of the RegExp instance.
		* 
		*	i - The regular expression is evaluated without case sensitivity.
		* 	This modifier corresponds to the ignoreCase property of the RegExp instance.
		* 
		*	s - The dot (.) character matches new-line characters.
		* 	Note This modifier corresponds to the dotall property of the RegExp instance.
		* 
		*	m - The caret (^) character and dollar sign ($) match before and after new-line characters.
		* 	This modifier corresponds to the multiline property of the RegExp instance.
		* 
		*	x - White space characters in the re string are ignored, so that you can write more readable constructors.
		* 	This modifier corresponds to the extended property of the RegExp instance.
		* 
		*	All other characters in the flags string are ignored.
		*/
		public function get flags():String
		{
			var flags:String = "";
			if( global )
			{
				flags += GLOBAL_FLAG;
			}
			if( dotall )
			{
				flags += DOTALL_FLAG;
			}
			if( extended )
			{
				flags += EXTENDED_FLAG;
			}
			if( multiline )
			{
				flags += MULTILINE_FLAG;
			}
			if( ignoreCase )
			{
				flags += IGNORE_CASE_FLAG;
			}						
			return flags;
		}
		
		public function set flags( value:String ):void
		{
			if( value == null )
			{
				value = "";
			}
			value = value.replace( /[^xmigs]/g, "" );
			//regex is invalidated on flag change
			_regex = new RegExp( this.regex.source, value );
		}
	}
}