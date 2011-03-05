package java.util.regex
{
	import org.w3c.dom.Document;
	import org.w3c.dom.DocumentType;
	import org.w3c.dom.DOMFeature;	
	import org.w3c.dom.DOMVersion;
	import org.w3c.dom.Element;	
	
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
			if( namespaceURI != null )
			{
				NodeImpl( document ).namespaceDeclarations.push(
					new Namespace( namespaceURI ) );
			}
			
			if( qualifiedName ==  null )
			{
				qualifiedName = "pattern";
			}
			
			var e:Element = document.createElement( qualifiedName );
			document.appendChild( e );
			
			setImplementation( document, doctype );
			return document;
		}
	}
}