package com.ffsys.io.loaders.message {
	
	import com.ffsys.utils.identifier.CamelCaseUtils;
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.io.loaders.message.AbstractLoadMessageFormatter;
	
	/**
	*	Implementation of <code>ILoadMessageFormatter</code> that
	*	converts the camel case <code>id</code> into title
	*	case when formatting load messages.
	*	
	*	After conversion of the <code>id</code> this method will
	*	substitute a <code>%s</code> value in the source
	*	<code>message</code> with the converted <code>id</code>.
	*	
	*	@see com.ffsys.utils.identifier.CamelCaseUtils
	*	@see com.ffsys.utils.string.StringUtils
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.11.2007
	*/
	public class LoadMessageFormatter
		extends AbstractLoadMessageFormatter {
		
		/**
		*	Creates a <code>LoadMessageFormatter</code>
		*	instance.
		*/		
		public function LoadMessageFormatter()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/		
		override public function format(
			message:String = null,
			id:String = null ):String
		{
			if( id )
			{
				id = StringUtils.removeExtension( id );
				id = CamelCaseUtils.camelCaseToTitleCase( id );
			}
			return StringUtils.substitute( message, id );
		}
	}
}