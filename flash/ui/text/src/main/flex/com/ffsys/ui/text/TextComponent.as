package com.ffsys.ui.text
{
	import flash.text.*;
	import flash.text.engine.*;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;	
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.core.IComponentStyleCache;
	import com.ffsys.ui.core.UIComponent;	
	import com.ffsys.ui.data.IDataBindingNotification;
	import com.ffsys.ui.data.StringDataBinding;
	import com.ffsys.ui.data.ChangeNotification;
	import com.ffsys.ui.data.CreateNotification;
	import com.ffsys.ui.text.core.ITypedTextField;
	import com.ffsys.ui.css.ICssTextFieldProxy;
	import com.ffsys.ui.css.IStyleManager;
	
	import com.ffsys.ui.layout.*;
	import com.ffsys.ui.text.*;	
	
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
		implements 	ITextComponent,
					ICssTextFieldProxy,
					IAdjustLayoutValue
	{
		/**
		* 	A default gutter to offset textfield positions.
		*/
		public static const GUTTER:int = -2;
		
	
		/**
		* 	A left gutter for textfields.
		*/
		public static const GUTTER_LEFT:int = 2;
		
	
		/**
		* 	A top gutter for textfields.
		*/
		public static const GUTTER_TOP:int = 3;
		
		private var _textfield:ITypedTextField;
		private var _textTransform:String;
		private var _offsets:Point;
		
		private var _fte:Boolean = false;
		private var _area:FteTextArea;
		
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
			this.maxWidth = maximumWidth;
			this.maxHeight = maximumHeight;
		}
		
		/**
		* 	Determines whether this component uses the flash
		* 	text engine to render text.
		* 
		* 	The default value is <code>true</code>.
		*/
		public function get fte():Boolean
		{
			return _fte;
		}
		
		public function set fte( value:Boolean ):void
		{
			_fte = value;
		}
		
		override protected function doWithStyleCache(
			cache:IComponentStyleCache ):void
		{
			super.doWithStyleCache( cache );
			
			//set up a default maximum with
			//this.maxWidth = 220;
			
			if( cache.main.fte is Boolean )
			{
				this.fte = cache.main.fte;
			}
			
			//trace("TextComponent::doWithStyleCache()", cache.main.textTransform );
			
			if( cache.main.textTransform )
			{
				this.textTransform = cache.main.textTransform;
			}
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
		* 	@inheritDoc
		*/
		
		/*
		override protected function applyBackground():void
		{
			super.applyBackground();
			if( this.background != null )
			{
				trace("TextComponent::applyBackground()",
					this.background,
					this.background.preferredWidth,
					this.background.preferredHeight );
			}
		}
		*/

		/**
		* 	@inheritDoc
		*/
		override protected function getBackgroundRect():Rectangle
		{
			var rect:Rectangle = super.getBackgroundRect();
			if( isNaN( rect.width ) )
			{
				rect.width = layoutWidth - border.width;
			}
			if( isNaN( rect.height ) )
			{
				rect.height = layoutHeight - border.height;
			}
			
			rect.height -= GUTTER_TOP;
			
			return rect;
		}
		
		override protected function getBorderDimensions():Rectangle
		{
			return new Rectangle( 0, 0, layoutWidth, layoutHeight );
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			position();
			
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
			
			/*
			var rect:Rectangle = calculateTextMetrics();
			trace("TextComponent::finalized() this/id/h/metrics.width/metrics.height/x: ", this, this.id, rect.width, rect.height, rect.x );			
			*/
			
			super.finalized();
			
			//trace("TextComponent::finalized()", this.text );
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
		override public function set maxWidth( value:Number ):void
		{
			super.maxWidth = value;
			if( !isNaN( value ) && textfield )
			{
				textfield.maximumWidth = value;
			}
		}
		
		/**
		* 	The maximum height that a multiline textfield
		* 	will resize before it becomes a fixed size.
		*/
		override public function set maxHeight( value:Number ):void
		{
			super.maxHeight = value;
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
			if( fte && _area )
			{
				return _area.dimensions.measuredWidth + paddings.width + border.width;
			}
			
			if( textfield && ( textfield.width > 0 && textfield.height > 0 ) )
			{
				return textfield.textWidth + paddings.width + border.width;
			}
			
			return this.width == 0 ? 0 : this.width - 4;
		}
		
		protected function calculateTextMetrics():Rectangle
		{
			var output:Rectangle = new Rectangle();
			if( textfield != null )
			{
				var isUpperCase:Boolean = false;
				var x:Number = Number.MAX_VALUE;
				var w:Number = 0;
				var h:Number = 0;
				var lineWidth:Number = 0;
				var lineHeight:Number = 0;
				var line:String = null;
				var metrics:TextLineMetrics = null;
				for( var i:int = 0;i < textfield.numLines;i++ )
				{
					metrics = textfield.getLineMetrics( i );
					line = textfield.getLineText( i );
					isUpperCase = line.toUpperCase() == line;
					x = Math.min( x, metrics.x );
					lineWidth = Math.max( lineWidth, metrics.width );
					trace("TextComponent::calculateTextMetrics() this/line/x/width/height/ascent/descent/leading", this, i, metrics.x, metrics.width, metrics.height, metrics.ascent, metrics.descent, metrics.leading );
					lineHeight = metrics.ascent;
					
					if( !isUpperCase )
					{
						lineHeight += metrics.descent;
					}
					
					if( i < ( textfield.numLines - 1 ) )
					{
						lineHeight += metrics.leading;
					}
					h += lineHeight;
				}
				
				w = lineWidth;
				
				trace("TextComponent::calculateTextMetrics() x/textfield.x:", x, textfield.x );
				x = x - textfield.x;
				
				
				//default gutter
				if( x == ( textfield.x - 2 ) )
				{
					x = 2;
				}
				
				output.x = x;
				output.width = w;
				output.height = h;
			}
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			if( fte && _area )
			{
				return _area.dimensions.measuredHeight + paddings.height + border.height - GUTTER_TOP;
			}
			
			var offsets:Point = this.offsets;
			
			if( textfield && ( textfield.width > 0 && textfield.height > 0 ) )
			{
				return textfield.textHeight + paddings.height + border.height;
			}
			
			return this.height == 0 ? 0 : this.height - 4;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function adjustLayoutValue(
			layout:ILayout,
			value:Object,
			parent:DisplayObjectContainer,
			child:DisplayObject,
			previous:DisplayObject = null ):Object
		{
			if( fte )
			{
				return value;
			}
			
			//TODO: account for previous children as the last child of a previous sibling
			//TODO: allow for lack of descenders - TextMetrics.descent on last line
			
			//trace("TextComponent::adjustLayoutValue()", this, child, this == child, previous, previous != null );
			
			//TODO: nly adjut for non-fte previous components
			if( previous is TextComponent )
			{
				//trace("TextComponent::adjustLayoutValue() ADJUSTING TEXT COMPONENT LAYOUT TO INCLUDE GUTTER TOP");
				if( layout is VerticalLayout )
				{
					return Number( value ) - GUTTER_TOP;
				}else if( layout is HorizontalLayout )
				{
					return Number( value ) - GUTTER_LEFT;
				}
			}
			return value;
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
		public function get text():String
		{
			return textfield.getText();
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function set text( text:String ):void
		{
			if( textTransform != null ) 
			{
				text = handleTextTransform( text );
			}			
			
			if( textfield == null
				&& text != null
				&& text != "" )
			{
				createTextField( text );
			}

			trace("TextComponent::set text() HAS FTE: ", fte, this.id );
			
			if( textfield != null )
			{
				
				
				if( fte )
				{
					trace("TextComponent::set text() SET TEXT ON FTE TEXTFIELD: ", text );

					var w:Number = 1000000;
					
					if( !isNaN( dimensions.preferredWidth ) )
					{
						w = dimensions.preferredWidth;
					}
					
					if( dimensions.hasExplicitWidth() )
					{
						w = dimensions.innerWidth;
					}
					
					//TODO :move to measure() and calculatedDimensions
					if( dimensions.maxWidth > 0 )
					{
						w = dimensions.maxWidth;
					}
					
					trace("TextComponent::set text()", "CREATINHG LINES WITH WIDTH: " , w );
					
					var converter:FteTextFormatConverter = new FteTextFormatConverter();
					_area = converter.convert(
						text,
						textfield.defaultTextFormat,
						w );
					
					trace("TextComponent::set text() GOT FTE TEXT BLOCK: ", _area );
					
					if( _area != null )
					{
						addChild( _area );
					}
					
					position();

					return;
				}

				//ensure inline styles work as expected
				//with html textfields
				if( this.styleManager && html )
				{
					var sheet:StyleSheet = this.stylesheet.toStyleSheet();
					//trace("TextComponent::set text()", "UPDATING TEXTFIELD STYLE SHEET", sheet, sheet.styleNames );
					//_textfield.defaultTextFormat = null;
					_textfield.styleSheet = sheet;
					
					//_textfield.background = true;
				}
			
				textfield.setText( text );
				
				//
				
				/*
				if( this.styleManager && html )
				{
					trace("TextComponent::set text()", _textfield.getText(), _textfield.styleSheet, _textfield.defaultTextFormat );
				}				
				*/

				//update the background
				applyBackground();
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
		* 	@private
		*/
		override public function prefinalize():void
		{
			trace("TextComponent::prefinalize()", this, this.id, fte );
			
			if( this.fte == true )
			{
				trace("TextComponent::prefinalize()", this, this.id, fte );			
				
				/*
				//TODO: remove this when the textfield support is removed
				if( _textfield && contains( DisplayObject( _textfield ) ) )
				{
					removeChild( DisplayObject( _textfield ) );
				}
				*/
			}
		}
		
		/**
		* 	Offsets to use when positioning the textfield.
		* 
		* 	The default value is to offset by the <code>GUTTER</code>.
		*/
		public function get offsets():Point
		{
			//temp
			
			if( _offsets == null )
			{
				
			
				if( fte )
				{
					_offsets = new Point( 0, -GUTTER_TOP );
					return _offsets;
				}
				
				/*
				if( styleManager != null && textfield )
				{
					var offsets:Object = styleManager.getStyle( "font-offsets" );
					
					var font:String = textfield.defaultTextFormat.font;
					font = font.replace( /\s/, "" );
					
					//trace("TextComponent::get offsets()", "GOT STYLE MANAGER OFFSETS: ", offsets );
					
					var z:String = null;
					var value:Object = null;
					for( z in offsets )
					{
						if( z.toLowerCase() == font.toLowerCase() )
						{
							value = offsets[ z ];
							//trace("TextComponent::get offsets()", "FOUND MATCHING FONT OFFSET:", z, value );
							
							if( value is Point )
							{
								return Point( value );
							}
							
							break; 
						}
					}
				}
				*/
				
				//var x:Number = paddings.left == 0 ? GUTTER : 0;
				//var y:Number = paddings.top == 0 ? GUTTER : 0;
				var x:Number = -( GUTTER_LEFT );
				var y:Number = -( GUTTER_TOP );
				_offsets = new Point( x, y );
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
				_textfield.x = paddings.left + border.left + offsets.x;
				_textfield.y = paddings.top + border.top + offsets.y;
			}
			
			if( _area != null )
			{
				//offset by the padding and border
				_area.x = paddings.left + border.left + offsets.x;
				_area.y = paddings.top + border.top + offsets.y;
				
				trace("TextComponent::position() POSITIONING FTE TEXT AREA: ", _area.y, paddings.top, border.top );
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
			//TODO: fix this so the textfield is resized to inner dimensions			
			_textfield.width = width;
			super.width = width;
		}
		
		override public function set height( height:Number ):void
		{
			
			//TODO: fix this so the textfield is resized to inner dimensions
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
		* 	@inheritDoc
		*/
		public function get html():Boolean
		{
			if( _textfield != null )
			{
				return _textfield.html;
			}			
			return false;
		}
		
		public function set html( value:Boolean ):void
		{
			if( _textfield != null )
			{
				_textfield.html = value;
				
				//html textfields can have links - need to toggle interactivity
				
				this.interactive = value;
				
				if( value )  
				{
					mouseChildren = true;
					useHandCursor = false;
				}
			}
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