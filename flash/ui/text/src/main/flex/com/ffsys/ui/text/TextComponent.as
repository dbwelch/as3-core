package com.ffsys.ui.text
{
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
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
			
			//TODO: investigate removing this and still
			//allowing components to be added to non-component parent
			//display objects
			addChild( DisplayObject( _textfield ) );
			
			this.maximumWidth = maximumWidth;
			this.maximumHeight = maximumHeight;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function createChildren():void
		{
			if( _textfield
				&& !contains( DisplayObject( _textfield ) ) )
			{
				addChild( DisplayObject( _textfield ) );
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
		override public function set maximumWidth( value:Number ):void
		{
			super.maximumWidth = value
			if( !isNaN( value ) && textfield )
			{
				textfield.maximumWidth = value;
			}
		}
		
		/**
		* 	The maximum height that a multiline textfield
		* 	will resize before it becomes a fixed size.
		*/
		override public function set maximumHeight( value:Number ):void
		{
			if( !isNaN( value ) && textfield )
			{
				textfield.maximumHeight = value;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			/*
			var metrics:TextLineMetrics = null;
			
			try
			{
				metrics = textfield.getLineMetrics( 0 );
			}catch( e:Error )
			{
				throw e;
			}
			
			if( metrics )
			{
				trace("TextComponent::layoutWidth(), ", metrics.width - metrics.x, metrics.width, metrics.x );
				return metrics.width;
			}
			*/
			
			if( textfield && ( textfield.width > 0 && textfield.height > 0 ) )
			{
				trace("TextComponent::layoutWidth(), returning text width:", textfield.textWidth );
				return textfield.textWidth;
			}
			
			return this.width == 0 ? 0 : this.width - 4;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			/*
			var metrics:TextLineMetrics = null;
			
			try
			{
				metrics = textfield.getLineMetrics( 0 );
			}catch( e:Error )
			{
				throw e;
			}
			
			if( metrics )
			{
				return metrics.height;
			}
			*/
			
			if( textfield && ( textfield.width > 0 && textfield.height > 0 ) )
			{
				return textfield.textHeight;
			}
			
			return this.height == 0 ? 0 : this.height - 4;
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
			
			//TODO: remove this debug drawing
			
			/*
			graphics.clear();
			graphics.lineStyle( 0, 0xff6600 );
			graphics.drawRect( textfield.x, textfield.y, textfield.width, textfield.height );
			
			graphics.lineStyle( 0, 0x0066ff );
			graphics.drawRect( 0, 0, textfield.textWidth, textfield.textHeight );
			
			graphics.endFill();
			*/
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
			
			//TODO: remove this duplicate call to set text
			//this.text = text;
			
			return _textfield;
		}
		
		/**
		* 	Gets the class of textfield to instantiate.
		* 
		* 	@return The class of textfield to instantiate.
		*/
		protected function getTextFieldClass():Class
		{
			throw new Error(
				"You must specify the textfield class in your concrete implementation." );
		}
	}
}