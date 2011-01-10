package com.ffsys.ui.dom
{	
	import com.ffsys.core.*;	
	import com.ffsys.ioc.*;
	
	/**
	*	A common type for all implementations that
	* 	appear as part of a <code>DOM</code> object graph.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public interface IDomElement
		extends IDomXmlAware,
				IBeanDocumentAware,
				IBean,
				IStringIdentifier,
				IDestroy
	{
		//
	}
}