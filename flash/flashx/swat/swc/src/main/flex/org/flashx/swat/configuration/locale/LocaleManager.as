package org.flashx.swat.configuration.locale {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import org.flashx.ioc.*;	

	import org.flashx.io.loaders.core.ILoader;
	import org.flashx.io.loaders.core.ILoaderQueue;
	import org.flashx.io.loaders.core.LoaderQueue;
	import org.flashx.io.loaders.resources.*;
	
	import org.flashx.ui.css.*;
	
	import org.flashx.utils.collections.strings.IStringCollection;
	
	import org.flashx.utils.locale.ILocale;
	import org.flashx.utils.locale.LocaleCollection;
	import org.flashx.utils.properties.IProperties;
	import org.flashx.utils.properties.Properties;
	
	import org.flashx.swat.configuration.*;
	import org.flashx.swat.configuration.rsls.*;
	import org.flashx.swat.core.ResourceLoadPhase;
	
	/**
	*	Manages the defined locales for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class LocaleManager extends LocaleCollection
		implements ILocaleManager {
		
		private var _lang:String;
		private var _defaultLocale:IConfigurationLocale;
		private var _current:IConfigurationLocale;
		private var _resources:IResourceDefinitionManager;
		private	var _configuration:IConfigurationElement;
		
		/**
		*	Creates a <code>LocaleManager</code> instance.
		*/
		public function LocaleManager()
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

		public function set configuration( configuration:IConfigurationElement ):void
		{
			_configuration = configuration;
		}		
		
		/**
		* 	The path configuration to be used when resolving resource paths.
		*/
		public function get paths():IPaths
		{
			if( this.configuration != null )
			{
				return this.configuration.paths;
			}
			return null;
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
		public function getQueueByPhase(
			phase:String,
			beanManager:IBeanManager,
			styleManager:IStyleManager ):ILoaderQueue
		{
			//trace("LocaleManager::getQueueByPhase()", phase, this.paths );
			
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
					queue = getBeansQueue( beanManager );
					break;
				case ResourceLoadPhase.CSS_PHASE:
					queue = getCssQueue( styleManager );
					break;
				case ResourceLoadPhase.XML_PHASE:
					queue = getXmlQueue();
					break;
				case ResourceLoadPhase.TEXT_PHASE:
					queue = getTextQueue();
					break;
				case ResourceLoadPhase.SETTINGS_PHASE:
					queue = getSettingsQueue();
					break;
				case ResourceLoadPhase.IMAGES_PHASE:
					queue = getImagesQueue();
					break;
				case ResourceLoadPhase.SOUNDS_PHASE:
					queue = getSoundsQueue();
					break;
				case ResourceLoadPhase.COMPONENTS_PHASE:
					queue = getComponentsQueue();
					break;
			}
			return queue;
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
		*	@private	
		*/
		protected function getMessagesQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.messages )
			{
				queue.append(
					this.resources.messages.getLoaderQueue(
						this.paths, null ) );
			}			
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.messages )
			{
				queue.append(
					defaultLocale.resources.messages.getLoaderQueue(
						this.paths, defaultLocale ) );
			}
			
			if( _current 
				&& _current.resources
				&& _current.resources.messages )
			{
				queue.append(
					_current.resources.messages.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
		
		/**
		*	@private	
		*/
		protected function getErrorsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();	
			if( this.resources && this.resources.errors )
			{
				queue.append(
					this.resources.errors.getLoaderQueue(
						this.paths, null ) );
			}			
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.errors )
			{
				queue.append(
					defaultLocale.resources.errors.getLoaderQueue(
						this.paths, defaultLocale ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.errors )
			{
				queue.append(
					_current.resources.errors.getLoaderQueue(
						this.paths, _current ) );
			}			
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getFontsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();	
			if( this.resources && this.resources.fonts )
			{
				queue.append(
					this.resources.fonts.getLoaderQueue(
						this.paths, null ) );
			}
			
			//OVERRIDING WITH DEFAULT LOCALE FONTS CAN CAUSE
			//PROBLEMS WHEN LOADING LOCALE SPECIFC FONTS!
			/*
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.fonts )
			{
				queue.append(
					defaultLocale.resources.fonts.getLoaderQueue() );
			}
			*/
			
			if( _current
				&& _current.resources
				&& _current.resources.fonts )
			{
				queue.append(
					_current.resources.fonts.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getRslsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.rsls )
			{
				queue.append(
					this.resources.rsls.getLoaderQueue(
						this.paths, null ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.rsls )
			{
				queue.append(
					_current.resources.rsls.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getBeansQueue( manager:IBeanManager ):ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.beans )
			{
				queue.append(
					this.resources.beans.getLoaderQueue(
						this.paths, null ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.beans )
			{
				queue.append(
					_current.resources.beans.getLoaderQueue(
						this.paths, _current ) );
			}
			//massage the beans queue so that it uses the bean manager
			//for loading, ensuring that bean file dependencies are resolved
			var loader:ILoader = null;
			for( var i:int = 0;i < queue.length;i++ )
			{
				loader = ILoader( queue.getLoaderAt( i ) );
				manager.addBeanDocument( loader.request );
			}
			//update our queue with the queue that the
			//bean manager will use
			queue = manager.getLoaderQueue();
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getXmlQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.xml )
			{
				queue.append(
					this.resources.xml.getLoaderQueue(
						this.paths, null ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.xml )
			{
				queue.append(
					_current.resources.xml.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getTextQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.text )
			{
				queue.append(
					this.resources.text.getLoaderQueue(
						this.paths, null ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.text )
			{
				queue.append(
					_current.resources.text.getLoaderQueue(
						this.paths, _current ) );
			}	
			return queue;
		}
		
		/**
		*	@private	
		*/
		protected function getSettingsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			
			//add current properties first
			//so they are retrieved first when locating properties
			if( this.resources
				&& this.resources.settings )
			{
				queue.append(
					this.resources.settings.getLoaderQueue(
						this.paths, null ) );
			}
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.settings )
			{
				queue.append(
					defaultLocale.resources.settings.getLoaderQueue(
						this.paths, defaultLocale ) );
			}

			if( _current 
				&& _current.resources
				&& _current.resources.settings )
			{
				queue.append(
					_current.resources.settings.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getCssQueue( manager:IStyleManager ):ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.css )
			{
				queue.append(
					this.resources.css.getLoaderQueue(
						this.paths, null ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.css )
			{
				queue.append(
					_current.resources.css.getLoaderQueue(
						this.paths, _current ) );
			}
		
			//massage the css queue so that it uses the style manager
			//for loading, ensuring that style dependencies are resolved
			var loader:ILoader = null;
			var css:ICssStyleSheet = null;
			for( var i:int = 0;i < queue.length;i++ )
			{
				loader = ILoader( queue.getLoaderAt( i ) );
				css = StyleSheetFactory.create();
				if( loader.id )
				{
					css.id = loader.id;
				}
				manager.addStyleSheet( loader.request );
			}
			
			//update our queue with the queue that the
			//style manager will use
			return manager.getLoaderQueue();
		}
		
		/**
		*	@private
		*/
		protected function getImagesQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources
				&& this.resources.images )
			{
				queue.append(
					this.resources.images.getLoaderQueue(
						this.paths, null ) );
			}			
			if( _current
				&& _current.resources
				&& _current.resources.images )
			{
				queue.append(
					_current.resources.images.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		protected function getSoundsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.sounds )
			{
				queue.append(
					this.resources.sounds.getLoaderQueue(
						this.paths, null ) );
			}			
			if( _current
				&& _current.resources
				&& _current.resources.sounds )
			{
				queue.append(
					_current.resources.sounds.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}	
		
		/**
		*	@private
		*/
		protected function getComponentsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
					
			if( this.resources
				&& this.resources.components )
			{
				queue.addElements(
					this.resources.components.getLoaderQueue(
						this.paths, null ) );
			}
			if( _current
				&& _current.resources
				&& _current.resources.components )
			{
				queue.addElements(
					_current.resources.components.getLoaderQueue(
						this.paths, _current ) );
			}
			return queue;
		}
	}
}