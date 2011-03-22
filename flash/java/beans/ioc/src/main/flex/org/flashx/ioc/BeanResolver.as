package org.flashx.ioc
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
	public class BeanResolver extends Object 
		implements IBeanResolver {
		
		private var _expression:String;
		private var _parameters:Array;
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
		public function resolve(
			document:IBeanDocument,
			descriptor:IBeanDescriptor,
			bean:Object ):Object
		{
			return null;
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
		* 	The expression string.
		*/
		public function get expression():String
		{
			return _expression;
		}
		
		public function set expression( value:String ):void
		{
			_expression = value;
		}
		
		/**
		* 	Parameters found when the expression was parsed.
		*/
		public function get parameters():Array
		{
			return _parameters;
		}
		
		public function set parameters( value:Array ):void
		{
			_parameters = value;
		}
				
		/**
		* 	@inheritDoc
		*/
		public function validate( types:Vector.<Class>, parameters:Array = null ):void
		{
			var params:Array = parameters;
			
			if( params == null )
			{
				params = this.parameters;
			}
			
			if( params == null )
			{
				params = new Array();
			}
			
			if( types != null )
			{
				if( types.length != params.length )
				{
					throw new Error(
						"Incorrect parameter count for expression '"
							+ expression + "', expected " + types.length + "." );
				}
				
				var parameter:Object = null;
				var type:Class = null;
				for( var i:int = 0;i < types.length;i++ )
				{
					type = types[ i ];
					parameter = params[ i ];
					
					//null values are allowed
					if( parameter != null
						&& !( parameter is type ) )
					{
						throw new Error( "The parameter at index " + i + " for expression '"
							+ expression + "' is not of the expected type '"
							+ type + "'." );
					}
				}
			}
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