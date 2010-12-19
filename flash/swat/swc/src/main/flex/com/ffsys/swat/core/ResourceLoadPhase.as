package com.ffsys.swat.core
{
	
	/**
	*	Encapsulates constants that represent the resource load phases.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public class ResourceLoadPhase extends Object
	{
		/**
		* 	The default resource load phase order.
		*/
		static public var defaults:Array = [
			MESSAGES_PHASE,
			ERRORS_PHASE,
			XML_PHASE,
			TEXT_PHASE,			
			FONTS_PHASE,
			RSLS_PHASE,
			CSS_PHASE,		
			BEANS_PHASE,
			IMAGES_PHASE,
			SOUNDS_PHASE ];
		
		/**
		*	Represents the preload phase for the main application code.	
		*/
		public static const CODE_PHASE:String = "code";
	
		/**
		*	Represents the preload phase for a configuration document.
		*/
		public static const CONFIGURATION_PHASE:String = "configuration";
	
		/**
		*	Represents the preload phase for message files.
		*/
		public static const MESSAGES_PHASE:String = "messages";
	
		/**
		*	Represents the preload phase for error files.
		*/
		public static const ERRORS_PHASE:String = "errors";
	
		/**
		*	Represents the preload phase for font files.
		*/
		public static const FONTS_PHASE:String = "fonts";
	
		/**
		*	Represents the preload phase for image files.
		*/
		public static const IMAGES_PHASE:String = "images";
	
		/**
		*	Represents the preload phase for sound files.
		*/
		public static const SOUNDS_PHASE:String = "sounds";
	
		/**
		*	Represents the preload phase for runtime shared libraries.	
		*/
		public static const RSLS_PHASE:String = "rsls";
	
		/**
		*	Represents the preload phase for bean documents.
		*/
		public static const BEANS_PHASE:String = "beans";
	
		/**
		*	Represents the preload phase for XML documents.
		*/
		public static const XML_PHASE:String = "xml";
		
		/**
		*	Represents the preload phase for text documents.
		*/
		public static const TEXT_PHASE:String = "text";	
	
		/**
		*	Represents the preload phase for CSS documents.	
		*/
		public static const CSS_PHASE:String = "css";
		
		/**
		*	A phase that indicates that all loading is complete.
		*/
		public static const COMPLETE_PHASE:String = "complete";
	}
}