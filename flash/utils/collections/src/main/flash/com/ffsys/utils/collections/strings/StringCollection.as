package com.ffsys.utils.collections.strings {
	
	import com.ffsys.utils.collections.data.AbstractDataCollection;
	
	/**
	*	A collection that encapsulates a set of strings
	*	referenced by identifier.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	dynamic public class StringCollection extends AbstractDataCollection
		implements IStringCollection {
		
		/**
		*	Creates a <code>StringCollection</code> instance.	
		*/
		public function StringCollection()
		{
			var dataTypes:Array = [ IStringCollection, String ];
			super( dataTypes );
		}
		
		public function getStringCollectionById( id:String ):IStringCollection
		{
			var value:IStringCollection = getCollectionById( id ) as IStringCollection;
			return value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function findStringById(
			id:String, list:String ):String
		{
			//deal with accessing specific lists
			var value:String = null;
			
			var collection:IStringCollection = null;
			
			if( list )
			{
				collection = getStringCollectionById( list );
				
				if( collection )
				{
					value = collection.getStringById( id );
					
					if( value )
					{
						return value;
					}
				}
			}
			
			if( _data[ id ] )
			{
				return _data[ id ];
			}
			
			if( Object( this ).hasOwnProperty( id ) )
			{
				return this[ id ];
			}
			
			return value;	
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStringById(
			id:String, list:String = null ):String
		{
			var value:String = findStringById( id, list );

			//look in child collections
			if( !value )
			{
				var collection:IStringCollection = null;
			
				//now try to see whether we can find it in any nested collections
				for( var i:int = 0;i < _collections.length;i++ )
				{
					collection = IStringCollection( _collections[ i ] );
					value = collection.findStringById( id, list );
					if( value )
					{
						return value;
					}
				}
			
			}else
			{
				return value;
			}
			
			throw new Error( "StringCollection: could not locate string with id : " + id );
		}
		
		/*
		*	IObjectInspector implementation.	
		*/		
		override public function getOutputClassName():String
		{
			return "StringCollection";
		}
	}
}