package org.flashx.io.loaders.types {
	
	import org.flashx.io.loaders.core.ILoader;
	
	import org.flashx.io.xml.IParser;
	
	/**
	*	Describes the contract for parser aware loaders.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public interface IParserAwareXmlLoader
		extends ILoader {
		
		/**
		*	The parser associated with this loader.	
		*/
		function get parser():IParser;
		function set parser( parser:IParser ):void;
		
		/**
		*	A root object that the XML document will be parsed into.
		*	
		*	If this is null then the default root object declared by
		*	the parser will be used.
		*/
		function get root():Object;
		function set root( root:Object ):void;
	}
}