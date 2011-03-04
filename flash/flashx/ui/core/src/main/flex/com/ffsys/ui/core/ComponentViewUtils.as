package com.ffsys.ui.core
{
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	/**
	*	Encapsulates utility properties and methods available to all
	* 	components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class ComponentViewUtils extends Object
		implements IComponentViewUtils
	{
		/**
		* 	@private
		*/
		internal var _stage:Stage;
		
		/**
		* 	@private
		*/
		internal var _root:DisplayObject;
		
		/**
		*	@private	
		*/
		internal var _renderer:IComponentRenderer;
		
		/**
		* 	@private
		*/
		private static var _layer:IComponentRootLayer = new ComponentRootLayer();
		
		/**
		* 	Creates a <code>ComponentViewUtils</code> instance.
		*/
		public function ComponentViewUtils()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get root():DisplayObject
		{
			return _root;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get stage():Stage
		{
			return _stage;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get layer():IComponentRootLayer
		{
			return _layer;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get renderer():IComponentRenderer
		{
			return _renderer;
		}
	}
}