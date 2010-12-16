package com.ffsys.ioc
{
	/**
	*	Abstract super class for bean reference expressions that
	* 	perform resolution at runtime.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanResolver extends Object {
		
		private var _beanName:String;
		private var _name:String;
		private var _value:Object;
		
		/**
		* 	Creates a <code>BeanResolver</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The name of the parsed value.
		*/
		public function BeanResolver(
			beanName:String,
			name:String,
			value:String ):void		
		{
			super();
			this.beanName = beanName;
			this.name = name;
			this.value = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beanName():String
		{
			return _beanName;
		}
		
		public function set beanName( value:String ):void
		{
			_beanName = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get value():Object
		{
			return _value;
		}
		
		public function set value( value:Object ):void
		{
			_value = value;
		}
		
		/**
		* 	@private
		*/
		protected function strip( candidate:String ):String
		{
			candidate = candidate.replace( /^\s+/, "" );
			candidate = candidate.replace( /\s+$/, "" );
			return candidate;
		}
		
		/**
		* 	@private
		*/
		protected function find(
			document:IBeanDocument,
			descriptor:IBeanDescriptor,
			target:Object,
			bean:Object ):Object
		{	
			var loop:Boolean = false;
			loop = ( target is IBeanResolver )
			while( loop )
			{
				target = IBeanResolver( target ).resolve( document, descriptor, bean );
				loop = ( target is IBeanResolver );
			}
			return target;
		}

		/**
		* 	@private
		*/
		//TODO: refactor this to use a CamelCaseConverter implementation when available
		protected function toCamelCase():String
		{
			//convert to camel case
			var re:RegExp = /^([^\-]*)\-([a-z]{1})(.*)$/;
			var matches:Object = re.exec( String( this.value ) );
			var camel:String = String( this.value );

			if( matches )
			{
				camel = "";
				var part:String = null;
				var i:int = 1;
	  			for( ;i < matches.length;i++ )
				{
					part = matches[ i ];
					if( i % 2 == 0 )
					{
						part = part.toUpperCase();
					}
					camel += part;
				}
			}

			return camel;	
		}		
	}
}