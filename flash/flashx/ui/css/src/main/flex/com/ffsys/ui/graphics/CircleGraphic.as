package com.ffsys.ui.graphics
{
	
	/**
	*	Represents a circular component graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class CircleGraphic extends EllipseGraphic
	{
		/**
		* 	Creates a <code>CircleGraphic</code> instance.
		* 
		* 	@param diameter The diameter for the circle.
		*	@param stroke A stroke to use when drawing.
		*	@param fill A fill to use when drawing.
		*/
		public function CircleGraphic(
			diameter:Number = 25,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			super( diameter, diameter, stroke, fill );
		}
		
		/**
		* 	Sets the size of this circle by radius.
		*/
		public function set radius( radius:Number ):void
		{
			this.diameter = ( radius * 2 );
		}
		
		/**
		* 	Sets the size of this circle by diameter.
		*/
		public function set diameter( diameter:Number ):void
		{
			this.preferredWidth = diameter;
			this.preferredHeight = diameter;			
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function getCloneClass():Class
		{
			return CircleGraphic;
		}
	}
}