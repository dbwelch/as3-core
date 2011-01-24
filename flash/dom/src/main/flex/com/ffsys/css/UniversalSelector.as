package com.ffsys.css
{
	
	/**
	* 	Represents the universal selector.
	* 
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class UniversalSelector extends TypeSelector
	{
		/**
		* 	Creates a <code>UniversalSelector</code> instance.
		*/
		public function UniversalSelector()
		{
			super( Selector.UNIVERSAL );
		}
		
		/**
		* 	Enforces the type contract for the universal
		* 	type selector.
		*/
		override public function get type():String
		{
			return Selector.UNIVERSAL;
		}
	}
}