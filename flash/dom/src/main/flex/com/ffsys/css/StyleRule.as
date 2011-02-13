package com.ffsys.css
{
	import flash.display.*;	
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.utils.flash_proxy;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.core.processor.*;
	
	import com.ffsys.ui.common.IMarginAware;
	import com.ffsys.ui.common.IPaddingAware;
	import com.ffsys.ui.common.IStyleAware;
	
	import com.ffsys.core.IStringIdentifier;

	import com.ffsys.utils.properties.PropertiesMerge;	
	
	/*
	
	Font Properties

	Property	Description	CSS
	@font-face	A rule that allows websites to download and use fonts other than the "web-safe" fonts	3
	font-size-adjust	Preserves the readability of text when font fallback occurs	3
	font-stretch	Selects a normal, condensed, or expanded face from a font family	3	
	
	*/

	dynamic public class StyleRule extends StyleElement
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
		
		private var _styleName:String;
		
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
			super( source );
			//trace("[ ::: StyleRule::init() ::: ]");
		}
		
		override protected function doWithNewProperty( name:*, value:* ):*
		{
			//trace("[ CSS ] [ StyleRule::doWithNewProperty ]", name, value );
			return value;
		}
		
		/**
		* 	The name of this style.
		*/
		public function get styleName():String
		{
			return _styleName;
		}
		
		public function set styleName( value:String ):void
		{
			_styleName = value;
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
		* 	@inheritDoc
		*/
		public function get display():String
		{
			return proxy.display;
		}
		
		public function set display( value:String ):void
		{
			proxy.display = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get position():String
		{
			return proxy.position;
		}
		
		public function set position( value:String ):void
		{
			proxy.position = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get overflow():String
		{
			return proxy.overflow;
		}
		
		public function set overflow( value:String ):void
		{
			proxy.overflow = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function transform():TextFormat
		{
			var tf:TextFormat = new TextFormat();
			if( proxy )
			{
				var merger:PropertiesMerge = new PropertiesMerge();
				merger.merge( tf, proxy );
			}
			return tf;
		}
		
		public function apply( target:Object ):void
		{
			var style:Object = this.proxy;
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






/*


div.test
{
text-overflow:ellipsis;
}

div
{ 
background: url(smiley.gif) top left no-repeat,
url(sqorange.gif) bottom left no-repeat,
url(sqgreen.gif) bottom right no-repeat;
}



Default value:	see individual properties
Inherited:	no
Version:	CSS1 + new properties in CSS3
JavaScript syntax:	object.style.background="red url(smiley.gif) top left no-repeat"

Syntax

background: color position size repeat origin clip attachment image;

Value	Description	CSS
background-color	Specifies the background color to be used	1
background-position	Specifies the position of the background images	1
background-size	Specifies the size of the background images	3
background-repeat	Specifies how to repeat the background images	1
background-origin	Specifies the positioning area of the background images	3
background-clip	Specifies the painting area of the background images	3
background-attachment	Specifies whether the background images are fixed or scrolls with the rest of the page	1
background-image	Specifies ONE or MORE background images to be used	1


background	A shorthand property for setting all the (CSS1, CSS2 and CSS3) background properties in one declaration	3
background-clip	Specifies the painting area of the background images	3
background-origin	Specifies the positioning area of the background images	3
background-size	Specifies the size of the background images	3
Border Properties

Property	Description	CSS
border-bottom-left-radius	Defines the shape of the border of the bottom-left corner	3
border-bottom-right-radius	Defines the shape of the border of the bottom-right corner	3
border-image	A shorthand property for setting all the border-image-* properties	3
border-image-outset	Specifies the amount by which the border image area extends beyond the border box	3
border-image-repeat	Specifies whether the image-border should be repeated, rounded or stretched	3
border-image-slice	Specifies the inward offsets of the image-border	3
border-image-source	Specifies an image to be used as a border	3
border-image-width	Specifies the widths of the image-border	3
border-radius	A shorthand property for setting all the four border-*-radius properties	3
border-top-left-radius	Defines the shape of the border of the top-left corner	3
border-top-right-radius	Defines the shape of the border of the top-right corner	3
box-decoration-break	 	3
box-shadow	Attaches one or more drop-shadows to the box	3
Text Properties

Property	Description	CSS
hanging-punctuation	Specifies whether a punctuation character may be placed outside the line box	3
punctuation-trim	Specifies whether a punctuation character should be trimmed	3
text-align-last	Describes how the last line of a block or a line right before a forced line break is aligned when text-align is "justify"	3
text-emphasis	Applies emphasis marks, and the foreground color of the emphasis marks, to the element's text	3
text-justify	Specifies the justification method used when text-align is "justify"	3
text-outline	Specifies a text outline	3
text-overflow	Specifies what should happen when text overflows the containing element	3
text-shadow	Adds shadow to text	3
text-wrap	Specifies line breaking rules for text	3
word-break	Specifies line breaking rules for non-CJK scripts	3
word-wrap	Allows long, unbreakable words to be broken and wrap to the next line	3
Font Properties

Property	Description	CSS
@font-face	A rule that allows websites to download and use fonts other than the "web-safe" fonts	3
font-size-adjust	Preserves the readability of text when font fallback occurs	3
font-stretch	Selects a normal, condensed, or expanded face from a font family	3
Color Properties

Property	Description	CSS
color-profile	Permits the specification of a source color profile other than the default	3
opacity	Sets the opacity level for an element	3
rendering-intent	Permits the specification of a color profile rendering intent other than the default	3
2D/3D Transform Properties

Property	Description	CSS
transform	Applies a 2D or 3D transformation to an element	3
transform-origin	Allows you to change the position on transformed elements	3
transform-style	Specifies how nested elements are rendered in 3D space	3
perspective	Specifies the perspective on how 3D elements are viewed	3
perspective-origin	Specifies the bottom position of 3D elements	3
backface-visibility	Defines whether or not an element should be visible when not facing the screen	3
Transition Properties

Property	Description	CSS
transition	A shorthand property for setting the four transition properties	3
transition-property	Specifies the name of the CSS property the transition effect is for	3
transition-duration	Specifies how many seconds or milliseconds a transition effect takes to complete	3
transition-timing-function	Specifies the speed curve of the transition effect	3
transition-delay	Specifies when the transition effect will start	3
Animation Properties

Property	Description	CSS
@keyframes	Specifies the animation	3
animation	A shorthand property for all the animation properties below, except the animation-play-state property	3
animation-name	Specifies a name for the @keyframes animation	3
animation-duration	Specifies how many seconds or milliseconds an animation takes to complete one cycle	3
animation-timing-function	Specifies the speed curve of the animation	3
animation-delay	Specifies when the animation will start	3
animation-iteration-count	Specifies the number of times an animation should be played	3
animation-direction	Specifies whether or not the animation should play in reverse on alternate cycles	3
animation-play-state	Specifies whether the animation is running or paused	3
Box Properties

Property	Description	CSS
overflow-x	Specifies whether or not to clip the left/right edges of the content, if it overflows the element's content area	3
overflow-y	Specifies whether or not to clip the top/bottom edges of the content, if it overflows the element's content area	3
overflow-style	Specifies the preferred scrolling method for elements that overflow	3
rotation	Rotates an element around a given point defined by the rotation-point property	3
rotation-point	Defines a point as an offset from the top left border edge	3
Linebox Properties

Property	Description	CSS
alignment-adjust	Allows more precise alignment of elements	3
alignment-baseline	Specifies how an inline-level element is aligned with respect to its parent	3
baseline-shift	Allows repositioning of the dominant-baseline relative to the dominant-baseline	3
dominant-baseline	Specifies a scaled-baseline-table	3
drop-initial-after-adjust	Sets the alignment point of the drop initial for the primary connection point	3
drop-initial-after-align	Sets which alignment line within the initial line box is used at the primary connection point with the initial letter box	3
drop-initial-before-adjust	Sets the alignment point of the drop initial for the secondary connection point	3
drop-initial-before-align	Sets which alignment line within the initial line box is used at the secondary connection point with the initial letter box	3
drop-initial-size	Controls the partial sinking of the initial letter	3
drop-initial-value	Activates a drop-initial effect	3 
inline-box-align	Sets which line of a multi-line inline block align with the previous and next inline elements within a line	3
line-stacking	A shorthand property for setting the line-stacking-strategy, line-stacking-ruby, and line-stacking-shift properties	3
line-stacking-ruby	Sets the line stacking method for block elements containing ruby annotation elements	3
line-stacking-shift	Sets the line stacking method for block elements containing elements with base-shift	3
line-stacking-strategy	Sets the line stacking strategy for stacked line boxes within a containing block element	3
text-height	Sets the block-progression dimension of the text content area of an inline box	3
Flexible Box Properties

Property	Description	CSS
box-align	Specifies how to align the child elements of a box	3
box-direction	Specifies in which direction the children of a box are displayed	3
box-flex	Specifies whether the children of a box is flexible or inflexible in size	3
box-flex-group	Assigns flexible elements to flex groups	3
box-lines	Specifies whether columns will go onto a new line whenever it runs out of space in the parent box	3
box-ordinal-group	Specifies the display order of the child elements of a box	3
box-orient	Specifies whether the children of a box should be laid out horizontally or vertically	3
box-pack	Specifies the horizontal position in horizontal boxes and the vertical position in vertical boxes	3
Hyperlink Properties

Property	Description	CSS
target	A shorthand property for setting the target-name, target-new, and target-position properties	3
target-name	Specifies where to open links (target destination)	3
target-new	Specifies whether new destination links should open in a new window or in a new tab of an existing window	3
target-position	Specifies where new destination links should be placed	3
Grid Properties

Property	Description	CSS
grid-columns	Specifies the width of each column in a grid	3
grid-rows	Specifies the height of each column in a grid	3
Multi-column Properties

Property	Description	CSS
column-count	Specifies the number of columns an element should be divided into	3
column-fill	Specifies how to fill columns	3
column-gap	Specifies the gap between the columns	3
column-rule	A shorthand property for setting all the column-rule-* properties	3
column-rule-color	Specifies the color of the rule between columns	3
column-rule-style	Specifies the style of the rule between columns	3
column-rule-width	Specifies the width of the rule between columns	3
column-span	Specifies how many columns an element should span across	3
column-width	Specifies the width of the columns	3
columns	A shorthand property for setting column-width and column-count	3
User-interface Properties

Property	Description	CSS
appearance	Allows you to make an element look like a standard user interface element	3
box-sizing	Allows you to define certain elements to fit an area in a certain way	3
icon	Provides the author the ability to style an element with an iconic equivalent	3
nav-down	Specifies where to navigate when using the arrow-down navigation key	3
nav-index	Specifies the tabbing order for an element	3
nav-left	Specifies where to navigate when using the arrow-left navigation key	3
nav-right	Specifies where to navigate when using the arrow-right navigation key	3
nav-up	Specifies where to navigate when using the arrow-up navigation key	3
outline-offset	Offsets an outline, and draws it beyond the border edge	3
resize	Specifies whether or not an element is resizable by the user	3
Marquee Properties

Property	Description	CSS
marquee-direction	Sets the direction of the moving content	3
marquee-play-count	Sets how many times the content move	3
marquee-speed	Sets how fast the content scrolls	3
marquee-style	Sets the style of the moving content	3
Generated Content Properties

Property	Description	CSS
crop	Allows a replaced element to be just a rectangular area of an object, instead of the whole object	3
move-to	Causes an element to be removed from the flow and reinserted at a later point in the document	3
page-policy	Determines which page-based occurance of a given element is applied to a counter or string value	3
Paged Media Properties

Property	Description	CSS
fit	Gives a hint for how to scale a replaced element if neither its width nor its height property is auto	3
fit-position	Determines the alignment of the object inside the box	3
image-orientation	Specifies a rotation in the right or clockwise direction that a user agent applies to an image	3
page	Specifies a particular type of page where an element SHOULD be displayed	3
size	Specifies the size and orientation of the containing box for page content	3
Content for Paged Media Properties

Property	Description	CSS
bookmark-label	Specifies the label of the bookmark	3
bookmark-level	Specifies the level of the bookmark	3
bookmark-target	Specifies the target of the bookmark link	3
float-offset	Pushes floated elements in the opposite direction of the where they have been floated with float	3
hyphenate-after	Specifies the minimum number of characters in a hyphenated word after the hyphenation character	3
hyphenate-before	Specifies the minimum number of characters in a hyphenated word before the hyphenation character	3
hyphenate-character	Specifies a string that is shown when a hyphenate-break occurs	3
hyphenate-lines	Indicates the maximum number of successive hyphenated lines in an element	3
hyphenate-resource	Specifies a comma-separated list of external resources that can help the browser determine hyphenation points	3
hyphens	Sets how to split words to improve the layout of paragraphs	3
image-resolution	Specifies the correct resolution of images	3
marks	Adds crop and/or cross marks to the document	3
string-set	 	3
Ruby Properties

Property	Description	CSS
ruby-align	Controls the text alignment of the ruby text and ruby base contents relative to each other	3
ruby-overhang	Determines whether, and on which side, ruby text is allowed to partially overhang any adjacent text in addition to its own base, when the ruby text is wider than the ruby base	3
ruby-position	Controls the position of the ruby text with respect to its base	3
ruby-span	Controls the spanning behavior of annotation elements	3
Speech Properties

Property	Description	CSS
mark	A shorthand property for setting the mark-before and mark-after properties	3
mark-after	Allows named markers to be attached to the audio stream	3
mark-before	Allows named markers to be attached to the audio stream	3
phonemes	Specifies a phonetic pronunciation for the text contained by the corresponding element	3
rest	A shorthand property for setting the rest-before and rest-after properties	3
rest-after	Specifies a rest or prosodic boundary to be observed after speaking an element's content	3
rest-before	Specifies a rest or prosodic boundary to be observed before speaking an element's content	3
voice-balance	Specifies the balance between left and right channels	3
voice-duration	Specifies how long it should take to render the selected element's content	3
voice-pitch	Specifies the average pitch (a frequency) of the speaking voice	3
voice-pitch-range	Specifies variation in average pitch	3
voice-rate	Controls the speaking rate	3
voice-stress	Indicates the strength of emphasis to be applied	3
voice-volume	Refers to the amplitude of the waveform output by the speech synthesises


Default value:	see individual properties
Inherited:	no
Version:	CSS1 + new properties in CSS3
JavaScript syntax:	object.style.background="red url(smiley.gif) top left no-repeat"

Syntax

background: color position size repeat origin clip attachment image;

Value	Description	CSS
background-color	Specifies the background color to be used	1
background-position	Specifies the position of the background images	1
background-size	Specifies the size of the background images	3
background-repeat	Specifies how to repeat the background images	1
background-origin	Specifies the positioning area of the background images	3
background-clip	Specifies the painting area of the background images	3
background-attachment	Specifies whether the background images are fixed or scrolls with the rest of the page	1
background-image	Specifies ONE or MORE background images to be used	1














*/