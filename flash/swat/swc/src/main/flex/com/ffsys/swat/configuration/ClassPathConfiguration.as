package com.ffsys.swat.configuration
{
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.swat.core.SwatFlashVariables;
	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	/**
	*	Default implementation of the class path configuration
	* 	contract.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class ClassPathConfiguration extends Object
		implements IClassPathConfiguration {
		
		/**
		* 	Creates a <code>ClassPathConfiguration</code> instance.
		*/
		public function ClassPathConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getMainClassPath():String
		{
			return "com.ffsys.swat.view.SwatApplication";
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFlashVariablesClassPath():String
		{
			return "com.ffsys.swat.core.SwatFlashVariables";
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getPreloadViewClassPath():String
		{
			throw new Error(
				"You must specify the application preload view class path in your concrete class configuration." );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getConfigurationParserClassPath():String
		{
			return "com.ffsys.swat.configuration.ConfigurationParser";
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function getConfigurationClassPath():String
		{
			return "com.ffsys.swat.configuration.Configuration";
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getMainClassInstance():Object
		{
			var classPath:String = getMainClassPath();
			var clz:Class = null;
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate main application class with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			return instance;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getApplicationPreloadViewInstance():Object
		{
			var classPath:String = getPreloadViewClassPath();
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate application preload view with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			return instance;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFlashVariablesInstance(
			root:DisplayObject ):Object
		{
			var classPath:String = getFlashVariablesClassPath();
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate flash variables with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz( root );
			return instance;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getConfigurationParserInstance():Object
		{
			var classPath:String = getConfigurationParserClassPath();
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not configuration parser with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			return instance;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function getConfigurationInstance():Object
		{
			var classPath:String = getConfigurationClassPath();
			var clz:Class = null;
			
			try
			{
				clz = Class(
					getDefinitionByName( classPath ) );
			}catch( e:Error )
			{
				throw new Error(
					"Could not locate configuration with class path '"
					+ classPath + "'" );
			}
			
			var instance:Object = new clz();
			return instance;
		}
	}
}