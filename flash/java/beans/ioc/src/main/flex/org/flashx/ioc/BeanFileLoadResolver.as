package org.flashx.ioc
{
	import org.flashx.io.loaders.core.*;
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
	/**
	*	Responsible for resolving loaded dependencies
	* 	as they become available.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.12.2010
	*/
	public class BeanFileLoadResolver extends Object
	{
		private var _element:IBeanElement;
		private var _queue:ILoaderQueue;
		private var _target:Object;
		
		/**
		* 	Creates a <code>BeanFileLoadResolver</code> instance.
		* 	
		* 	@param element The bean element that triggered the load request.
		* 	@param queue The loader queue handling resolving the files.
		* 	@param target A target implementation that should have the resolved
		* 	properties assigned to.
		*/
		public function BeanFileLoadResolver(
			element:IBeanElement = null,
			queue:ILoaderQueue = null,
			target:Object = null )
		{
			super();
			this.element = element;
			this.queue = queue;
			this.target = target;
		}
		
		/**
		* 	The loader queue being managed.
		*/
		public function get queue():ILoaderQueue
		{
			return _queue;
		}
		
		public function set queue( value:ILoaderQueue ):void
		{
			if( this.queue )
			{
				removeQueueListeners();
			}		
			
			_queue = value;
			
			if( this.queue )
			{
				addQueueListeners();
			}
		}
		
		/**
		* 	The bean element that started the load operation.
		*/
		public function get element():IBeanElement
		{
			return _element;
		}
		
		public function set element( value:IBeanElement ):void
		{
			_element = value;
		}
		
		/**
		* 	A target object that should receive
		* 	notifications as file dependencies are resolved.
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
		* 	Gets the bean document related to this file load
		* 	resolve operation.
		*/
		public function get document():IBeanDocument
		{
			if( this.element is IBeanDocument )
			{
				return IBeanDocument( this.element );
			}else if( this.element is IBeanDescriptor )
			{
				return IBeanDescriptor( this.element ).document;
			}
			return null;
		}
		
		/**
		* 	Attempts to retrieve the bean element as a bean descriptor.
		*/
		public function get descriptor():IBeanDescriptor
		{
			if( this.element is IBeanDescriptor )
			{
				return IBeanDescriptor( this.element );
			}
			return null;
		}
		
		/**
		* 	Determines whether the target object is an observer
		* 	implementation.
		*/
		public function get observer():IBeanLoadObserver
		{
			return ( this.target as IBeanLoadObserver );
		}
		
		/**
		*	@private
		*/
		private function resolveFileDependency( event:LoadEvent ):void
		{
			var dependency:BeanFileDependency = event.loader.customData as BeanFileDependency;

			if( dependency != null )
			{
				//we change the bean property sent to be resolved
				//based upon whether the resource was found
				//when it is found the data encapsulated by the resource
				//is passed to resolve otherwise it is the loader that attempted
				//to load the file
				
				//resolve in the context of the document
				if( this.descriptor == null
				 	|| this.descriptor.filePolicy == BeanFilePolicy.DOCUMENT_FILE_POLICY )
				{

					resolveDocumentLevelFileDependency( dependency, event );
				//resolve in the context of a bean descriptor
				}else if( this.descriptor )
				{
					resolveBeanLevelFileDependency( dependency, event );
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function resolveDocumentLevelFileDependency(
			dependency:BeanFileDependency, event:LoadEvent ):void
		{
			var result:Object = event.type == LoadEvent.RESOURCE_NOT_FOUND
				? event.loader : IResource( event.resource ).data;
			dependency.resolve(
				this.document,
				this.descriptor,
				result );
		}
		
		/**
		* 	@private
		*/
		private function resolveBeanLevelFileDependency(
			dependency:BeanFileDependency, event:LoadEvent ):void
		{
			var result:Object = event.type == LoadEvent.RESOURCE_NOT_FOUND
				? event.loader : IResource( event.resource ).data;
			
			//operating on an instantiated bean
			if( this.target != null && this.descriptor )
			{
				var hasProp:Boolean = this.target.hasOwnProperty( dependency.name );

				//obey any observer implementation
				if( this.observer )
				{
					var process:Boolean = observer.shouldProcessResource(
						IResource( event.resource ), this.descriptor, dependency );
					
					//the bean processes the resource so we
					//defer responsibility	
					if( process )
					{
						//defer property setting to the observer
						hasProp = false;
						observer.doWithResource(
							IResource( event.resource ), this.descriptor, dependency );
					}
				}
				
				if( hasProp )
				{
					//attempt to set the property
					descriptor.setBeanProperty( target, dependency.name, result );					
				}
			}
		}
		
		/**
		*	@private
		*/
		private function dependenciesLoaded( event:LoadEvent ):void
		{
			if( this.observer != null
				&& this.descriptor != null )
			{
				this.observer.doWithResourceList(
					IResourceList( queue.resource ), this.descriptor );
			}
			removeQueueListeners();
		}
		
		/**
		* 	@private
		* 
		* 	Adds listeners to the queue being managed.
		*/
		private function addQueueListeners():void
		{
			if( this.queue )
			{
				this.queue.addEventListener( LoadEvent.DATA, resolveFileDependency );
				this.queue.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, resolveFileDependency );				
				this.queue.addEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
			}
		}
		
		/**
		* 	@private
		* 
		* 	Removes listeners to the queue being managed.
		*/
		private function removeQueueListeners():void
		{
			if( this.queue )
			{
				this.queue.removeEventListener( LoadEvent.DATA, resolveFileDependency );
				this.queue.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, resolveFileDependency );
				this.queue.removeEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
			}
		}		
	}
}