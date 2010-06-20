package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.UIComponent;
	
	/**
	*	Super class for all containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Container extends UIComponent {
		
		/**
		*	Creates a <code>Container</code> instance.
		*/
		public function Container()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get layoutWidth():Number
		{
			if( !isNaN( this.preferredWidth ) ) 
			{
				return this.preferredWidth;
			}

			return super.layoutWidth;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get layoutHeight():Number
		{
			if( !isNaN( this.preferredHeight ) ) 
			{
				return this.preferredHeight;
			}

			return super.layoutHeight;
		}
	}
}