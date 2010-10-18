package com.ffsys.io.loaders.resources {
	
	import flash.events.EventDispatcher;
	
	/**
	*	Abstract super class for all loaded resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class AbstractResource extends EventDispatcher
		implements IResource {
			
		private var _id:String;
		private var _data:Object;
		private var _uri:String;
		private var _bytesTotal:uint;
		
		public function AbstractResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super();
			this.data = data;
			this.uri = uri;
			this.bytesTotal = bytesTotal;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}		
		
		public function set bytesTotal( value:uint ):void
		{
			_bytesTotal = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get data():Object
		{
			return _data;
		}		
		
		public function set data( value:Object ):void
		{
			_data = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get uri():String
		{
			return _uri;
		}				
		
		public function set uri( val:String ):void
		{
			_uri = val;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			return _id;
		}		
		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function destroy():void
		{
			_data = null;
			_uri = null;
			_id = null;
		}
	}
}