package com.ffsys.swat.core
{
	import com.ffsys.io.loaders.resources.IResourceList;
	
	import com.ffsys.ioc.IBeanDocument;	
	
	/**
	* 	Encapsulates the data for a loaded component.
	* 
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.12.2010
	*/
	public class ComponentResource extends Object
		implements IComponentResource
	{
		private var _id:String;
		private var _resources:IResourceList;
		private var _target:Object;
		private var _document:IBeanDocument;
		
		/**
		* 	Creates a <code>ComponentResource</code> instance.
		* 
		* 	@param id The identifier for the component.
		* 	@param resources The list of resources the component
		* 	loaded.
		*/
		public function ComponentResource(
			id:String = null,
			resources:IResourceList = null )
		{
			super();
			this.id = id;
			this.resources = resources;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get resources():IResourceList
		{
			return _resources;
		}
		
		public function set resources( value:IResourceList ):void
		{
			_resources = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get target():Object
		{
			return _target;
		}
		
		public function set target( value:Object ):void
		{
			_target = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}
	}
}