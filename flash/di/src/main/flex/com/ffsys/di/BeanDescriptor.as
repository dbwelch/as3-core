package com.ffsys.di
{
	import com.ffsys.utils.properties.PropertiesMerge;	
	
	public class BeanDescriptor extends Object
		implements IBeanDescriptor
	{	
		private var _document:IBeanDocument;
		private var _id:String;
		private var _instanceClass:Class;
		private var _singleton:Boolean = false;
		private var _properties:Object;
		private var _singletonInstance:Object;
		
		/**
		* 	Creates a <code>BeanDescriptor</code> instance.
		* 
		* 	@param source A source object to copy bean descriptor
		* 	information from.
		*/
		public function BeanDescriptor( source:Object = null )
		{
			super();
			if( source != null )
			{
				transfer( source );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( document:IBeanDocument ):void
		{
			_document = document;
		}
		
		/**
		* 	An identifier for the bean.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isBean():Boolean
		{
			return ( this.instanceClass is Class );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get instanceClass():Class
		{
			return _instanceClass;
		}
		
		public function set instanceClass( clazz:Class ):void
		{
			_instanceClass = clazz;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get singleton():Boolean
		{
			return _singleton;
		}
		
		public function set singleton( value:Boolean ):void
		{
			_singleton = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get properties():Object
		{
			return _properties;
		}
		
		public function set properties( properties:Object ):void
		{
			_properties = properties;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function copy():Object
		{
			var output:Object = {};
			for( var z:String in properties )
			{
				output[ z ] = properties[ z ];
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getProperties():Object
		{
			var clone:Object = copy();
			if( clone )
			{
				resolveConstants( clone );
				//resolve references
				resolve( clone );			
			}
			return clone;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getBean():Object
		{
			if( this.singleton && _singletonInstance )
			{
				return _singletonInstance;
			}
			
			trace("***************************** BeanDescriptor::getBean()", this.id, this.singleton );
			
			var clazz:Class = null;
			
			try
			{
				clazz = this.instanceClass;
			}catch( e:Error )
			{
				//if the above fails we likely already have a complex object
				//we are definitely not dealing with a dynamic object
				//so return the existing complex object
				return this.properties;
			}
			
			if( properties )
			{
				resolveConstants( properties );
				//resolve references
				resolve( properties );
			}
			
			if( this.properties && clazz )
			{
				var instance:Object = null;
				
				try
				{
					instance = new clazz();
				}catch( e:Error )
				{
					throw new Error(
						"Could not instantiate bean instance with class '" + this.instanceClass + "'." );
					
					//throw e;
				}
				
				if( instance )
				{
					if( isMethodReference( this.properties ) )
					{
						return getMethod( this.properties, instance ) as Function;
					}

					var merger:PropertiesMerge = new PropertiesMerge();
					merger.merge( instance, this.properties, true, [ IBeanResolver ] );
				}
				
				if( this.singleton )
				{
					_singletonInstance = instance;
				}
				
				trace("********************** BeanDescriptor::getBean() returning: ", instance );

				return instance;
			}
			
			return null;
		}	
		
		/**
		* 	@inheritDoc
		*/
		public function transfer( target:Object ):void
		{
			if( target )
			{
				if( target.hasOwnProperty( BeanConstants.INSTANCE_CLASS_PROPERTY ) )
				{
					var instanceClassCandidate:Object = target[ BeanConstants.INSTANCE_CLASS_PROPERTY ];	
					if( instanceClassCandidate is Class )
					{
						this.instanceClass = ( instanceClassCandidate as Class );
						delete target[ BeanConstants.INSTANCE_CLASS_PROPERTY ];
					}
				}
				
				if( target.hasOwnProperty( BeanConstants.SINGLETON_PROPERTY ) )
				{
					var singletonCandidate:Object = target[ BeanConstants.SINGLETON_PROPERTY ];
					if( singletonCandidate is Boolean )
					{
						this.singleton = ( singletonCandidate as Boolean );
						delete target[ BeanConstants.SINGLETON_PROPERTY ];
					}
				}
				
				if( target.hasOwnProperty( BeanConstants.ID_PROPERTY ) )
				{
					var idCandidate:Object = target[ BeanConstants.ID_PROPERTY ];
					if( idCandidate is String )
					{
						this.id = ( idCandidate as String );
						delete target[ BeanConstants.ID_PROPERTY ];
					}
				}		
			
				_properties = target;
			}
		}
		
		/**
		* 	@private
		*/
		private function resolve( bean:Object ):void
		{
			var z:String = null;
			var o:Object = null;
			var resolver:IBeanResolver = null;
			var loop:Boolean = false;
			var resolved:Object = null;
			for( z in bean )
			{
				o = bean[ z ];
				if( o is IBeanResolver && !( o is BeanMethod ) )
				{
					resolver = IBeanResolver( o );
					resolved = resolver.resolve( this.document, bean );

					loop = ( resolved is IBeanResolver ) && ( resolved != resolver )
					while( loop )
					{
						resolved = IBeanResolver( resolved ).resolve( this.document, bean );
						loop = ( resolved is IBeanResolver ) && ( resolved != resolver );
					}

					//setBeanProperty( bean, z, resolved );
					
					bean[ z ] = resolved;
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function resolveConstants( bean:Object ):void
		{
			trace("BeanDescriptor::resolveConstants()", "RESOLVING CONSTANTS: ", bean );
			if( bean )
			{
				var z:String = null;
				for( z in bean )
				{
					if( bean[ z ] is BeanConstant )
					{
						trace("BeanDescriptor::resolveConstants()", "RESOLVING CONSTANT!!!!!!!!!!!!!!: ", z, bean[ z ] );
						bean[ z ] = BeanConstant( bean[ z ] ).resolve( this.document, bean );
					}
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function isMethodReference( properties:Object ):Boolean
		{
			return properties && properties[ BeanConstants.METHOD_PROPERTY ] && ( properties[ BeanConstants.METHOD_PROPERTY ] is BeanMethod );
		}
		
		/**
		* 	@private
		*/
		private function getMethod( properties:Object, target:Object ):Function
		{
			//handle method references
			if( isMethodReference( properties ) )
			{
				return BeanMethod( properties[ BeanConstants.METHOD_PROPERTY ] ).resolve( this.document, target ) as Function;
			}
			
			return null;
		}		
	}
}