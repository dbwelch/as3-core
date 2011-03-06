package java.util.regex
{
	import com.ffsys.w3c.dom.CoreDocumentImpl;
	import com.ffsys.w3c.dom.xml.XMLDocumentImpl;
	
	import javax.xml.namespace.QualifiedName;
	
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
			var nm:String = QualifiedName.toName(
				Pattern.NAMESPACE_PREFIX, Rule.NAME );
			var bean:Object = createElementNS(
				Pattern.NAMESPACE_URI, nm );
					
			trace("[CREATE RULE] PatternDocumentImpl::PatternDocumentImpl()", nm, bean is Rule );
					
			var rule:Rule = bean as Rule;
			if( rule != null )
			{
				trace("[RULE NODE NAME] PatternDocumentImpl::PatternDocumentImpl()",
					rule.nodeName );
				
				if( pattern != null && pattern != "" )
				{
					rule.compile( pattern );
				}
				rule.comment = comment;
			}
			return rule;
		}
		
		/**
		* 	
		*/
		public function createPattern(
			pattern:String,
			comment:String = null ):Pattern
		{
			//TODO: throw exception if pattern is null or the empty string
			
			var ptn:Pattern = Pattern( getDomBean( Pattern.NAME ) );
			ptn.source = pattern;
			ptn.comment = comment;
			return ptn;
		}
	}
}