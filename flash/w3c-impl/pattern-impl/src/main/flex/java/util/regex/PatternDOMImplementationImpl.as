package java.util.regex
{
	import org.w3c.dom.Document;
	import org.w3c.dom.DocumentType;
	import org.w3c.dom.DOMFeature;	
	import org.w3c.dom.DOMVersion;
	import org.w3c.dom.Element;	
	
	import javax.xml.namespace.QualifiedName;
	
	import com.ffsys.w3c.dom.NodeImpl;
	
	import com.ffsys.w3c.dom.xml.XMLDOMImplementationImpl;
	
	/**
	* 	Represents the pattern DOM implementation.
	*/
	public class PatternDOMImplementationImpl extends XMLDOMImplementationImpl
	{
		/**
		* 	The bean name for the implementation of the "Pattern" feature.
		*/
		public static const NAME:String = "Pattern";
		
		/**
		* 	The representation of a "Pattern 3.0" feature.
		*/
		public static const FEATURE:DOMFeature = new DOMFeature(
			NAME, DOMVersion.VERSION_3 );
		
		/**
		* 	Creates a <code>PatternDOMImplementationImpl</code> instance.
		*/
		public function PatternDOMImplementationImpl()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		override protected function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = super.supported;
				_supported.push( FEATURE );
			}
			return _supported;
		}
		
		/**
		* 	Creates a new pattern document.
		* 
		* 	@return A pattern document.
		*/
		public function createPatternDocument():PatternDocument
		{
			return createDocument( null, null, null ) as PatternDocument;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function createDocument(
			namespaceURI:String,
			qualifiedName:String,
			doctype:DocumentType ):Document
		{
			var document:PatternDocumentImpl = PatternDocumentImpl(
				getDomBean( PatternDocumentImpl.NAME ) );
			
			//TEMP
			NodeImpl( document ).namespaceDeclarations.push(
				Pattern.NAMESPACE );
			
			if( qualifiedName ==  null )
			{
				qualifiedName = RuleList.NAME;
			}
			
			var e:Element = document.createElementNS(
				Pattern.NAMESPACE_URI, QualifiedName.toName(
					Pattern.NAMESPACE_PREFIX, qualifiedName ) );
			document.appendChild( e );
			
			setImplementation( document, doctype );
			return document;
		}
	}
}