package com.ffsys.css
{
	
	/**
	* 	A common type for pseudo selectors.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class PseudoSelector extends Selector
	{
		private var _name:String;
		
		/**
		* 	Creates a <code>PseudoSelector</code> instance.
		* 
		* 	@param name The name of the pseudo class.
		*/
		public function PseudoSelector( name:String = null )
		{
			super();
			this.name = name;
		}
		
		/**
		* 	The name of the pseudo class.
		*/
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
	}
}