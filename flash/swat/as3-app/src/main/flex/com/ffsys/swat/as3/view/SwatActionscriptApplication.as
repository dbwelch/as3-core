package com.ffsys.swat.as3.view
{
	import com.ffsys.swat.view.SwatApplication;	
	import com.ffsys.swat.as3.core.ApplicationFlashVariables;
	
	/**
	*	Application entry point.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class SwatActionscriptApplication extends SwatApplication
	{
		static private var _container:SwatActionscriptContainer;
		
		/**
		* 	Creates a SwatActionscriptApplication instance.
		*/
		public function SwatActionscriptApplication()
		{
			super();
		}
		
		override protected function ready():void
		{
			this.preloader.view = null;
			super.ready();
		}
	}
}