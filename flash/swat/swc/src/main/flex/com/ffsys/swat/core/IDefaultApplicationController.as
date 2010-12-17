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
	*	@since  08.06.2010
	*/
	public interface IDefaultApplicationController
		extends IDestroy,
				IBeanAccess,
				IMessageAccess,
				IMediaAccess,
				IConfigurationAware
	{
		//
	}
}