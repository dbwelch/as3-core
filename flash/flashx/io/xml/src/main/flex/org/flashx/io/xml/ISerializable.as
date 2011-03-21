package org.flashx.io.xml {
	
	import org.flashx.core.IStringIdentifier;
	import org.flashx.io.xml.Serializer;
	
	/**
	*	Describes the contract for 
	*	objects that can be serialized as XML.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.05.2007
	*/
	public interface ISerializable extends IStringIdentifier {
		function serialize( serializer:Serializer = null ):XML;
	}
}