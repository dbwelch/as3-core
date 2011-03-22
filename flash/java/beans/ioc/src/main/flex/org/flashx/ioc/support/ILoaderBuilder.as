package org.flashx.ioc.support
{
	import org.flashx.io.loaders.core.ILoaderQueue;	
	
	/**
	*	Describes the contract for loader builder implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public interface ILoaderBuilder
	{
		/**
		* 	The file extension to use when building the file list.
		*/
		function get extension():String;
		function set extension( value:String ):void;
		
		/**
		* 	A prefix to use when building the file path.
		*/
		function get prefix():String;
		function set prefix( value:String ):void;
		
		
		/**
		* 	The class of loader queue to instantiate.
		*/
		function get loaderQueueClass():Class;
		function set loaderQueueClass( value:Class ):void;
		
		/**
		* 	A factory used to instantiate the loaders.
		*/
		function get loaderFactory():ILoaderFactory;
		function set loaderFactory( value:ILoaderFactory ):void;
		
		/**
		* 	Builds a list of all the files this builder represents.
		* 
		* 	@return A list of file paths for this builder.
		*/
		function getFileList():Vector.<String>;
		
		/**
		* 	Gets a loader queue created by this builder.
		* 
		* 	@return A queue created by this builder.
		*/
		function getLoaderQueue():ILoaderQueue;
	}
}