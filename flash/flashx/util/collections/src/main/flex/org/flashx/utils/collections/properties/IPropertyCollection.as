package org.flashx.utils.collections.properties {
	
	import org.flashx.utils.collections.data.IDataCollection;
	
	/**
	*	Common type for collections of properties.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	public interface IPropertyCollection
		extends IDataCollection,
				IPropertyAccess {
		
		function getPropertyCollectionById(
			id:String ):IPropertyCollection;
	}
}