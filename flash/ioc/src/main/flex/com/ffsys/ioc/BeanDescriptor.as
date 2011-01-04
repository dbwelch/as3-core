package com.ffsys.ioc
{	
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
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
	public class BeanDescriptor extends BeanElement
		implements IBeanDescriptor
	{
		static private var _beanFileLoadManager:BeanFileLoadManager
			= new BeanFileLoadManager();
			
		private var _document:IBeanDocument;
		private var _staticClass:Class;
		private var _singleton:Boolean = false;
		private var _properties:Object;
		private var _instanceClassConstant:BeanConstant;
		private var _staticClassConstant:BeanConstant;
		private var _factoryReference:BeanReference;
		
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
		* 	@param source A source object to transfer
		* 	bean descriptor properties from.
		*/
		public function BeanDescriptor(
			id:String = null,
			source:Object = null )
		{
			super();
			this.id = id;
			if( source != null )
			{
				transfer( source );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get filePolicy():String
		{
			//force non-bean descriptors to document level
			//file dependencies for the moment
			if( !isBean() )
			{
				BeanFilePolicy.DOCUMENT_FILE_POLICY;
			}
			
			var policy:String = super.filePolicy;
			if( policy != null )
			{
				return policy;
			}
			
			//defer to the document file policy if none was explicitly set
			if( this.document != null
				&& this.document.filePolicy != null )
			{
				return this.document.filePolicy;
			}
			
			//return the default policy
			return BeanFilePolicy.DOCUMENT_FILE_POLICY;
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
		* 	@inheritDoc
		*/
		public function isBean():Boolean
		{
			return ( _factoryReference != null
				|| _singletonInstance != null
				|| ( this.instanceClass is Class ) );
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
					candidate = _staticClassConstant.resolve( this.document, this, this );
				}catch( e:Error )
				{
					throw new Error( "Could not resolve static class constant on property '"
						+ _staticClassConstant.name + "'." );
				}
				
				if( !( candidate is Class ) )
				{
					throw new Error( "The static class constant value '"
						+ candidate + "' is not a class." );
				}
				
				_staticClass = candidate as Class;
			}	
			return _staticClass;
		}
		
		/**
		* 	@private
		*/
		private function getInstanceClass():Class
		{
			if( !_instanceClass && _instanceClassConstant )
			{
				var candidate:Object = null;
				try
				{
					candidate = _instanceClassConstant.resolve( this.document, this, this );
				}catch( e:Error )
				{
					throw new Error( "Could not resolve instance class constant on property '"
						+ _staticClassConstant.name + "'." );
				}
				if( !( candidate is Class ) )
				{
					throw new Error( "The instance class constant value '"
						+ candidate + "' is not a class." );
				}
				return candidate as Class;
			}
			
			return _instanceClass;
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
			
			if( value === false
				&& ( _singletonInstance != null ) )
			{
				_singletonInstance = null;
			}
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
		public function merge( source:IBeanDescriptor ):Boolean
		{
			var merged:Boolean = false;
			if( source.properties )
			{
				var z:String = null;
				for( z in source.properties )
				{
					_properties[ z ] = source.properties[ z ];
					merged = true;
				}
			}
			return merged;
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
				//TODO: check if we should resolve constants when in a constant bean?
				clone = resolveConstants( clone );
				
				//resolve references
				clone = resolve( clone );
			}
			return clone;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getBean( inject:Boolean = true, finalize:Boolean = true ):Object
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
				
				//a method reference on a static class
				if( isMethodReference( this.properties ) )
				{
					return getMethod( this.properties, clazz ) as Function;
				}
				return clazz;
			}

			//not an instance return the properties
			if( !isBean() )
			{
				return getProperties();
			}

			//handle factory instantiation
			if( _factoryReference )
			{
				var methodCandidate:Object = _factoryReference.resolve( this.document, this, this );
				if( !( methodCandidate is Function ) )
				{
					throw new BeanError(
						"A factory reference must be a method '"
						+ methodCandidate + "'." );
				}
				var method:Function = ( methodCandidate as Function );
				instance = method.apply( null, [] );
				if( this.singleton )
				{
					_singletonInstance = instance;
				}
				return instance;
			}
			
			try
			{
				clazz = this.getInstanceClass();
			}catch( e:Error )
			{
				//if the above fails we likely already have a complex object
				//we are definitely not dealing with a dynamic object
				//so return the existing complex object
				return this.properties;
			}

			var parameters:Object = getProperties();
			
			if( clazz )
			{
				var instance:Object = null;

				try
				{
					instance = new clazz();
				}catch( e:Error )
				{
					/*
					throw new Error(
						"Could not instantiate bean instance with class '" + this.instanceClass + "'."
						+ "\n" + e.message );
					*/
					
					throw e;
				}
			
				if( instance != null )
				{
					//instance method references
					if( isMethodReference( parameters ) )
					{
						return getMethod( parameters, instance ) as Function;
					}
					
					if( instance is IBeanDocumentAware )
					{
						IBeanDocumentAware( instance ).document = this.document;
					}
					
					var bean:IBean = ( instance as IBean );
					
					//handle dependency injection by type first
					doTypeInjection( instance, parameters );
					if( inject && document && document.injector )
					{
						document.injector.inject( document, this.id, instance );
					}
					
					if( bean != null )
					{
						bean.afterInjection( this );
					}
					
					//then call properties and invoke methods
					callBeanMethods( instance, parameters );
					setBeanProperties( instance, parameters );
					
					if( bean != null )
					{
						bean.afterProperties( this );
					}					
					
					//handle resource dependencies
					var resources:ILoaderQueue = doLoadResources( instance, parameters );
					
					if( bean != null )
					{
						bean.afterResources( this, resources );
					}
					
					//finalize at the end
					doFinalization( instance, parameters, finalize );
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
		* 	@private
		* 
		* 	Sets the properties on an instantiated bean.
		*/
		private function setBeanProperties( instance:Object, parameters:Object ):void
		{
			if( instance && parameters )
			{
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( instance, parameters, true, [ IBeanResolver ], assign );
			}
		}
		
		/**
		* 	@private
		*/
		protected function assign(
			target:Object,
			source:Object,
			name:String,
			value:* ):Boolean
		{
			if( target is IBeanProperty
				&& IBeanProperty( target ).shouldSetBeanProperty( name, value ) )
			{
				setBeanProperty( target, name, value );
				return false;
			}
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setBeanProperty( target:Object, name:String, value:* ):Boolean
		{
			if( target is IBeanProperty )
			{
				var property:IBeanProperty = IBeanProperty( target );
				if( property.shouldSetBeanProperty( name, value ) )
				{
					//delegate bean property assignment
					property.setBeanProperty( name, value );
					return true;
				}
			}else
			{
				try
				{
					target[ name ] = value;
					return true;
				}catch( e:Error )
				{
					throw e;
				}
			}
			return false;
		}
		
		/**
		* 	@private
		* 
		* 	Calls methods on an instantiated bean.
		*/
		private function callBeanMethods( instance:Object, parameters:Object ):void
		{
			if( instance )
			{
				//search for method call references
				var z:String = null;
				var property:Object;
				var result:*;
				for( z in _properties )
				{
					property = _properties[ z ];
					if( property is BeanMethodCall )
					{
						result = BeanMethodCall( property ).resolve( this.document, this, instance );
						if( result != null && instance.hasOwnProperty( z ) )
						{
							try
							{
								instance[ z ] = result;
							}catch( e:Error )
							{
								throw new BeanError(
									BeanError.BEAN_METHOD_RESULT_SET, z, instance, result );
							}
						}		
					}
				}
			}
		}
		
		/**
		* 	@private
		* 
		* 	Applies document level bean type injectors to an instantiated bean.
		* 
		* 	@param instance The bean instance.
		* 	@param parameters The bean property parameters.
		*/
		private function doTypeInjection( instance:Object, parameters:Object ):void
		{			
			if( this.document != null )
			{
				var i:int = 0;
				var types:Vector.<BeanTypeInjector> = this.document.types;

				var xref:IBeanDocument = null;
				for( i = 0;i < this.document.xrefs.length;i++ )
				{
					xref = this.document.xrefs[ i ];
					if( xref.types.length > 0 )
					{
						types = types.concat( xref.types );
					}
				}
				
				var injector:BeanTypeInjector = null;
				for( i = 0;i < types.length;i++ )
				{
					injector = types[ i ];	
					//only perform injection if the corresponding property
					//has not been manually wired
					if( injector
						&& !( parameters.hasOwnProperty( injector.name ) ) )
					{
						injector.resolve( this.document, this, instance );
					}
				}
			}
		}
		
		/**
		* 	@private
		* 
		* 	Handles file resources that should be instantiated when the bean
		* 	is retrieved.
		* 
		* 	@param instance The bean instance.
		* 	@param parameters The bean property parameters.
		*/
		private function doLoadResources( instance:Object, parameters:Object ):ILoaderQueue
		{
			var target:ILoaderQueue = null;
			
			if( this.filePolicy == BeanFilePolicy.BEAN_FILE_POLICY
				&& this.files.length > 0 )
			{
			
				if( instance is ILoaderQueue )
				{
					target = ILoaderQueue( instance );
				}
			
				if( !target )
				{
					target = this.dependencies;
				}
				
				//ensure the newly instantiated instance gets all the file loaders
				if( target == instance )
				{
					target.append( this.dependencies );
				}
				
				//no reference at the moment
				var fileResolver:BeanFileLoadResolver =
					new BeanFileLoadResolver( this, target, instance );

				var autoLoad:Boolean = true;
				var observer:IBeanLoadObserver =
					( instance as IBeanLoadObserver );
				if( observer != null )
				{
					autoLoad = observer.getFileLoadBehaviour( target, this, this.files );
					target = observer.doWithLoaderQueue( target, this, this.files );
					//if the observer returns a null loader queue
					//we discard starting any load process
					if( target == null )
					{
						return null;
					}
				}
				
				if( autoLoad )
				{
					//add the loader queue to our stacked based loader
					_beanFileLoadManager.addLoader( target );
					if( !_beanFileLoadManager.loading )
					{
						_beanFileLoadManager.load();
					}
				}
			}
			
			return target;
		}
		
		/**
		* 	@private
		* 
		* 	Handles finalization of a bean instantiation.
		* 
		* 	@param instance The bean instance.
		* 	@param parameters The bean property parameters.
		* 	@param notify Whether a bean finalization implementation
		* 	should in be notified that finalization has occured.
		*/
		private function doFinalization(
			instance:Object,
			parameters:Object,
			notify:Boolean = true ):void
		{
			if( notify === true
				&& instance is IBeanFinalized )
			{
				IBeanFinalized( instance ).finalized();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function transfer( target:Object ):void
		{
			if( target )
			{
				clear();
				
				//keep track of whether this bean instantiates as a factory
				if( target.hasOwnProperty( BeanConstants.FACTORY_PROPERTY ) )
				{
					var factoryCandidate:Object = target[ BeanConstants.FACTORY_PROPERTY ];
					if( factoryCandidate )
					{
						if( !( factoryCandidate is BeanReference ) )
						{
							throw new BeanError(
								"A factory property must be a bean reference, received '"
								+ factoryCandidate + "'." );
						}
						_factoryReference = ( factoryCandidate as BeanReference );
						delete target[ BeanConstants.FACTORY_PROPERTY ];
					}
				}
				
				//transfer any instance class reference
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
				
				//transfer any static class reference
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
				
				//keep track of whether this bean is a singleton instance
				if( target.hasOwnProperty( BeanConstants.SINGLETON_PROPERTY ) )
				{
					var singletonCandidate:Object = target[ BeanConstants.SINGLETON_PROPERTY ];
					if( singletonCandidate is Boolean )
					{
						this.singleton = ( singletonCandidate as Boolean );
						delete target[ BeanConstants.SINGLETON_PROPERTY ];
					}
				}
				
				//copy a file policy property if present
				if( target.hasOwnProperty( BeanConstants.FILE_POLICY_PROPERTY ) )
				{
					var filePolicyCandidate:Object = target[ BeanConstants.FILE_POLICY_PROPERTY ];
					if( ( filePolicyCandidate is String ) )
					{
						this.filePolicy = ( filePolicyCandidate as String );
						delete target[ BeanConstants.FILE_POLICY_PROPERTY ];
					}
				}
				
				//copy an identifier is appropriate
				if( target.hasOwnProperty( BeanConstants.ID_PROPERTY ) )
				{
					var idCandidate:Object = target[ BeanConstants.ID_PROPERTY ];
					if( ( idCandidate is String ) && this.id == null )
					{
						this.id = ( idCandidate as String );
						//we don't delete the id property as it may need to be assigned
					}
				}
				
				//copy all properties so that they are
				//resolved when the bean is retrieved
				_properties = target;
			}
		}
		
		/**
		* 	Destroys this bean descriptor.
		*/
		override public function destroy():void
		{
			super.destroy();
			clear();
			_document = null;
		}
		
		/**
		* 	@private
		*/
		private function resolve( bean:Object ):Object
		{
			var output:Object = new Object();
			var z:String = null;
			var o:Object = null;
			var resolver:IBeanResolver = null;
			var loop:Boolean = false;
			var resolved:Object = null;
			for( z in bean )
			{
				o = bean[ z ];
				if( o is IBeanResolver
					&& !( o is BeanFileDependency )				
					&& !( o is BeanMethod )
					&& !( o is BeanMethodCall ) )
				{
					resolver = IBeanResolver( o );
					resolved = resolver.resolve( this.document, this, bean );
					
					loop = ( resolved is IBeanResolver ) && ( resolved != resolver )
					while( loop )
					{
						resolved = IBeanResolver( resolved ).resolve(
							this.document, this, bean );
						loop = ( resolved is IBeanResolver )
							&& ( resolved != resolver );
					}

					//didn't resolve correctly as the result
					//still points to an expression
					if( resolved is IBeanResolver )
					{
						throw new BeanError(
							BeanError.BEAN_REFERENCE_ERROR,
							getQualifiedClassName( resolver ),
							resolver.beanName,
							resolver.name,
							resolver.value );
					}
					
					output[ z ] = resolved;
				}else{
					//pass through intact
					output[ z ] = bean[ z ];
				}
			}
			
			return output;
		}
		
		/**
		* 	@private
		*/
		private function resolveConstants( bean:Object ):Object
		{
			var output:Object = new Object();
			if( bean )
			{
				var z:String = null;
				for( z in bean )
				{
					if( bean[ z ] is BeanConstant )
					{
						output[ z ] = BeanConstant(
							bean[ z ] ).resolve( this.document, this, bean );
					}else{
						output[ z ] = bean[ z ];
					}
				}
			}
			return output;
		}
		
		/**
		* 	@private
		*/
		private function isMethodReference( properties:Object ):Boolean
		{
			return properties && properties[ BeanConstants.METHOD_PROPERTY ]
				&& ( properties[ BeanConstants.METHOD_PROPERTY ] is BeanMethod );
		}
		
		/**
		* 	@private
		*/
		private function getMethod( properties:Object, target:Object ):Function
		{
			//handle method references
			if( isMethodReference( properties ) )
			{
				return BeanMethod( properties[ BeanConstants.METHOD_PROPERTY ] ).resolve(
					this.document, this, target ) as Function;
			}
			return null;
		}		
	}
}