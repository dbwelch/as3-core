package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSValue;
	import org.w3c.dom.css.CSSValueList;
	
	import com.ffsys.w3c.dom.AbstractListImpl;
	
	/**
	* 	Represents a list of CSS values.
	*/
	public class CSSValueListImpl extends AbstractListImpl
		implements CSSValueList
	{
		/**
		* 	Creates a <code>CSSValueListImpl</code> instance.
		*/
		public function CSSValueListImpl()
		{
			super();
		}	
		
		/**
		* 	@inheritDoc
		*/
		public function item( index:uint ):CSSValue
		{
			var child:CSSValue = _children[ index ] as CSSValue;
			return child;
		}
	}
}