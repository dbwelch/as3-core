package org.flashx.io.log {
	
	import org.flashx.utils.inspector.ObjectInspector;
	import org.flashx.utils.inspector.ObjectInspectorOptions;
	
	/**
	*	Implementation of <code>ILogFormatter</code>
	*	that uses an <code>ObjectInspector</code> to
	*	format the <code>LogEvent</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.03.2008
	*/
	public class LogObjectFormatter extends Object
		implements ILogFormatter {
		
		/**
		*	Creates a <code>LogObjectFormatter</code>.
		*/
		public function LogObjectFormatter()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function format(
			event:LogEvent, logger:ILogger = null ):String
		{
			
			if( !event )
			{
				return null;
			}
			
			var output:ObjectInspector = new ObjectInspector(
				event, new ObjectInspectorOptions() );
				
			output.detail = logger.applicationName;
			
			if( logger.url )
			{
				output.detail += " " + logger.url;
			}
			
			var properties:Object = new Object();
			properties.message = event.message;
			properties.level = event.level;
			properties.category = event.category;
			properties.className = event.className;
			properties.methodName = event.methodName;
			properties.lineNumber = event.lineNumber;
			
			output.properties = properties;
			
			return output.getComplexInspection();
		}	
	}
	
}
