package com.ffsys.io.loaders.core {
	
	/**
	*	Handles global settings for all ILoader instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.09.2007
	*/
	public class LoadManager extends Object {
		
		static private var _globalCachePrevention:Boolean = false;
		
		/**
		*	@private	
		*/
		public function LoadManager()
		{
			super();
		}
		
		static public function setGlobalCachePrevention( value:Boolean ):void
		{
			_globalCachePrevention = value;
		}
		
		static public function getGlobalCachePrevention():Boolean
		{
			return _globalCachePrevention;
		}
		
		static public function getGlobalCachePreventionString():String
		{
			var date:Date = new Date();
			return "?unix=" + date.getTime();
		}
	}
}