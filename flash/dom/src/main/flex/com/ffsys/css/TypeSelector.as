package com.ffsys.css
{
	
	/**
	* 	Represents a type selector.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class TypeSelector extends Selector
		implements SimpleSelector
	{
		private var _type:String;
		
		/**
		* 	Creates a <code>TypeSelector</code> instance.
		* 
		* 	@param type The type of element to select.
		*/
		public function TypeSelector( type:String = null )
		{
			super();
			this.type = type;
		}
		
		/**
		* 	The type of element to select.
		*/
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
	}
}