package com.ffsys.ui.text
{
	import flash.text.TextField;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;	
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.data.IDataBindingNotification;
	import com.ffsys.ui.data.StringDataBinding;
	import com.ffsys.ui.data.ChangeNotification;
	import com.ffsys.ui.data.CreateNotification;
	import com.ffsys.ui.text.core.ITypedTextField;
	import com.ffsys.ui.css.ICssTextFieldProxy;
	
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
		implements 	ICssTextFieldProxy
	{
		/**
		* 	A default gutter to offset textfield positions.
		*/
		public static const GUTTER:int = -2;
		
		private var _textfield:ITypedTextField;
		private var _textTransform:String;
		private var _offsets:Point;
		
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
		override public function set preferredWidth( value:Number ):void
		{
			super.preferredWidth = value;
			if( textfield != null )
			{
				textfield.width = value;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set preferredHeight( value:Number ):void
		{
			super.preferredHeight = value;
			if( textfield != null )
			{
				textfield.height = value;
			}
		}
		
		public function get textTransform():String
		{
			return _textTransform;
		}
		
		public function set textTransform( value:String ):void
		{
			if( value != null )
			{
				value = value.toLowerCase();
			}
			_textTransform = value;
		}
		
		/**
		* 	Invoked when this component is finalized
		* 	as a bean.
		*/
		override public function finalized():void
		{
			//trace("TextComponent::finalized()", this, this.id, this.messages, this.identifier );
			if( this.messages != null
				&& this.identifier != null )
			{
				var msg:String = this.messages.getProperty.apply(
					this.messages, [ this.identifier ] ) as String;
				
				//trace("TextComponent::finalized() SEARCHING FOR MESSAGE TO SET: ", msg );
				
				if( msg != null )
				{
					this.text = msg;
				}
			}
			super.finalized();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function notify( notification:IDataBindingNotification ):void
		{
			//trace("TextComponent::notify()", notification, this, dataBinding, StringDataBinding( this.dataBinding ).value );
			
			if( ( notification is ChangeNotification || notification is CreateNotification )
				&& ( this.dataBinding is StringDataBinding ) )
			{
				this.text = StringDataBinding( this.dataBinding ).value;
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function getProxyTextFields():Vector.<TextField>
		{
			var output:Vector.<TextField> = new Vector.<TextField>();
			output.push( TextField( _textfield ) );
			return output;
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
			
			/*
				
			if( textfield && !isNaN( textfield.measuredWidth ) )
			{
				return textfield.measuredWidth;
			}
			*/
			
			if( textfield && ( textfield.width > 0 && textfield.height > 0 ) )
			{
				return textfield.textWidth + paddings.width;
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
			
			/*
			if( textfield && !isNaN( textfield.measuredHeight ) )
			{
				return textfield.measuredHeight;
			}
			*/
			
			if( textfield && ( textfield.width > 0 && textfield.height > 0 ) )
			{
				return textfield.textHeight + paddings.height;
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
		
		private function handleTextTransform( text:String ):String
		{
			if( this.textTransform == TextTransform.UPPERCASE )
			{
				text = text.toUpperCase();
			}else if( this.textTransform == TextTransform.LOWERCASE )
			{
				text = text.toLowerCase();
			}else if( this.textTransform == TextTransform.UNDERLINE )
			{
				_textfield.applyTextFormatProperties( { underline: true } );
			}else if( this.textTransform == TextTransform.NONE )
			{
				_textfield.applyTextFormatProperties( { underline: false } );
			}
			
			return text;
		}
		
		/**
		* 	Whether the text is underlined.
		*/
		public function get underline():Boolean
		{
			return _textfield.defaultTextFormat.underline;
		}
		
		public function set underline( value:Boolean ):void
		{
			_textfield.defaultTextFormat.underline = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set text( text:String ):void
		{	
			if( textfield == null
				&& text != null
				&& text != "" )
			{
				createTextField( text );
			}
			
			if( textfield != null )
			{
			
				if( textTransform != null ) 
				{
					text = handleTextTransform( text );
				}
			
				textfield.setText( text );
				
				position();
			}
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
			
			//TODO: investigate removing this and still
			//allowing components to be added to non-component parent
			//display objects
			addChild( DisplayObject( _textfield ) );
			
			return _textfield;
		}
		
		/**
		* 	Offsets to use when positioning the textfield.
		* 
		* 	The default value is to offset by the <code>GUTTER</code>.
		*/
		public function get offsets():Point
		{
			if( _offsets == null )
			{
				_offsets = new Point( GUTTER, GUTTER );
			}
			return _offsets;
		}
		
		public function set offsets( value:Point ):void
		{
			_offsets = value;
		}
		
		/**
		* 	Positions the textfield within this component.
		*/
		protected function position():void
		{
			if( _textfield != null )
			{
				//offset by the padding, border and textfield gutter
				_textfield.x = paddings.left + offsets.x;
				_textfield.y = paddings.top + offsets.y;
			}
		}
		
		/**
		*		
		*/
		public function get embedFonts():Boolean
		{
			return _textfield.embedFonts;
		}
		
		public function set embedFonts( embedFonts:Boolean ):void
		{
			_textfield.embedFonts = embedFonts;
		}
		
		public function get wordWrap():Boolean
		{
			return _textfield.wordWrap;
		}

		public function set wordWrap( wordWrap:Boolean ):void
		{
			_textfield.wordWrap = wordWrap;
		}
		
		public function get multiline():Boolean
		{
			return _textfield.multiline;
		}

		public function set multiline( multiline:Boolean ):void
		{
			_textfield.multiline = multiline;
		}				
		
		override public function set width( width:Number ):void
		{
			_textfield.width = width;
			super.width = width;
		}
		
		override public function set height( height:Number ):void
		{
			_textfield.height = height;
			super.height = height;
		}
		
		public function get autoSize():String
		{
			return _textfield.autoSize;
		}
		
		public function set autoSize( autoSize:String ):void
		{
			_textfield.autoSize = autoSize;
		}
		
		public function get antiAliasType():String
		{
			return _textfield.antiAliasType;
		}

		public function set antiAliasType( antiAliasType:String ):void
		{
			_textfield.antiAliasType = antiAliasType;
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
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_textfield = null;
			_textTransform = null		
		}
	}
}