package com.ffsys.css
{
	import com.ffsys.dom.core.*;
	
	/**
	* 	Represents an identifier selector.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class IdentifierSelector extends Selector
		implements SimpleSelector
	{	
		/**
		* 	Creates a <code>IdentifierSelector</code> instance.
		* 
		* 	@param id The specified identifier.
		*/
		public function IdentifierSelector( id:String = null )
		{
			super();
			this.id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function test( candidate:Node ):Boolean
		{
			return candidate != null && candidate.id == this.id;
		}
		
		/**
		* 	The identifier selector prefix.
		*/
		override public function get prefix():String
		{
			return Selector.IDENTIFIER;
		}
	}
}