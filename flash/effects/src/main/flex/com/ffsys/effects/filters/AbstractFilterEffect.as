package com.ffsys.effects.filters {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.effects.display.AbstractDisplayObjectEffect;
	import com.ffsys.effects.events.TweenUpdateEvent;
	import com.ffsys.effects.tween.ITweenUpdater;
	import com.ffsys.effects.tween.ITween;
	
	import flash.filters.BlurFilter;
	
	/**
	*	Abstract base class for filter effects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class AbstractFilterEffect extends AbstractDisplayObjectEffect
		implements ITweenUpdater {

		protected var _filter:Object;
		
		protected var _filters:Array;
		
		public function AbstractFilterEffect(
			displayObject:DisplayObject, filter:Object, properties:Array )
		{
			super( displayObject, properties );
			_filter = filter;
		}
		
		public function get filter():Object
		{
			return _filter;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function shouldApplyTweenValues( properties:Array, values:Array ):Boolean
		{
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function shouldApplyTweenValue( property:String, value:Object ):Boolean
		{
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function applyTweenValue( target:Object, property:String, value:Object ):void
		{
			if( target.hasOwnProperty( property ) )
			{
				target[ property ] = value;
				applyFilter();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function configure(
			target:Object,
			start:Object = 0,
			end:Object = 1,
			duration:Number = 1,
			easing:Object = null ):ITween
		{
			var tween:ITween = super.configure(
				target,
				start,
				end,
				duration,
				easing );
			
			tween.updater = this;
			
			//assign our filter
			var filters:Array = !( _displayObject.filters is Array ) ? [] : _displayObject.filters;
			filters.push( _filter );
			_displayObject.filters = filters;
			
			//store a copy of the filters assigned to the display object
			_filters = filters;

			return tween;
		}
		
		/**
		*	@private
		*/
		protected function applyFilter():void
		{
			//update the display object filter
			_displayObject.filters = _filters;
		}
	}
}