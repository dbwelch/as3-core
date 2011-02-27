package com.ffsys.w3c.dom.css
{
	import com.ffsys.w3c.dom.ElementImpl;
	
	/**
	* 	Abstract super class for CSS DOM elements.
	* 
	* 	Although the CSS-DOM Level 2 specification does not
	* 	enfore that CSS-DOM implementations are Element implementations,
	* 	this absract class extends the Element implementation
	* 	so that CSS documents may be easily transferred to and
	* 	from XML representations.
	*/
	public class AbstractCSSDOMElement extends ElementImpl
	{
		/**
		* 	Creates an <code>AbstractCSSDOMElement</code> instance.
		*/
		public function AbstractCSSDOMElement()
		{
			super();
		}
	}
}