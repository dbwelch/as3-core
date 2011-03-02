package com.ffsys.w3c.dom
{
	/**
	* 	Encapsulates constants that represent the various
	* 	DOM modules and corresponding feature names.
	* 
	* 	@see http://www.w3.org/TR/2010/WD-domcore-20101007/index.html#dom-features
	*/	
	public class DOMFeature extends Object
	{
		/**
		* 	The delimiter between a feature name
		* 	and a version number -- a single space character.
		*/
		public static const DELIMITER:String = " ";
		
		/**
		* 	The expression used to determine if a candidate
		* 	feature part is a module.
		*/
		public static const MODULE_EXPRESSION:RegExp = /\+?[a-zA-Z]+/;
		
		/**
		* 	The expression used to determine if a candidate
		* 	feature part is a version number.
		*/
		public static const VERSION_EXPRESSION:RegExp = /^([0-9]+)?\.?([0-9]+)/;
		
		/**
		* 	The optional character that may appear
		* 	at the beginning of a feature name.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	Represents the core module.
		*/
		public static const CORE_MODULE:String = "Core";
		
		/**
		* 	Represents the XML module.
		*/
		public static const XML_MODULE:String = "XML";
		
		/**
		* 	Represents the HTML module.
		*/
		public static const HTML_MODULE:String = "HTML";		
		
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
		* 	Represents the Range module.
		*/
		public static const RANGE_MODULE:String = "Range";
		
		/**
		* 	Represents the Traversal module.
		*/
		public static const TRAVERSAL_MODULE:String = "Traversal";
		
		/**
		* 	Represents the Views module.
		*/
		public static const VIEWS_MODULE:String = "Views";
		
		/**
		* 	Represents the StyleSheets module.
		*/
		public static const STYLESHEETS_MODULE:String = "StyleSheets";
		
		/**
		* 	Represents the CSS module.
		*/
		public static const CSS_MODULE:String = "CSS";
		
		/**
		* 	Represents the CSS2 module.
		*/
		public static const CSS2_MODULE:String = "CSS2";
		
		/**
		* 	Represents the ElementTraversal module.
		*/
		public static const ELEMENT_TRAVERSAL_MODULE:String = "ElementTraversal";
		
		/**
		* 	A list of all possible backward compatible
		* 	version numbers.
		*/
		public static const COMPATIBILITY_VERSIONS:Array = [
			DOMVersion.LEVEL_2,
			DOMVersion.LEVEL_1
		];

		/**
		* 	A feature implementation to represent
		* 	the DOM Core level 3.0 feature.
		* 
		* 	This representation is also backwards compatible
		* 	with the "2.0" and "1.0" version numbers.
		*/
		public static const CORE_3_FEATURE:DOMFeature =
			new DOMFeature(
				CORE_MODULE,
				DOMVersion.VERSION_3.clone( COMPATIBILITY_VERSIONS )
			);
			
		/**
		* 	A feature implementation to represent
		* 	the DOM XML level 3.0 feature.
		* 
		* 	This representation is also backwards compatible
		* 	with the "2.0" and "1.0" version numbers.
		*/
		public static const XML_3_FEATURE:DOMFeature =
			new DOMFeature(
				XML_MODULE,
				DOMVersion.VERSION_3.clone( COMPATIBILITY_VERSIONS )
			);
					
		/**
		* 	A feature implementation to represent
		* 	the DOM HTML level 2.0 feature.
		* 
		* 	This representation is also backwards compatible
		* 	with the "1.0" version number.
		*/
		public static const HTML_2_FEATURE:DOMFeature =
			new DOMFeature(
				HTML_MODULE, 
				DOMVersion.VERSION_2.clone(
					[
						DOMVersion.LEVEL_1
					] )
				);
					
		/**
		* 	A feature implementation to represent
		* 	the DOM LS level 3.0 feature.
		*/
		public static const LS_3_FEATURE:DOMFeature =
			new DOMFeature(
				LS_MODULE, DOMVersion.VERSION_3 );

		/**
		* 	A feature implementation to represent
		* 	the DOM LS Async level 3.0 feature.
		*/
		public static const LS_ASYNC_3_FEATURE:DOMFeature =
			new DOMFeature(
				LS_ASYNC_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Validation level 3.0 feature.
		*/
		public static const VALIDATION_3_FEATURE:DOMFeature =
			new DOMFeature(
				VALIDATION_MODULE, DOMVersion.VERSION_3 );

		/**
		* 	A feature implementation to represent
		* 	the DOM Range level 2.0 feature.
		*/
		public static const RANGE_2_FEATURE:DOMFeature =
			new DOMFeature(
				RANGE_MODULE, DOMVersion.VERSION_2 );

		/**
		* 	A feature implementation to represent
		* 	the DOM Traversal level 2.0 feature.
		*/
		public static const TRAVERSAL_2_FEATURE:DOMFeature =
			new DOMFeature(
				TRAVERSAL_MODULE, DOMVersion.VERSION_2 );

		/**
		* 	A feature implementation to represent
		* 	the DOM ElementTraversal level 3.0 feature.
		* 
		* 	This representation is also backwards compatible
		* 	with the "2.0" and "1.0" version numbers.
		*/
		public static const ELEMENT_TRAVERSAL_3_FEATURE:DOMFeature =
			new DOMFeature(
				ELEMENT_TRAVERSAL_MODULE, 
				DOMVersion.VERSION_3.clone(
					COMPATIBILITY_VERSIONS )
			);
		
		/**
		* 	A feature implementation to represent
		* 	the DOM Events level 3.0 feature.
		* 
		* 	This representation is also backwards compatible
		* 	with the "2.0" and "1.0" version numbers.
		*/
		public static const EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				EVENTS_MODULE,
				DOMVersion.VERSION_3.clone( COMPATIBILITY_VERSIONS ) );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM UI Events level 3.0 feature.
		*/
		public static const UI_EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				UI_EVENTS_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Mouse Events level 3.0 feature.
		*/
		public static const MOUSE_EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				MOUSE_EVENTS_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Text Events level 3.0 feature.
		*/
		public static const TEXT_EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				TEXT_EVENTS_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Keyboard Events level 3.0 feature.
		*/
		public static const KEYBOARD_EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				KEYBOARD_EVENTS_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Mutation Events level 3.0 feature.
		*/
		public static const MUTATION_EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				MUTATION_EVENTS_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Mutation Events level 3.0 feature.
		*/
		public static const MUTATION_NAME_EVENTS_3_FEATURE:DOMFeature =
			new DOMFeature(
				MUTATION_NAME_EVENTS_MODULE, DOMVersion.VERSION_3 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM Views level 2.0 feature.
		*/
		public static const VIEWS_2_FEATURE:DOMFeature =
			new DOMFeature(
				VIEWS_MODULE, DOMVersion.VERSION_2 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM StyleSheets level 2.0 feature.
		*/
		public static const STYLESHEETS_2_FEATURE:DOMFeature =
			new DOMFeature(
				STYLESHEETS_MODULE, DOMVersion.VERSION_2 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM CSS level 2.0 feature.
		*/
		public static const CSS_2_FEATURE:DOMFeature =
			new DOMFeature(
				CSS_MODULE, DOMVersion.VERSION_2 );
			
		/**
		* 	A feature implementation to represent
		* 	the DOM CSS2 level 2.0 feature.
		*/
		public static const CSS2_2_FEATURE:DOMFeature =
			new DOMFeature(
				CSS2_MODULE, DOMVersion.VERSION_2 );

		private var _feature:String;
		private var _version:DOMVersion;
		
		/**
		* 	Creates a <code>DOMFeature</code> instance.
		* 
		* 	@param feature The DOM feature.
		* 	@param version The DOM feature version.
		*/
		public function DOMFeature(
			feature:String = null,
			version:Object = null )
		{
			super();
			_feature = feature;
			
			var v:DOMVersion = version as DOMVersion;
			if( v == null )
			{
				v = new DOMVersion( "" + version );
			}

			_version = v;
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
					|| feature == HTML_MODULE.toLowerCase()
					|| feature == LS_MODULE.toLowerCase()
					|| feature == LS_ASYNC_MODULE.toLowerCase()					
					|| feature == VALIDATION_MODULE.toLowerCase()
					|| feature == ELEMENT_TRAVERSAL_MODULE.toLowerCase()
					|| feature == RANGE_MODULE.toLowerCase()
					|| feature == TRAVERSAL_MODULE.toLowerCase()					
					|| feature == XPATH_MODULE.toLowerCase()							
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
					|| feature == VIEWS_MODULE.toLowerCase()
					|| feature == CSS_MODULE.toLowerCase()
					|| feature == CSS2_MODULE.toLowerCase();
			}
			
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function equals(
			name:String, level:String ):Boolean
		{
			if( name == null
				|| this.feature == null )
			{
				return false;
			}
			
			var valid:Boolean = false;
			
			/*
			var targetVersion:DOMVersion = null;
			//explicit version number found
			if( level != null && level != "" )
			{
				targetVersion = new DOMVersion( level );
				
				//invalid version number
				if( !targetVersion.isValid() )
				{
					return false;
				}
			}
			*/
			
			//trace("[FT EQUALS] DOMFeature::equals()", name, level, toString() );
			
			//feature names are case-insensitive
			var ft:String = this.feature.toLowerCase();
			name = name.toLowerCase();
			
			if( this.version != null
				&& ( level != null && level != "" && level != ( "" + null ) ) )
			{
				valid = ( this.version.test( level ) )
					&& ( name === ft );
			}else
			{
				valid = ( name === ft );
			}
			return valid;
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
		public function get version():DOMVersion
		{
			if( _version == null )
			{
				return new DOMVersion();
			}
			return _version;
		}

		public function set version( value:DOMVersion ):void
		{
			_version = value;
		}
		
		/**
		* 	The full representation of this feature
		* 	including version information when available.
		* 
		* 	@return A string representation of this feature.
		*/
		public function toString():String
		{
			if( this.version == null )
			{
				return this.feature;
			}
			return this.feature + DELIMITER + this.version;
		}
		
		/**
		* 	A convenience method for implementations to generate
		* 	an identifier consisting of a feature name optionally
		* 	concatenated with a version.
		* 
		* 	@param feature The DOM feature.
		* 	@param version The version number.
		* 
		* 	@return A full feature and version string
		* 	delimited with whitespace.
		*/
		static public function getQualifiedFeatureName(
			feature:String, version:String = null ):String
		{
			var nm:String = feature;
			if( version != null )
			{
				nm += DOMFeature.DELIMITER + version;
			}
			return nm;
		}
	}
}