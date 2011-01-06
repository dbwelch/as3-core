package com.ffsys.ioc
{
	import flash.events.EventDispatcher;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	
	/**
	*	Abstract super class for bean elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.12.2010
	*/
	public class BeanElement extends EventDispatcher
		implements IBeanElement
	{
		private var _id:String = null;
		private var _filePolicy:String = null;
		
		/**
		* 	@private
		*/
		protected var _files:Vector.<BeanFileDependency> = null;
		
		/**
		* 	Creates a <code>BeanElement</code> instance.
		* 
		* 	@param id An identifier for this bean element.
		*/
		public function BeanElement( id:String = null )
		{
			super();
			this.id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get filePolicy():String
		{
			return _filePolicy;
		}
		
		public function set filePolicy( value:String ):void
		{
			_filePolicy = value;
		}		
		
		/**
		*	An identifier for this element.
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
		public function get files():Vector.<BeanFileDependency>
		{
			if( _files == null )
			{
				_files = new Vector.<BeanFileDependency>();
			}
			
			return _files;
		}
		
		public function set files( value:Vector.<BeanFileDependency> ):void
		{
			_files = value;
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
		* 	Destroys this bean document.
		*/
		public function destroy():void
		{
			//null references
			_id = null;
			_files = null;
			_filePolicy = null;
		}
	}
}