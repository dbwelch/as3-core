package com.ffsys.swat.core
{
	import com.ffsys.core.IDestroy;
	import com.ffsys.ioc.IBeanAccess;
	import com.ffsys.swat.core.IMessageAccess;
	import com.ffsys.swat.core.IStyleAccess;
	
	/**
	*	Describes the contract for application controllers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.12.2010
	*/
	public interface IApplicationController
		extends IDestroy,
				IBeanAccess,
				IMessageAccess,
				IStyleAccess,
				IConfigurationAware
	{
		//
	}
}