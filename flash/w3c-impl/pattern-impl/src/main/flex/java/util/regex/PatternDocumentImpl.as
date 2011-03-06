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
				
			trace("[RULE NAME] PatternDocumentImpl::createRule()", nm );
				
			var bean:Object = createElementNS(
				Pattern.NAMESPACE_URI, nm );
				
			trace("[GOT BEAN] PatternDocumentImpl::createRule()", bean, rule );				
		
			var rule:Rule = bean as Rule;
			
			trace("[CREATED RULE] PatternDocumentImpl::createRule()", bean, rule );
			
			if( rule != null )
			{
				if( pattern != null && pattern != "" )
				{
					rule.compile( pattern );
				}
				
				if( comment != null && comment != "" )
				{
					rule.comment = comment;
				}
			}
			return rule;
		}
		
		/**
		* 	
		*/
		public function createPattern(
			pattern:String = null,
			comment:String = null ):Pattern
		{	
			var nm:String = QualifiedName.toName(
				Pattern.NAMESPACE_PREFIX, Pattern.NAME );
			var bean:Object = createElementNS(
				Pattern.NAMESPACE_URI, nm );	
						
			//TODO: throw exception if pattern is null or the empty string
			
			var ptn:Pattern = bean as Pattern;
			
			trace("[PTN] PatternDocumentImpl::createPattern()", ptn );
			
			if( ptn != null )
			{
				if( pattern != null && pattern != "" )
				{
					ptn.source = pattern;
				}
				if( comment != null && comment != "" )
				{
					ptn.comment = comment;
				}
			}
			return ptn;
		}
	}
}