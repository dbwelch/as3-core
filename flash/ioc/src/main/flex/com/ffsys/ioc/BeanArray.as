package com.ffsys.ioc
{
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Represents a bean array expression.
	* 
	* 	This can be used to create arrays of bean references.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanArray extends BeanResolver
		implements IBeanResolver {

		/**
		* 	Creates a <code>BeanArray</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		*/
		public function BeanArray(
			beanName:String = null,
			name:String = null,
			value:String = null ):void
		{
			super( beanName, name, value );
		}

		/**
		* 	@inheritDoc
		*/
		public function resolve(
			document:IBeanDocument,
			descriptor:IBeanDescriptor,
			bean:Object ):Object
		{
			if( document != null )
			{	
				var parts:Array = this.value.split( "," );
				var part:String = null;
				var parsed:Object = null;

				var parser:BeanTextElementParser = new BeanTextElementParser( document );

				for( var i:int = 0;i < parts.length;i++ )
				{
					part = String( parts[ i ] );
					
					part = strip( part );

					//overwrite the array entry with the parsed value
					parsed = parser.parse( descriptor, beanName, this.name, part );

					if( parsed is IBeanResolver )
					{
						parsed = find( document, descriptor, parsed, bean );
					}

					//update the array element
					parts[ i ] = parsed;
				}
				return parts;
			}	

			return null;
		}
	}
}