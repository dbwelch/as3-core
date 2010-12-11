package com.ffsys.io.loaders.core {
	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.resources.IResourceList;
	import com.ffsys.io.loaders.resources.IResource;
	
	import com.ffsys.utils.identifier.IdentifierUtils;
	
	/**
	*	Decorates classes that implement the
	*	<code>ILoader</code> interface but can
	*	change the inheritance hierarchy depending
	*	upon the type of load operation required.
	*	
	*	Implementors of <code>ILoader</code> may extend
	*	<code>URLLoader</code>, <code>URLStream</code> or
	*	another type of loader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.08.2007
	*/
	public class LoaderDecorator extends Object
		implements 	ILoaderParameters,
		 			IForceLoad {
		
		/**
		*	@private	
		*/
		protected var _customData:Object;
		
		/**
		*	@private	
		*/	
		protected var _list:IResourceList;

		/**
		*	@private	
		*/
		protected var _resource:IResource;

		/**
		*	@private	
		*/	
		protected var _id:String;

		/**
		*	@private	
		*/	
		protected var _request:URLRequest;

		/**
		*	@private	
		*/	
		protected var _options:ILoadOptions;

		/**
		*	@private	
		*/	
		protected var _queue:ILoaderQueue;

		/**
		*	@private	
		*/	
		protected var _forceLoad:Boolean;
		
		/**
		* 	Creates a <code>LoaderDecorator</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function LoaderDecorator(
			request:URLRequest,
			options:ILoadOptions = null )
		{
			super();
			
			if( !options )
			{
				options = new LoadOptions();
			}
			
			this.options = options;
			this.request = request;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set list( val:IResourceList ):void
		{
			_list = val;
		}
		
		public function get list():IResourceList
		{
			return _list;
		}		
		
		/**
		*	@inheritDoc	
		*/		
		public function set customData( val:Object ):void
		{
			_customData = val;
		}
		
		public function get customData():Object
		{
			return _customData;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set resource( val:IResource ):void
		{
			_resource = val;
			
			//pass our id into the resource
			if( val && id )
			{
				val.id = id;
			}
		}
		
		public function get resource():IResource
		{
			return _resource;
		}			
		
		/**
		*	An identifier for this decorator.
		*/		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			
			//trace( "LoaderDecorator get id : " + this );
			
			if( !_id )
			{
				_id = getAutomaticId();
				
				//trace( "LoaderDecorator set auto id : " + _id );
			}
			
			return _id;
		}		
		
		/**
		*	@inheritDoc	
		*/		
		public function set queue( val:ILoaderQueue ):void
		{
			_queue = val;
		}
		
		public function get queue():ILoaderQueue
		{
			return _queue;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set options( val:ILoadOptions ):void
		{
			_options = val;
		}
		
		public function get options():ILoadOptions
		{
			return _options;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set request( val:URLRequest ):void
		{
			_request = val;
			
			if( _request && options.autoGenerateId )
			{
				this.id = getAutomaticId();
			}
		}
		
		public function get request():URLRequest
		{
			return _request;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set forceLoad( val:Boolean ):void
		{
			_forceLoad = val;
		}
		
		public function get forceLoad():Boolean
		{
			return _forceLoad;
		}						
		
		/**
		*	@inheritDoc	
		*/		
		public function set uri( val:String ):void
		{
			this.request = new URLRequest( val );
		}
		
		public function get uri():String
		{
			if( _request )
			{
				return _request.url;
			}
			
			return null;
		}
		
		/**
		*	@private	
		*/
		private function getAutomaticId():String
		{
			if( this.uri )
			{
				
				var autoId:String = IdentifierUtils.getFileNameId( this.uri );
				
				//trace( "getAutomaticId: " + autoId );
				
				return autoId;
			}
			
			return null;
		}
	}
}