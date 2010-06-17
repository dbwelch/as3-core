package com.ffsys.swat.configuration.filters {
	
	import flash.filters.BitmapFilter;
	import flash.utils.Dictionary;
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	/**
	*	Represents a collection of filters stored by identifier
	*	and retrieved by identifier.
	*	
	*	When a filter is retrieved a clone of the original filter
	*	is returned.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class FilterCollection extends Object
		implements 	IFilterCollection,
					IDeserializeProperty {
						
		private var _filters:Dictionary = new Dictionary();
		
		/**
		*	Creates a <code>FilterCollection</code> instance.
		*/
		public function FilterCollection()
		{
			super();
		}
		
		public function removeFilterById( id:String ):Boolean
		{
			var z:String;
			for( z in _filters )
			{
				if( z === id )
				{
					return delete _filters[ z ];
				}
			}
			
			return false;
		}
		
		public function getFilterById(
			id:String ):BitmapFilter
		{
			var filter:IFilterConfiguration = _filters[ id ] as IFilterConfiguration;
			return filter.clone();
		}
		
		public function addFilter( filter:IFilterConfiguration ):Boolean
		{
			//ignore filters with no id
			if( filter && filter.id )
			{
				_filters[ filter.id ] = filter;
				return true;
			}
			return false;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function setDeserializedProperty(
			name:String,
			value:Object ):void
		{
			if( value is IFilterConfiguration )
			{
				var filter:IFilterConfiguration = IFilterConfiguration( value );
				addFilter( filter );
			}
		}
	}
}