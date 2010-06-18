package com.ffsys.utils.collections.properties {
	
	import com.ffsys.utils.collections.data.AbstractDataCollection;
	
	/**
	*	Represents a collection of simple properties.
	*	
	*	This collection supports strings, numbers, booleans
	*	objects, arrays and nested property collections.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	dynamic public class PropertyCollection extends AbstractDataCollection
		implements IPropertyCollection {
		
		/**
		*	Creats a <code>PropertyCollection</code> instance.
		*/
		public function PropertyCollection()
		{
			super();
			_types = [ IPropertyCollection, String, Number, Boolean, Object, Array ];
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getPropertyCollectionById(
			id:String ):IPropertyCollection
		{
			var value:IPropertyCollection = getCollectionById( id ) as IPropertyCollection;
			return value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getPropertyById(
			id:String, list:String = null ):Object
		{
			var value:Object = null;
			
			if( list )
			{
				var collection:IPropertyCollection = getPropertyCollectionById( list );
				
				if( collection )
				{
					value = collection.getPropertyById( id );
					
					if( value )
					{
						return value;
					}
					
				}
				
			}
			
			if( _data[ id ] != null )
			{
				return _data[ id ];
			}
			
			if( Object( this ).hasOwnProperty( id ) )
			{
				return this[ id ];
			}
			
			throw new Error(
				"PropertyCollection: could not locate property with id : " + id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStringById(
			id:String, collection:String = null ):String
		{
			return String( getPropertyById( id, collection ) );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getNumberById(
			id:String, collection:String = null ):Number
		{
			return Number( getPropertyById( id, collection ) );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBooleanById(
			id:String, collection:String = null ):Boolean
		{
			return Boolean( getPropertyById( id, collection ) );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getArrayById(
			id:String, collection:String = null ):Array
		{
			//cast slightly differenly on Array
			//to prevent compiler warning
			return getPropertyById( id, collection ) as Array;
		}
	}
}