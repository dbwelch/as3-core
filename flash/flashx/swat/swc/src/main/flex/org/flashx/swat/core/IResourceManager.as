package org.flashx.swat.core
{
	import flash.display.Bitmap;
	import flash.media.Sound;
		
	import org.flashx.core.IDestroy;
	import org.flashx.ioc.IBeanAccess;
	import org.flashx.ioc.IBeanDocument;	
	import org.flashx.ioc.IBeanManager;
	import org.flashx.ui.css.IStyleManager;
	import org.flashx.io.loaders.resources.IResourceList;
	import org.flashx.io.loaders.resources.ResourceNotFound;
	
	import org.flashx.utils.properties.IProperties;
	import org.flashx.utils.properties.Properties;
	
	/**
	*	Describes the contract for resource manager implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IResourceManager
		extends	IDestroy,
		 		IBeanAccess,
				IStyleAccess,
				ISettingAccess,
				IMessageAccess,
				IResourceAccess
	{
		/**
		* 	The style manager used to load the style documents.
		*/
		function get styleManager():IStyleManager;
		function set styleManager( value:IStyleManager ):void;		
		
		/**
		* 	A list of resources that were not found.
		*/
		function get missing():Vector.<ResourceNotFound>;
		
		/**
		* 	The collection of component resources.
		*/
		function get components():Vector.<IComponentResource>;
		
		/**
		* 	Gets a component by identifier.
		* 
		* 	@param id The identifier for the component.
		* 
		* 	@return The component or <code>null</code>
		* 	if no matching component was found.
		*/
		function getComponent( id:String ):Object;
		
		/**
		* 	Gets a component resource by identifier.
		* 
		* 	@param id The identifier for the component.
		* 
		* 	@return The component resource.
		*/	
		function getComponentById( id:String ):IComponentResource;
		
		/**
		* 	The bean manager used to load the bean documents.
		*/
		function get beanManager():IBeanManager;
		function set beanManager( value:IBeanManager ):void;
		
		/**
		* 	The document containing the beans for the application.
		*/
		function get document():IBeanDocument;
		
		/**
		* 	The main resource list being managed.
		*/
		function get list():IResourceList;
		function set list( value:IResourceList ):void;
		
		/**
		* 	The message manager for application messages.
		*/
		function get messages():IProperties;
		
		/**
		* 	The message manager for error messages.
		*/
		function get errors():IProperties;
		
		/**
		* 	The application settings.
		*/
		function get settings():IProperties;
		
		/**
		* 	List of xml resources.
		* 
		* 	This will be <code>null</code> if no xml
		* 	resources have been defined.
		*/
		function get xml():IResourceList;
		
		/**
		* 	List of text resources.
		* 
		* 	This will be <code>null</code> if no text
		* 	resources have been defined.
		*/
		function get text():IResourceList;
		
		/**
		* 	List of bean resources.
		* 
		* 	This will be <code>null</code> if no bean
		* 	resources have been defined.
		*/
		function get beans():IResourceList;
		
		/**
		* 	List of css resources.
		* 
		* 	This will be <code>null</code> if no css
		* 	resources have been defined.
		*/
		function get css():IResourceList;
		
		/**
		* 	List of font resources.
		* 
		* 	This will be <code>null</code> if no font
		* 	resources have been defined.
		*/
		function get fonts():IResourceList;		
		
		/**
		* 	List of rsl resources.
		* 
		* 	This will be <code>null</code> if no rsl
		* 	resources have been defined.
		*/
		function get rsls():IResourceList;
		
		/**
		* 	List of image resources.
		* 
		* 	This will be <code>null</code> if no image
		* 	resources have been defined.
		*/
		function get images():IResourceList;
		
		/**
		* 	List of sound resources.
		* 
		* 	This will be <code>null</code> if no sound
		* 	resources have been defined.
		*/
		function get sounds():IResourceList;
	}
}