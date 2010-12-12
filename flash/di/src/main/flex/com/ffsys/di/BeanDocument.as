package com.ffsys.di
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
				&& !hasBeanDescriptor( descriptor ) )
			{
				descriptor.document = this;
				_beans.push( descriptor );
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
				if( descriptor.isBean() )
				{
					return descriptor.getBean();
				}else{
					return descriptor.getProperties();
				}
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
			
			//TODO: ensure file dependency and bindings are also destroyed
			
			//null references
			_id = null;
			_delimiter = null;
			_bindings = null;
			_beans = null;
			_files = null;
		}
	}
}