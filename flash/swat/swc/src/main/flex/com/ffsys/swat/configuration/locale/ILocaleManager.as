package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocaleCollection;
	import com.ffsys.io.xml.IDeserializeProperty;
	
	/**
	*	Describes the contract for implementations
	*	that manage the available locales for the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface ILocaleManager
		extends ILocaleCollection,
		 		IDeserializeProperty {
		
	}
}