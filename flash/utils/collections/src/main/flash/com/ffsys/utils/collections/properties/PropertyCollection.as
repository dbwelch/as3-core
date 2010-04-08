package com.ffsys.utils.collections.properties {
	
	import com.ffsys.utils.collections.data.AbstractDataCollection;
	
	/**
	*	Concrete implementation of AbstractDataCollection.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	dynamic public class PropertyCollection extends AbstractDataCollection
		implements IPropertyCollection {
		
		public function PropertyCollection()
		{
			var dataTypes:Array = [ IPropertyCollection, String, Number, Boolean, Object, Array ];
			super( dataTypes );
		}
		
		public function getPropertyCollectionById( id:String ):IPropertyCollection
		{
			var value:IPropertyCollection = getCollectionById( id ) as IPropertyCollection;
			return value;
		}
		
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
		
		public function getStringById(
			id:String, collection:String = null ):String
		{
			return String( getPropertyById( id, collection ) );
		}
		
		public function getNumberById(
			id:String, collection:String = null ):Number
		{
			return Number( getPropertyById( id, collection ) );
		}
		
		public function getBooleanById(
			id:String, collection:String = null ):Boolean
		{
			return Boolean( getPropertyById( id, collection ) );
		}
		
		public function getArrayById(
			id:String, collection:String = null ):Array
		{
			//cast slightly differenly on Array
			//to prevent compiler warning
			return getPropertyById( id, collection ) as Array;
		}
	}
}