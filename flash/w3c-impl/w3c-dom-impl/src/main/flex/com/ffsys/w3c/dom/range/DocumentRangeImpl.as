package com.ffsys.w3c.dom.range
{
	import org.w3c.dom.range.DocumentRange;
	import org.w3c.dom.range.Range;
	
	import com.ffsys.w3c.dom.DOMBootstrap;
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;

	public class DocumentRangeImpl extends AbstractNodeProxyImpl
		implements DocumentRange
	{
		/**
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
			}
			return Range( bean );
		}
	}
}