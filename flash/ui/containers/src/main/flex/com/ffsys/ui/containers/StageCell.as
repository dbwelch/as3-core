package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import com.ffsys.ui.core.IComponent;
	
	/**
	*	Represents a cell that resizes to the stage size.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.11.2010
	*/
	public class StageCell extends Cell {
		
		/**
		*	Creates a <code>StageCell</code> instance.
		*	
		*	@param width The preferred width of the cell.
		*	@param height The preferred height of the cell.
		*	@param content The initial content for the cell.
		*/
		public function StageCell(
			width:Number = NaN,
			height:Number = NaN,
			content:IComponent = null )
		{
			super( width, height, content );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function createChildren():void
		{
			trace("StageCell::createChildren()");
			stage.addEventListener( Event.RESIZE, resized );
		}
		
		/**
		* 	@private
		*/
		private function resized( event:Event ):void
		{
			if( stage )
			{
				trace("StageCell::resized()", stage.stageWidth, stage.stageHeight );
				this.preferredWidth = stage.stageWidth;
				this.preferredHeight = stage.stageHeight;
			}
			
			if( this.layout && this.content )
			{
				this.layout.update( this );
			}
		}
		
		/**
		* 	Performs clean up of this instance.
		* 
		* 	The implementation of this method should clean any
		* 	event listeners and null any references to complex objects.
		*/
		override public function destroy():void
		{
			super.destroy();
			
			if( stage )
			{
				stage.removeEventListener( Event.RESIZE, resized )
			}
		}		
	}
}