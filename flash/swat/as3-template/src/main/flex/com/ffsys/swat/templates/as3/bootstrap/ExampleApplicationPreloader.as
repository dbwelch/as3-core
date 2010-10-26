package com.ffsys.swat.templates.as3.bootstrap
{
	import com.ffsys.swat.view.SwatApplicationPreloader;
	
	import com.ffsys.swat.templates.as3.bootstrap.ExampleClassConfiguration;
	import com.ffsys.swat.templates.as3.bootstrap.ExampleFlashVariables;
	import com.ffsys.swat.templates.as3.view.ExampleApplicationPreloadView;
	
	/**
	*	Custom application preloader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ExampleApplicationPreloader extends SwatApplicationPreloader
	{		
		/**
		* 	Creates an <code>ExampleApplicationPreloader</code> instance.
		*/
		public function ExampleApplicationPreloader()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getRuntimeClasses():Array
		{
			var output:Array = super.getRuntimeClasses();
			output.push( ExampleClassConfiguration );
			output.push( ExampleFlashVariables );
			output.push( ExampleApplicationPreloadView );
			return output;
		}
	}
}