package com.ffsys.swat.configuration {
	
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.types.MovieLoader;	
	
	/**
	*	Encapsulates a collection of runtime shared libraries.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class RuntimeSharedLibraryCollection extends AbstractConfigurationCollection
		implements IDeserializeProperty {
		
		private var _queue:ILoaderQueue = new LoaderQueue();
		
		/**
		*	Creates a <code>RuntimeSharedLibraryCollection</code> instance.
		*/
		public function RuntimeSharedLibraryCollection()
		{
			super();
		}
		
		/**
		* 	Gets the loader queue used to load the runtime shared
		* 	libraries.
		* 
		* 	@return The runtime shared library loader queue.
		*/
		public function get queue():ILoaderQueue
		{
			return _queue;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( value is RuntimeSharedLibrary )
			{
				var lib:RuntimeSharedLibrary = RuntimeSharedLibrary( value );
				//store the library reference
				this.push( lib );
				
				var request:URLRequest = new URLRequest( lib.url );
				var loader:MovieLoader = new MovieLoader( request );
				
				if( lib.trusted )
				{
					loader.context =
						new LoaderContext( false, ApplicationDomain.currentDomain );
				}
				
				queue.addLoader( loader.request, loader );
			}
		}
	}
}