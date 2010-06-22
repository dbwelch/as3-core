package com.ffsys.ui.graphics.bullets
{
	import com.ffsys.ui.graphics.CircleGraphic;
	import com.ffsys.ui.graphics.IFill;
	import com.ffsys.ui.graphics.IStroke;
	import com.ffsys.ui.graphics.SolidFill;

	/**
	*	Represents a small circular bullet graphic.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public class DiscBullet extends CircleGraphic
	{
		/**
		* 	Creates a <code>DiscBullet</code> instance.
		* 
		* 	@param diameter The diameter of the disc.
		* 	@param color The color of the disc.
		* 	@param alpha The alpha of the disc.
		* 	@param stroke A stroke for the disc.
		* 	@param fill A fill for the disc.
		*/
		public function DiscBullet(
			diameter:Number = 5,
			color:Number = 0x999999,
			alpha:Number = 1,
			stroke:IStroke = null,
			fill:IFill = null )
		{
			if( !fill )
			{
				fill = new SolidFill( color, alpha );
			}
			
			super( diameter, stroke, fill );
		}
	}
}