package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	
	/**
	*	Describes the contract for implementations
	*	that extend the default locale data and encapsulate
	*	additional configurartion information for the locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface IConfigurationLocale
		extends ILocale,
				IResourceCollectionAware {

	}
}