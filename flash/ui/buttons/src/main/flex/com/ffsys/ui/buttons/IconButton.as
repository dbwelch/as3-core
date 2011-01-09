package com.ffsys.ui.buttons
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.core.State;	
	import com.ffsys.ui.text.Label;
	import com.ffsys.ui.text.TextComponent;	

	/**
	*	Represents a button that contains an icon.
	* 
	* 	This component includes a background graphic
	* 	in the default styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class IconButton extends Button
	{
		private var _icon:DisplayObject;
		
		/**
		* 	Creates an <code>IconButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function IconButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( text, width, height );
			if( icon )
			{
				this.icon = icon;
			}
		}
		
		/**
		*	The icon for this button.	
		*/
		public function get icon():DisplayObject
		{
			return _icon;
		}
		
		public function set icon( icon:DisplayObject ):void
		{
			if( this.icon && this.contains( this.icon ) )
			{
				removeChild( this.icon );
			}
			
			_icon = icon;
			
			if( this.icon && !this.contains( this.icon ) )
			{
				addChild( this.icon );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredWidth():Number
		{
			var width:Number = super.preferredWidth;
			
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );
			
			if( isNaN( _preferredWidth ) )
			{
				//a default width if no icon and label
				if( !hasIcon && !hasLabel )
				{
					width = 18;
				}
				
				if( hasIcon && !hasLabel )
				{
					width = icon.width + paddings.left + paddings.right;
				}else if( hasIcon && hasLabel )
				{
					width = icon.width
						+ paddings.left
						+ paddings.right
						+ label.layoutWidth
						+ spacing;
				}
			}
			
			return width;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredHeight():Number
		{
			var height:Number = super.preferredHeight;
			
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );
			
			if( isNaN( _preferredHeight ) )
			{
				//a default height if no icon and label
				if( !hasIcon && !hasLabel )
				{
					height = 18;
				}

				if( hasIcon && !hasLabel )
				{
					height = icon.height + paddings.top + paddings.bottom;
				}else if( hasIcon && hasLabel )
				{
					var maximum:Number = Math.max(
						icon.height, label.layoutHeight );
					height = maximum
						+ paddings.top
						+ paddings.bottom;
				}
			}
			
			return height;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );			
			
			//some border data - use border dimensions
			if( this.border.valid() )
			{
				return getBorderDimensions().width;
			}else if( this.background != null )
			{
				return this.background.preferredWidth;
			}else if( hasIcon && hasLabel )
			{
				return icon.width + spacing + label.layoutWidth;
			}else if( hasIcon )
			{
				return icon.width;
			}else if( hasLabel )
			{
				return label.layoutWidth;
			}
			
			return super.layoutWidth;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );			
			
			if( this.border.valid() )
			{
				return getBorderDimensions().height;
			}else if( this.background != null )
			{
				return this.background.preferredHeight;
			}else if( hasIcon && hasLabel )
			{
				return Math.max( icon.height, label.layoutHeight );
			}else if( hasIcon )
			{
				return icon.height;
			}else if( hasLabel )
			{
				return label.layoutHeight;
			}
			
			return super.layoutHeight;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			//trace("IconButton::finalized()", this, this.id, preferredWidth, preferredHeight );
			super.finalized();
			position();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function updateState( state:State ):void
		{
			super.updateState( state );
			position();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function removeLabel():void
		{
			super.removeLabel();
			position();
		}
		
		/**
		*	Positions the icon and label.
		*/
		protected function position():void
		{
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );			
			
			var ix:Number = paddings.left;
			var iy:Number = paddings.top;
			
			var lx:Number = paddings.left;
			var ly:Number = paddings.top;
			
			var w:Number = _preferredWidth;
			var h:Number = _preferredHeight;			
			
			if( hasIcon )
			{
				//w = icon.width + paddings.left + paddings.right;
				//h = icon.height + paddings.top + paddings.bottom;
				
				//trace("IconButton::position()", this, this.id, hasLabel, icon.width, icon.height, w, h );
				
				//default to centring the icon if
				//we have preferred dimensions
				if( !isNaN( w ) )
				{
					ix = ( w * 0.5 ) - ( icon.width * 0.5 );
				}
				
				if( !isNaN( h ) )
				{
					iy = ( h * 0.5 ) - ( icon.height * 0.5 );
				}
				
				//modiy calculations when a label is available
				if( hasLabel )
				{
					//only handling left align at the moment
					ix = ( preferredWidth * 0.5 ) -
						( ( icon.width + spacing + label.layoutWidth ) * 0.5 ) ;
					
					//default label positions when an icon is specified
					lx = ix + icon.width + spacing;
					ly = iy + ( icon.height * 0.5 ) - ( label.layoutHeight * 0.5 );
				}
				
				icon.x = ix;
				icon.y = iy;
			}
			
			if( hasLabel )
			{
				label.x = lx;
				label.y = ly;
			}
			
			
			if( isNaN( w ) )
			{
				w = this.preferredWidth;
			}
			
			if( isNaN( h ) )
			{
				h = this.preferredHeight;
			}			
			
			//update background graphic size
			applyBackground();
		}
	}
}