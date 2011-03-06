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
		implements PatternDocument
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
		* 
		* 	@return The created rule.
		*/
		public function createRule(
			pattern:String = "",
			comment:String = null ):Rule
		{
			var rule:Rule = Rule( getDomBean( Rule.NAME ) );
			if( pattern != null && pattern != "" )
			{
				rule.compile( pattern );
			}
			rule.comment = comment;
			return rule;
		}
		
		/**
		* 	
		*/
		public function createPattern(
			pattern:String,
			comment:String = null ):Pattern
		{
			var ptn:Pattern = Pattern( getDomBean( Pattern.NAME ) );
			ptn.comment = comment;
			return ptn;
		}
	}
}