package com.ffsys.utils.font.parser {
	
	import com.ffsys.io.xml.IParser;
	
	import com.ffsys.utils.font.ITypeFaceManager;
	
	/**
	*	Describes the contract for instances
	*	that can parse the font definition
	*	document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.05.2008
	*/
	public interface ITypeFaceParser
		extends IParser {
		
		/**
		*	Parses the font definition xml document to an
		*	<code>ITypeFaceManager</code> implementation.
		*	
		*	@param x The xml document to parse.
		*	@param target An optional <code>ITypeFaceManager</code>
		*	implementation to parse the data into.
		*	
		*	@return The parsed <code>ITypeFaceManager</code> instance.
		*/
		function parse(
			x:XML, target:ITypeFaceManager = null ):ITypeFaceManager;
	}
}