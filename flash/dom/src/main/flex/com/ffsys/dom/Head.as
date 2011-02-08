package com.ffsys.dom
{
	import com.ffsys.dom.core.*;
	
	/**
	*	A <code>DOM</code> element used to store the
	* 	the meta information about the document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class Head extends Element
	{
		/**
		* 	Creates a <code>Head</code> instance.
		*/
		public function Head( xml:XML = null )
		{
			super( xml );
		}
	}
}