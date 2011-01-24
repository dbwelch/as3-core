package com.ffsys.css
{
	/**
	* 	Represents a pseudo class selector.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class PseudoClassSelector extends PseudoSelector
		implements SimpleSelector
	{
		/**
		* 	Creates a <code>PseudoClassSelector</code> instance.
		* 
		* 	@param name The name of the pseudo class.
		*/
		public function PseudoClassSelector( name:String = null )
		{
			super( name );
		}
	}
}