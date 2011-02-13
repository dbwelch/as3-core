package org.w3c.xml
{
	import com.ffsys.scanner.*;	
	
	/**
	* 	A grammar definition for XML namespaces.
	* 
	* 	<ol>
	* 		<li><pre>NSAttName ::= PrefixedAttName | DefaultAttName</pre></li>
	* 		<li><pre>PrefixedAttName	::= 'xmlns:' NCName	[NSC: Reserved Prefixes and Namespace Names]</pre></li>
	* 		<li><pre>DefaultAttName ::= 'xmlns'</pre></li>
	* 		<li><pre>NCName ::= NCNameStartChar NCNameChar*	#An XML Name, minus the ':'</pre></li>
	* 		<li><pre>NCNameChar ::= NameChar - ':'</pre></li>
	* 		<li><pre>NCNameStartChar	::= NameStartChar - ':'</pre></li>
	* 	</ol>
	* 
	* 	@see http://www.w3.org/TR/2006/REC-xml-names11-20060816/index.html#dt-NSName
	*/
	public class NamespaceGrammar extends Grammar
	{
		
		/**
		* 	Creates a <code>NamespaceGrammar</code> instance.
		*/
		public function NamespaceGrammar()
		{
			super();
		}
		
		/**
		* 	Configures the grammar for XML namespaces.
		* 
		* 	@param grammar The target grammar.
		* 
		* 	@return The configured grammar.
		*/
		override protected function doWithGrammar( grammar:Grammar ):Grammar
		{
			return grammar;
		}
	}
}