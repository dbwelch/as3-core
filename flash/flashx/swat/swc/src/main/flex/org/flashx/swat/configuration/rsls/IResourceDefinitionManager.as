package org.flashx.swat.configuration.rsls {
	
	import org.flashx.swat.configuration.rsls.IResourceCollection;
	import org.flashx.swat.configuration.locale.IConfigurationLocale;	
	
	/**
	*	Describes the contract for implementations that encapsulate
	*	the resource collections for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2010
	*/
	public interface IResourceDefinitionManager
		extends IResourceDefinitionElement {
		
		/**
		*	The collection of bean files.
		*/
		function get beans():IResourceCollection;
		function set beans( value:IResourceCollection ):void;
		
		/**
		*	The collection of message properties files.
		*/
		function get messages():IResourceCollection;
		function set messages( value:IResourceCollection ):void;
		
		/**
		*	The collection of error properties files.
		*/
		function get errors():IResourceCollection;
		function set errors( value:IResourceCollection ):void;
		
		/**
		*	The collection of font files.
		*/
		function get fonts():IResourceCollection;
		function set fonts( value:IResourceCollection ):void;
		
		/**
		*	The collection of runtime shared library resources.
		*/
		function get rsls():IResourceCollection;
		function set rsls( rsls:IResourceCollection ):void;
		
		/**
		*	The collection of CSS resources.
		*/
		function get css():IResourceCollection;
		function set css( css:IResourceCollection ):void;		
		
		/**
		*	The collection of image resources.
		*/
		function get images():IResourceCollection;
		function set images( rsls:IResourceCollection ):void;
		
		/**
		*	The collection of XML resources.
		*/
		function get xml():IResourceCollection;
		function set xml( rsls:IResourceCollection ):void;
		
		/**
		*	The collection of text resources.
		*/
		function get text():IResourceCollection;
		function set text( text:IResourceCollection ):void;
		
		/**
		*	The collection of settings resources.
		*/
		function get settings():IResourceCollection;
		function set settings( text:IResourceCollection ):void;
		
		/**
		*	The collection of sound resources.
		*/
		function get sounds():IResourceCollection;
		function set sounds( rsls:IResourceCollection ):void;
		
		/**
		*	A collection of component resources.
		*/
		function get components():IResourceCollection;
		function set components( value:IResourceCollection ):void;
	}
}