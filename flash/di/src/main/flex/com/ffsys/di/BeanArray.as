package com.ffsys.di
{
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Represents a bean array reference.
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
		* 	This method differs from other implementations in that it expects
		* 	the <code>bean</code> parameter to be the object that contains
		* 	the method reference.
		* 
		* 	@inheritDoc
		*/
		public function resolve( document:IBeanDocument, bean:Object ):Object
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
					
					part = part.replace(/^\s+/,"");
					part = part.replace(/\s+$/,"");

					//overwrite the array entry with the parsed value
					parsed = parser.parse( part, beanName, this.name );

					if( parsed is IBeanResolver )
					{
						parsed = find( parsed, bean, document );
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