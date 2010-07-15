package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
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