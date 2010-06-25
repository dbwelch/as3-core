package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import com.ffsys.ui.tooltips.IToolTipManager;
	import com.ffsys.ui.tooltips.ToolTipManager;
	
	/**
	*	Represents a layer added to the root of the display list
	* 	so that certain components such as alerts and tooltips
	* 	appear above all other display list objects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class ComponentRootLayer extends UIComponent
		implements IComponentRootLayer
	{
		private static var _initialized:Boolean = false;
		private static var _tooltips:IToolTipManager;
		
		/**
		* 	Creates a <code>ComponentRootLayer</code> instance.
		*/
		public function ComponentRootLayer()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function createChildren():void
		{
			this.parent.addEventListener( Event.ADDED, checkSiblingAdded );
			_tooltips = new ToolTipManager();
			addChild( DisplayObject( _tooltips ) );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get tooltips():IToolTipManager
		{
			return _tooltips;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get initialized():Boolean
		{
			return _initialized;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function initialize( root:DisplayObject ):Boolean
		{
			if( _initialized || !root )
			{
				return false;
			}
			
			var container:DisplayObjectContainer = root as DisplayObjectContainer;
			var initializable:Boolean = container != null;

			if( initializable )
			{
				container.addChild( this );
				_initialized = true;
			}
			
			return _initialized;
		}
		
		/**
		* 	@private
		* 
		* 	Handles ensuring this display object is always at the highest depth
		* 	on the root of the display list hierarchy allowing child display list
		* 	layers to always appear above other display list objects.
		* 
		* 	@param event The event dispatched when a display object is added.
		*/
		private function checkSiblingAdded( event:Event ):void
		{
			var display:DisplayObject = event.target as DisplayObject;
			if( display && display.parent && display.parent == this.parent )
			{
				var index:uint = this.parent.getChildIndex( this );
				var sibling:uint = this.parent.getChildIndex( display );
				this.parent.setChildIndex( this, sibling );
			}
		}
	}
}