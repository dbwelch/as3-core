package com.ffsys.w3c.dom.css.support
{
	import javax.script.scanner.Grammar;
	import javax.script.scanner.Scanner;
	
	/**
	* 	Creates a <code>CSSScanner</code> instance.
	*/
	public class CSSScanner extends Scanner
	{
		/**
		* 	Creates a <code>CSSScanner</code> instance.
		* 
		* 	@param whitespace Whether whitespace is preserved.
		* 	@param comments Whether comments are preserved.
		* 	@param grammar A specific grammar to use when scanning,
		* 	if none is specifed the default CSS3Grammar implementation
		* 	will be used.
		*/
		public function CSSScanner(
			whitespace:Boolean = true,
			comments:Boolean = true,
			grammar:Grammar = null )
		{
			super();
			if( grammar == null )
			{
				grammar = CSS3Grammar.newInstance();
			}
			this.grammar = grammar;
		}
	}
}