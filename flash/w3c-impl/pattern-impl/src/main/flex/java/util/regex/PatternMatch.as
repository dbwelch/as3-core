package java.util.regex
{
	import flash.utils.getQualifiedClassName;
	
	/**
	* 	Represents the result of a single pattern
	* 	match.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.03.2011
	*/
	public class PatternMatch extends PatternList
	{
		private var _pattern:Pattern;
		private var _position:uint = 0;
		private var _result:Boolean;
		private var _target:*;
		
		/**
		* 	Creates a <code>PatternMatch</code> instance.
		* 
		* 	@param position The position in the pattern that the
		* 	match occured at.
		* 	@param pattern The pattern used for the match.
		* 	@param target The target value being matched against.
		*/
		public function PatternMatch(
			position:uint = 0,
			pattern:Pattern = null,
			target:* = null )
		{
			super();
			this.position = position;
			this.pattern = pattern;
			this.target = target;
		}
		
		/**
		* 	The position for this pattern match.
		*/
		public function get position():uint
		{
			return _position;
		}
		
		public function set position( value:uint ):void
		{
			_position = value;
		}
		
		/**
		* 	The pattern being matched against.
		*/
		public function get pattern():Pattern
		{
			return _pattern;
		}
		
		public function set pattern( value:Pattern ):void
		{
			_pattern = value;
		}
		
		/**
		* 	Whether the pattern match succeeded.
		*/
		public function get result():Boolean
		{
			return _result;
		}
		
		public function set result( value:Boolean ):void
		{
			_result = value;
		}
		
		/**
		* 	The target being matched.
		*/
		public function get target():*
		{
			return _target;
		}
		
		public function set target( value:* ):void
		{
			_target = value;
		}
		
		/**
		* 	An xml representation of this match.
		*/
		override public function get xml():XML
		{
			return getXml( false );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			return getXml( false ).toXMLString();
		}
		
		/**
		* 	@private
		*/
		private function getXml( simple:Boolean = true ):XML
		{
			var x:XML = getXmlElement( MATCH );
			x.@position = position;			
			x.@result = result;
			if( !simple )
			{
				if( target != null )
				{
					var src:XML = getXmlElement( TARGET, target );
					src.@type = getQualifiedClassName( target );
					x.appendChild( src );
				}
				if( pattern != null )
				{
					x.appendChild( getXmlElement(
						PATTERN, pattern.toPatternLiteral() ) );
				}
			}
			return x;
		}
	}
}