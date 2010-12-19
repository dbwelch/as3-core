package com.ffsys.swat.configuration.locale {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.ioc.*;	

	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.ui.css.CssStyleSheet;
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.ui.css.StyleManager;
	import com.ffsys.ui.css.StyleSheetFactory;
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;	
	import com.ffsys.utils.properties.IProperties;
	import com.ffsys.utils.properties.Properties;
	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.rsls.*;
	import com.ffsys.swat.core.ResourceLoadPhase;
	
	
	/**
	*	Manages all the runtime assets for a collection
	*	of locales.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class LocaleManager extends LocaleCollection
		implements ILocaleManager {
			
		static internal var _styleManager:IStyleManager
			= new StyleManager();
			
		static internal var _beanManager:IBeanManager
			= new BeanManager();
		
		private var _lang:String;
		private var _defaultLocale:IConfigurationLocale;
		private var _current:IConfigurationLocale;
		private var _resources:IResourceDefinitionManager;
		private	var _parent:IConfiguration;
		private var _paths:IPaths;
		private var _messages:IProperties;		
		
		//TODO: build these queues every time and do not maintain a reference
		private var _beansQueue:ILoaderQueue;
		private var _messagesQueue:ILoaderQueue;
		private var _errorsQueue:ILoaderQueue;
		private var _fontsQueue:ILoaderQueue;
		private var _rslsQueue:ILoaderQueue;
		private var _cssQueue:ILoaderQueue;
		private var _xmlQueue:ILoaderQueue;
		private var _imagesQueue:ILoaderQueue;
		private var _soundsQueue:ILoaderQueue;
		
		/**
		*	Creates a <code>LocaleManager</code> instance.
		*/
		public function LocaleManager()
		{
			super();
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
			return _beanManager.getBean( beanName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get document():IBeanDocument
		{
			return _beanManager.document;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parent():IConfiguration
		{
			return _parent;
		}
		
		public function set parent( parent:IConfiguration ):void
		{
			_parent = parent;
		}

		/**
		*	@inheritDoc	
		*/
		public function get resources():IResourceDefinitionManager
		{
			return _resources;
		}
		
		public function set resources( value:IResourceDefinitionManager ):void
		{
			_resources = value;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get defaultLocale():IConfigurationLocale
		{
			return _defaultLocale;
		}
		
		public function set defaultLocale( value:IConfigurationLocale ):void
		{
			_defaultLocale = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getQueueByPhase( phase:String ):ILoaderQueue
		{
			var queue:ILoaderQueue = null;
			switch( phase )
			{
				case ResourceLoadPhase.MESSAGES_PHASE:
					queue = getMessagesQueue();
					break;
				case ResourceLoadPhase.ERRORS_PHASE:
					queue = getErrorsQueue();
					break;
				case ResourceLoadPhase.FONTS_PHASE:
					queue = getFontsQueue();
					break;
				case ResourceLoadPhase.RSLS_PHASE:
					queue = getRslsQueue();
					break;
				case ResourceLoadPhase.BEANS_PHASE:
					queue = getBeansQueue();
					break;
				case ResourceLoadPhase.CSS_PHASE:
					queue = getCssQueue();
					break;
				case ResourceLoadPhase.XML_PHASE:
					queue = getXmlQueue();
					break;
				case ResourceLoadPhase.IMAGES_PHASE:
					queue = getImagesQueue();
					break;
				case ResourceLoadPhase.SOUNDS_PHASE:
					queue = getSoundsQueue();
					break;
			}
			return queue;
		}			
		
		/**
		*	@inheritDoc	
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			return getMessageFromQueue(
				getMessagesQueue(), id, replacements );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getError( id:String, ... replacements ):String
		{
			return getMessageFromQueue(
				getErrorsQueue(), id, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			var resource:IResource = getResourceById(
				_imagesQueue, id, ImageResource );
			
			if( resource )
			{
				return new Bitmap(
					ImageResource( resource ).bitmapData );
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			var x:XML = null;
			
			var queue:ILoaderQueue = getXmlQueue();
			var resource:XmlResource = 
				queue.resources.getResourceById( id ) as XmlResource;
				
			if( resource )
			{
				x = resource.xml;
			}
			
			return x;
		}
			
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get stylesheet():ICssStyleSheet
		{
			return _styleManager.stylesheet;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			return _styleManager.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			_styleManager.setStyle( styleName, style );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			var resource:IResource = getResourceById(
				_soundsQueue, id, SoundResource );
			
			if( resource )
			{
				return SoundResource( resource ).sound;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			return _styleManager.getFilter( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get current():IConfigurationLocale
		{
			return _current;
		}
		
		public function set current( value:IConfigurationLocale ):void
		{
			if( value )
			{
				this.lang = value.prefix;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get lang():String
		{
			return _lang;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set lang( lang:String ):void
		{
			_lang = lang;
			
			var parts:Array = null;
			var delimiters:Array = [ "_", "-" ];
			var delimiter:String = null;
			var country:String = null;
			
			if( length == 0 )
			{
				throw new Error(
					"Cannot update the language with no locale data." );
			}
			
			if( lang )
			{
				var selected:ILocale = null;
				var hasDelimiter:Boolean = false;
				
				for( var i:int = 0;i < delimiters.length;i++ )
				{
					delimiter = delimiters[ i ];
					
					hasDelimiter = ( lang.indexOf( delimiter ) > -1 );
					
					if( hasDelimiter )
					{
						parts = lang.split( delimiter );
						selected = getLocaleByLanguageAndCountry(
							parts[ 0 ], parts[ 1 ] );
						break;
					}
				}
				
				if( !hasDelimiter )
				{
					selected = getLocaleByLanguage( lang );
				}

				if( selected )
				{
					_current = IConfigurationLocale( selected ).clone();
				}else{
					throw new Error( "Could not locate locale for language code '" + lang + "'" );
				}
			}
		}
		
		/**
		*	@private
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( hasOwnProperty( name ) )
			{
				this[ name ] = value;
			}else if( value is ILocale )
			{
				addLocale( ILocale( value ) );
			}
		}
		
		/**
		*	@private
		*/
		public function deserialized():void
		{
			if( defaultLocale )
			{
				var exists:Boolean = hasLocale( defaultLocale );
				
				if( !exists )
				{
					throw new Error(
						"The default locale does not exist in the available locales." );
				}
				
				//override the default locale with the loaded locale
				defaultLocale = IConfigurationLocale(
					getLocaleByLanguageAndCountry(
						defaultLocale.lang,
						defaultLocale.country ) );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getMessages():IProperties
		{
			var cumulative:IProperties = new Properties();
			
			//TODO: check - this may need reversin
			var properties:Vector.<IProperties> = getAllProperties( getMessagesQueue() );
			var current:IProperties = null;
			
			//trace("LocaleManager::messages(), ", properties.length );
			
			var z:Object = null;
			for( var i:int = 0;i < properties.length;i++ )
			{
				current = properties[ i ];
				cumulative.merge( current );
				
				/*
				trace("LocaleManager::message(), adding to cumulative ",
					current.length, cumulative.length );
				*/
				
			}	
			return cumulative;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get messages():IProperties
		{
			if( !_messages )
			{
				_messages = getMessages();
			}
			return _messages;
		}
		
		/**
		*	@private
		*/
		private function getAllProperties(
			queue:ILoaderQueue ):Vector.<IProperties>
		{
			var output:Vector.<IProperties> = new Vector.<IProperties>();
			var list:IResourceList = queue.resources;
			var resource:PropertiesResource = null;
			var properties:IProperties = null;
			
			for( var i:int = 0;i < list.length;i++ )
			{
				resource = PropertiesResource( list.getResourceAt( i ) );
				properties = resource.properties;
				if( properties )
				{
					output.push( properties );
				}
			}
			
			return output;
		}	
		
		/**
		*	@private
		*/
		private function getMessageFromQueue(
			queue:ILoaderQueue, id:String, replacements:Array ):String
		{
			var output:String = null;
			var list:IResourceList = queue.resources;
			var resource:PropertiesResource = null;
			var properties:IProperties = null;
			replacements.unshift( id );
			for( var i:int = 0;i < list.length;i++ )
			{
				resource = PropertiesResource( list.getResourceAt( i ) );
				properties = resource.properties;
				
				if( properties )
				{
					output = properties.getProperty.apply(
						properties, replacements );
				
					if( output )
					{
						return output;
					}
				}
			}
			
			return output;
		}
		
		/**
		*	@private	
		*/
		private function getResourceById(
			queue:ILoaderQueue, id:String, type:Class ):IResource
		{
			var output:IResource = null;
			var list:IResourceList = null;
			
			if( queue )
			{
				list = queue.resources;
			}
			
			if( list )
			{
				list = list.getResourcesByType( type );
				output = list.getResourceById( id );
			}
			
			return output;
		}
		
		
		/**
		*	@private	
		*/
		private function getMessagesQueue():ILoaderQueue
		{
			if( !_messagesQueue )
			{
				_messagesQueue = new LoaderQueue();
				
				//add current properties first
				//so they are retrieved first when locating properties
				if( _current 
					&& _current.resources
					&& _current.resources.messages )
				{
					_messagesQueue.append(
						_current.resources.messages.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.resources
					&& defaultLocale.resources.messages )
				{
					_messagesQueue.append(
						defaultLocale.resources.messages.getLoaderQueue() );
				}
				
				if( this.resources && this.resources.messages )
				{
					_messagesQueue.append(
						this.resources.messages.getLoaderQueue() );
				}
			}
			
			return _messagesQueue;
		}
		
		/**
		*	@private	
		*/
		private function getErrorsQueue():ILoaderQueue
		{
			if( !_errorsQueue )
			{
				_errorsQueue = new LoaderQueue();
				
				//add current properties first
				//so they are retrieved first when locating properties
				if( _current
					&& _current.resources
					&& _current.resources.errors )
				{
					_errorsQueue.append(
						_current.resources.errors.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.resources
					&& defaultLocale.resources.errors )
				{
					_errorsQueue.append(
						defaultLocale.resources.errors.getLoaderQueue() );
				}
				
				if( this.resources && this.resources.errors )
				{
					_errorsQueue.append(
						this.resources.errors.getLoaderQueue() );
				}
			}
			
			return _errorsQueue;
		}
		
		/**
		*	@private
		*/
		private function getFontsQueue():ILoaderQueue
		{
			if( !_fontsQueue )
			{
				_fontsQueue = new LoaderQueue();
				
				if( this.resources && this.resources.fonts )
				{
					_fontsQueue.append(
						this.resources.fonts.getLoaderQueue() );
				}
				
				//OVERRIDING WITH DEFAULT LOCALE FONTS CAN CAUSE
				//PROBLEMS WHEN LOADING LOCALE SPECIFC FONTS!
				/*
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.resources
					&& defaultLocale.resources.fonts )
				{
					_fontsQueue.append(
						defaultLocale.resources.fonts.getLoaderQueue() );
				}
				*/
				
				if( _current
					&& _current.resources
					&& _current.resources.fonts )
				{
					_fontsQueue.append(
						_current.resources.fonts.getLoaderQueue() );
				}
			}
			
			return _fontsQueue;
		}
		
		/**
		*	@private
		*/
		private function getRslsQueue():ILoaderQueue
		{
			if( !_rslsQueue )
			{
				_rslsQueue = new LoaderQueue();
				
				if( this.resources && this.resources.rsls )
				{
					_rslsQueue.append(
						this.resources.rsls.getLoaderQueue() );
				}
				
				if( _current
					&& _current.resources
					&& _current.resources.rsls )
				{
					_rslsQueue.append(
						_current.resources.rsls.getLoaderQueue() );
				}
			}
			
			return _rslsQueue;
		}
		
		/**
		*	@private
		*/
		private function getBeansQueue():ILoaderQueue
		{
			if( !_beansQueue )
			{
				_beansQueue = new LoaderQueue();
				if( this.resources && this.resources.beans )
				{
					_beansQueue.append(
						this.resources.beans.getLoaderQueue() );
				}
				if( _current
					&& _current.resources
					&& _current.resources.beans )
				{
					_beansQueue.append(
						_current.resources.beans.getLoaderQueue() );
				}
				
				//massage the css queue so that it uses the style manager
				//for loading, ensuring that style dependencies are resolved
				var loader:ILoader = null;
				for( var i:int = 0;i < _beansQueue.length;i++ )
				{
					loader = ILoader( _beansQueue.getLoaderAt( i ) );
					_beanManager.addBeanDocument( loader.request );
				}
				
				//update our queue with the queue that the
				//style manager will use
				_beansQueue = _beanManager.getLoaderQueue();
			}
			
			return _beansQueue;
		}
		
		/**
		*	@private
		*/
		private function getXmlQueue():ILoaderQueue
		{
			if( !_xmlQueue )
			{
				_xmlQueue = new LoaderQueue();

				if( this.resources && this.resources.xml )
				{
					_xmlQueue.append(
						this.resources.xml.getLoaderQueue() );
				}

				if( _current
					&& _current.resources
					&& _current.resources.xml )
				{
					_xmlQueue.append(
						_current.resources.xml.getLoaderQueue() );
				}
			}

			return _xmlQueue;
		}
		
		/**
		*	@private
		*/
		private function getCssQueue():ILoaderQueue
		{
			if( !_cssQueue )
			{
				_cssQueue = new LoaderQueue();

				if( this.resources && this.resources.css )
				{
					_cssQueue.append(
						this.resources.css.getLoaderQueue() );
				}

				if( _current
					&& _current.resources
					&& _current.resources.css )
				{
					_cssQueue.append(
						_current.resources.css.getLoaderQueue() );
				}
				
			
				//massage the css queue so that it uses the style manager
				//for loading, ensuring that style dependencies are resolved
				var loader:ILoader = null;
				var css:ICssStyleSheet = null;
				for( var i:int = 0;i < _cssQueue.length;i++ )
				{
					loader = ILoader( _cssQueue.getLoaderAt( i ) );
					css = StyleSheetFactory.create();
					if( loader.id )
					{
						css.id = loader.id;
					}
					_styleManager.addStyleSheet( loader.request );
				}
				
				//update our queue with the queue that the
				//style manager will use
				_cssQueue = _styleManager.getLoaderQueue();
			}

			return _cssQueue;
		}
		
		/**
		*	@private
		*/
		private function getImagesQueue():ILoaderQueue
		{
			if( !_imagesQueue )
			{
				_imagesQueue = new LoaderQueue();
				
				if( _current
					&& _current.resources
					&& _current.resources.images )
				{
					_imagesQueue.append(
						_current.resources.images.getLoaderQueue() );
				}				
				
				if( this.resources
					&& this.resources.images )
				{
					_imagesQueue.append(
						this.resources.images.getLoaderQueue() );
				}
			}
			
			return _imagesQueue;
		}
		
		/**
		*	@private
		*/
		private function getSoundsQueue():ILoaderQueue
		{
			if( !_soundsQueue )
			{
				_soundsQueue = new LoaderQueue();
				
				if( _current
					&& _current.resources
					&& _current.resources.sounds )
				{
					_soundsQueue.append(
						_current.resources.sounds.getLoaderQueue() );
				}				
				
				if( this.resources && this.resources.sounds )
				{
					_soundsQueue.append(
						this.resources.sounds.getLoaderQueue() );
				}
			}
			
			return _soundsQueue;
		}		
	}
}