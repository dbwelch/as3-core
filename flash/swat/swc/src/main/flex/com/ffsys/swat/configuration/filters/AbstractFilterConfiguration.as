package com.ffsys.swat.configuration.filters {
	
	import flash.filters.BitmapFilter;
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	import com.ffsys.utils.properties.PropertiesMerge;
	
	/**
	*	Abstract super class for all filter configurations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class AbstractFilterConfiguration extends Object
		implements  IFilterConfiguration,
		 			IDeserializeProperty {
		
		private var _id:String;
		private var _properties:Object;
		
		/**
		*	Creates an <code>AbstractFilterConfiguration</code> instance.
		*	
		*	@param id The identifier for the filter configuration.
		*/
		public function AbstractFilterConfiguration( id:String = null )
		{
			super();
			_properties = new Object();
			this.id = id;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get properties():Object
		{
			return _properties;
		}
		
		public function set properties( properties:Object ):void
		{
			_properties = properties;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getFilterClass():Class
		{
			throw new Error( "You must implement getFilterClass() in your concrete implementation." );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function clone():BitmapFilter
		{
			var clazz:Class = getFilterClass();
			var filter:BitmapFilter = null;
			try
			{
				filter = BitmapFilter( new clazz() );
			}catch( e:Error )
			{
				throw new Error( "Could not instantiate the target bitmap filter." );
			}
			
			var merger:PropertiesMerge = new PropertiesMerge();
			merger.merge( filter, properties );
			
			return filter;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function setDeserializedProperty(
			name:String,
			value:Object ):void
		{
			this.properties[ name ] = value;
		}
	}
}