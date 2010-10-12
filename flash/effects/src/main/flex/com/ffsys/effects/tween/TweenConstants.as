package com.ffsys.effects.tween {

	import com.ffsys.effects.easing.Quad;
	
	/**
	*	Encapsulates all constants for the tween functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class TweenConstants extends Object {
		
		/**
		*	Constant indicating that an ITween that plays
		*	in a cyclical manner, ie, play forwards then 
		*	backwards is in the out bound (forwards) stage
		*	of the cycle.
		*/
		static public var OUTBOUND:int = 0;
		
		/**
		*	Constant indicating that an ITween that plays
		*	in a cyclical manner, ie, play forwards then 
		*	backwards is in the in bound (backwards) stage
		*	of the cycle.
		*/
		static public var INBOUND:int = 1;
	
		/*
		*	String constants referring to tweenable properties
		*	of a DisplayObject.
		*/
		static public const ALPHA_PROPERTY:String = "alpha";
		static public const X_PROPERTY:String = "x";
		static public const Y_PROPERTY:String = "y";
		static public const WIDTH_PROPERTY:String = "width";
		static public const HEIGHT_PROPERTY:String = "height";
		static public const SCALE_X_PROPERTY:String = "scaleX";
		static public const SCALE_Y_PROPERTY:String = "scaleY";
		static public const ROTATION_PROPERTY:String = "rotation";
		
		/**
		*	Read-only property but declared here as the property
		*	used when tweening a MovieClip timeline.
		*/
		static public const CURRENT_FRAME_PROPERTY:String = "currentFrame";
		
		/**
		*	Non-existent property used to indicate access of elements
		*	contained in an Array.
		*/
		static public const INDEX_PROPERTY:String = "index";
		
		/*
		*	String constants referring to tweenable properties
		*	of the filters available in the flash.filters package.
		*/
		static public const BLUR_X_PROPERTY:String = "blurX";
		static public const BLUR_Y_PROPERTY:String = "blurY";
		
		/*
		*	String constants for tweenable properties of the
		*	SoundTransform class.
		*/
		static public const PAN_PROPERTY:String = "pan";
		static public const VOLUME_PROPERTY:String = "volume";
		
		/**
		*	The default frame rate for all tweens.
		*/
		static public const DEFAULT_FRAME_RATE:Number = 30;
		
		/**
		*	The default easing equation to use for all tweens.
		*/
		static public const DEFAULT_EASING:Function = Quad.easeOut;
		
		/**
		*	@private
		*/
		public function TweenConstants()
		{
			super();
		}
		
	}
	
}
