package org.flashx.utils.collections.strings {
	
	import org.flashx.utils.locale.ILocale;
	
	/**
	*	A string collection that is aware of a current locale
	*	and only attempts to locate strings within the string
	*	collection that represents the current locale.
	*	
	*	Note that the <code>locale</code> assigned to this
	*	collection determines the current locale that should be used
	*	when extracting strings by locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.04.2010
	*/
	public class LocaleAwareStringCollection
		extends StringCollection {
		
		/**
		*	Creates a <code>LocaleAwareStringCollection</code> instance.
		*/
		public function LocaleAwareStringCollection()
		{
			super();
		}
		
		/**
		*	Overriden so that strings are always searched for in the appropriate
		*	locale specific child collection. If no locale is assigned we will search
		*	normally.
		*/
		override public function getStringById(
			id:String, list:String = null ):String
		{
			if( this.locale )
			{
				var child:IStringCollection = getChildStringCollectionByLocale(
					this.locale );
					
				if( !child )
				{
					//this will happen if the locale assigned to this collection
					//does not correspond to the locale of a child string collection
					throw new Error( "Attempt to locate a locale specific"
						+ " string with no locale string collection defined." );
				}
				
				return child.getStringById( id, list );
			}else{
				return super.getStringById( id, list );
			}
			
			return null;
		}
		
		/**
		*	Attempts to locale a child string collection based on the locale
		*	assigned to this collection.
		*	
		*	@param locale The locale to search with.
		*	
		*	@return A locale specific string collection or null if none could be found.
		*/
		public function getChildStringCollectionByLocale( locale:ILocale ):IStringCollection
		{
			if( locale == null )
			{
				throw new Error(
					"A locale must be specified in order to find the appropriate string collection." );
			}
			
			var child:IStringCollection = null;
			
			for( var i:int = 0;i < children.length;i++ )
			{
				child = IStringCollection( children[ i ] );
				if( child.locale == locale || ( child.locale.equals( locale ) ) )
				{
					return child;
				}
			}
			
			return null;
		}
	}
}