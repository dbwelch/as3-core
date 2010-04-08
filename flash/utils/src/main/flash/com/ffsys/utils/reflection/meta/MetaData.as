package com.ffsys.utils.reflection.meta {
	
	import com.ffsys.utils.reflection.AbstractReflectionCollection;
	
	/**
	*	Encapsulates meta data associated with a member of an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class MetaData extends AbstractReflectionCollection {
		
		private var _name:String;
		
		public function MetaData()
		{
			super();
		}
		
		/**
		*	@private
		*/
		public function set arg( val:MetaDataItem ):void
		{
			push( val );
		}
		
		/**
		*	@private
		*/
		public function get arg():MetaDataItem
		{
			return null;
		}
		
		//-->
		
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return null;
		}		
		
	}
	
}
