package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
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
			
			//setup sensible defaults for the stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//hook into the resize event to keep preferred dimensions in sync
			stage.addEventListener( Event.RESIZE, resize );
			
			//invoke resize immediately
			resize();
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
		* 	Provides static access to tooltip manager for the application.
		* 
		* 	The return value of this method will be null if no components
		* 	have been added to the display list.
		* 
		* 	@return The tool tip manager implementation.
		*/
		public static function getToolTipManager():IToolTipManager
		{
			return _tooltips;
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
		
		/**
		* 	@private
		* 
		* 	Handles the event dispatched when the stage resizes,
		* 	this method simply keeps the preferred dimensions to
		* 	match the stage dimensions.
		*/
		private function resize( event:Event = null ):void
		{
			if( stage )
			{
				this.preferredWidth = stage.stageWidth;
				this.preferredHeight = stage.stageHeight;
				
				if( tooltips )
				{
					tooltips.preferredWidth = stage.stageWidth;
					tooltips.preferredHeight = stage.stageHeight;
				}
			}
		}
	}
}