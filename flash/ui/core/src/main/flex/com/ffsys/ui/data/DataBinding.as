package com.ffsys.ui.data
{
	import com.ffsys.ui.core.IComponent;
	
	/**
	*	Abstract super class for data binding implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class DataBinding extends Object
	{
		/**
		* 	@private
		*/
		protected var _data:Object;
		
		/**
		* 	Creates a <code>DataBinding</code> instance.
		* 
		* 	@param data The data encapsulated by this data binding.
		*/
		public function DataBinding( data:Object = null )
		{
			super();
			_data = data;
		}
		
		/**
		* 	The data that this data binding encapsulates.
		*/
		public function get data():Object
		{
			return _data;
		}
	}
}