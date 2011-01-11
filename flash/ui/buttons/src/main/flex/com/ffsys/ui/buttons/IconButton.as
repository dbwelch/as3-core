package com.ffsys.ui.buttons
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.core.State;	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.layout.*;
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
			this.layout = new HorizontalLayout();
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
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( DisplayObject( label ) );			
			
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
			var hasLabel:Boolean = ( label != null ) && contains( DisplayObject( label ) );			
			
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
	}
}