package com.ffsys.utils.reflection.meta {
	
	import com.ffsys.utils.reflection.AbstractReflection;
	
	/**
	*	Encapsulates information contained in a meta data item.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class MetaDataItem extends AbstractReflection {
		
		private var _key:String;
		private var _value:String;
		
		public function MetaDataItem()
		{
			super();
		}
		
		public function set key( val:String ):void
		{
			_key = val;
		}
		
		public function get key():String
		{	
			return _key;
		}
		
		public function set value( val:String ):void
		{
			_value = val;
		}
		
		public function get value():String
		{	
			return _value;
		}		
		
	}
	
}
