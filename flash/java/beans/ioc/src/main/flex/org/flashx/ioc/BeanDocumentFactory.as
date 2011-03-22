package org.flashx.ioc {
	
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
		*	The default class to instantiate when creating bean documents.
		*/
		public static var documentClass:Class = BeanDocument;
		
		/**
		*	Creates a <code>BeanDocumentFactory</code> instance.
		*/
		public function BeanDocumentFactory()
		{
			super();
		}
		
		/**
		*	Creates a new bean document based on the specified class
		*	parameter. If no class is specified then the bean
		*	sheet class assigned to this factory will be used.
		*	
		*	@param clazz The class of bean document to instantiate.
		*	
		*	@throws ArgumentError An argument error if the specified class is null
		*	or if the bean document class is null.
		*	@throws Error An error if the class could not be instantiated.
		*	@throws Error An error if the instantiated class does not adhere
		*	to the bean document contract.
		*	
		*	@return The created bean document.
		*/
		public static function create( clazz:Class = null ):IBeanDocument
		{
			var document:Object = null;
			if( clazz == null )
			{
				clazz = documentClass;
			}
			
			if( clazz == null )
			{
				throw new ArgumentError( "The bean document factory could not determine the"
					+ " class of bean document to instantiate." );
			}
			try
			{
				document = new clazz();
			}catch( e:Error )
			{
				throw e;
			}
			if( !( document is IBeanDocument ) )
			{
				throw new Error( "The created bean document does not adhere"
					+ " to the bean document contract." );
			}
			return IBeanDocument( document );
		}
	}
}