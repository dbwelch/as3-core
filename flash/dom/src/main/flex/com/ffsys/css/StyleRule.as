package com.ffsys.css
{
	import flash.display.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.utils.flash_proxy;

	import com.ffsys.dom.*;
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.css.*;
	
	import com.ffsys.core.processor.*;
	
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	
	import com.ffsys.core.IStringIdentifier;

	import com.ffsys.utils.properties.PropertiesMerge;
	
	/**
	* 	Represents a css style rule.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class StyleRule extends Element
	{
		/**
		* 	Represents the group of css font properties.
		*/
		public static const FONT:String = "font";
		
		/**
		* 	Represents the group of css background properties.
		*/
		public static const BACKGROUND:String = "background";
		
		/**
		* 	Represents the group of css border properties.
		*/
		public static const BORDER:String = "border";
		
		/**
		* 	Represents the group of css text properties.
		*/
		public static const TEXT:String = "text";
		
		/**
		* 	Represents the group of css overflow properties.
		*/
		public static const OVERFLOW:String = "overflow";
		
		/**
		* 	Represents the group of css rotation properties.
		*/
		public static const ROTATION:String = "rotation";
		
		/**
		* 	Represents the group of css animation properties.
		*/
		public static const ANIMATION:String = "animation";
		
		/**
		* 	Represents the group of css transition properties.
		*/
		public static const TRANSITION:String = "transition";
		
		private static var _groups:Array = [
			FONT,
			BACKGROUND,
			BORDER,
			TEXT,
			OVERFLOW,
			ROTATION,
			ANIMATION,
			TRANSITION ];
		
		/**
		* 	The name of the property to search for when
		* 	mapping font family declarations.
		*/
		public static const FONT_PROPERTY:String = "font";
		
		private var _selector:Selector;
		
		private var _id:String;
		
		//position styles - invalidates layout
		private var _top:Number;
		private var _right:Number;
		private var _bottom:Number;
		private var _left:Number;
		private var _display:String;
		private var _position:String;
		
		private var _backgroundColor:Number;
		private var _opacity:Number;
		
		private var _textDecoration:String;
		
		private var _textOverflow:String;
		
		//depth management
		private var _zIndex:int;
		
		/*
		p.normal {font-style:normal;}
		p.italic {font-style:italic;}
		p.oblique {font-style:oblique;}		
		
		*/
		
		//TODO: transform: skew() etc
		
		//overflow - invalidates parent layout
		private var _overflow:String;	
	
		public function StyleRule( source:Object = null )
		{
			super();
			
			if( source != null )
			{
				setSource( source );
			}
			//trace("[ ::: StyleRule::init() ::: ]");
		}
		
		override protected function doWithNewProperty( name:*, value:* ):*
		{
			//trace("[ CSS ] [ StyleRule::doWithNewProperty ]", name, value );
			return value;
		}
		
		/**
		* 	The selector for this rule.
		*/
		public function get selector():Selector
		{
			return _selector;
		}
		
		public function set selector( value:Selector ):void
		{
			_selector = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get display():String
		{
			return source.display;
		}
		
		public function set display( value:String ):void
		{
			source.display = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get position():String
		{
			return source.position;
		}
		
		public function set position( value:String ):void
		{
			source.position = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get overflow():String
		{
			return source.overflow;
		}
		
		public function set overflow( value:String ):void
		{
			source.overflow = value;
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
			//trace("StyleRuleSheet::applyStyle()", target, style, target is IPaddingAware  );
			if( style && target )
			{
				
				//trace("StyleRuleSheet::applyStyle() CHECKING PADDING AWARE: ", target, ( target is IPaddingAware ) );
				
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
					
					//trace("StyleRuleSheet::intercept() GOT FONT FAMILY DECLARATION: ", target, style, style.fontFamily.fontNames );
					
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
				
				/*
				if( target is IStyleRuleInterceptor )
				{
					style = IStyleRuleInterceptor( target ).doWithStyleObject( style );
				}
				*/
			
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
				//trace("StyleRuleSheet::assign() FOUND DOT STYLE PROPERTY NAME: ", target, name, value );
				var assignment:IPropertyProcessor = new PropertyAssignmentProcessor(
					name, target, value );
				assignment.process();
				
				return false;
				
				/*
				trace("StyleRuleSheet::assign() AFTER ASSIGNMENT: ",
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
			//trace("StyleRuleSheet::applyPadding()", target, style );
			
			if( target && target.paddings )
			{
				//trace("StyleRuleSheet::applyPadding()", style.padding );
				
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