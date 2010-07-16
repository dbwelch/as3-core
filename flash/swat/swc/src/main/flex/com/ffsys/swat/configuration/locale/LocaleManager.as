package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;	
	
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
			
		private var _propertiesQueue:ILoaderQueue;
		private var _fontsQueue:ILoaderQueue;
		
		/**
		*	Creates a <code>LocaleManager</code> instance.
		*/
		public function LocaleManager()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getPropertiesQueue():ILoaderQueue
		{
			if( !_propertiesQueue )
			{
				_propertiesQueue = new LoaderQueue();
			}
			
			return _propertiesQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getFontsQueue():ILoaderQueue
		{
			if( !_fontsQueue )
			{
				_fontsQueue = new LoaderQueue();
			}
			
			return _fontsQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( value is ILocale )
			{
				addLocale( ILocale( value ) );
			}
		}
	}
}