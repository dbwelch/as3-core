package org.w3c.dom.css
{
	/**
	* 	Encapsulates the available CSS media types.
	*/
	public class MediaType extends Object
	{
		/**
		* 	Represents all media types.
		* 
		* 	Suitable for all devices.
		*/
		public static const ALL_MEDIA_TYPE:String = "all";
		
		/**
		* 	Represents print media.
		* 
		* 	Intended for paged material and for documents
		* 	viewed on screen in print preview mode.
		*/
		public static const PRINT_MEDIA_TYPE:String = "print";
		
		/**
		* 	Represents the screen media type.
		* 
		* 	Intended primarily for color computer screens.
		*/
		public static const SCREEN_MEDIA_TYPE:String = "screen";
		
		/**
		* 	Represents the braille media type.
		* 
		* 	Intended for braille tactile feedback devices.
		*/
		public static const BRAILLE_MEDIA_TYPE:String = "braille";
		
		/**
		* 	Represents the embossed media type.
		* 
		* 	Intended for paged braille printers.	
		*/
		public static const EMBOSSED_MEDIA_TYPE:String = "embossed";
		
		/**
		* 	Represents the handheld media type.
		* 
		* 	Intended for handheld devices (typically small
		* 	screen, limited bandwidth).
		*/
		public static const HANDHELD_MEDIA_TYPE:String = "handheld";
		
		/**
		* 	Represents the projection media type.
		* 
		* 	Intended for projected presentations, for example projectors.
		*/
		public static const PROJECTION_MEDIA_TYPE:String = "projection";
		
		/**
		* 	Represents the speech media type.
		* 
		* 	Intended for speech synthesizers. Note: CSS2 had a
		* 	similar media type called 'aural' for this purpose.
		*/
		public static const SPEECH_MEDIA_TYPE:String = "speech";
		
		/**
		* 	Represents the tty media type.
		* 
		* 	Intended for media using a fixed-pitch character grid
		* 	(such as teletypes, terminals, or portable devices with
		* 	limited display capabilities). Authors should not use
		* 	pixel units with the "tty" media type.
		*/
		public static const TTY_MEDIA_TYPE:String = "tty";
		
		/**
		* 	Represents the tv media type.
		* 
		* 	Intended for television-type devices (low resolution,
		* 	color, limited-scrollability screens, sound available).
		*/
		public static const TV_MEDIA_TYPE:String = "tv";
		
		/**
		* 	A media type constant for the <code>all</code> value.
		*/
		public static const ALL:MediaType =
			new MediaType( ALL_MEDIA_TYPE );
			
		/**
		* 	A media type constant for the <code>print</code> value.
		*/
		public static const PRINT:MediaType =
			new MediaType( PRINT_MEDIA_TYPE );
			
		/**
		* 	A media type constant for the <code>screen</code> value.
		*/
		public static const SCREEN:MediaType =
			new MediaType( SCREEN_MEDIA_TYPE );	
		
		private var _medium:String;
	
		/**
		* 	Creates a <code>MediaType</code> instance.
		* 
		* 	@param medium The medium.
		*/
		public function MediaType( medium:String = null )
		{
			super();
			_medium = medium;
		}
		
		/**
		* 	Determines whether a candidate media type
		* 	is one of the known media types.
		* 
		* 	@param media The candidate media type.
		* 
		* 	@return Whether the media type is a known
		* 	media type.
		*/
		public static function isValid( media:String ):Boolean
		{
			return media === ALL_MEDIA_TYPE
				|| media === PRINT_MEDIA_TYPE
				|| media === SCREEN_MEDIA_TYPE
				|| media === BRAILLE_MEDIA_TYPE
				|| media === EMBOSSED_MEDIA_TYPE
				|| media === HANDHELD_MEDIA_TYPE
				|| media === PROJECTION_MEDIA_TYPE
				|| media === SPEECH_MEDIA_TYPE
				|| media === TTY_MEDIA_TYPE
				|| media === TV_MEDIA_TYPE;																												
		}
		
		/**
		* 	A string representation of this media type.
		* 
		* 	@return The underlying medium.
		*/
		public function toString():String
		{
			return _medium;
		}
	}
}