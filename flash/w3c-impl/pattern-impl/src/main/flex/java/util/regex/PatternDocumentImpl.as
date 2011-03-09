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
		* 	@inheritDoc
		*/
		public function createRule(
			pattern:String = "",
			comment:String = null ):Rule
		{
			var nm:String = QualifiedName.toName(
				Pattern.NAMESPACE_PREFIX, Rule.NAME );	
			var bean:Object = createElementNS(
				Pattern.NAMESPACE_URI, nm );
			var rule:Rule = bean as Rule;
			if( rule != null )
			{
				if( comment != null && comment != "" )
				{
					rule.comment = comment;
				}					
				if( pattern != null && pattern != "" )
				{
					rule.compile( pattern );
				}
			}
			return rule;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createPattern(
			pattern:String = null,
			comment:String = null ):Pattern
		{	
			var nm:String = QualifiedName.toName(
				Pattern.NAMESPACE_PREFIX, Pattern.NAME );
			var bean:Object = createElementNS(
				Pattern.NAMESPACE_URI, nm );
			var ptn:Pattern = bean as Pattern;
			if( ptn != null )
			{
				if( comment != null && comment != "" )
				{
					ptn.comment = comment;
				}
				if( pattern != null && pattern != "" )
				{
					ptn.source = pattern;
				}
			}
			return ptn;
		}
	}
}