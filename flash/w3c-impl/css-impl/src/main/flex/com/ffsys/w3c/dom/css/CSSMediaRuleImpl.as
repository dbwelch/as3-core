package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSMediaRule;
	import org.w3c.dom.css.CSSRule;	
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.MediaList;
	import org.w3c.dom.css.RuleType;	
	
	/**
	*	 Represents a &#64;media CSS rule.
	*/
	public class CSSMediaRuleImpl extends CSSRuleImpl
		implements CSSMediaRule
	{
		/**
		* 	The bean name for a media at-rule.
		*/
		public static const NAME:String = "media";
		
		/**
		* 	The name of the <code>type</code> attribute
		* 	used to store the comma-delimited list of media
		* 	types.
		*/
		public static const MEDIA_TYPE_ATTR:String = "types";
		
		private var _media:MediaList;
		
		/**
		* 	Creates a <code>CSSMediaRuleImpl</code> instance.
		* 
		* 	@param sheet The parent style sheet.
		* 	@param parent A parent rule.
		*/
		public function CSSMediaRuleImpl(
			sheet:CSSStyleSheet = null,
			parent:CSSRule = null,
			name:String = NAME )
		{
			__cssRuleType = RuleType.MEDIA_RULE;
			super( sheet, parent, name );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get media():MediaList
		{
			return _media;
		}
		
		/**
		* 	@private
		*/
		internal function setMedia( value:String ):void
		{
			_media = new MediaListImpl( value );
			setAttribute( MEDIA_TYPE_ATTR, _media.mediaText );
		}
	}
}