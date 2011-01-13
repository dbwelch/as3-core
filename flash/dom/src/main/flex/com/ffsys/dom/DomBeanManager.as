package com.ffsys.dom
{
	import com.ffsys.ioc.*;	

	public class DomBeanManager extends BeanManager
	{	
		/**
		* 	Creates a <code>DomBeanManager</code> instance.
		*/
		public function DomBeanManager( elements:IBeanDocument = null )
		{
			super();
			this.document = elements;
		}
	}
}