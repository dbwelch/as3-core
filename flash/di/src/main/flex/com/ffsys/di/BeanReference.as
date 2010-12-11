package com.ffsys.di
{
	/**
	*	Represents a reference to another bean or bean property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanReference extends BeanResolver
		implements IBeanResolver {

		/**
		* 	Creates a <code>BeanReference</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		*/
		public function BeanReference(
			beanName:String = null,
			name:String = null,
			value:String = null ):void
		{
			super( beanName, name, value );
		}

		/**
		* 	@inheritDoc
		*/
		public function resolve( document:IBeanDocument, bean:Object ):Object
		{
			if( document )
			{
				var candidate:String = this.value;
				var found:Object;

				//we check the delimiter is beyond the first character
				if( candidate.lastIndexOf( BeanConstants.REFERENCE_PROPERTY_DELIMITER ) > 0 )
				{
					if( candidate.indexOf( BeanConstants.REFERENCE_PROPERTY_DELIMITER ) == 0 )
					{
						//remove the first character if it matches the reference delimiter
						candidate = candidate.substr( 1 );
					}

					var parts:Array = candidate.split( BeanConstants.REFERENCE_PROPERTY_DELIMITER );
					if( !(parts.length == 2 ) )
					{
						throw new Error( "Found invalid bean reference candidate '" + candidate + "'." );
					}

					candidate = parts[ 0 ];
					var property:String = parts[ 1 ];
					var candidateStyle:Object = document.getBean( candidate );
					if( !candidateStyle )
					{
						throw new Error(
							"Could not locate bean reference with value '" + candidate + "'." );					
					}

					found = candidateStyle[ property ];
				}else{
					found = document.getBean( candidate );

					if( found is IBeanResolver && found != this )
					{
						found = find( found, bean, document );
					}
				}

				if( found == null )
				{
					throw new Error(
						"Could not locate bean reference with value '" + candidate + "'." );
				}

				return found;
			}

			return bean;
		}
	}
}