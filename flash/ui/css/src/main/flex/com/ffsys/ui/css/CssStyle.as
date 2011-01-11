package com.ffsys.ui.css
{
	import flash.display.DisplayObject;	
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.core.processor.*;
	
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	import com.ffsys.ui.common.IStyleAware;
	
	import com.ffsys.core.IStringIdentifier;

	import com.ffsys.utils.properties.PropertiesMerge;	

	public class CssStyle extends Object
	{
		/**
		* 	The name of the property to search for when
		* 	mapping font family declarations.
		*/
		public static const FONT_PROPERTY:String = "font";
		
		private var _source:Object;
		private var _id:String;
		
		//text styles
		private var _fontFamily:FontFamily;
		private var _fontSize:String;
		private var _fontWeight:String;
		private var _fontStyle:String;
		
		private var _top:Number;
		private var _right:Number;
		private var _bottom:Number;
		private var _left:Number;
		
		private var _zIndex:int;
		
		private var _backgroundColor:Number;
		private var _opacity:Number;
		
		private var _textDecoration:String;
		
		/*
		p.normal {font-style:normal;}
		p.italic {font-style:italic;}
		p.oblique {font-style:oblique;}		
		
		*/
		
		//TODO: transform: skew() etc
		
		private var _display:String;
		private var _position:String;
		private var _overflow:String;	
	
		public function CssStyle( source:Object = null )
		{
			super();
			this.source = source;
		}
		
		/*
		
		Default value:	static
		Inherited:	no
		Version:	CSS2
		JavaScript syntax:	object.style.position="absolute"
		
		absolute	Generates an absolutely positioned element, positioned relative to the first parent element that has a position other than static. The element's position is specified with the "left", "top", "right", and "bottom" properties
		fixed	Generates an absolutely positioned element, positioned relative to the browser window. The element's position is specified with the "left", "top", "right", and "bottom" properties
		relative	Generates a relatively positioned element, positioned relative to its normal position, so "left:20" adds 20 pixels to the element's LEFT position
		static	Default. No position, the element occurs in the normal flow (ignores any top, bottom, left, right, or z-index declarations)
		inherit	Specifies that the value of the position property should be inherited from the parent element	
		
		*/		
		
		/**
		* 	The source object containing enumerable style properties.
		*/
		public function get source():Object
		{
			return _source;
		}
		
		public function set source( value:Object ):void
		{
			_source = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get display():String
		{
			return _display;
		}
		
		public function set display( value:String ):void
		{
			_display = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get position():String
		{
			return _position;
		}
		
		public function set position( value:String ):void
		{
			_position = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get overflow():String
		{
			return _overflow;
		}
		
		public function set overflow( value:String ):void
		{
			_overflow = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function transform():TextFormat
		{
			var tf:TextFormat = new TextFormat();
			if( source )
			{
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( tf, source );
			}
			return tf;
		}
		
		public function apply( target:Object ):void
		{
			var style:Object = this.source;
			//trace("CssStyleSheet::applyStyle()", target, style, target is IPaddingAware  );
			if( style && target )
			{
				
				//trace("CssStyleSheet::applyStyle() CHECKING PADDING AWARE: ", target, ( target is IPaddingAware ) );
				
				if( target is IPaddingAware )
				{
					applyPadding( IPaddingAware( target ), style );
				}
				
				if( target is IMarginAware )
				{
					applyMargin( IMarginAware( target ), style );
				}
				
				var txt:TextField = null;
				var format:TextFormat = null;

				var targets:Vector.<TextField> = new Vector.<TextField>(); 
				
				if( target is TextField )
				{
					targets.push( TextField( target ) );			
				}
				
				if( target is ICssTextFieldProxy )
				{
					targets = ICssTextFieldProxy( target ).getProxyTextFields();
				}

				//got a font family declaration
				if( style.fontFamily is FontFamily )
				{
					var family:FontFamily = style.fontFamily as FontFamily;
					
					//trace("CssStyleSheet::intercept() GOT FONT FAMILY DECLARATION: ", target, style, style.fontFamily.fontNames );
					
					var embed:Boolean = style.embedFonts is Boolean ? style.embedFonts as Boolean : false;
					var fte:Boolean = style.fte is Boolean ? style.fte as Boolean : false;
					var font:String = family.getFont( embed, fte );
					if( font == null )
					{
						throw new Error( "Could not locate a valid font for font family declaration '"
						 + family.fontNames + "'." );
					}
					style[ FONT_PROPERTY ] = font;
				}
				
				//allow an target to perform last minute modification
				//of the style object applied
				
				if( target is ICssStyleInterceptor )
				{
					style = ICssStyleInterceptor( target ).doWithStyleObject( style );
				}
			
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( target, style, true, null, assign, intercept );
				
				//ensure color transforms are applied
				if( target is DisplayObject )
				{
					if( style.colorTransform is ColorTransform )
					{
						DisplayObject( target ).transform.colorTransform =
							ColorTransform( style.colorTransform );
					}
				}
				
				//TODO: handle cursor changes here
				
				//we cannot guarantee the order that styles will
				//be applied so we need to ensure that any width/height
				//are applied after other properties such as autoSize
				//for the textfield to render correctly
				
				if( targets.length )
				{
					format = transform();
				
					for each( txt in targets )
					{
						if( !txt )
						{
							continue;
						}
						
						if( txt.styleSheet == null )
						{
							txt.defaultTextFormat = format;
						}
					
						if( style.hasOwnProperty( "width" ) )
						{
							target.width = style.width;
						}
					
						if( style.hasOwnProperty( "height" ) )
						{
							target.height = style.height;
						}
					
						if( txt.text )
						{
							txt.text = txt.text;
						}
						
					}
				}
			}			
		}
		
		/**
		* 	@private
		*/
		private function assign(
			target:Object,
			source:Object,
			name:String,
			value:* ):Boolean
		{
			if( target is IBeanProperty )
			{
				var property:IBeanProperty = IBeanProperty( target );
				if( property.shouldSetBeanProperty( name, value ) )
				{
					//delegate bean property assignment
					property.setBeanProperty( name, value );
					return false;
				}
			}
			return true;
		}
		
		/**
		* 	@private
		*/
		private function intercept(
			target:Object,
			source:Object,
			name:String,
			value:* ):Boolean
		{
			if( name.indexOf( "." ) > -1 )
			{
				//trace("CssStyleSheet::assign() FOUND DOT STYLE PROPERTY NAME: ", target, name, value );
				var assignment:IPropertyProcessor = new PropertyAssignmentProcessor(
					name, target, value );
				assignment.process();
				
				return false;
				
				/*
				trace("CssStyleSheet::assign() AFTER ASSIGNMENT: ",
					assignment.currentTarget, assignment.targets );
				*/
			}

			return true;
		}		
		
		/**
		* 	@private
		*/
		private function applyPadding( target:IPaddingAware, style:Object ):void
		{
			//trace("CssStyleSheet::applyPadding()", target, style );
			
			if( target && target.paddings )
			{
				//trace("CssStyleSheet::applyPadding()", style.padding );
				
				if( style.padding is Number )
				{
					target.paddings.padding = style.padding;
				}
			
				if( style.paddingLeft is Number )
				{
					target.paddings.left = style.paddingLeft;
				}
				
				if( style.paddingTop is Number )
				{
					target.paddings.top = style.paddingTop;	
				}
				
				if( style.paddingRight is Number )
				{
					target.paddings.right = style.paddingRight;					
				}
				
				if( style.paddingBottom is Number )
				{
					target.paddings.bottom = style.paddingBottom;					
				}				
			}
		}
		
		/**
		* 	@private
		*/
		private function applyMargin( target:IMarginAware, style:Object ):void
		{
			if( target && target.margins )
			{
				if( style.margin is Number )
				{
					target.margins.margin = style.margin;
				}
			
				if( style.marginLeft is Number )
				{
					target.margins.left = style.marginLeft;
				}
				
				if( style.marginTop is Number )
				{
					target.margins.top = style.marginTop;	
				}
				
				if( style.marginRight is Number )
				{
					target.margins.right = style.marginRight;					
				}
				
				if( style.marginBottom is Number )
				{
					target.margins.bottom = style.marginBottom;					
				}				
			}
		}		
	}
}