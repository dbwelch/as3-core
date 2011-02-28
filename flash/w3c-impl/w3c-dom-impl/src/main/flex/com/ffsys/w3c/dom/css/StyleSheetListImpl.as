package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.StyleSheet;	
	import org.w3c.dom.css.StyleSheetList;
	
	import com.ffsys.w3c.dom.AbstractListImpl;
	
	/**
	* 	Represents a list of style sheets.
	*/
	public class StyleSheetListImpl extends AbstractListImpl
		implements StyleSheetList
	{
		/**
		* 	Creates a <code>StyleSheetListImpl</code> instance.
		*/
		public function StyleSheetListImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):StyleSheet
		{
			return null;
		}
	}
}