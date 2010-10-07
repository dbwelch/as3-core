package com.ffsys.swat.view {
	
	import com.ffsys.swat.events.RslEvent;
	import com.ffsys.swat.configuration.IConfiguration;
	
	/**
	*	Describes the contract for views that handle the application
	*	load process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public interface IApplicationPreloadView {
		
		/**
		*	Invoked when the instance is added to the display list.	
		*/
		function created():void;
		
		/**
		*	Invoked while the main code base is being loaded.
		*/
		function code( event:RslEvent ):void;
		
		/**
		*	Invoked when a runtime resource could not be found.
		*/
		function resourceNotFound( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the configuration load process.
		*/
		function configuration( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the messages file
		*	load process.
		*/
		function message( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the errors file
		*	load process.
		*/
		function error( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the rsl load process.
		*/
		function rsl( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the XML load process.
		*/
		function xml( event:RslEvent ):void;		
		
		/**
		*	Invoked with events related to the font load process.
		*/
		function font( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the image load process.
		*/
		function image( event:RslEvent ):void;
		
		/**
		*	Invoked with events related to the sound load process.
		*/
		function sound( event:RslEvent ):void;
		
		/**
		*	Invoked when all runtime assets have been loaded.
		*/
		function complete( event:RslEvent ):void;
	}
}