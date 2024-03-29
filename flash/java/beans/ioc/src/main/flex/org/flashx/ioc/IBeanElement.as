package org.flashx.ioc
{
	import flash.events.IEventDispatcher;
		
	import org.flashx.core.IDestroy;	
	import org.flashx.core.IStringIdentifier;
	
	import org.flashx.io.loaders.core.ILoaderQueue;	

	/**
	*	Describes the contract for bean elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.12.2010
	*/
	public interface IBeanElement
		extends	IDestroy,
				IStringIdentifier,
				IEventDispatcher
	{
		
		/**
		* 	Determines the file resolution policy for this bean element.
		*/
		function get filePolicy():String;
		function set filePolicy( value:String ):void;
		
		/**
		* 	A collection of external file dependencies found when
		* 	the bean document was parsed.
		*/
		function get files():Vector.<BeanFileDependency>;
		function set files( value:Vector.<BeanFileDependency> ):void;
		
		/**
		*	A queue that represents the dependencies that
		*	were found when the beans were parsed.
		*/
		function get dependencies():ILoaderQueue;	
	}
}