package org.flashx.utils.properties {
	
	import org.flashx.utils.collections.data.IDataCollection;
	
	/**
	*	Describes the contract for implementations that
	*	encapsulate a collection of string properties that
	*	were defined in a properties file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface IProperties extends IDataCollection {
		
		/**
		*	Parses the raw string data for a collection
		*	of properties into this instance.
		*	
		*	@param data The raw properties data.
		*/
		function parse( data:String ):void;
		
		/**
		*	Gets a property by full path identifier.
		*	
		*	@param id The fully qualified path to the property.
		*	@param replacements Replacement values
		*	to use when performing substitution.
		*	
		*	@return The string property or null if no matching
		*	property could be found.
		*/
		function getProperty(
			id:String, ... replacements ):Object;
		
		/**
		*	Gets a properties collection by identifier.
		*	
		*	@param id The identifier for the properties collection.
		*/
		function getPropertiesById( id:String ):IProperties;
		
		/**
		*	Performs string substitution by identifier with the 
		*	specififed target replacements.
		*	
		*	@param id The identifier of the string contained
		*	by this properties collection.
		*	@param replacements The array of replacement values
		*	to use when performing substitution.
		*/
		function substitute(
			id:String, replacements:Array ):String;
	}
}