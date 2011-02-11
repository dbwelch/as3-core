package org.w3c.dom
{
	
	/**
	* 	Represents a processing instruction.
	* 
	* 	The ProcessingInstruction interface
	* 	represents a "processing instruction",
	* 	used in XML as a way to keep processor-specific
	* 	information in the text of the document.
	*
	*	No lexical check is done on the content of a
	* 	processing instruction and it is therefore
	* 	possible to have the character sequence <code>?&gt;"</code>
	* 	in the content, which is illegal a processing 
	* 	instruction per section 2.6 of [XML 1.0]. The
	* 	presence of this character sequence must generate
	* 	a fatal error during serialization.
	*/
	public interface ProcessingInstruction extends Node
	{
		/**
		* 	The target of this processing instruction.
		* 
		* 	XML defines this as being the first token
		* 	following the markup that begins the processing instruction.
		*/
		function get target():String;
		
		/**
		* 	The content of this processing instruction.
		* 	
		* 	This is from the first non white space character
		* 	after the target to the character immediately
		* 	preceding the <code>?&gt;</code>.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR: Raised 
		* 	when the node is readonly.
		*/
		function get data():String;
		function set data( value:String ):void
	}
}