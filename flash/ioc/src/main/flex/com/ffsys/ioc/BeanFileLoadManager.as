package com.ffsys.ioc
{
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	/**
	*	Responsible for managing all lazily instantiated bean
	* 	file dependency loader queues.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.12.2010
	*/
	public class BeanFileLoadManager extends LoaderQueue
	{
		/**
		* 	Creates a <code>BeanFileLoadManager</code> instance.
		*/
		public function BeanFileLoadManager()
		{
			super();
			addEventListener( LoadEvent.LOAD_COMPLETE, allItemsLoaded );
		}
		
		private function allItemsLoaded( event:LoadEvent ):void
		{
			//clear all loaded elements in preparation for
			//any more bean retrieval
			clear();
		}
	}
}