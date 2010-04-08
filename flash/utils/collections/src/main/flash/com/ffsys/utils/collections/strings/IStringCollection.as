package com.ffsys.utils.collections.strings {
	
	import com.ffsys.utils.collections.data.IDataCollection;
	
	/**
	*	Common type for collections of Strings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.09.2007
	*/
	public interface IStringCollection
		extends IDataCollection,
				IStringAccess {
		
		function getStringCollectionById( id:String ):IStringCollection;
	}
}