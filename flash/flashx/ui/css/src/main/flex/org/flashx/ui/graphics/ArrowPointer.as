package org.flashx.ui.graphics {
	
	import flash.geom.Point;
	
	import org.flashx.ui.common.Orientation;
	
	/**
	*	Represents a pointer associated with another component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.07.2010
	*/
	public class ArrowPointer extends ArrowGraphic
		implements IPointer {
			
		private var _inside:Boolean = true;
		private var _offset:Number = NaN;
		private var _edge:String;
		
		/**
		*	Creates an <code>ArrowPointer</code> instance.
		*	
		*	@param width The width of the pointer.
		*	@param height The height of the pointer.
		*	@param orientation The orientation for the pointer.
		*	@param edge An edge this pointer should be aligned to.
		*	@param offset An offset for the pointer.
		*/
		public function ArrowPointer(
			width:Number = 8,
			height:Number = 6,
			edge:String = Orientation.BOTTOM,
			orientation:String = Orientation.BOTTOM,
			offset:Number = NaN )
		{
			super( width, height, null, null, orientation );
			this.edge = edge;
			this.offset = offset;
		}
		
		/**
		*	@inheritDoc
		*/
		public function drawPointer(
			graphic:IComponentGraphic, start:Point, end:Point ):void
		{
			var target:Point = null;
			
			//trace("ArrowPointer::drawPointer(), ", edge );
			
			switch( edge )
			{
				case Orientation.TOP:
					target = new Point(
						start.x + ( preferredWidth / 2 ), start.y - preferredHeight );
					break;
				case Orientation.RIGHT:
					target = new Point(
						start.x + preferredHeight, start.y + ( preferredWidth / 2 ) );
					break;
				case Orientation.BOTTOM:
					target = new Point(
						start.x - ( preferredWidth / 2 ), start.y + preferredHeight );
					break;
				case Orientation.LEFT:
					target = new Point(
						start.x - preferredHeight, start.y - ( preferredWidth / 2 ) );
					break;
			}
			graphic.lineTo( target );
			graphic.lineTo( end );
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function get offset():Number
		{
			return _offset;
		}
		
		public function set offset( value:Number ):void
		{
			_offset = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get edge():String
		{
			return _edge;
		}
		
		public function set edge( value:String ):void
		{
			_edge = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get inside():Boolean
		{
			return _inside;
		}
		
		public function set inside( value:Boolean ):void
		{
			_inside = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return ArrowPointer;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function clone():IComponentGraphic
		{
			var graphic:IPointer =
				IPointer( super.clone() );
			graphic.inside = inside;
			graphic.offset = offset;
			graphic.edge = edge;
			return graphic;
		}
	}
}