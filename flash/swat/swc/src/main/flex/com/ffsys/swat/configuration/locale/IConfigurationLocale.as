package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.ILocale;
	
	import com.ffsys.swat.configuration.rsls.IResourceDefinitionManagerAware;
	
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
				IResourceDefinitionManagerAware {
			
		/**
		* 	The parent locale manager.
		*/
		function get parent():ILocaleManager;
		function set parent( manager:ILocaleManager ):void;
		
		
		/**
		* 	Concatenates the <code>lang</code> and
		* 	<code>country</code> using the specified delimiter.
		* 	
		* 	@param delimiter The delimiter to insert between the language and
		* 	country.
		* 	
		* 	@return The language, delimiter and country concatenated.
		*/
		function getPrefix( delimiter:String = "-" ):String;
		
		/**
		* 	Gets the prefix to use when loading locale specific
		* 	resources.
		* 
		* 	If no prefix is specified the <code>lang</code> and
		* 	<code>country</code> codes are returned concatenated
		* 	by a hyphen.
		*/
		function get prefix():String;
		function set prefix( prefix:String ):void;
		
		/**
		* 	Creates a clone of this locale.
		* 
		* 	@return A copy of this locale.
		*/	
		function clone():IConfigurationLocale;
	}
}