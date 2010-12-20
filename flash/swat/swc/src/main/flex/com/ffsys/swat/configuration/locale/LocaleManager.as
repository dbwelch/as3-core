package com.ffsys.swat.configuration.locale {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.ioc.*;	

	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.ui.css.*;
	
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
		
		private var _lang:String;
		private var _defaultLocale:IConfigurationLocale;
		private var _current:IConfigurationLocale;
		private var _resources:IResourceDefinitionManager;
		private	var _parent:IConfiguration;
		private var _paths:IPaths;
		private var _messages:IProperties;
		
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
		public function getQueueByPhase(
			phase:String,
			beanManager:IBeanManager,
			styleManager:IStyleManager ):ILoaderQueue
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
		private function getMessagesQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.messages )
			{
				queue.append(
					this.resources.messages.getLoaderQueue() );
			}			
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.messages )
			{
				queue.append(
					defaultLocale.resources.messages.getLoaderQueue() );
			}
			if( _current 
				&& _current.resources
				&& _current.resources.messages )
			{
				queue.append(
					_current.resources.messages.getLoaderQueue() );
			}			
			return queue;
		}
		
		/**
		*	@private	
		*/
		private function getErrorsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();	
			if( this.resources && this.resources.errors )
			{
				queue.append(
					this.resources.errors.getLoaderQueue() );
			}			
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.errors )
			{
				queue.append(
					defaultLocale.resources.errors.getLoaderQueue() );
			}
			if( _current
				&& _current.resources
				&& _current.resources.errors )
			{
				queue.append(
					_current.resources.errors.getLoaderQueue() );
			}			
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getFontsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();	
			if( this.resources && this.resources.fonts )
			{
				queue.append(
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
				queue.append(
					defaultLocale.resources.fonts.getLoaderQueue() );
			}
			*/
			
			if( _current
				&& _current.resources
				&& _current.resources.fonts )
			{
				queue.append(
					_current.resources.fonts.getLoaderQueue() );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getRslsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.rsls )
			{
				queue.append(
					this.resources.rsls.getLoaderQueue() );
			}
			if( _current
				&& _current.resources
				&& _current.resources.rsls )
			{
				queue.append(
					_current.resources.rsls.getLoaderQueue() );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getBeansQueue( manager:IBeanManager ):ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.beans )
			{
				queue.append(
					this.resources.beans.getLoaderQueue() );
			}
			if( _current
				&& _current.resources
				&& _current.resources.beans )
			{
				queue.append(
					_current.resources.beans.getLoaderQueue() );
			}
			//massage the css queue so that it uses the style manager
			//for loading, ensuring that style dependencies are resolved
			var loader:ILoader = null;
			for( var i:int = 0;i < queue.length;i++ )
			{
				loader = ILoader( queue.getLoaderAt( i ) );
				manager.addBeanDocument( loader.request );
			}
			//update our queue with the queue that the
			//style manager will use
			queue = manager.getLoaderQueue();
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getXmlQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.xml )
			{
				queue.append(
					this.resources.xml.getLoaderQueue() );
			}
			if( _current
				&& _current.resources
				&& _current.resources.xml )
			{
				queue.append(
					_current.resources.xml.getLoaderQueue() );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getTextQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.text )
			{
				queue.append(
					this.resources.text.getLoaderQueue() );
			}
			if( _current
				&& _current.resources
				&& _current.resources.text )
			{
				queue.append(
					_current.resources.text.getLoaderQueue() );
			}	
			return queue;
		}
		
		/**
		*	@private	
		*/
		private function getSettingsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			//add current properties first
			//so they are retrieved first when locating properties
			if( _current 
				&& _current.resources
				&& _current.resources.settings )
			{
				queue.append(
					_current.resources.settings.getLoaderQueue() );
			}
			if( defaultLocale
				&& ( defaultLocale != current )
				&& defaultLocale.resources
				&& defaultLocale.resources.settings )
			{
				queue.append(
					defaultLocale.resources.settings.getLoaderQueue() );
			}
			if( this.resources && this.resources.settings )
			{
				queue.append(
					this.resources.settings.getLoaderQueue() );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getCssQueue( manager:IStyleManager ):ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( this.resources && this.resources.css )
			{
				queue.append(
					this.resources.css.getLoaderQueue() );
			}
			if( _current
				&& _current.resources
				&& _current.resources.css )
			{
				queue.append(
					_current.resources.css.getLoaderQueue() );
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
		private function getImagesQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( _current
				&& _current.resources
				&& _current.resources.images )
			{
				queue.append(
					_current.resources.images.getLoaderQueue() );
			}				
			if( this.resources
				&& this.resources.images )
			{
				queue.append(
					this.resources.images.getLoaderQueue() );
			}
			return queue;
		}
		
		/**
		*	@private
		*/
		private function getSoundsQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			if( _current
				&& _current.resources
				&& _current.resources.sounds )
			{
				queue.append(
					_current.resources.sounds.getLoaderQueue() );
			}				
			if( this.resources && this.resources.sounds )
			{
				queue.append(
					this.resources.sounds.getLoaderQueue() );
			}
			return queue;
		}		
	}
}