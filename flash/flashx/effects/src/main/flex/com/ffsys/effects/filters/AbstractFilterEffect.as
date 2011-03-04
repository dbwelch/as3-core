package com.ffsys.effects.filters {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.effects.display.AbstractDisplayObjectEffect;
	import com.ffsys.effects.tween.TweenEvent;
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

		private var _filter:Object;
		private var _filters:Array;
		
		public function AbstractFilterEffect(
			displayObject:DisplayObject = null, 
			filter:Object = null,
			properties:Array = null )
		{
			super( displayObject, properties );
			this.filter = filter;
		}
		
		public function get filter():Object
		{
			return _filter;
		}
		
		public function set filter(value:Object):void
		{
			_filter = value;
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
			var filters:Array = !( this.displayObject.filters is Array ) ? [] : this.displayObject.filters;
			filters.push( _filter );
			this.displayObject.filters = filters;
			
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
			this.displayObject.filters = _filters;
		}
	}
}