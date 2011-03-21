package org.flashx.ui.graphics {
	
	import flash.geom.Point;
	
	import org.flashx.ui.common.Orientation;
	
	/**
	*	Represents an arrow.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class ArrowGraphic extends TriangleGraphic
		implements IOrientationAware {
		
		private var _orientation:String;
		
		/**
		*	Creates an <code>ArrowGraphic</code> instance.
		*	
		*	@param width The width of the arrow.
		*	@param height The height of the arrow.
		*	@param stroke A stroke for the graphic.
		*	@param fill A fill for the graphic.
		*	@param orientation The orientation for the arrow.
		*/
		public function ArrowGraphic(
			width:Number = 10,
			height:Number = 10,
			stroke:IStroke = null,
			fill:IFill = null,
			orientation:String = Orientation.RIGHT )
		{
			super( stroke, fill );
			this.preferredWidth = width;
			this.preferredHeight = height;
			this.orientation = orientation;
		}
		
		/**
		*	Determines the orientation of the arrow.
		*	
		*	This is the direction that the arrow points to.
		*/
		public function get orientation():String
		{
			return _orientation;
		}
		
		public function set orientation( orientation:String ):void
		{
			_orientation = orientation;
		}
		
		/**
		*	@private	
		*/
		protected function setTrianglePointsFromOrientation(
			width:Number, height:Number ):void
		{
			switch( orientation )
			{
				case Orientation.RIGHT:
					this.point1 = new Point();
					this.point2 = new Point( width, height / 2 );
					this.point3 = new Point( 0, height );
					break;
				case Orientation.LEFT:
					this.point1 = new Point( 0, height / 2 );
					this.point2 = new Point( width, 0 );
					this.point3 = new Point( width, height );
					break;
				case Orientation.TOP:
					this.point1 = new Point( width / 2, 0 );
					this.point2 = new Point( width, height );
					this.point3 = new Point( 0, height );
					break;					
				case Orientation.BOTTOM:
					this.point1 = new Point( 0, 0 );
					this.point2 = new Point( width, 0 );
					this.point3 = new Point( width / 2, height );
					break;
				case Orientation.TOP_LEFT:
					this.point1 = new Point( 0, 0 );
					this.point2 = new Point( width, 0 );
					this.point3 = new Point( 0, height );
					break;
				case Orientation.TOP_RIGHT:
					this.point1 = new Point( 0, 0 );
					this.point2 = new Point( width, 0 );
					this.point3 = new Point( width, height );
					break;
				case Orientation.BOTTOM_RIGHT:
					this.point1 = new Point( width, 0 );
					this.point2 = new Point( width, height );
					this.point3 = new Point( 0, height );
					break;					
				case Orientation.BOTTOM_LEFT:
					this.point1 = new Point( 0, 0 );
					this.point2 = new Point( width, height );
					this.point3 = new Point( 0, height );
					break;
				default:
					throw new Error( "Arrow graphic encountered an invalid orientation." );
			}	
		}		
		
		/**
		*	@inheritDoc	
		*/
		override protected function doDraw( width:Number, height:Number ):void
		{
			setTrianglePointsFromOrientation( width, height );
			super.doDraw( width, height );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return ArrowGraphic;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function clone():IComponentGraphic
		{
			var graphic:IOrientationAware =
				IOrientationAware( super.clone() );
			graphic.orientation = orientation;
			return IComponentGraphic( graphic );
		}
	}
}