package org.w3c.dom.css
{
	
	
	public interface CSSMediaRule extends CSSRule
	{
		
		/*
		
		Interface CSSMediaRule (introduced in DOM Level 2)
		The CSSMediaRule interface represents a @media rule in a CSS style sheet. A @media rule can be used to delimit style rules for specific media types.


		IDL Definition
		// Introduced in DOM Level 2:
		interface CSSMediaRule : CSSRule {
		  readonly attribute stylesheets::MediaList  media;
		  readonly attribute CSSRuleList      cssRules;
		  unsigned long      insertRule(in DOMString rule, 
		                                in unsigned long index)
		                                        raises(DOMException);
		  void               deleteRule(in unsigned long index)
		                                        raises(DOMException);
		};

		Attributes
		cssRules of type CSSRuleList, readonly
		A list of all CSS rules contained within the media block.
		media of type stylesheets::MediaList, readonly
		A list of media types for this rule.
		Methods
		deleteRule
		Used to delete a rule from the media block.
		Parameters
		index of type unsigned long
		The index within the media block's rule collection of the rule to remove.
		Exceptions
		DOMException

		INDEX_SIZE_ERR: Raised if the specified index does not correspond to a rule in the media rule list.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this media rule is readonly.

		No Return Value
		insertRule
		Used to insert a new rule into the media block.
		Parameters
		rule of type DOMString
		The parsable text representing the rule. For rule sets this contains both the selector and the style declaration. For at-rules, this specifies both the at-identifier and the rule content.
		index of type unsigned long
		The index within the media block's rule collection of the rule before which to insert the specified rule. If the specified index is equal to the length of the media blocks's rule collection, the rule will be added to the end of the media block.
		Return Value
		unsigned long

		The index within the media block's rule collection of the newly inserted rule.

		Exceptions
		DOMException

		HIERARCHY_REQUEST_ERR: Raised if the rule cannot be inserted at the specified index, e.g., if an @import rule is inserted after a standard rule set or other at-rule.

		INDEX_SIZE_ERR: Raised if the specified index is not a valid insertion point.

		NO_MODIFICATION_ALLOWED_ERR: Raised if this media rule is readonly.

		SYNTAX_ERR: Raised if the specified rule has a syntax error and is unparsable.		
		
		*/
	}
}