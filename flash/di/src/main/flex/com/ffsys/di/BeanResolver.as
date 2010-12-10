package com.ffsys.di
{
	
	public class BeanResolver extends Object {
		
		/**
		* 	The name of the bean that holds this reference.
		*/
		public var beanName:String;

		/**
		* 	The name of the bean property that holdes this reference.
		*/
		public var name:String;

		/**
		* 	The refrerence value extracted when this reference was parsed.
		*/
		public var value:String;
		
		/**
		* 	Creates a <code>BeanResolver</code> instance.
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
		* 	@private
		*/
		protected function find(
			target:Object,
			style:Object,
			document:IBeanDocument ):Object
		{	
			var loop:Boolean = false;
			loop = ( target is IBeanResolver )
			while( loop )
			{
				target = IBeanResolver( target ).resolve( document, style );
				loop = ( target is IBeanResolver );
			}

			return target;
		}
		

		/**
		* 	@private
		*/
		protected function toCamelCase():String
		{
			//convert to camel case
			var re:RegExp = /^([^\-]*)\-([a-z]{1})(.*)$/;
			var matches:Object = re.exec( this.value );
			var camel:String = this.value;

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