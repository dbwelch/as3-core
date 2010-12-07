package com.ffsys.ui.data
{
	import flash.display.DisplayObject;
	
	/**
	*	Concrete implementation for a data binding that encapsulates
	* 	a display object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public class DisplayObjectDataBinding extends DataBinding
	{
		/**
		* 	Creates a <code>DisplayObjectDataBinding</code> instance.
		* 
		* 	@param value The display object this data binding encapsulates.
		*/
		public function DisplayObjectDataBinding( value:DisplayObject = null )
		{
			super( value );
		}
		
		/**
		* 	The display object associated with this data binding.
		*/
		public function get value():DisplayObject
		{
			return DisplayObject( this.data );
		}
		
		public function set value( value:DisplayObject ):void
		{
			this.data = value;
		}
	}
}