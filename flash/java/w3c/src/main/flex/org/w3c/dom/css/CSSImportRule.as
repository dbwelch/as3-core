package org.w3c.dom.css
{
	/**
	* 	The CSSImportRule interface represents &#64;import rule
	* 	within a CSS style sheet.
	* 
	* 	The &#64;import rule is used to import style rules from other style sheets.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSImportRule extends CSSRule
	{
		
		/**
		* 	The location of the style sheet to be imported.
		* 
		* 	The attribute will not contain the "url(...)" specifier around the URI.
		*/
		function get href():String;
		
		/**
		* 	A list of media types for which this style
		* 	sheet may be used.
		*/
		function get media():MediaList;
		
		/**
		* 	The style sheet referred to by this rule,
		* 	if it has been loaded.
		* 
		* 	The value of this attribute is null if the style
		* 	sheet has not yet been loaded or if it will not be
		* 	loaded (e.g. if the style sheet is for a media type
		* 	not supported by the user agent).
		*/
		function get styleSheet():CSSStyleSheet;
	}
}