package com.ffsys.dom
{
	import com.ffsys.css.*;
	
	import com.ffsys.net.sax.*;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.support.xml.BeanSaxParser;
	
	import com.ffsys.utils.string.PropertyNameConverter;	
	
	/**
	* 	Responsible for parsing css documents
	* 	represented as <code>XML</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class CssSaxParser extends BeanSaxParser
	{
		private var _css:CssDocument;
		private var _inStyleRule:Boolean = false;
		private var _rule:StyleRule;
		private var _style:Object;
		
		/**
		* 	Creates a <code>CssSaxParser</code> instance.
		*/
		public function CssSaxParser()
		{
			super();
		}
		
		/**
		* 	The css document receiving the parsed data.
		*/
		public function get css():CssDocument
		{
			if( _css == null )
			{
				_css = new CssDocument();
			}
			return _css;
		}
		
		public function set css( value:CssDocument ):void
		{
			_css = value;
		}

		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			super.beginDocument( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endDocument( token:SaxToken ):void
		{
			super.endDocument( token );
		}
		
		override public function text( token:SaxToken ):void
		{
			//
			var text:String = stripWhitespace( token.xml.toString() );
			text = stripComments( text );
			
			trace("CssSaxParser::text()", text );
			
			var parts:Array = text.split( /\n/ );
			var part:String = null;
			for( var i:int = 0;i < parts.length;i++ )
			{
				part = stripWhitespace( parts[ i ] );
				if( part == "" )
				{
					continue;
				}
			
				if( part.indexOf( CssIdentifiers.AT_RULE_CHARACTER ) == 0 )
				{
					handleAtRule( part );
					continue;
				}
				
				part = parsePart( part );
			}
		}
		
		/**
		* 	Parses an individual part.
		*/
		private function parsePart( part:String ):String
		{
			//trace("[PART] CssSaxParser::text()", part );
			
			var start:int = part.indexOf( CssIdentifiers.STYLE_RULE_START );
			var prop:int = part.indexOf( CssIdentifiers.PROPERTY_VALUE_DELIMITER );
			var end:int = part.indexOf( CssIdentifiers.STYLE_RULE_END );
			
			if( start > -1 )
			{
				part = startStyleRule( part );
			}
			
			//potential style rule property
			if( _inStyleRule
				&& prop > -1 )
			{
				parseStyleRuleProperty( part );
			}
			
			if( end > -1 )
			{
				part = finishStyleRule( part );
				
				trace("[SELECTOR END] CssSaxParser::text()", _rule.xml.toXMLString() );
			}
			
			//start more style rules if necessary
			start = part.indexOf( CssIdentifiers.STYLE_RULE_START );
			if( start > -1 )
			{
				part = parsePart( part );
			}
			
			return part;
		}
		
		/**
		* 	@private
		*/
		private function parseStyleRuleProperty( part:String ):String
		{
			var index:int = part.indexOf(
				CssIdentifiers.PROPERTY_VALUE_DELIMITER );
			var nm:String = null;
			var value:String = null;
			
			//strip any trailing end style rule character and property delimiter
			part = part.replace( /\s*\;*\s*}\s*$/, "" );
			
			var multiple:int = part.indexOf(
				CssIdentifiers.PROPERTY_DELIMITER );
			
			//handle condensed property declarations
			if( multiple > -1 )
			{
				var parts:Array = part.split(	
					CssIdentifiers.PROPERTY_DELIMITER );
				for( var i:int = 0;i < parts.length;i++ )
				{
					part = parseStyleRuleProperty(
						stripWhitespace( parts[ i ] ) );
				}
				return part;
			}
			if( index > -1 )
			{
				nm = stripWhitespace( part.substr( 0, index ) );
				value = stripWhitespace( part.substr( index + 1 ) );
				_style[ nm ] = value;
				
				var property:StyleProperty = StyleProperty(
					getCssBean(
						CssIdentifiers.STYLE_PROPERTY ) );
					
				property.name = nm;
				property.value = value;
				
				if( property.isSupported() )
				{
					_rule.appendChild( property );
				}
				
				trace("CssSaxParser::parseStyleRuleProperty()", property, property.localName, property.propertyName, property.value );
			}
			return part;
		}

		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			super.complete();
		}
		
		/**
		* 	@private
		*/
		private function stripWhitespace( text:String ):String
		{
			if( text != null )
			{
				text = text.replace( /^\s+/, "" );
				text = text.replace( /\s+$/, "" );
			}
			return text;
		}
		
		/**
		* 	@private
		*/
		private function stripComments( text:String ):String
		{
			if( text != null )
			{
				text = text.replace( /\/\*[^\/]*\*\//g, "" );
			}
			return text;
		}
		
		/**
		* 	@private
		* 	
		* 	Handles css at rule definitions.
		*/
		private function handleAtRule( part:String ):void
		{
			var rule:AtRule = AtRule( getCssBean( CssIdentifiers.AT_RULE ) );
			
			trace("[AT RULE] CssSaxParser::handleAtRule()", part, rule );
			
			rule.expression = part;
			if( rule.isSupported() )
			{
				this.css.appendChild( rule );
			}
		}
		
		/**
		* 	@private
		* 	
		* 	Starts a style rule definition.
		* 
		* 	@param part The part being parsed.
		* 
		* 	@return The part being parsed.
		*/
		private function startStyleRule( part:String ):String
		{
			_inStyleRule = true;
			_style = new Object();	
			_rule = StyleRule( 
				getCssBean(
					CssIdentifiers.STYLE_RULE ) );		
			var index:int = part.indexOf( CssIdentifiers.STYLE_RULE_START );
			if( index > -1 )
			{
				var candidate:String = stripWhitespace( part.substr( 0, index ) );
				
				//anonymous css block declarations do not
				//create selectors
				if( candidate != "" )
				{
					var selectors:Array = [ candidate ];
					if( candidate.indexOf( Selector.DELIMITER ) > -1 )
					{
						selectors = candidate.split( Selector.DELIMITER );
					}
				
					var expression:String = null;
					var selector:Selector = null;
					for( var i:int = 0;i < selectors.length;i++ )
					{
						expression = stripWhitespace( selectors[ i ] );
						selector = Selector( getCssBean( CssIdentifiers.SELECTOR ) );
						selector.expression = expression;
						_rule.appendChild( selector );
					}
				}
			}
			return part.substr( index + 1 );
		}
		
		/**
		* 	@private
		* 	
		* 	Finishes a style rule definition.
		* 
		* 	@param part The part being parsed.
		* 
		* 	@return The part being parsed.
		*/
		private function finishStyleRule( part:String ):String
		{
			this.css.addStyleRule( _rule );
			
			_inStyleRule = false;
			_style = null;
			return part.replace( /\s*}/, "" );
		}
		
		/**
		* 	@private
		*/
		protected function getCssBean( beanName:String ):Object
		{
			var bean:Object =  document.getBean(
				beanName );
			if( bean is Node )
			{
				Node( bean ).setOwnerDocument( this.css );
				//trace("[CSS BEAN] CssSaxParser::getCssBean()", bean, Node( bean ).ownerDocument );
			}
			return bean;
		}
	}
}