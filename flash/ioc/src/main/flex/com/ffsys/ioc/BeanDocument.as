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
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanDocument extends EventDispatcher
		implements IBeanDocument
	{		
		private var _id:String;
		private var _delimiter:String = "|";		
		private var _bindings:IBindingCollection = new BindingCollection();
		private var _beans:Vector.<IBeanDescriptor> = new Vector.<IBeanDescriptor>();
		private var _files:Vector.<BeanFileDependency> = null;
		private var _injector:IBeanInjector;
		
		/**
		* 	Creates a <code>BeanDocument</code> instance.
		*/
		public function BeanDocument()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get injector():IBeanInjector
		{
			if( !_injector )
			{
				var descriptor:IBeanDescriptor = getBeanDescriptor( BeanConstants.INJECTOR_NAME );	
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
		public function get files():Vector.<BeanFileDependency>
		{
			if( _files == null )
			{
				_files = new Vector.<BeanFileDependency>();
			}
			
			return _files;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get dependencies():ILoaderQueue
		{
			var output:ILoaderQueue = new LoaderQueue();
			if( this.files != null )
			{
				for( var i:int = 0;i < this.files.length;i++ )
				{
					output.addLoader( files[ i ].getLoader() );
				}
			}
			return output;
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
				BeanConstants.CONSTANTS_PROPERTY_NAME );
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
		*	An identifier for this document.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
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
					var policy:String = descriptor.policy;
					//nothing to do on existing bean match
					if( policy == BeanCreationPolicy.NONE )
					{
						return false;
					}else if( policy == BeanCreationPolicy.REPLACE )
					{
						//remove the existing bean
						removeBeanDescriptor( existing );
						//add the new one
						_beans.push( descriptor );
					}else if( policy == BeanCreationPolicy.CHANGE
					 	&& descriptor.instanceClass != null )
					{
						//just change the implementation
						existing.instanceClass = descriptor.instanceClass;
					}else if( policy == BeanCreationPolicy.MERGE )
					{
						//TODO
						trace("BeanDocument::addBeanDescriptor()", "MERGE BEANS" );
						
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
		public function getBeanDescriptor( beanName:String ):IBeanDescriptor
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
			var descriptor:IBeanDescriptor = getBeanDescriptor( beanName );
			if( descriptor )
			{
				return descriptor.getBean();
			}
			return null;
		}
		
		/**
		* 	Destroys this bean document.
		*/
		public function destroy():void
		{
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
			_id = null;
			_delimiter = null;
			_bindings = null;
			_beans = null;
			_files = null;
		}
	}
}