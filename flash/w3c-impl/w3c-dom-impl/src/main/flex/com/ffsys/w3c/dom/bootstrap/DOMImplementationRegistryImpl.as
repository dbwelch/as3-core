package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.*;
		
	import com.ffsys.w3c.dom.DOMImplementationSourceImpl;	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;	
	
	import org.w3c.dom.*;
	import org.w3c.dom.bootstrap.DOMImplementationRegistry;
	
	/**
	* 	@inheritDoc
	*/
	public class DOMImplementationRegistryImpl extends AbstractNodeProxyImpl
		implements DOMImplementationRegistry
	{
		static private var __sources:Vector.<DOMImplementationSource>;
		
		/**
		* 	Creates a <code>DOMImplementationRegistryImpl</code> instance.
		*/
		public function DOMImplementationRegistryImpl()
		{
			super();
		}
		
		/**
		* 	Retrieves a list of DOM implementation
		* 	source instances from the bean document
		* 	that this registry was instantiated from.
		*/
		public function get sources():Vector.<DOMImplementationSource>
		{
			if( __sources == null && this.document != null )
			{
				__sources = new Vector.<DOMImplementationSource>();
				var names:Array = this.document.beanNames;
				if( names != null )
				{
					var descriptor:IBeanDescriptor = null;
					var nm:String;
					for( var i:int = 0;i < names.length;i++ )
					{
						nm = names[ i ];
						descriptor = this.document.getBeanDescriptor( nm );
						if( descriptor.instanceClass == DOMImplementationSourceImpl )
						{
							//extract the implementation source
							__sources.push( DOMImplementationSource(
								document.getBean( nm ) ) );
						}
					}
				}
			}
			return __sources;
		}
	
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementation( features:String ):DOMImplementation
		{
			var src:Vector.<DOMImplementationSource> = this.sources;
			if( src != null )
			{
				var source:DOMImplementationSource = null;
				var impl:DOMImplementation = null;
				for( var i:int = 0;i < src.length;i++ )
				{
					source = src[ i ];
					impl = source.getDOMImplementation( features );
					
					trace("DOMImplementationRegistryImpl::getDOMImplementation()", impl );
					
					if( impl != null )
					{
						trace("[FOUND IMPLEMENTATION] DOMImplementationRegistryImpl::getDOMImplementation()",
							features, beanName, document, src, impl );
						return impl;
					}
				}			
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementationList( features:String ):DOMImplementationList
		{
			var src:Vector.<DOMImplementationSource> = this.sources;
			return null;
		}
	}
}