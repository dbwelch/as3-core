package java.util.regex.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;	
	
	import org.w3c.dom.DOMFeature;
	import org.w3c.dom.DOMImplementation;
	
	import com.ffsys.w3c.dom.bootstrap.DOMXMLBootstrap;
	
	import java.util.regex.Pattern;
	import java.util.regex.PatternDocumentImpl;
	import java.util.regex.PatternDOMImplementationImpl;
	import java.util.regex.Rule;
	
	
	/**
	* 	A boostrap document for the DOM Pattern implementation.
	*/
	public class DOMPatternBootstrap extends DOMXMLBootstrap
	{
		/**
		* 	Creates a <code>DOMPatternBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMPatternBootstrap( identifier:String = null )
		{
			if( identifier == null )
			{
				identifier = NAME;
			}
			super( identifier );
		}
		
		/**
		* 	@private
		*/
		override protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			super.doWithImplementationFactories( factories );
			
			var impl:DOMImplementation =
				new PatternDOMImplementationImpl();
			createImplementationFactory(
				factories,
				PatternDOMImplementationImpl.NAME,
				PatternDOMImplementationImpl,
				impl );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( PatternDOMImplementationImpl.NAME );
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			var descriptor:IBeanDescriptor = null;
			descriptor = new BeanDescriptor(
				PatternDocumentImpl.NAME );
			descriptor.instanceClass = PatternDocumentImpl;
			beans.addBeanDescriptor( descriptor );
		}		
	}
}