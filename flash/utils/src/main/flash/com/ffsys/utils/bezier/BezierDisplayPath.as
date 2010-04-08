package com.ffsys.utils.bezier {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.containers.Canvas;
	
	/**
	*	Adds drawing ability to the BezierPath class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class BezierDisplayPath extends BezierPath {
		
		private var _sprite:Sprite;
		
		private var _bezier:UIComponent;
		private var _bezierPoints:UIComponent;
		private var _linePoints:UIComponent;
		private var _controlPoints:UIComponent;
		private var _controlPointLines:UIComponent;
		
		public function BezierDisplayPath( start:BezierPoint = null, end:BezierPoint = null )
		{
			super( start, end );
		}
		
		public function set sprite( val:Sprite ):void
		{
			_sprite = val;
			
			if( !_bezier )
			{			
				//the drawn bezier curve
				_bezier = new UIComponent();
				_sprite.addChild( _bezier );
				
				//the points mapped along each spline
				_bezierPoints = new UIComponent();
				_sprite.addChild( _bezierPoints );				
				
				//the interpolated points between the start/end
				_linePoints = new UIComponent();
				_sprite.addChild( _linePoints );
			
				//control point lines
				_controlPointLines = new UIComponent();
				_sprite.addChild( _controlPointLines );
				
				//control point handles
				_controlPoints = new UIComponent();
				_sprite.addChild( _controlPoints );				
			}			
		}
		
		public function get sprite():Sprite
		{
			return _sprite;
		}
		
		public function drawPointMarker(
			graphics:Graphics,
			point:BezierPoint,
			colour:Number = 0x000000,
			alpha:Number = .25,
			radius:Number = 3 ):void
		{
			graphics.beginFill( colour, alpha );
			//graphics.drawCircle( point.x, point.y, radius );
			graphics.drawRect( point.x - ( radius / 2 ), point.y - ( radius / 2 ), radius, radius );
			graphics.endFill();
		}		
		
		public function drawLinePoints():void
		{
			var graphics:Graphics = _linePoints.graphics;
			
			graphics.clear();
			
			drawPointMarker( graphics, this.start );
			
			var i:int = 0;
			var l:int = getLength() - 1;
			
			var spline:QuadraticBezierSpline;
			
			for( ;i < l;i++ )
			{
				spline = _splines[ i ];
				drawPointMarker( graphics, spline.end );
			}
			
			drawPointMarker( graphics, this.end );
		}
		
		private function createControlPoint( position:BezierPoint ):void
		{
			var child:Sprite;
			
			child = new UIComponent();
			
			child.useHandCursor = true;
			child.buttonMode = true;
			child.mouseEnabled = true;	
			
			drawPointMarker(
				child.graphics,
				new BezierPoint( 0, 0 ),
				0x000000,
				0.5,
				5 );
			
			child.addEventListener( MouseEvent.MOUSE_DOWN, startControlDrag );
			child.addEventListener( MouseEvent.MOUSE_UP, stopControlDrag );
			
			child.x = position.x;
			child.y = position.y;
				
			_controlPoints.addChild( child );			
		}
		
		private function drawControlPoints():void
		{
			
			var i:int = 0;
			var l:int = getLength();
			
			var spline:QuadraticBezierSpline;
			
			for( ;i < l;i++ )
			{
				spline = _splines[ i ];
				
				createControlPoint( spline.control );
			}
		}
		
		private function startControlDrag( event:MouseEvent ):void
		{
			dispatchEvent( event );
			
			var sp:Sprite = event.target as Sprite;
			sp.startDrag( false );
			
			sp.addEventListener( Event.ENTER_FRAME, controlDrag );
		}
		
		private function controlDrag( event:Event ):void
		{
			var sp:Sprite = event.target as Sprite;
			
			var x:Number = sp.x;
			var y:Number = sp.y;
			
			//update the control point
			var index:Number = sp.parent.getChildIndex( sp );
			
			_splines[ index ].control.x = x;
			_splines[ index ].control.y = y;
			
			update();
		}
		
		private function update():void
		{
			drawBezierPathPoints();
			drawControlPointLines();
			drawBezier();			
		}
		
		private function stopControlDrag( event:MouseEvent ):void
		{
			dispatchEvent( event );
			
			var sp:Sprite = event.target as Sprite;
			sp.stopDrag();
			
			sp.removeEventListener( Event.ENTER_FRAME, controlDrag );
		}		
		
		public function drawControlPointLines():void
		{
			var graphics:Graphics = _controlPointLines.graphics;
			
			graphics.clear();
			
			graphics.lineStyle( 1, 0x666666, 0.4 );
			
			var i:int = 0;
			var l:int = getLength();
			
			var spline:QuadraticBezierSpline;
			
			for( ;i < l;i++ )
			{
				spline = _splines[ i ];
				
				graphics.moveTo( spline.control.x, spline.control.y );
				graphics.lineTo( spline.start.x, spline.start.y );
				
				graphics.moveTo( spline.control.x, spline.control.y );
				graphics.lineTo( spline.end.x, spline.end.y );				
			}
		}
		
		private function drawBezier():void
		{
			var graphics:Graphics = _bezier.graphics;
			
			graphics.clear();
			
			graphics.lineStyle( 1, 0x666666, 0.8 );
			
			graphics.moveTo( start.x, start.y );
			
			var l:int = getLength();
			
			//no control points
			if( !l )
			{
				graphics.lineTo( end.x, end.y );
			}else{
				var i:int = 0;
				
				var spline:QuadraticBezierSpline;
				
				for( ;i < l;i++ )
				{
					spline = _splines[ i ];
					
					/*
					trace( "BezierDisplayPath draw start x : " + spline.start.x );
					trace( "BezierDisplayPath draw start y : " + spline.start.y );
					trace( "BezierDisplayPath draw end x : " + spline.end.x );
					trace( "BezierDisplayPath draw end y : " + spline.end.y );
					trace( "BezierDisplayPath draw control x : " + spline.control.x );
					trace( "BezierDisplayPath draw control y : " + spline.control.y );
					*/
					
					graphics.moveTo( spline.start.x, spline.start.y );
					
					graphics.curveTo(
						spline.control.x,
						spline.control.y,
						spline.end.x, 
						spline.end.y );
				}
			}			
		}

		private function drawBezierPathPoints():void
		{
			var graphics:Graphics = _bezierPoints.graphics;
			
			graphics.clear();
			
			var points:Array = getBezierPathPoints( this.quality );
			
			var i:int = 0;
			var l:int = points.length;
			
			var position:BezierPoint;
			
			for( ;i < l;i++ )
			{
				position = points[ i ];
				drawPointMarker( graphics, position, 0xff0000 );
			}
		}
		
		private var _quality:int;
		
		public function set quality( val:int ):void
		{
			_quality = val;
		}
		
		public function get quality():int
		{
			return _quality;
		}					
		
		public function draw( sprite:Sprite, quality:int = 100 ):void
		{
			this.sprite = sprite;
			this.quality = quality;
			
			drawLinePoints();
			drawControlPoints();
			drawControlPointLines();
			drawBezierPathPoints();
			drawBezier();
			
		}
		
	}
	
}
