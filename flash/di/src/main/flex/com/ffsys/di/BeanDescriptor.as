package com.ffsys.di
{	
	import com.ffsys.utils.properties.PropertiesMerge;	
	
	/**
	*	Encapsulates all the information required to instantiate a bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanDescriptor extends Object
		implements IBeanDescriptor
	{	
		private var _document:IBeanDocument;
		private var _id:String;
		private var _staticClass:Class;
		private var _singleton:Boolean = false;
		private var _properties:Object;
		private var _instanceClassConstant:BeanConstant;
		private var _staticClassConstant:BeanConstant;
		
		/**
		* 	@private
		*/
		protected var _instanceClass:Class;
		
		/**
		* 	@private
		*/
		protected var _singletonInstance:Object;
		
		/**
		* 	Creates a <code>BeanDescriptor</code> instance.
		* 
		* 	@param id An identifier for the bean.
		*/
		public function BeanDescriptor( id:String = null )
		{
			super();
			this.id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			_instanceClass = null;
			_staticClass = null;
			_properties = null;
			_singletonInstance = null;
			_instanceClassConstant = null;
			_staticClassConstant = null;		
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
		* 	@private
		*/
		private function getStaticClass():Class
		{
			if( !_staticClass && _staticClassConstant )
			{
				var candidate:Object = null;
				try
				{
					candidate = _staticClassConstant.resolve( this.document, this );
				}catch( e:Error )
				{
					throw new Error( "Could not resolve a static class constant." );
				}
				
				if( !( candidate is Class ) )
				{
					throw new Error( "The static class constant value '" + candidate + "' is not a class." );
				}
				
				_staticClass = candidate as Class;
			}
			
			return _staticClass;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get instanceClass():Class
		{
			if( !_instanceClass && _instanceClassConstant )
			{
				var candidate:Object = null;
				try
				{
					candidate = _instanceClassConstant.resolve( this.document, this );
				}catch( e:Error )
				{
					throw new Error( "Could not resolve an instance class constant." );
				}
				
				if( !( candidate is Class ) )
				{
					throw new Error( "The instance class constant value '" + candidate + "' is not a class." );
				}
				
				return candidate as Class;
			}
			
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
		public function getBean( inject:Boolean = true ):Object
		{			
			//prefer singletons to static classes
			if( this.singleton && _singletonInstance )
			{
				return _singletonInstance;
			}
			
			var clazz:Class = null;
			
			//handle static class references
			if( _staticClass != null || _staticClassConstant != null )
			{
				clazz = this.getStaticClass();
				if( isMethodReference( this.properties ) )
				{
					return getMethod( this.properties, clazz ) as Function;
				}
				return clazz;
			}
			
			//trace("****************************************** BeanDescriptor::getBean()", this.id, isBean(), this.instanceClass );
			
			//not an instance return the properties
			if( !isBean() )
			{
				return getProperties();
			}
			
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

			var parameters:Object = null;
			
			if( this.properties )
			{
				//get a copy of the properties
				parameters = copy();
				resolveConstants( parameters );
				//resolve references
				resolve( parameters );
			}
			
			if( clazz )
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
					if( parameters )
					{
						//instance method references
						if( isMethodReference( parameters ) )
						{
							return getMethod( parameters, instance ) as Function;
						}

						var merger:PropertiesMerge = new PropertiesMerge();
						merger.merge( instance, parameters, true, [ IBeanResolver ] );
					}
					
					if( inject && document && document.injector )
					{
						document.injector.inject( document, this.id, instance );
					}
				}
				
				if( this.singleton )
				{
					_singletonInstance = instance;
				}
				
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
				clear();
				
				if( target.hasOwnProperty( BeanConstants.INSTANCE_CLASS_PROPERTY ) )
				{
					var instanceClassCandidate:Object = target[ BeanConstants.INSTANCE_CLASS_PROPERTY ];	
					if( instanceClassCandidate is Class || instanceClassCandidate is BeanConstant )
					{
						if( instanceClassCandidate is Class )
						{
							this.instanceClass = ( instanceClassCandidate as Class );
						}else if( instanceClassCandidate is BeanConstant )
						{
							_instanceClassConstant = BeanConstant( instanceClassCandidate );
						}
						
						delete target[ BeanConstants.INSTANCE_CLASS_PROPERTY ];
					}
				}
				
				if( target.hasOwnProperty( BeanConstants.STATIC_CLASS_PROPERTY ) )
				{
					var staticClassCandidate:Object = target[ BeanConstants.STATIC_CLASS_PROPERTY ];
					if( staticClassCandidate is Class || staticClassCandidate is BeanConstant )
					{
						if( staticClassCandidate is Class )
						{
							_staticClass = ( staticClassCandidate as Class );
						}else if( staticClassCandidate is BeanConstant )
						{
							_staticClassConstant = BeanConstant( staticClassCandidate );
						}
						delete target[ BeanConstants.STATIC_CLASS_PROPERTY ];
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
					if( ( idCandidate is String ) && this.id == null )
					{
						this.id = ( idCandidate as String );
						//we don't delete the id property as it may need to be assigned
					}
				}
			
				_properties = target;
			}
		}
		
		/**
		* 	Destroys this bean descriptor.
		*/
		public function destroy():void
		{
			clear();
			_document = null;
			_id = null;
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
				if( o is IBeanResolver && !( o is BeanMethod ) && !( o is BeanFileDependency ) )
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
					
					//TODO: reintegrate with a central bean property set method
					
					bean[ z ] = resolved;
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function resolveConstants( bean:Object ):void
		{
			if( bean )
			{
				var z:String = null;
				for( z in bean )
				{
					if( bean[ z ] is BeanConstant )
					{
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