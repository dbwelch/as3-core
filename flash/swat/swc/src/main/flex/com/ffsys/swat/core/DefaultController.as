package com.ffsys.swat.core
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	import flash.net.URLRequest;

	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.support.xml.IBeanXmlParser;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	
	import com.ffsys.swat.configuration.IConfigurationElement;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	import com.ffsys.swat.configuration.IPaths;	
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	A default controller implementation that can be used at
	* 	a page or component level.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public class DefaultController extends Object
		implements IApplicationController
	{
		private var _resolver:IBeanModuleResolver;
		private var _configuration:IConfigurationElement;
		
		/**
		* 	Creates a <code>DefaultController</code> instance.
		*/
		public function DefaultController()
		{
			super();
		}
	
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfigurationElement
		{
			return _configuration;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set configuration( configuration:IConfigurationElement ):void
		{
			_configuration = configuration;
		}		
		
		/**
		* 	The resolver responsible for determining the name of the
		* 	bean that corresponds to the module.
		*/
		public function get resolver():IBeanModuleResolver
		{
			return _resolver;
		}
		
		public function set resolver( value:IBeanModuleResolver ):void
		{
			_resolver = value;
		}
		
		/**
		* 	Determines whether this controller loads a module.
		* 
		* 	@return Whether this controller loads a module.
		*/
		public function shouldLoadModule():Boolean
		{
			return false;
		}
		
		/**
		* 	Loads a module from a bean definition.
		* 
		* 	@param beanName The name of the bean that defines the module.
		* 
		* 	@return The loader queue handling the module load process.
		*/
		public function loadModuleBean( beanName:String = null ):ILoaderQueue
		{
			if( beanName == null )
			{
				if( resolver != null )
				{
					beanName = resolver.resolve( this );
				}
			}
			
			if( beanName == null )
			{
				throw new Error( "Cannot load a module using a null bean name." );
			}
			
			return null;
		}
		
		/**
		* 	Loads a module from a url request.
		* 
		* 	@param request The url request.
		* 
		* 	@return The loader queue handling the module load process.
		*/
		public function loadModule( request:URLRequest ):ILoaderQueue
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			verifyConfiguration();
			return this.configuration.styleManager;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getComponent( id:String ):Object
		{
			verifyConfiguration();
			return this.configuration.getComponent( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getComponentById( id:String ):IComponentResource
		{
			verifyConfiguration();
			return this.configuration.getComponentById( id );
		}
		
		/**
		* 	Provides access to stored beans.
		* 
		* 	@param beanName The name of the bean.
		* 
		* 	@return An instance of the bean.
		*/
		public function getBean( beanName:String ):Object
		{
			verifyConfiguration();
			return this.configuration.getBean( beanName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			verifyConfiguration();
			return this.configuration.flashvars;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			verifyConfiguration();
			return this.configuration.getFilter( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			verifyConfiguration();
			replacements.unshift( id );
			return this.configuration.getMessage.apply(
				this.configuration, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getError( id:String, ... replacements ):String
		{
			verifyConfiguration();
			replacements.unshift( id );
			return this.configuration.getError.apply(
				this.configuration, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			verifyConfiguration();
			return this.configuration.getImage( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			verifyConfiguration();
			return this.configuration.getXmlDocument( id );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get stylesheet():ICssStyleSheet
		{
			verifyConfiguration();
			return this.configuration.stylesheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			verifyConfiguration();
			return this.configuration.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			verifyConfiguration();
			this.configuration.setStyle( styleName, style );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			verifyConfiguration();
			return this.configuration.getSound( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLocalePath(
			path:String,
			locale:IConfigurationLocale = null ):String
		{
			verifyConfiguration();
			if( locale == null )
			{
				locale = configuration.locales.current;
			}
			var paths:IPaths = configuration.paths;
			var out:String = paths.join(
				[ paths.getLocalePath( locale ) ], path );
			return out;
		}
		
		/**
		* 	Override this method to specify a parser implementation
		* 	to use when parsing view documents.
		* 
		* 	@return A parser implementation to use when retrieving
		* 	view component documents.
		*/
		protected function getViewParser():IBeanXmlParser
		{
			return null;
		}
		
		/**
		* 	Gets the bean document from the bean parser
		* 	used to parse view documents.
		* 
		* 	@return The view bean document.
		*/
		protected function getViewDocument():IBeanDocument
		{
			var parser:IBeanXmlParser = getViewParser();
			if( parser != null )
			{
				return parser.document;
			}
			return null;
		}
		
		/**
		* 	Performs actions on a bean document used when loading
		* 	a view component.
		* 
		* 	The default implementation ensures that view bean
		* 	documents have access to the other bean documents
		* 	via cross references.
		* 
		* 	@param document The view component bean document.
		* 	@param component The component resource that encapsulates
		* 	the view definition.
		*/
		protected function doWithViewBeans(
			document:IBeanDocument,
			component:IComponentResource ):void
		{
			verifyConfiguration();
			
			//TODO: add xrefs to the component bean document
			
			trace("::::::::::::>>>>>>>>>>>>>>>>>>>>>>>>> DefaultController::doWithViewBeans()",
				document,
				this.configuration.resources.document,
				this.configuration.resources.document.id );
			
			var xrefs:Vector.<IBeanDocument> = new Vector.<IBeanDocument>();
			var main:IBeanDocument = this.configuration.resources.document;
			if( main != null )
			{
				xrefs = main.xrefs.slice();
				xrefs.push( main );
			}
			
			var xref:IBeanDocument = null;
			for( var i:int = 0;i < xrefs.length;i++ )
			{
				xref = xrefs[ i ];
				if( document.xrefs.indexOf( xref ) == -1 )
				{
					trace("DefaultController::doWithViewBeans()", "ADDING DOCUMENT XREF", xref, xref.id );
					document.xrefs.push( xref );
				}
			}
			
			//add component beans as available to the view document
			if( component.document != null
				&& document.xrefs.indexOf( component.document ) == -1 )
			{
				trace("DefaultController::getViewDocument()", "ADDING COMPONENT BEANS TO VIEW BEANS!?!!?!?!?!?!?!?!?!?" );
				document.xrefs.push( component.document );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getView( id:String, ...bindings ):DisplayObject
		{
			verifyConfiguration();
			
			var parser:IBeanXmlParser = getViewParser();
			if( parser == null )
			{
				throw new Error(
					"Cannot retrieve a view with no valid view parser." );
			}
			
			var componentResource:IComponentResource = 
				getComponentById( id );
				
			//no matching component
			if( componentResource == null )
			{
				return null;
			}
			
			var component:XML = componentResource.target as XML;
			if( component == null )
			{
				throw new Error(
					"Could not retrieve a view component with identifier '"
					 + id + "'." );
			}
			
			var bindingMethod:Function = parser[ "addDocumentBindings" ] as Function;
			
			if( bindingMethod != null )
			{
				//use the default runtime document assigned to the parser
				bindings.unshift( null );
				bindingMethod.apply( parser, bindings );
			}
			
			trace("DefaultController::getView()", "BINDING METHOD: ", bindingMethod );
			
			var beans:IBeanDocument = parser.document;
			if( beans != null )
			{
				doWithViewBeans( beans, componentResource );
			}
			
			var document:Object = parser.deserialize( component );
			
			trace("DefaultController::getView()", id, document );
			
			return document as DisplayObject;
		}
		
		/**
		* 	Clean the references stored by this application.
		*/
		public function destroy():void
		{
			_configuration = null;
		}
		
		/**
		*	@private
		*/
		private function verifyConfiguration():void
		{
			if( this.configuration == null )
			{
				throw new Error(
					"Cannot access configuration data with a null configuration,"
					+ "you need to inject a configuration bean." );
			}
		}			
	}
}