package com.ffsys.di
{
	import flash.events.EventDispatcher;
	
	import com.ffsys.utils.substitution.IBindingCollection;
	
	public class BeanDocument extends EventDispatcher
		implements IBeanDocument
	{		
		private var _id:String;
		private var _bindings:IBindingCollection;
		private var _beans:Vector.<IBeanDescriptor> = new Vector.<IBeanDescriptor>();
		private var _constants:Object;
		
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
		*	@inheritDoc
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
	}
}