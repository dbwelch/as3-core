package org.w3c.dom.css
{
	/**
	* 	The CSS2Properties interface represents a convenience mechanism
	* 	for retrieving and setting properties within a CSSStyleDeclaration.
	* 
	* 	The attributes of this interface correspond to all the properties
	* 	specified in CSS2. Getting an attribute of this interface is
	* 	equivalent to calling the getPropertyValue method of the CSSStyleDeclaration
	* 	interface. Setting an attribute of this interface is equivalent to
	* 	calling the setProperty method of the CSSStyleDeclaration interface.
	* 
	* 	<p><strong>Note:</strong> The interface found within this section are not mandatory.
	* 	A DOM application may use the hasFeature(feature, version) method of
	* 	the DOMImplementation interface with parameter values "CSS2" and "2.0"
	* 	(respectively) to determine whether or not this module is supported by
	* 	the implementation. In order to fully support this module, an
	* 	implementation must also support the "CSS" feature defined defined in
	* 	CSS Fundamental Interfaces. Please refer to additional information
	* 	about conformance in the DOM Level 2 Core specification [DOM Level 2 Core].</p>
	* 
	* 	A conformant implementation of the CSS module is not required to
	* 	implement the CSS2Properties interface. If an implementation does implement
	* 	this interface, the expectation is that language-specific methods can be
	* 	used to cast from an instance of the CSSStyleDeclaration interface to the
	* 	CSS2Properties interface.
	* 
	* 	If an implementation does implement this interface, it is expected
	* 	to understand the specific syntax of the shorthand properties,
	* 	and apply their semantics; when the margin property is set,
	* 	for example, the marginTop, marginRight, marginBottom and marginLeft
	* 	properties are actually being set by the underlying implementation.
	* 
	* 	When dealing with CSS "shorthand" properties, the shorthand properties
	* 	should be decomposed into their component longhand properties as appropriate,
	* 	and when querying for their value, the form returned should be the shortest
	* 	form exactly equivalent to the declarations made in the ruleset. However, if
	* 	there is no shorthand declaration that could be added to the ruleset without
	* 	changing in any way the rules already declared in the ruleset (i.e., by
	* 	adding longhand rules that were previously not declared in the ruleset),
	* 	then the empty string should be returned for the shorthand property.
	* 
	* 	For example, querying for the font property should not return
	* 	"normal normal normal 14pt/normal Arial, sans-serif", when
	* 	"14pt Arial, sans-serif" suffices. (The normals are initial values,
	* 	and are implied by use of the longhand property.)
	* 
	* 	If the values for all the longhand properties that compose a
	* 	particular string are the initial values, then a string consisting
	* 	of all the initial values should be returned (e.g. a border-width
	* 	value of "medium" should be returned as such, not as "").
	* 
	* 	For some shorthand properties that take missing values from
	* 	other sides, such as the margin, padding, and border-[width|style|color]
	* 	properties, the minimum number of sides possible should be used;
	* 	i.e., "0px 10px" will be returned instead of "0px 10px 0px 10px".
	* 
	* 	If the value of a shorthand property can not be decomposed into
	* 	its component longhand properties, as is the case for the font
	* 	property with a value of "menu", querying for the values of the
	* 	component longhand properties should return the empty string.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSS2Properties extends CSSStyleDeclaration
	{
		/**
		* 	See the <code>azimuth</code> property definition in CSS2.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the new value
		* 	has a syntax error and is unparsable.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if this property is readonly.
		*/
		function get azimuth():String;
		function set azimuth( value:String ):void;
		
		/**
		* 	See the <code>background</code> property definition in CSS2.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the new value
		* 	has a syntax error and is unparsable.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if this property is readonly.
		*/
		function get background():String;
		function set background( value:String ):void;
		
		/**
		* 	See the <code>background-attachment</code> property definition in CSS2.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the new value
		* 	has a syntax error and is unparsable.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if this property is readonly.
		*/
		function get backgroundAttachment():String;
		function set backgroundAttachment( value:String ):void;
		
		/*
		
		2.3. CSS2 Extended Interface

		Interface CSS2Properties (introduced in DOM Level 2)
		
		IDL Definition
		// Introduced in DOM Level 2:
		interface CSS2Properties {
		           attribute DOMString        backgroundColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        backgroundImage;
		                                        // raises(DOMException) on setting

		           attribute DOMString        backgroundPosition;
		                                        // raises(DOMException) on setting

		           attribute DOMString        backgroundRepeat;
		                                        // raises(DOMException) on setting

		           attribute DOMString        border;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderCollapse;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderSpacing;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderTop;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderRight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderBottom;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderLeft;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderTopColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderRightColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderBottomColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderLeftColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderTopStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderRightStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderBottomStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderLeftStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderTopWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderRightWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderBottomWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderLeftWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        borderWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        bottom;
		                                        // raises(DOMException) on setting

		           attribute DOMString        captionSide;
		                                        // raises(DOMException) on setting

		           attribute DOMString        clear;
		                                        // raises(DOMException) on setting

		           attribute DOMString        clip;
		                                        // raises(DOMException) on setting

		           attribute DOMString        color;
		                                        // raises(DOMException) on setting

		           attribute DOMString        content;
		                                        // raises(DOMException) on setting

		           attribute DOMString        counterIncrement;
		                                        // raises(DOMException) on setting

		           attribute DOMString        counterReset;
		                                        // raises(DOMException) on setting

		           attribute DOMString        cue;
		                                        // raises(DOMException) on setting

		           attribute DOMString        cueAfter;
		                                        // raises(DOMException) on setting

		           attribute DOMString        cueBefore;
		                                        // raises(DOMException) on setting

		           attribute DOMString        cursor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        direction;
		                                        // raises(DOMException) on setting

		           attribute DOMString        display;
		                                        // raises(DOMException) on setting

		           attribute DOMString        elevation;
		                                        // raises(DOMException) on setting

		           attribute DOMString        emptyCells;
		                                        // raises(DOMException) on setting

		           attribute DOMString        cssFloat;
		                                        // raises(DOMException) on setting

		           attribute DOMString        font;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontFamily;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontSize;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontSizeAdjust;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontStretch;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontVariant;
		                                        // raises(DOMException) on setting

		           attribute DOMString        fontWeight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        height;
		                                        // raises(DOMException) on setting

		           attribute DOMString        left;
		                                        // raises(DOMException) on setting

		           attribute DOMString        letterSpacing;
		                                        // raises(DOMException) on setting

		           attribute DOMString        lineHeight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        listStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        listStyleImage;
		                                        // raises(DOMException) on setting

		           attribute DOMString        listStylePosition;
		                                        // raises(DOMException) on setting

		           attribute DOMString        listStyleType;
		                                        // raises(DOMException) on setting

		           attribute DOMString        margin;
		                                        // raises(DOMException) on setting

		           attribute DOMString        marginTop;
		                                        // raises(DOMException) on setting

		           attribute DOMString        marginRight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        marginBottom;
		                                        // raises(DOMException) on setting

		           attribute DOMString        marginLeft;
		                                        // raises(DOMException) on setting

		           attribute DOMString        markerOffset;
		                                        // raises(DOMException) on setting

		           attribute DOMString        marks;
		                                        // raises(DOMException) on setting

		           attribute DOMString        maxHeight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        maxWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        minHeight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        minWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        orphans;
		                                        // raises(DOMException) on setting

		           attribute DOMString        outline;
		                                        // raises(DOMException) on setting

		           attribute DOMString        outlineColor;
		                                        // raises(DOMException) on setting

		           attribute DOMString        outlineStyle;
		                                        // raises(DOMException) on setting

		           attribute DOMString        outlineWidth;
		                                        // raises(DOMException) on setting

		           attribute DOMString        overflow;
		                                        // raises(DOMException) on setting

		           attribute DOMString        padding;
		                                        // raises(DOMException) on setting

		           attribute DOMString        paddingTop;
		                                        // raises(DOMException) on setting

		           attribute DOMString        paddingRight;
		                                        // raises(DOMException) on setting

		           attribute DOMString        paddingBottom;
		                                        // raises(DOMException) on setting

		           attribute DOMString        paddingLeft;
		                                        // raises(DOMException) on setting

		           attribute DOMString        page;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pageBreakAfter;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pageBreakBefore;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pageBreakInside;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pause;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pauseAfter;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pauseBefore;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pitch;
		                                        // raises(DOMException) on setting

		           attribute DOMString        pitchRange;
		                                        // raises(DOMException) on setting

		           attribute DOMString        playDuring;
		                                        // raises(DOMException) on setting

		           attribute DOMString        position;
		                                        // raises(DOMException) on setting

		           attribute DOMString        quotes;
		                                        // raises(DOMException) on setting

		           attribute DOMString        richness;
		                                        // raises(DOMException) on setting

		           attribute DOMString        right;
		                                        // raises(DOMException) on setting

		           attribute DOMString        size;
		                                        // raises(DOMException) on setting

		           attribute DOMString        speak;
		                                        // raises(DOMException) on setting

		           attribute DOMString        speakHeader;
		                                        // raises(DOMException) on setting

		           attribute DOMString        speakNumeral;
		                                        // raises(DOMException) on setting

		           attribute DOMString        speakPunctuation;
		                                        // raises(DOMException) on setting

		           attribute DOMString        speechRate;
		                                        // raises(DOMException) on setting

		           attribute DOMString        stress;
		                                        // raises(DOMException) on setting

		           attribute DOMString        tableLayout;
		                                        // raises(DOMException) on setting

		           attribute DOMString        textAlign;
		                                        // raises(DOMException) on setting

		           attribute DOMString        textDecoration;
		                                        // raises(DOMException) on setting

		           attribute DOMString        textIndent;
		                                        // raises(DOMException) on setting

		           attribute DOMString        textShadow;
		                                        // raises(DOMException) on setting

		           attribute DOMString        textTransform;
		                                        // raises(DOMException) on setting

		           attribute DOMString        top;
		                                        // raises(DOMException) on setting

		           attribute DOMString        unicodeBidi;
		                                        // raises(DOMException) on setting

		           attribute DOMString        verticalAlign;
		                                        // raises(DOMException) on setting

		           attribute DOMString        visibility;
		                                        // raises(DOMException) on setting

		           attribute DOMString        voiceFamily;
		                                        // raises(DOMException) on setting

		           attribute DOMString        volume;
		                                        // raises(DOMException) on setting

		           attribute DOMString        whiteSpace;
		                                        // raises(DOMException) on setting

		           attribute DOMString        widows;
		                                        // raises(DOMException) on setting

		           attribute DOMString        width;
		                                        // raises(DOMException) on setting

		           attribute DOMString        wordSpacing;
		                                        // raises(DOMException) on setting

		           attribute DOMString        zIndex;
		                                        // raises(DOMException) on setting

		};

		Attributes
		
		background of type DOMString
		See the background property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		backgroundAttachment of type DOMString
		See the background-attachment property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		backgroundColor of type DOMString
		See the background-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		backgroundImage of type DOMString
		See the background-image property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		backgroundPosition of type DOMString
		See the background-position property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		backgroundRepeat of type DOMString
		See the background-repeat property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		border of type DOMString
		See the border property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderBottom of type DOMString
		See the border-bottom property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderBottomColor of type DOMString
		See the border-bottom-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderBottomStyle of type DOMString
		See the border-bottom-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderBottomWidth of type DOMString
		See the border-bottom-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderCollapse of type DOMString
		See the border-collapse property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderColor of type DOMString
		See the border-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderLeft of type DOMString
		See the border-left property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderLeftColor of type DOMString
		See the border-left-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderLeftStyle of type DOMString
		See the border-left-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderLeftWidth of type DOMString
		See the border-left-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderRight of type DOMString
		See the border-right property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderRightColor of type DOMString
		See the border-right-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderRightStyle of type DOMString
		See the border-right-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderRightWidth of type DOMString
		See the border-right-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderSpacing of type DOMString
		See the border-spacing property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderStyle of type DOMString
		See the border-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderTop of type DOMString
		See the border-top property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderTopColor of type DOMString
		See the border-top-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderTopStyle of type DOMString
		See the border-top-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderTopWidth of type DOMString
		See the border-top-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		borderWidth of type DOMString
		See the border-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		bottom of type DOMString
		See the bottom property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		captionSide of type DOMString
		See the caption-side property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		clear of type DOMString
		See the clear property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		clip of type DOMString
		See the clip property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		color of type DOMString
		See the color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		content of type DOMString
		See the content property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		counterIncrement of type DOMString
		See the counter-increment property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		counterReset of type DOMString
		See the counter-reset property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		cssFloat of type DOMString
		See the float property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		cue of type DOMString
		See the cue property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		cueAfter of type DOMString
		See the cue-after property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		cueBefore of type DOMString
		See the cue-before property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		cursor of type DOMString
		See the cursor property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		direction of type DOMString
		See the direction property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		display of type DOMString
		See the display property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		elevation of type DOMString
		See the elevation property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		emptyCells of type DOMString
		See the empty-cells property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		font of type DOMString
		See the font property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontFamily of type DOMString
		See the font-family property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontSize of type DOMString
		See the font-size property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontSizeAdjust of type DOMString
		See the font-size-adjust property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontStretch of type DOMString
		See the font-stretch property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontStyle of type DOMString
		See the font-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontVariant of type DOMString
		See the font-variant property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		fontWeight of type DOMString
		See the font-weight property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		height of type DOMString
		See the height property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		left of type DOMString
		See the left property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		letterSpacing of type DOMString
		See the letter-spacing property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		lineHeight of type DOMString
		See the line-height property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		listStyle of type DOMString
		See the list-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		listStyleImage of type DOMString
		See the list-style-image property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		listStylePosition of type DOMString
		See the list-style-position property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		listStyleType of type DOMString
		See the list-style-type property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		margin of type DOMString
		See the margin property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		marginBottom of type DOMString
		See the margin-bottom property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		marginLeft of type DOMString
		See the margin-left property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		marginRight of type DOMString
		See the margin-right property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		marginTop of type DOMString
		See the margin-top property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		markerOffset of type DOMString
		See the marker-offset property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		marks of type DOMString
		See the marks property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		maxHeight of type DOMString
		See the max-height property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		maxWidth of type DOMString
		See the max-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		minHeight of type DOMString
		See the min-height property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		minWidth of type DOMString
		See the min-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		orphans of type DOMString
		See the orphans property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		outline of type DOMString
		See the outline property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		outlineColor of type DOMString
		See the outline-color property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		outlineStyle of type DOMString
		See the outline-style property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		outlineWidth of type DOMString
		See the outline-width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		overflow of type DOMString
		See the overflow property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		padding of type DOMString
		See the padding property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		paddingBottom of type DOMString
		See the padding-bottom property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		paddingLeft of type DOMString
		See the padding-left property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		paddingRight of type DOMString
		See the padding-right property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		paddingTop of type DOMString
		See the padding-top property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		page of type DOMString
		See the page property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pageBreakAfter of type DOMString
		See the page-break-after property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pageBreakBefore of type DOMString
		See the page-break-before property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pageBreakInside of type DOMString
		See the page-break-inside property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pause of type DOMString
		See the pause property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pauseAfter of type DOMString
		See the pause-after property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pauseBefore of type DOMString
		See the pause-before property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pitch of type DOMString
		See the pitch property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		pitchRange of type DOMString
		See the pitch-range property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		playDuring of type DOMString
		See the play-during property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		position of type DOMString
		See the position property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		quotes of type DOMString
		See the quotes property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		richness of type DOMString
		See the richness property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		right of type DOMString
		See the right property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		size of type DOMString
		See the size property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		speak of type DOMString
		See the speak property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		speakHeader of type DOMString
		See the speak-header property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		speakNumeral of type DOMString
		See the speak-numeral property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		speakPunctuation of type DOMString
		See the speak-punctuation property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		speechRate of type DOMString
		See the speech-rate property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		stress of type DOMString
		See the stress property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		tableLayout of type DOMString
		See the table-layout property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		textAlign of type DOMString
		See the text-align property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		textDecoration of type DOMString
		See the text-decoration property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		textIndent of type DOMString
		See the text-indent property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		textShadow of type DOMString
		See the text-shadow property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		textTransform of type DOMString
		See the text-transform property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		top of type DOMString
		See the top property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		unicodeBidi of type DOMString
		See the unicode-bidi property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		verticalAlign of type DOMString
		See the vertical-align property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		visibility of type DOMString
		See the visibility property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		voiceFamily of type DOMString
		See the voice-family property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		volume of type DOMString
		See the volume property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		whiteSpace of type DOMString
		See the white-space property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		widows of type DOMString
		See the widows property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		width of type DOMString
		See the width property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		wordSpacing of type DOMString
		See the word-spacing property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.

		zIndex of type DOMString
		See the z-index property definition in CSS2.
		Exceptions on setting
		DOMException

		SYNTAX_ERR: Raised if the new value has a syntax error and is unparsable.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this property is readonly.		
		
		
		*/
	}
}