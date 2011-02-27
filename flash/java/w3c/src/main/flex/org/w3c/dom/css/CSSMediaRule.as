package org.w3c.dom.css
{
	/**
	* 	The CSSMediaRule interface represents a &#64;media rule
	* 	in a CSS style sheet.
	* 
	* 	A &#64;media rule can be used to delimit style rules for
	* 	specific media types.
	* 
	*	@see http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/css.html
	*/
	public interface CSSMediaRule extends CSSRule
	{
		/**
		* 	A list of media types for this rule.
		*/
		function get media():MediaList;
		
		/**
		* 	A list of all CSS rules contained within 
		* 	the media block.
		*/
		function get cssRules():CSSRuleList;
		
		/**
		* 	Used to insert a new rule into the media block.
		* 	
		* 	@param rule The parsable text representing the rule.
		* 	For rule sets this contains both the selector and the
		* 	style declaration. For at-rules, this specifies both
		* 	the at-identifier and the rule content.
		* 	@param index The index within the media block's rule
		* 	collection of the rule before which to insert the specified rule.
		* 	If the specified index is equal to the length of the media
		* 	blocks's rule collection, the rule will be added to the end of
		* 	the media block.
		* 
		* 	@throws DOMException.HIERARCHY_REQUEST_ERR: Raised if the rule cannot
		* 	be inserted at the specified index, e.g., if an @import rule is inserted
		* 	after a standard rule set or other at-rule.
		*	@throws DOMException.INDEX_SIZE_ERR: Raised if the specified index is
		* 	not a valid insertion point.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if this media
		* 	rule is readonly.
		*	@throws DOMException.SYNTAX_ERR: Raised if the specified rule has a
		* 	syntax error and is unparsable.
		* 
		* 	@return The index within the media block's rule
		* 	collection of the newly inserted rule.
		*/
		function insertRule( rule:String, index:uint ):uint;
		
		/**
		* 	Used to delete a rule from the media block.
		* 
		* 	@param index The index within the media block's
		* 	rule collection of the rule to remove.
		* 
		* 	@throws DOMException.INDEX_SIZE_ERR: Raised if the
		* 	specified index does not correspond to a rule in the
		* 	media rule list.
		*	@throws DOMException.NO_MODIFICATION_ALLOWED_ERR: Raised if
		* 	this media rule is readonly.
		*/
		function deleteRule( index:uint ):void;
	}
}