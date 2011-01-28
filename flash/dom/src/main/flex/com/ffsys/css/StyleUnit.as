package com.ffsys.css
{
	import flash.system.Capabilities;
	
	import com.ffsys.dom.Element;
	
	/**
	* 	A helper for working with css units.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class StyleUnit extends Element
	{
		
		/*
		in: inches — 1in is equal to 2.54cm.
		cm: centimeters
		mm: millimeters
		pt: points — the points used by CSS are equal to 1/72nd of 1in.
		pc: picas — 1pc is equal to 12pt.
		px: pixel units — 1px is equal to 0.75pt.
		*/		
		
		
		
		/*
		
		em: "em", 		//EMS
		ex: "ex", 		//EMX
		px: "px",		//LENGTH
		cm: "cm",		//LENGTH
		mm: "mm",		//LENGTH
		"in": "in",		//LENGTH
		pt: "pt",		//LENGTH
		pc: "pc",		//LENGTH
		deg: "deg",		//ANGLE
		rad: "rad",		//ANGLE
		grad: "grad",	//ANGLE
		ms: "ms",		//TIME
		s: "s",			//TIME
		hz: "Hz",		//FREQUENCY
		khz: "kHz",		//FREQUENCY
		"%": "%"		//PERCENTAGE		
		
		*/		
		
		/**
		* 	A regular expression used to determine
		* 	if a string is a css unit declaration.
		*/
		public static const UNIT_EXPRESSION:RegExp = 
			/^([0-9]*\.?[0-9]{1,})(em|ex|px|cm|mm|in|pt|pc|px|%)$/;
		
		/**
		* 	Represents a unit specified as a relative <code>em</code>
		* 	size.
		*/
		public static const EMS:String = "em";
		
		/**
		* 	Represents a unit specified as a relative <code>ex</code>
		* 	size.
		*/
		public static const EXS:String = "ex";
		
		/**
		* 	Represents a unit specified as a <code>percentage</code>.
		*/
		public static const PERCENT:String = "%";		
		
		/**
		* 	Represents a unit specified in <code>inches</code>.
		*/
		public static const INCHES:String = "in";
		
		/**
		* 	Represents a unit specified in <code>centimetres</code>.
		*/
		public static const CENTIMETRES:String = "cm";
		
		/**
		* 	Represents a unit specified in <code>millimetres</code>.
		*/
		public static const MILLIMETRES:String = "mm";
		
		/**
		* 	Represents a unit specified in <code>points</code>.
		*/
		public static const POINTS:String = "pt";
		
		/**
		* 	Represents a unit specified in <code>picas</code>.
		*/
		public static const PICAS:String = "pc";
		
		/**
		* 	Represents a unit specified in <code>pixels</code>.
		*/
		public static const PIXELS:String = "px";
		
		/**
		* 	An expression used to determine the <code>em</code> unit type.
		*/
		public static const EMS_EXP:String = "(?P<emsunit>" + EMS + ")";

		/**
		* 	An expression used to determine the <code>ex</code> unit type.
		*/
		public static const EXS_EXP:String = "(?P<exsunit>" + EXS + ")";

		/**
		* 	An expression used to determine the <code>length</code> unit type.
		*/
		public static const LENGTH_EXP:String = "(?P<lengthunit>px|cm|mm|in|pt|pc)";

		/**
		* 	An expression used to determine the <code>angle</code> unit type.
		*/
		public static const ANGLE_EXP:String = "(?P<angleunit>grad|deg|rad)";

		/**
		* 	An expression used to determine the <code>time</code> unit type.
		*/
		public static const TIME_EXP:String = "(?P<timeunit>ms|s)";

		/**
		* 	An expression used to determine the <code>frequency</code> unit type.
		*/
		public static const FREQUENCY_EXP:String = "(?P<frequencyunit>kHz|Hz)";

		/**
		* 	An expression used to determine the <code>percentage</code> unit type.
		*/
		public static const PERCENTAGE_EXP:String = "(?P<percentunit>" + PERCENT + ")";
		
		private var _expression:String;
		private var _operand:Number;
		private var _unit:String;
		private var _computed:Number;
		
		/**
		* 	Creates a <code>StyleUnit</code> instance.
		*/
		public function StyleUnit()
		{
			super();
		}
		
		/**
		* 	A computed value for this unit.
		*/
		public function get computed():Number
		{
			return _computed;
		}
		
		/**
		* 	A raw expression of the unit value.
		*/
		public function get expression():String
		{
			return _expression;
		}
		
		public function set expression( value:String ):void
		{
			_expression = value;
			
			if( value != null )
			{
				parse( value );
			}
		}
		
		/**
		* 	The numeric operand for the unit.
		*/
		public function get operand():Number
		{
			return _operand;
		}
		
		public function set operand( value:Number ):void
		{
			_operand = value;
		}
		
		/**
		* 	The unit qualifier.
		*/
		public function get unit():String
		{
			return _unit;
		}
		
		public function set unit( value:String ):void
		{
			_unit = value;
		}
		
		/**
		* 	Retrieves the dots-per-inch for the current display.
		*/
		public function get dpi():Number
		{
			return Capabilities.screenDPI;
		}
		
		/**
		* 	Determines whether this unit represents a
		* 	relative value.
		* 
		* 	@return Whether this unit is considered to
		* 	be a relative value.
		*/
		public function isRelative():Boolean
		{
			return ( unit == PERCENT || unit == EMS || unit == EXS );
		}
		
		/**
		* 	Determines whether this unit represents an
		* 	absolute value.
		* 
		* 	@return Whether this unit is considered to
		* 	be an absolute value.
		*/
		public function isAbsolute():Boolean
		{
			return !isRelative();
		}
		
		/**
		* 	Determines whether a string is
		* 	a css unit definition.
		* 
		* 	@param candidate THe candidate string.
		* 
		* 	@return Whether the candidate appears to be
		* 	a numerical value specified as a css unit.
		*/
		public static function isUnit( candidate:String ):Boolean
		{
			return candidate != null && UNIT_EXPRESSION.test( candidate );
		}
		
		/**
		* 	Computes absolute values to pixels.
		*/
		private function absolute():void
		{
			if( isAbsolute() )
			{
				if( isNaN( operand ) )
				{
					_computed = 0;
				}else{
					switch( unit )
					{
						case PIXELS:
							_computed = operand;
							break;
						case INCHES:
							_computed = ( dpi * _operand );
							break;
						case CENTIMETRES:
							//scale the operand to inches
							_computed = ( dpi * ( _operand * 0.39370079 ) );
							break;
						case MILLIMETRES:
							//scale the operand to inches
							_computed = ( dpi * ( _operand * 0.039370079 ) )
							break;
						case POINTS:
							//scale the operand to inches
							//css treats points as 1/72nd of an inch
							_computed = ( dpi * ( _operand / 72 ) )
							break;
						case PICAS:
							//upscale the operand to inches to get the point value
							//and multiply by points per pica
							_computed = ( dpi * ( ( _operand / 72 ) ) * 12 );
							break;
					}
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function parse( expression:String ):void
		{
			if( expression != null )
			{
				var num:String = expression.replace( UNIT_EXPRESSION, "$1" );
				var unit:String = expression.replace( UNIT_EXPRESSION, "$2" );
				this.operand = Number( num );
				this.unit = unit;
				
				//compute any absolute value immediately
				absolute();
				
				trace("[CSS UNIT] StyleUnit::parse()", expression, dpi, operand, this.unit, this );
				
			}
		}
		
		/**
		* 	Gets a string representation of this
		* 	unit.
		* 
		* 	@return A string representation of this unit.
		*/
		override public function toString():String
		{
			return "[object " + getClass().name + "(" + expression + "=" + computed + "px)]";
		}
	}
}