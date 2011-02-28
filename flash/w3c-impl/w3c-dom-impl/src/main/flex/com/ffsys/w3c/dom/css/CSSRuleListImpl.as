package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.CSSRuleList;
	
	import com.ffsys.w3c.dom.AbstractListImpl;
	
	/**
	* 	Represents a list of CSS rules.
	*/
	public class CSSRuleListImpl extends AbstractListImpl
		implements CSSRuleList
	{
		/**
		* 	Creates a <code>CSSRuleListImpl</code> instance.
		*/
		public function CSSRuleListImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):CSSRule
		{
			return null;
		}
	}
}