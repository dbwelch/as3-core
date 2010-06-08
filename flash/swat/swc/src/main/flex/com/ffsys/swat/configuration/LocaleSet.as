package com.ffsys.swat.configuration {
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	/**
	*	Encapsulates the collection of locales for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class LocaleSet extends LocaleCollection
		implements IDeserializeProperty {
		
		/**
		*	Creates a <code>LocaleSet</code> instance.	
		*/
		public function LocaleSet()
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