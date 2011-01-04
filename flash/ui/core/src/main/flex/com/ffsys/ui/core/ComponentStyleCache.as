package com.ffsys.ui.core
{
	
	
	public class ComponentStyleCache extends Object
		implements IComponentStyleCache
	{
		private var _styleNames:Array;
		private var _styleObjects:Array;
		private var _styles:String;
		private var _main:Object;
		
		/**
		* 	Creates a <code>ComponentStyleCache</code> instance.
		*/
		public function ComponentStyleCache()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get main():Object
		{
			return _main;
		}
		
		public function set main( value:Object ):void
		{
			_main = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleNames():Array
		{
			return _styleNames;
		}
		
		public function set styleNames( value:Array ):void
		{
			_styleNames = value;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function get styleObjects():Array
		{
			return _styleObjects;
		}
		
		public function set styleObjects( value:Array ):void
		{
			_styleObjects = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styles():String
		{
			return _styles;
		}
		
		public function set styles( value:String ):void
		{
			_styles = value;
		}
	}
}