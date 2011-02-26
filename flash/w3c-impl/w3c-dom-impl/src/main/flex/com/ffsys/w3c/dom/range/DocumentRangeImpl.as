package com.ffsys.w3c.dom.range
{
	import org.w3c.dom.range.DocumentRange;
	import org.w3c.dom.range.Range;
	
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;

	import com.ffsys.w3c.dom.DOMImplementationImpl;

	public class DocumentRangeImpl extends DOMImplementationImpl
		implements DocumentRange
	{
		/**
		* 	@private
		* 	
		* 	Creates a <code>DocumentRangeImpl</code> instance.
		*/
		public function DocumentRangeImpl()
		{
			super();
		}
	
		/**
		* 	@inheritDoc
		*/
		public function createRange():Range
		{
			var bean:Object = null;
			try
			{
				bean = this.document.getBean(
					DOMBootstrap.RANGE_IMPL );
			}catch( e:Error )
			{
				//no bean document assigned most likely
				//not instantiated via IoC
				bean = new RangeImpl();
			}
			return Range( bean );
		}
	}
}