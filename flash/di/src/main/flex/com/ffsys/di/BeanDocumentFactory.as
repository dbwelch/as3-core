package com.ffsys.di {
	
	/**
	*	Factory class for creating bean document instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.10.2010
	*/
	public class BeanDocumentFactory extends Object {
		
		/**
		*	The default class to instantiate when creating bean stores.
		*/
		public static var beanStoreClass:Class = BeanDocument;
		
		/**
		*	Creates a <code>BeanDocumentFactory</code> instance.
		*/
		public function BeanDocumentFactory()
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
		public static function create( clazz:Class = null ):IBeanDocument
		{
			var storage:Object = null;
			
			if( clazz == null )
			{
				clazz = beanStoreClass;
			}
			
			if( clazz == null )
			{
				throw new ArgumentError( "The bean document factory could not determine the"
					+ " class of bean document to instantiate." );
			}
			
			try
			{
				storage = new clazz();
			}catch( e:Error )
			{
				throw e;
			}
			
			if( !( storage is IBeanDocument ) )
			{
				throw new Error( "The created bean document does not adhere"
					+ " to the bean document contract." );
			}
			
			return IBeanDocument( storage );
		}
	}
}