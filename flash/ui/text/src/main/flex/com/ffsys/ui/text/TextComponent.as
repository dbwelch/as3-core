package com.ffsys.ui.text
{
	import flash.display.DisplayObject;
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.text.core.ITypedTextField;
	
	/**
	*	Abstract super class for all components
	* 	that encapsulate single textfield.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public class TextComponent extends UIComponent
	{
		private var _textfield:ITypedTextField;		
		
		/**
		*	Creates a <code>TextComponent</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param maximumWidth The maximum width for the textfield.
		* 	@param maximumHeight The maximum height for the textfield.
		*/
		public function TextComponent(
			text:String = "",
			maximumWidth:Number = NaN,
			maximumHeight:Number = NaN )
		{
			super();
			createTextField( text );
			this.maximumWidth = maximumWidth;
			this.maximumHeight = maximumHeight;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function createChildren():void
		{
			if( textfield )
			{
				addChild( DisplayObject( textfield ) );
			}
		}
		
		/**
		* 	Determines whether this text component is interactive.
		* 
		* 	When a text component is interactive it behaves as a
		* 	button.
		*/
		public function get interactive():Boolean
		{
			return this.enabled;
		}
		
		public function set interactive( interactive:Boolean ):void
		{
			enabled = interactive;
			buttonMode = interactive;
			useHandCursor = interactive;
			mouseEnabled = interactive;
			
			//we never mouse children to prevent the textfield
			//capturing events
			mouseChildren = false;
		}
		
		/**
		* 	The maximum width before the label wraps to a
		* 	multiline textfield.
		*/
		public function get maximumWidth():Number
		{
			if( textfield )
			{
				return textfield.maximumWidth;
			}
			
			return NaN;
		}
		
		public function set maximumWidth( maximumWidth:Number ):void
		{
			if( !isNaN( maximumWidth ) && textfield )
			{
				textfield.maximumWidth = maximumWidth;
			}
		}
		
		/**
		* 	The maximum height that a multiline textfield
		* 	will resize before it becomes a fixed size.
		*/
		public function get maximumHeight():Number
		{
			if( textfield )
			{
				return textfield.maximumHeight;
			}
			
			return NaN;
		}
		
		public function set maximumHeight( maximumHeight:Number ):void
		{
			if( !isNaN( maximumHeight ) && textfield )
			{
				textfield.maximumHeight = maximumHeight;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			return this.width - 4;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			return this.height - 4;
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function set enabled( enabled:Boolean ):void
		{
			super.enabled = enabled;
			this.textfield.enabled = enabled;
		}
		
		/**
		* 	Gets the textfield this label is using to render text.
		*/
		public function get textfield():ITypedTextField
		{
			return _textfield;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():String
		{
			return textfield.getText();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set text( text:String ):void
		{
			textfield.setText( text );
		}
		
		/**
		*	The color for the label.
		*/
		public function get color():Number
		{
			return Number( textfield.defaultTextFormat.color );
		}
		
		public function set color( color:Number ):void
		{
			textfield.textColor = color;
			textfield.applyTextFormatProperties( { color: color } );
		}
		
		/**
		* 	Creates the textfield encapsulated by this component.
		* 
		* 	@param text The text for the textfield.
		* 	
		*	@return The created textfield.
		*/
		protected function createTextField( text:String ):ITypedTextField
		{
			
			_textfield = textFieldFactory.getTextFieldByClass(
				getTextFieldClass(), text );
			_textfield.enabled = false;
			
			//offset by the textfield gutter
			_textfield.x = _textfield.y = -2;
			
			return _textfield;			
		}		
		
		/**
		* 	Gets the class of textfield to instantiate.
		* 
		* 	@return The class of textfield to instantiate.
		*/
		protected function getTextFieldClass():Class
		{
			throw new Error( "You must specify the textfield class in your concrete implementation." );
		}
	}
}