package com.ffsys.ioc
{
	import flash.events.EventDispatcher;

	import com.ffsys.io.loaders.core.ILoader;	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;	
	import com.ffsys.utils.substitution.BindingCollection;
	import com.ffsys.utils.substitution.IBindingCollection;
	
	/**
	*	Encapsulates a collection of beans.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 10.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanDocument extends BeanElement
		implements IBeanDocument
	{		
		private var _delimiter:String = "|";		
		private var _bindings:IBindingCollection = new BindingCollection();
		private var _beans:Vector.<IBeanDescriptor> = new Vector.<IBeanDescriptor>();
		private var _injector:IBeanInjector;
		private var _locked:Boolean = true;
		private var _policy:String = null;
		private var _types:Vector.<BeanTypeInjector> = new Vector.<BeanTypeInjector>();
		private var _xrefs:Vector.<IBeanDocument> = new Vector.<IBeanDocument>();
		
		/**
		* 	Creates a <code>BeanDocument</code> instance.
		* 
		* 	@param id An identifier for this bean element.
		*/
		public function BeanDocument( id:String = null )
		{
			super( id );
			configure();
		}
		
		/**
		* 	Configures the default beans for this document.
		*/
		protected function configure():void
		{
			//BEAN_ELEMENT_PARSER
			
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				BeanNames.BEAN_ELEMENT_PARSER );
			descriptor.instanceClass = BeanTextElementParser;
			addBeanDescriptor( descriptor );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get types():Vector.<BeanTypeInjector>
		{
			return _types;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xrefs():Vector.<IBeanDocument>
		{
			return _xrefs;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get policy():String
		{
			return _policy;
		}
		
		public function set policy( value:String ):void
		{
			_policy = value;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get locked():Boolean
		{
			return _locked;
		}
		
		public function set locked( value:Boolean ):void
		{
			_locked = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get injector():IBeanInjector
		{
			if( !_injector )
			{
				var descriptor:IBeanDescriptor = getBeanDescriptor( BeanNames.INJECTOR_NAME );	
				if( descriptor != null )
				{
					var injector:Object = descriptor.getBean( false );
					if( !( injector is IBeanInjector ) )
					{
						throw new BeanError(
							"The specified injector bean does not adhere to the bean injector interface." );
					}
					return IBeanInjector( injector );
				}
			}
			return _injector;
		}
		
		public function set injector( value:IBeanInjector ):void
		{
			_injector = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get delimiter():String
		{
			return _delimiter;
		}
		
		public function set delimiter( value:String ):void
		{
			_delimiter = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parse( text:String, parser:IBeanParser = null ):ILoaderQueue
		{
			if( parser == null )
			{
				parser = new BeanTextParser( this );
			}
			
			//reset the file list
			_files = new Vector.<BeanFileDependency>();
			
			parser.document = this;
			parser.parse( text );
			return this.dependencies;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get constants():Object
		{
			var descriptor:IBeanDescriptor = getBeanDescriptor(
				BeanNames.CONSTANTS_PROPERTY_NAME );
			if( descriptor )
			{
				return descriptor.getProperties();
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			_beans = new Vector.<IBeanDescriptor>();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get bindings():IBindingCollection
		{
			return _bindings;
		}
		
		public function set bindings( bindings:IBindingCollection ):void
		{
			_bindings = bindings;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():uint
		{
			return _beans.length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get beanNames():Array
		{
			var output:Array = new Array();
			var bean:IBeanDescriptor = null;
			for( var i:int = 0;i < _beans.length;i++ )
			{
				bean = _beans[ i ];
				output.push( bean.id );
			}
			return output;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function hasBeanDescriptor( descriptor:IBeanDescriptor ):Boolean
		{
			var index:int = _beans.indexOf( descriptor );
			if( index > -1 )
			{
				return true;
			}
			var bean:IBeanDescriptor = null;
			for( var i:int = 0;i < _beans.length;i++ )
			{
				bean = _beans[ i ];
				if( ( bean.id != null && descriptor.id != null ) && bean.id == descriptor.id )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function addBeanDescriptor( descriptor:IBeanDescriptor ):Boolean
		{
			if( descriptor
				&& descriptor.id )
			{
				descriptor.document = this;				
				var existing:IBeanDescriptor = getBeanDescriptor(
					descriptor.id );

				if( existing )
				{
					if( this.locked )
					{
						throw new BeanError(
							BeanError.BEAN_MODIFICATION_ERROR, existing.id );
					}
					
					//nothing to do on existing bean match
					if( this.policy == BeanCreationPolicy.NONE )
					{
						return false;
					}else if( this.policy == BeanCreationPolicy.REPLACE )
					{
						//remove the existing bean
						removeBeanDescriptor( existing );
						//add the new one
						_beans.push( descriptor );
					}else if( this.policy == BeanCreationPolicy.CHANGE
					 	&& descriptor.instanceClass != null )
					{
						//just change the implementation
						existing.instanceClass = descriptor.instanceClass;
					}else if( this.policy == BeanCreationPolicy.MERGE )
					{
						//update the implementation if one is available
						//in the new descriptor
						if( descriptor.instanceClass != null )
						{
							existing.instanceClass = descriptor.instanceClass;
						}
						
						//merge in the properties or the new definition
						//with the existing definition
						existing.merge( descriptor );
					}
				}else{
					_beans.push( descriptor );
				}
				handleBeanDescriptorFileDependencies( descriptor );
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeBeanDescriptor( descriptor:IBeanDescriptor ):Boolean
		{
			if( descriptor )
			{
				var bean:IBeanDescriptor = null;
				for( var i:int = 0;i < _beans.length;i++ )
				{
					bean = _beans[ i ];
					if( bean == descriptor )
					{
						_beans.splice( i, 1 );
						return true;
					}
				}
			}
			return false;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function getBeanDescriptor( beanName:String, xrefs:Boolean = false ):IBeanDescriptor
		{
			var bean:IBeanDescriptor = null;
			for( var i:int = 0;i < _beans.length;i++ )
			{
				bean = _beans[ i ];
				if( bean.id == beanName )
				{
					return bean;
				}
			}
			
			//search document xrefs for descriptors
			if( xrefs === true && this.xrefs.length > 0 )
			{
				var document:IBeanDocument = null;
				for( i = 0;i < this.xrefs.length;i++ )
				{
					document = this.xrefs[ i ];		
					if( document != null )
					{
						bean = document.getBeanDescriptor( beanName );
						if( bean != null )
						{
							return bean;
						}
					}
				}
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getBeanByType( beanName:String, types:Vector.<Class> ):Object
		{
			var bean:Object = null;
			if( beanName != null && types != null )
			{
				var descriptor:IBeanDescriptor = getBeanDescriptor( beanName );
				if( descriptor )
				{
					bean = descriptor.getBean();
					var type:Class = null;
					for( var i:int = 0;i < types.length;i++ )
					{
						type = types[ i ];
						if( type && bean is type )
						{
							return bean;
						}
					}
				}
			}
			return bean;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function copy( document:IBeanDocument ):uint
		{
			if( document != null )
			{
				var names:Array = document.beanNames;
				var descriptor:IBeanDescriptor = null;
				for( var i:int = 0;i < names.length;i++ )
				{
					descriptor = document.getBeanDescriptor( names[ i ] );
					addBeanDescriptor( descriptor );
				}
			}
			return this.length;
		}

		/**
		* 	@inheritDoc
		*/
		public function getBean( beanName:String ):Object
		{
			var instance:Object = null;
			var descriptor:IBeanDescriptor = getBeanDescriptor( beanName, true );

			if( descriptor != null )
			{
				//look in this document first
				instance = descriptor.getBean();
				if( instance != null )
				{
					return instance;
				}
			}
			
			//check cross referenced documents
			
			/*
			if( this.xrefs.length > 0 )
			{
				var document:IBeanDocument = null;
				for( var i:int = 0;i < this.xrefs.length;i++ )
				{
					document = xrefs[ i ];
					if( document != null )
					{
						instance = document.getBean( beanName );
						if( instance != null )
						{
							return instance;
						}
					}
				}
			}
			*/
			
			//TODO: make this configurable (strict?), stylesheet bean documents need to be able to retrieve
			//null for non-existent beans
			/*
			if( !instance )
			{
				throw new BeanError( BeanError.BEAN_NOT_FOUND, beanName );
			}
			*/
			
			return null;
		}
		
		/**
		*	@private
		*/
		protected function handleBeanDescriptorFileDependencies( descriptor:IBeanDescriptor ):void
		{
			//handle storing file dependencies
			if( descriptor != null )
			{
				var z:String = null;
				var output:Object;
				
				for( z in descriptor.properties )
				{
					if( descriptor.properties.hasOwnProperty( z ) )
					{
						output = descriptor.properties[ z ];
						if( output is BeanFileDependency )
						{
							var files:Vector.<BeanFileDependency> = 
								( descriptor.filePolicy == BeanFilePolicy.DOCUMENT_FILE_POLICY )
									? this.files : descriptor.files;
								
							//ensure import expressions have the correct document reference
							if( BeanFileDependency( output ).loaderClass == BeanLoader )
							{
								BeanFileDependency( output ).properties = { document: this };
							}
								
							if( files != null )
							{
								files.push(
									BeanFileDependency( output ) );
							}
						}
					}
				}
			}
		}	
		
		/**
		* 	Destroys this bean document.
		*/
		override public function destroy():void
		{
			super.destroy();
			//destroy child bean descriptors
			var bean:IBeanDescriptor = null;
			for( var i:int = 0;i < _beans.length;i++ )
			{
				bean = _beans[ i ];
				if( bean )
				{
					bean.destroy();
				}
			}
			
			//clear all stored beans
			clear();
			
			//TODO: ensure bindings are also destroyed
			
			//null references
			_delimiter = null;
			_bindings = null;
			_beans = null;
			_types = null;
		}
	}
}