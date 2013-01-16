package com.motionnexus.samples.gestures
{

	import com.motionnexus.data.cursor.MotionNexusCursor;
	import com.motionnexus.infastructure.IMotionNexusListenerCursor;
	import com.motionnexus.samples.gestures.data.GestureTimeCursor;
	import com.motionnexus.samples.gestures.data.GestureTimeSkeleton;
	import com.motionnexus.samples.gestures.processors.GestureProcessor;
	
	import flash.events.Event;
	import flash.utils.getTimer;

	[Event(name="swipeLeft", type="flash.events.Event")]
	[Event(name="swipeRight", type="flash.events.Event")]
	/**
	 *
	 * @author Justin
	 */
	public class SwipeGesture extends GestureProcessor
	{

		public static const SWIPE_LEFT:String='swipeLeft';
		public static const SWIPE_RIGHT:String='swipeRight';

		private var _swipeMinimalLength:Number=30;
		private var _swipeMaximalHeight:Number=15;
		
		private var _swipeDuration:Number=100;
		private var _timeBetweenGestures:Number=1000;
		private var _lastGesture:Number=0;

		override public function updateCursor($cursor:MotionNexusCursor):void
		{
			super.updateCursor($cursor);
			var timeSinceLastGesture:Number=getTimer() - _lastGesture;
			if (timeSinceLastGesture < _timeBetweenGestures)
			{
				return;
			}
			var history:Vector.<GestureTimeCursor>=getCursorHistory($cursor.trackingId, $cursor.type);
			var currentCursor:GestureTimeCursor=getCurrentCursor($cursor.trackingId, $cursor.type);
			if (currentCursor == null)
			{
				return;
			}
			for each (var cursorEntry:GestureTimeCursor in history)
			{
				if (cursorEntry && cursorEntry.time != currentCursor.time)
				{
					if (testGestureSwipe(currentCursor, cursorEntry) == true)
					{
						deleteCursorHistory($cursor.trackingId, $cursor.type);
						break;
					}
				}
			}
		}

		/**
		 *
		 * @param currentCursor
		 * @param previousCursor
		 * @return
		 */
		protected function testGestureSwipe(currentCursor:GestureTimeCursor, previousCursor:GestureTimeCursor):Boolean
		{
			if (currentCursor == null || previousCursor == null)
			{
				return false;
			}
			var skeleton:GestureTimeSkeleton=getCurrentSkeleton(currentCursor.trackingId);
			var cursorDepth:Number;
			if (currentCursor.type == MotionNexusCursor.LEFT_HAND)
			{
				if (skeleton.skeleton.leftHand.depth.y > skeleton.skeleton.leftElbow.depth.y)
				{
					return false;
				}
				cursorDepth = skeleton.skeleton.leftHand.z;
			}
			else
			{
				if (skeleton.skeleton.rightHand.depth.y > skeleton.skeleton.rightElbow.depth.y)
				{
					return false;
				}
				cursorDepth = skeleton.skeleton.rightHand.z;
			}
			//Make sure the Y has not moved higher than maximal
			var diffY:Number=Math.abs((currentCursor.depth.y - previousCursor.depth.y)*cursorDepth);
			if ((diffY < _swipeMaximalHeight) == true)
			{

				//Validate length of movement
				var diffX:Number=Math.abs((currentCursor.depth.x - previousCursor.depth.x)*cursorDepth);
				if ((diffX > _swipeMinimalLength) == true)
				{

					var totalMilliseconds:Number=currentCursor.time - previousCursor.time;
					if (totalMilliseconds <= _swipeDuration && totalMilliseconds <= _swipeDuration)
					{
						if (((currentCursor.depth.x - previousCursor.depth.x) < 0.01) == true)
						{
							dispatchEvent(new Event(SWIPE_RIGHT));
						}
						else
						{
							dispatchEvent(new Event(SWIPE_LEFT));
						}
						_lastGesture=getTimer();
						return true;
					}

				}
			}
			return false;
		}

		public function get swipeMinimalLength():Number
		{
			return _swipeMinimalLength;
		}

		public function set swipeMinimalLength(value:Number):void
		{
			_swipeMinimalLength=value;
		}

		public function get swipeMaximalHeight():Number
		{
			return _swipeMaximalHeight;
		}

		public function set swipeMaximalHeight(value:Number):void
		{
			_swipeMaximalHeight=value;
		}

		public function get swipeDuration():Number
		{
			return _swipeDuration;
		}

		public function set swipeDuration(value:Number):void
		{
			_swipeDuration=value;
		}

		public function get timeBetweenGestures():Number
		{
			return _timeBetweenGestures;
		}

		public function set timeBetweenGestures(value:Number):void
		{
			_timeBetweenGestures=value;
		}


	}
}
