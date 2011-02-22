package com.ffsys.w3c.dom.core
{
	/**
	* 	Encapsulates constants that represent the various
	* 	DOM modules and corresponding feature names.
	*/	
	public class DOMFeature extends Object
	{
		/**
		* 	Represents the core module.
		*/
		public static const CORE_MODULE:String = "Core";
		
		/**
		* 	Represents the XML module.
		*/
		public static const XML_MODULE:String = "XML";
		
		/**
		* 	Represents the events module.
		*/
		public static const EVENTS_MODULE:String = "Events";
		
		/**
		* 	Represents the UI events module.
		*/
		public static const UI_EVENTS_MODULE:String = "UIEvents";
		
		/**
		* 	Represents the mouse events module.
		*/
		public static const MOUSE_EVENTS_MODULE:String = "MouseEvents";
		
		/**
		* 	Represents the wheel events module.
		*/
		public static const WHEEL_EVENTS_MODULE:String = "WheelEvents";
		
		/**
		* 	Represents the composition events module.
		*/
		public static const COMPOSITION_EVENTS_MODULE:String = "CompositionEvents";
		
		/**
		* 	Represents the custom events module.
		*/
		public static const CUSTOM_EVENTS_MODULE:String = "CustomEvents";
		
		/**
		* 	Represents the text events module.
		*/
		public static const TEXT_EVENTS_MODULE:String = "TextEvents";
		
		/**
		* 	Represents the keyboard events module.
		*/
		public static const KEYBOARD_EVENTS_MODULE:String = "KeyboardEvents";
		
		/**
		* 	Represents the mutation events module.
		*/
		public static const MUTATION_EVENTS_MODULE:String = "MutationEvents";
		
		/**
		* 	Represents the mutation name events module.
		*/
		public static const MUTATION_NAME_EVENTS_MODULE:String = "MutationNameEvents";
		
		/**
		* 	Represents the load and save module.
		*/
		public static const LS_MODULE:String = "LS";
		
		/**
		* 	Represents the asynchronous load and save module.
		*/
		public static const LS_ASYNC_MODULE:String = "LS-Async";
		
		/**
		* 	Represents the validation module.
		*/
		public static const VALIDATION_MODULE:String = "Validation";
		
		/**
		* 	Represents the XPath module.
		*/
		public static const XPATH_MODULE:String = "XPath";
		
		/**
		* 	Represents the HTML module.
		*/
		public static const HTML_MODULE:String = "HTML";
		
		/**
		* 	Represents the Views module.
		*/
		public static const VIEWS_MODULE:String = "Views";
		
		/**
		* 	Represents the DOM level 1 version number.
		*/
		public static const LEVEL_1:String = "1.0";
		
		/**
		* 	Represents the DOM level 2 version number.
		*/
		public static const LEVEL_2:String = "2.0";
		
		/**
		* 	Represents the DOM level 3 version number.
		*/
		public static const LEVEL_3:String = "3.0";
		
		/**
		* 	A feature implementation to represent
		* 	the DOM Core feature.
		*/
		public static const CORE_FEATURE:DOMFeature =
			new DOMFeature( CORE_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Core feature.
		*/
		public static const XML_FEATURE:DOMFeature =
			new DOMFeature( XML_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Events feature.
		*/
		public static const EVENTS_FEATURE:DOMFeature =
			new DOMFeature( EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM UI Events feature.
		*/
		public static const UI_EVENTS_FEATURE:DOMFeature =
			new DOMFeature( UI_EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Mouse Events feature.
		*/
		public static const MOUSE_EVENTS_FEATURE:DOMFeature =
			new DOMFeature( MOUSE_EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Text Events feature.
		*/
		public static const TEXT_EVENTS_FEATURE:DOMFeature =
			new DOMFeature( TEXT_EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Keyboard Events feature.
		*/
		public static const KEYBOARD_EVENTS_FEATURE:DOMFeature =
			new DOMFeature( KEYBOARD_EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Mutation Events feature.
		*/
		public static const MUTATION_EVENTS_FEATURE:DOMFeature =
			new DOMFeature( MUTATION_EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Mutation Events feature.
		*/
		public static const MUTATION_NAME_EVENTS_FEATURE:DOMFeature =
			new DOMFeature( MUTATION_NAME_EVENTS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM LS feature.
		*/
		public static const LS_FEATURE:DOMFeature =
			new DOMFeature( LS_MODULE, LEVEL_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM LS Async feature.
		*/
		public static const LS_ASYNC_FEATURE:DOMFeature =
			new DOMFeature( LS_ASYNC_MODULE, LEVEL_3 );
		
		private var _feature:String;
		private var _version:String;
		
		/**
		* 	Creates a <code>DOMFeature</code> instance.
		* 
		* 	@param feature The DOM feature.
		* 	@param version The DOM feature version.
		*/
		public function DOMFeature(
			feature:String = null, version:String = null )
		{
			super();
			this.feature = feature;
			this.version = version;
		}
		
		/**
		* 	Determines whether this feature
		*	is a valid recognised DOM feature.
		*/
		public function get valid():Boolean
		{
			if( feature is String )
			{
				feature = feature.toLowerCase();
				return feature == CORE_MODULE.toLowerCase()
					|| feature == XML_MODULE.toLowerCase()
					|| feature == EVENTS_MODULE.toLowerCase()
					|| feature == UI_EVENTS_MODULE.toLowerCase()
					|| feature == MOUSE_EVENTS_MODULE.toLowerCase()
					|| feature == TEXT_EVENTS_MODULE.toLowerCase()
					|| feature == KEYBOARD_EVENTS_MODULE.toLowerCase()
					|| feature == MUTATION_EVENTS_MODULE.toLowerCase()
					|| feature == MUTATION_NAME_EVENTS_MODULE.toLowerCase()
					|| feature == WHEEL_EVENTS_MODULE.toLowerCase()
					|| feature == CUSTOM_EVENTS_MODULE.toLowerCase()					
					|| feature == COMPOSITION_EVENTS_MODULE.toLowerCase()
					|| feature == LS_MODULE.toLowerCase()
					|| feature == LS_ASYNC_MODULE.toLowerCase()
					|| feature == VALIDATION_MODULE.toLowerCase()
					|| feature == XPATH_MODULE.toLowerCase()
					|| feature == HTML_MODULE.toLowerCase()
					|| feature == VIEWS_MODULE.toLowerCase();																																																																											
			}
			
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasFeature(
			feature:String, version:String ):Boolean
		{
			if( feature == null
				|| this.feature == null
				|| feature != this.feature )
			{
				return false;
			}
			feature = feature.toLowerCase();
			if( version != null && this.version != null )
			{
				var target:Number = Number( version );
				var limit:Number = Number( this.version );
				if( isNaN( target ) || target > limit )
				{
					return false;
				}
			}
			return ( feature == this.feature.toLowerCase() );
		}
		
		/**
		* 	The DOM feature.
		*/
		public function get feature():String
		{
			return _feature;
		}
		
		public function set feature( value:String ):void
		{
			_feature = value;
		}
		
		/**
		* 	The DOM feature version.
		*/
		public function get version():String
		{
			return _version;
		}

		public function set version( value:String ):void
		{
			_version = value;
		}
	}
}