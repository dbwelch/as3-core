package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	
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
		public function get tooltips():IToolTipManager
		{
			//child components of the root layer must be
			//added lazily
			
			/*
			if( !contains( DisplayObject( _tooltips ) ) )
			{
				addChild( DisplayObject( _tooltips ) );
			}
			*/
			
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
				//add this instance to the root of the display list hierarchy
				container.addChild( this );
				
				//setup sensible defaults for the stage
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.stageFocusRect = false;
		
				//hook into the resize event to keep preferred dimensions in sync
				stage.addEventListener( Event.RESIZE, resize );
				
				stage.addEventListener( FocusEvent.FOCUS_IN, stageFocusIn );
				stage.addEventListener( FocusEvent.FOCUS_OUT, stageFocusOut );
		
				//invoke resize immediately
				resize();
				
				//hook into find out when siblings are added
				//to ensure this root layer remains at the highest depth
				this.parent.addEventListener( Event.ADDED, checkSiblingAdded );
				
				_tooltips = new ToolTipManager();
				_tooltips.width = stage.stageWidth;
				_tooltips.height = stage.stageHeight;				
				
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
				
				if( _tooltips )
				{
					_tooltips.preferredWidth = stage.stageWidth;
					_tooltips.preferredHeight = stage.stageHeight;
				}
			}
		}
		
		/**
		* 	@private
		* 	
		*	Handles the focus in event.
		*/
		private function stageFocusIn( event:FocusEvent ):void
		{
			if( stage )
			{
				var component:UIComponent = event.target as UIComponent;
				
				if( component )
				{
					component.focusIn( event );
				}
			}
		}
		
		/**
		* 	@private
		* 	
		*	Handles the focus out event.
		*/
		private function stageFocusOut( event:FocusEvent ):void
		{
			if( stage )
			{
				var component:UIComponent = event.target as UIComponent;
				
				/*
				trace("ComponentRootLayer::stageFocusOut(), ",
					event.target,
					event.currentTarget,
					event.relatedObject,
					component );
				*/
				
				if( component )
				{
					component.focusOut( event );
				}
			}
		}
	}
}