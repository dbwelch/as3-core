package com.ffsys.swat.core
{
	import com.ffsys.core.IDestroy;
	import com.ffsys.ioc.IBeanAccess;
	import com.ffsys.swat.configuration.IMessageAccess;
	import com.ffsys.swat.configuration.IMediaAccess;
	import com.ffsys.swat.configuration.IConfigurationAware;
	
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
				IMediaAccess,
				IConfigurationAware
	{
		//
	}
}