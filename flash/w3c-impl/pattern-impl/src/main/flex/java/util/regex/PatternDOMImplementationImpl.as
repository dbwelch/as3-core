package java.util.regex
{
	import org.w3c.dom.Document;
	import org.w3c.dom.DocumentType;
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
		* 	Creates a <code>PatternDOMImplementationImpl</code> instance.
		*/
		public function PatternDOMImplementationImpl()
		{
			super();
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