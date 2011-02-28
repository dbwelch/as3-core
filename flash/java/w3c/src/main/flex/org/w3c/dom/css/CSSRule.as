package org.w3c.dom.css
{
	/**
	* 	The CSSRule interface is the abstract base
	* 	interface for any type of CSS statement.
	* 
	* 	This includes both rule sets and at-rules.
	* 	An implementation is expected to preserve all
	* 	rules specified in a CSS style sheet, even if
	* 	the rule is not recognized by the parser.
	* 	Unrecognized rules are represented using the
	* 	CSSUnknownRule interface.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSRule
	{
		/**
		* 	The type of the rule.
		* 
		* 	The expectation is that binding-specific
		* 	casting methods can be used to cast down from
		* 	an instance of the CSSRule interface to the
		* 	specific derived interface implied by the type.
		*/
		function get type():uint;
		
		/**
		* 	The parsable textual representation of the rule.
		* 
		* 	This reflects the current state of the rule and not
		* 	its initial value.
		* 
		* 	@throws DOMException.SYNTAX_ERR: Raised if the specified
		* 	CSS string value has a syntax error and is unparsable.
		* 	@throws DOMException.INVALID_MODIFICATION_ERR: Raised if
		* 	the specified CSS string value represents a different type
		* 	of rule than the current one.
		* 	@throws DOMException.HIERARCHY_REQUEST_ERR: Raised if the
		* 	rule cannot be inserted at this point in the style sheet.
		* 	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if the rule is readonly.
		*/
		function get cssText():String;
		function set cssText( text:String ):void;
		
		/**
		* 	The style sheet that contains this rule.
		*/
		function get parentStyleSheet():CSSStyleSheet;
		
		/**
		* 	If this rule is contained inside another
		* 	rule (e.g. a style rule inside an @media block),
		* 	this is the containing rule. If this rule is not
		* 	nested inside any other rules, this returns null.
		*/
		function get parentRule():CSSRule;
	}
}