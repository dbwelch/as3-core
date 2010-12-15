package com.ffsys.ioc.support
{
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	
	/**
	*	Abstract super class for implementations this build a queue
	* 	of resources to load.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class LoaderBuilder extends Object
		implements ILoaderBuilder
	{
		private var _loaderFactory:ILoaderFactory;
		private var _loaderQueueClass:Class = LoaderQueue;
		private var _extension:String;
		private var _prefix:String;
		
		/**
		* 	Creates a <code>LoaderBuilder</code> instance.
		*/
		public function LoaderBuilder()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get extension():String
		{
			return _extension;
		}
		
		public function set extension( value:String ):void
		{
			_extension = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get prefix():String
		{
			return _prefix;
		}
		
		public function set prefix( value:String ):void
		{
			_prefix = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loaderFactory():ILoaderFactory
		{
			return _loaderFactory;
		}
		
		public function set loaderFactory( value:ILoaderFactory ):void
		{
			_loaderFactory = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFileList():Vector.<String>
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loaderQueueClass():Class
		{
			return _loaderQueueClass;
		}
		
		public function set loaderQueueClass( value:Class ):void
		{
			_loaderQueueClass = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderQueue():ILoaderQueue
		{
			if( this.loaderQueueClass == null )
			{
				throw new Error( "A loader builder cannot create a loader queue with a null loader queue class." );				
			}
			
			if( this.loaderFactory == null )
			{
				throw new Error( "A loader builder cannot retrieve a loader with no loader factory reference." );
			}
			
			var files:Vector.<String> = getFileList();
			var output:ILoaderQueue = new loaderQueueClass();
			var loader:ILoader = null;
			var file:String = null;
			if( files != null )
			{
				for( var i:int = 0;i < files.length;i++ )
				{
					file = files[ i ];
					loader = this.loaderFactory.getLoaderByFileExtension(
						this.extension );
					loader.request = new URLRequest( file );
					output.addLoader( loader );
				}
			}
			
			return output;
		}
	}
}