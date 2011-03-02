package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import org.w3c.dom.DOMImplementation;
	
	import org.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;	
	import com.ffsys.w3c.dom.events.EventImpl;
	import com.ffsys.w3c.dom.events.MutationEventImpl;
	
	/**
	* 	A boostrap document for the DOM Events implementation.
	*/
	public class DOMEventsBootstrap extends DOMCoreBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> Events implementation bean document.
		*/
		public static const NAME:String = DOMFeature.EVENTS_MODULE;
		
		/**
		* 	Creates a <code>DOMEventsBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMEventsBootstrap( identifier:String = null )
		{
			if( identifier == null )
			{
				identifier = NAME;
			}
			super( identifier );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );			
			addCommonEvents( beans );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.EVENTS_3_FEATURE );
			return output;
		}
		
		/**
		* 	@private
		*/
		override protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			super.doWithImplementationFactories( factories );
			
			var impl:DOMImplementation = new DocumentEventImpl();
			
			var descriptor:IBeanDescriptor = createImplementationFactory(
				factories,
				DocumentEventImpl.NAME, 
				DocumentEventImpl,
				impl );

			descriptor.names = new Vector.<String>();
			addCommonEventAliases( descriptor.names );
		}
		
		/**
		* 	@private
		*/
		protected function addCommonEventAliases( names:Vector.<String> ):void
		{
			names.push( DOMFeature.MUTATION_EVENTS_MODULE );
			names.push( DOMFeature.MUTATION_NAME_EVENTS_MODULE );
			names.push( DOMFeature.CUSTOM_EVENTS_MODULE );		
		}
		
		/**
		* 	@private
		*/
		protected function addCommonEvents( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
						
			//DOM Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.EVENT_INTERFACE );
			descriptor.instanceClass = EventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM Mutation Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.MUTATION_EVENT_INTERFACE );
			descriptor.instanceClass = MutationEventImpl;
			impls.addBeanDescriptor( descriptor );
		}		
	}
}