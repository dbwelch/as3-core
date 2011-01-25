package com.ffsys.css
{
	import com.ffsys.dom.Element;
	
	
	dynamic public class StyleElement extends Element
	{
		/**
		* 	Creates a <code>StyleElement</code> instance.
		*/
		public function StyleElement( source:Object = null )
		{
			super();
			if( source != null )
			{
				setSource( source );
			}
		}
	}
}