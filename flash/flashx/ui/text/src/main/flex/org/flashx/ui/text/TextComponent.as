package org.flashx.ui.text
{
	import flash.text.*;
	import flash.text.engine.*;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;	
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	
	import org.flashx.ioc.*;
	
	import org.flashx.ui.core.*;
	import org.flashx.ui.containers.*;
	import org.flashx.ui.data.*;
	import org.flashx.ui.text.core.ITypedTextField;
	import org.flashx.ui.css.ICssTextFieldProxy;
	import org.flashx.ui.css.IStyleManager;
	
	import org.flashx.ui.layout.*;
	import org.flashx.ui.text.*;	
	
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
	public class TextComponent extends InteractiveComponent	
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
		
		//TODO: implement a common interface
		private var _textfield:TextField;
		private var _area:FteTextArea;
		
		private var _textTransform:String;
		private var _offsets:Point;
		
		private var _fte:Boolean = true;
		private var _textProperties:Object = new Object();
		
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
			//createTextField( text );
			this.maxWidth = maximumWidth;
			this.maxHeight = maximumHeight;
		}
		
		/**
		* 	@inheritDoc
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
			
			if( cache.source.fte is Boolean )
			{
				this.fte = cache.source.fte;
			}
			
			//trace("TextComponent::doWithStyleCache()", cache.source.textTransform );
			
			if( cache.source.textTransform )
			{
				this.textTransform = cache.source.textTransform;
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
		
		/*
		override protected function getBorderDimensions():Rectangle
		{
			return new Rectangle( 0, 0, layoutWidth, layoutHeight );
		}	
		*/
		

		/**
		* 	@inheritDoc
		*/
		override public function measure():IComponentDimensions
		{
			var output:IComponentDimensions = super.measure();
			output.preferredWidth = this.layoutWidth;
			output.preferredHeight = this.layoutHeight - GUTTER_TOP;
			//trace("TextComponent::measure() MEASURING TEXT COMPONENT: ", output );
			return output;
		}
		
		
		/**
		* 	@private
		*/
		override public function prefinalize():void
		{
			/*
			///trace("TextComponent::prefinalize()", this, this.id, fte );
			
			if( this.fte == true )
			{
				//trace("TextComponent::prefinalize()", this, this.id, fte );			
			}
			*/
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			//position();
			
			//trace("::::::::::::::::::::: [FINALIZED] TextComponent::finalized()", this, this.id, this.text, contentText );
			
			if( contentText != null )
			{
				this.text = contentText;
			}else if( this.messages != null
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
		* 	@inheritDoc
		*/
		override public function set interactive( interactive:Boolean ):void
		{
			super.interactive = interactive;
			//we never mouse children to prevent the textfield or TextLine(s)
			//capturing events
			mouseChildren = false;
			//text components don't use the hand cursor
			useHandCursor = false;
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
				ITypedTextField( textfield ).maximumWidth = value;
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
				ITypedTextField( textfield ).maximumHeight = value;
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
			
			if( textfield && ( ITypedTextField( textfield ).width > 0 && ITypedTextField( textfield ).height > 0 ) )
			{
				return ITypedTextField( textfield ).textWidth + paddings.width + border.width;
			}
			
			return this.width == 0 ? 0 : this.width - 4;
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
			
			if( textfield && ( ITypedTextField( textfield ).width > 0 && ITypedTextField( textfield ).height > 0 ) )
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
			if( textfield != null )
			{
				ITypedTextField( textfield ).enabled = enabled;
			}
		}
		
		/**
		* 	Gets the textfield this label is using to render text.
		*/
		public function get textfield():TextField
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
			}
			
			if( textfield is ITypedTextField )
			{
				if( this.textTransform == TextTransform.UNDERLINE )
				{
					ITypedTextField( textfield ).applyTextFormatProperties( { underline: true } );
				}else if( this.textTransform == TextTransform.NONE )
				{
					ITypedTextField( textfield ).applyTextFormatProperties( { underline: false } );
				}
			}
			return text;
		}
		
		public function get contentText():String
		{
			return _textProperties.contentText is String ? _textProperties.contentText : null;
		}
		
		public function set contentText( value:String ):void
		{
			_textProperties.contentText = value;
		}
		
		/**
		* 	Whether the text is underlined.
		*/
		public function get underline():Boolean
		{
			return _textProperties.underline is Boolean ? _textProperties.underline : false;
		}
		
		public function set underline( value:Boolean ):void
		{
			if( _textfield is TextField )
			{
				_textfield.defaultTextFormat.underline = value;
			}
			_textProperties.underline = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():String
		{
			if( textfield is ITypedTextField )
			{
				return ITypedTextField( textfield ).getText();
			}
			return _textProperties.text is String ? _textProperties.text : null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set text( text:String ):void
		{	
			_textProperties.text = text;
			
			if( textTransform != null ) 
			{
				text = handleTextTransform( text );
			}
			
			//trace("TextComponent::set text() HAS FTE: ", fte, this.id );		
				
			if( fte )
			{
				//trace("TextComponent::set text() SET TEXT ON FTE TEXTFIELD: ", text );

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
				
				//trace("TextComponent::set text()", "CREATINHG LINES WITH WIDTH: " , w );
				
				try
				{
				
					var converter:FteTextFormatConverter = new FteTextFormatConverter();
					_area = converter.convert(
						text,
						getStyleCache().source.transform(),
						w );
				
					//trace("TextComponent::set text() GOT FTE TEXT BLOCK: ", _area );
				
					if( _area != null )
					{
						addChild( _area );
					}
				
				}catch( e:Error )
				{
					// TODO
				}

			}else{			
				if( textfield == null
					&& text != null
					&& text != "" )
				{
					createTextField( text );
				}
			
				if( textfield is ITypedTextField )
				{
					//ensure inline styles work as expected
					//with html textfields
					if( this.styleManager && this.stylesheet && html )
					{
						var sheet:StyleSheet = this.stylesheet.toStyleSheet();
						//trace("TextComponent::set text()", "UPDATING TEXTFIELD STYLE SHEET", sheet, sheet.styleNames );
						//_textfield.defaultTextFormat = null;
						_textfield.styleSheet = sheet;
					
						//_textfield.background = true;
					}
			
					ITypedTextField( textfield ).setText( text );
				
					//
				
					/*
					if( this.styleManager && html )
					{
						trace("TextComponent::set text()", _textfield.getText(), _textfield.styleSheet, _textfield.defaultTextFormat );
					}				
					*/
				}
			}
			
			//update the background
			applyBackground();
			position();		
		}
		
		/**
		*	The color for the label.
		*/
		public function get color():Number
		{
			return _textProperties.color is Number ? _textProperties.color : 0x990099;
		}
		
		public function set color( color:Number ):void
		{
			if( textfield is ITypedTextField )
			{
				textfield.textColor = color;
				ITypedTextField( textfield ).applyTextFormatProperties( { color: color } );
			}
			_textProperties.color = color;
		}
		
		/**
		* 	Creates the textfield encapsulated by this component.
		* 
		* 	@param text The text for the textfield.
		* 	
		*	@return The created textfield.
		*/
		protected function createTextField( text:String ):TextField
		{
			_textfield = textFieldFactory.getTextFieldByClass(
				getTextFieldClass(), text ) as TextField;
				
			if( _textfield is TextField )
			{
				TextField( _textfield ).embedFonts = this.embedFonts;
				TextField( _textfield ).wordWrap = this.wordWrap;
				TextField( _textfield ).multiline = this.multiline;
				TextField( _textfield ).autoSize = this.autoSize;
			}
				
			if( _textfield is ITypedTextField )
			{
				
				ITypedTextField( _textfield ).enabled = false;
			}
			
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
			//temp
			
			if( _offsets == null )
			{
				
			
				if( fte )
				{
					//_offsets = new Point( 0, -GUTTER_TOP );
					//return _offsets;
					
					if( paddings.top > 0 )
					{
						return new Point( 0, -GUTTER_TOP );
					}
					
					return new Point( 0, 0 );
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
				
				//trace("TextComponent::position() POSITIONING FTE TEXT AREA: ", _area.y, paddings.top, border.top );
			}
		}
		
		
		/**
		* 	@inheritDoc
		*/
		public function get html():Boolean
		{
			if( _textfield is ITypedTextField )
			{
				return ITypedTextField( _textfield ).html;
			}
			return false;
		}
		
		public function set html( value:Boolean ):void
		{
			if( _textfield is ITypedTextField )
			{
				ITypedTextField( _textfield ).html = value;
				
				//html textfields can have links - need to toggle interactivity
				
				this.interactive = value;
				
				if( value ) 
				{
					mouseChildren = true;
					useHandCursor = false;
				}
			}
		}		
		
		public function get autoSize():String
		{	
			return _textProperties.autoSize is String
				? _textProperties.autoSize : TextFieldAutoSize.NONE;
		}
		
		public function set autoSize( autoSize:String ):void
		{
			_textProperties.autoSize = autoSize;
		}
		
		public function get antiAliasType():String
		{
			return _textProperties.antiAliasType is String
				? _textProperties.antiAliasType : "advanced";
		}

		public function set antiAliasType( antiAliasType:String ):void
		{
			_textProperties.antiAliasType = antiAliasType;
		}
		
		/**
		*	//	
		*/
		public function get embedFonts():Boolean
		{
			return _textProperties.embedFonts is Boolean
				? _textProperties.embedFonts : false;
		}
		
		public function set embedFonts( embedFonts:Boolean ):void
		{
			_textProperties.embedFonts = embedFonts;
		}
		
		public function get wordWrap():Boolean
		{
			return _textProperties.wordWrap is Boolean
				? _textProperties.wordWrap : false;
		}

		public function set wordWrap( wordWrap:Boolean ):void
		{
			_textProperties.wordWrap = wordWrap;
		}
		
		public function get multiline():Boolean
		{
			return _textProperties.multiline is Boolean
				? _textProperties.multiline : false;
		}

		public function set multiline( multiline:Boolean ):void
		{
			_textProperties.multiline = multiline;
		}				
		
		override public function set width( width:Number ):void
		{
			if( _textfield is TextField )
			{
				//TODO: fix this so the textfield is resized to inner dimensions			
				_textfield.width = width;
			}
			super.width = width;
		}
		
		override public function set height( height:Number ):void
		{
			if( _textfield is TextField )
			{
				//TODO: fix this so the textfield is resized to inner dimensions
				_textfield.height = height;
			}
			super.height = height;
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