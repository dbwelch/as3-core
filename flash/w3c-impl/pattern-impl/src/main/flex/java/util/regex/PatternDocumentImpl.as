package java.util.regex
{
	import com.ffsys.w3c.dom.CoreDocumentImpl;
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;	
	
	/**
	* 	Represents a document of #ptnlib:term:rule;(s).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.03.2011
	*/
	public class PatternDocumentImpl extends XMLDocumentImpl
	{
		/**
		* 	The bean name for a pattern document.
		*/
		public static const NAME:String = "#pattern";
		
		/**
		* 	Creates a <code>PatternDocumentImpl</code> instance.
		*/
		public function PatternDocumentImpl()
		{
			super();
		}
		
		/**
		* 	Creates a Rule from the specified pattern.
		* 
		* 	@param pattern The source pattern.
		* 	@param comment An optional comment for the rule.
		*/
		public function createRule(
			pattern:String = "",
			comment:String = null ):Rule
		{
			//TODO
			return null;
		}
		
		/**
		* 	
		*/
		public function createPattern(
			pattern:String,
			comment:String = null ):void
		{
			//
		}
	}
}