package com.ffsys.w3c.dom
{
	import com.ffsys.ioc.*;
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;
	import org.w3c.dom.*;

	dynamic public class DOMImplementationSourceImpl extends DOMImplementationListImpl
		implements DOMImplementationSource
	{
		/**
		* 	The bean name for the main DOM implementation source.
		*/
		public static const NAME:String = "dom-impl-source";
		
		/**
		* 	Creates a <code>DOMImplementationSourceImpl</code> instance.
		*/
		public function DOMImplementationSourceImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementation(
			features:String ):DOMImplementation
		{
			if( features == null || this.document == null )
			{
				return null;
			}
			var list:DOMImplementationList = getDOMImplementationList( features );
			
			trace("DOMImplementationSourceImpl::getDOMImplementation()", list, list.length );
			
			if( list != null && list.length > 0 )
			{
				return list[ 0 ];
			}
			return null;
		}
			
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementationList(
			features:String ):DOMImplementationList
		{
			if( features == null || this.document == null )
			{
				return null;
			}			
			
			var i:uint = 0;
			var j:uint = 0;
			
			var nm:String;			
			
			var list:DOMImplementationList = DOMImplementationList(
				this.document.getBean( DOMImplementationListImpl.NAME ) );
			
			//TODO: handle searching for multiple features
			var parts:Array = features.split(
				DOMImplementationImpl.MODULE_VERSION_DELIMITER );
				
			//represent the string as a list of features
			var specified:Vector.<DOMFeature> = new Vector.<DOMFeature>();
			var ft:DOMFeature = null;
			for( i = 0;i < parts.length;i++ )
			{
				nm = parts[ i ];
				//got alpha-numeric character
				if( /[a-zA-Z]+/.test( nm ) )
				{
					ft = new DOMFeature( nm );
					specified.push( ft );
				}else if(
					ft != null
					&& /^([0-9]+)?\.?([0-9]+)/.test( nm ) )
				{
					ft.version = nm;
				}
			}
			
			//trace("[GOT SPECIFIED FEATURES LIST] DOMImplementationSourceImpl::init()", specified );
			
			//extract the implementation document xrefs
			var impls:Vector.<IBeanDocument> = new Vector.<IBeanDocument>();
			for( i = 0;i < this.document.xrefs.length;i++ )
			{
				if( this.document.xrefs[ i ].id == DOMBootstrap.XML_IMPLEMENTATION_DOC_NAME
				 	|| this.document.xrefs[ i ].id == DOMBootstrap.HTML_IMPLEMENTATION_DOC_NAME )
				{
					impls.push( this.document.xrefs[ i ] );
				}
			}
			
			if( impls.length == 0 )
			{
				throw new Error( "No DOM implementations could be located." );
			}
			
			var targetImpl:IBeanDocument = null;
			var testImpl:IBeanDocument = null;

			//find the preferred target implementation - XML or HTML
			//the first match is returned, ie: "XML Core HTML" retrieves
			//an "XML" implementation, while "HTML Core XML" retrieves
			//an "HTML" implementation
			for( i = 0;i < impls.length;i++ )
			{
				testImpl = impls[ i ];
				for( j = 0;j < specified.length;j++ )
				{
					ft = specified[ j ];
					if( ft.feature.toLowerCase() == testImpl.id.toLowerCase() )
					{
						targetImpl = testImpl;
						i = impls.length;
						break;
					}
				}
			}
			
			var names:Array = targetImpl.beanNames;
			if( names != null )
			{
				var k:uint = 0;
				var c:uint = 0;
				var bean:Object = null;
				var impl:DOMImplementation = null;
				for( i = 0;i < names.length;i++ )
				{
					nm = names[ i ];
					bean = targetImpl.getBean( nm );
					if( bean is DOMImplementation )
					{
						impl = DOMImplementation( bean );
						
						/*
						trace("[GOT IMPLEMENTATION CANDIDATE] DOMImplementationSourceImpl::init()",
 							impl );
						*/
						
						//test the specified features
						for( k = 0;k < specified.length;k++ )
						{
							ft = specified[ k ];
							if( !impl.hasFeature( ft.feature, ft.version ) )
							{
								break;
							}
						}
						
						if( k == specified.length )
						{
							list[ c++ ] = impl;
						}
					}
				}
			}
			return list;
		}
	}
}