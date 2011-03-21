package org.flashx.effects.array {
	
	import org.flashx.effects.tween.ITween;
	import org.flashx.effects.tween.TweenConstants; 
	
	import org.flashx.effects.tween.ITweenUpdater;
	import org.flashx.effects.tween.ITweenValueFormatter;
	
	import org.flashx.utils.number.NumericRange;
	
	/**
	*	Tweens indexed access to the elements stored in an Array.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public class ArrayElementEffect extends AbstractArrayEffect
		implements 	ITweenValueFormatter,
					ITweenUpdater {
		
		/**
		*	The element being accessed in the Array. 
		*/
		private var _element:Object;
		
		/**
		*	The current index of the element being accessed.
		*/
		private var _index:int;
		
		public function ArrayElementEffect(
			targetArray:Array,
			duration:Number = 1,
			range:NumericRange = null,
			easing:Function = null )
		{
			super( targetArray, [ TweenConstants.INDEX_PROPERTY ] );
			
			if( !range )
			{
				range = new NumericRange( 0, targetArray.length - 1 );
			}
			
			if( range.start < 0 )
			{
				range.start = 0;
			}
			
			if( range.end > targetArray.length - 1 )
			{
				range.end = targetArray.length - 1;
			}
			
			var tween:ITween = configure(
				targetArray,
				range.start,
				range.end,
				duration,
				easing );
				
			_index = range.start;
		
			tween.updater = this;
			tween.formatter = this;
		}
		
		public function set element( val:Object ):void
		{
			_element = val;
		}
		
		public function get element():Object
		{
			return _element;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		/*
		*	ITweenValueFormatter implementation.
		*/
		public function formatTweenValue( value:Number ):Number
		{
			return Math.floor( value );
		}
		
		/*
		*	ITweenUpdater implementation.
		*/
		public function shouldApplyTweenValues( properties:Array, values:Array ):Boolean
		{
			return true;
		}
		
		public function shouldApplyTweenValue( property:String, value:Object ):Boolean
		{
			return true;
		}
				
		public function applyTweenValue( target:Object, property:String, value:Object ):void
		{
			//trace( "ARRAY ELEMENT EFFECT APPLY VALUE  : " + targetArray[ value ] );
			
			_index = ( value as int );
			
			var elem:Object = targetArray[ value ];
			
			if( elem != element )
			{
				this.element = elem;
			}
		}
	}
}