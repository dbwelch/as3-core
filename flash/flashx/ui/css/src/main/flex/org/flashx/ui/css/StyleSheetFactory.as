package org.flashx.ui.css {
	
	/**
	*	Factory class for creating style sheets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.10.2010
	*/
	public class StyleSheetFactory extends Object {
		
		/**
		*	The default class to instantiate when creating style sheets.
		*/
		public static var styleSheetClass:Class = CssStyleSheet;
		
		/**
		*	Creates a <code>StyleSheetFactory</code> instance.
		*/
		public function StyleSheetFactory()
		{
			super();
		}
		
		/**
		*	Creates a new style sheet based on the specified class
		*	parameter. If no class is specified then the style
		*	sheet class assigned to this factory will be used.
		*	
		*	@param clazz The class of style sheet to instantiate.
		*	
		*	@throws An argument error if the specified class is null
		*	and the style sheet class is null.
		*	@throws An error if the class could not be instantiated.
		*	@throws An error if the instantiated class does not adhere
		*	to the style sheet contract.
		*	
		*	@return The created style sheet.
		*/
		public static function create( clazz:Class = null ):ICssStyleSheet
		{
			var sheet:Object = null;
			
			if( clazz == null )
			{
				clazz = styleSheetClass;
			}
			
			if( clazz == null )
			{
				throw new ArgumentError( "The style factory could not determine the"
					+ " class of style sheet to instantiate." );
			}
			
			try
			{
				sheet = new clazz();
			}catch( e:Error )
			{
				throw e;
			}
			
			if( !( sheet is ICssStyleSheet ) )
			{
				throw new Error( "The created style sheet does not adhere"
					+ " to the style sheet contract." );
			}
			
			return ICssStyleSheet( sheet );
		}
	}
}